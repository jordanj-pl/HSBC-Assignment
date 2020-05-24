//
//  ProfilePresenter.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 18/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import Foundation
import MessageUI

protocol ProfileEventHandlerProtocol: class {

	func didLoad() -> Void

	func didTapMobileNumber() -> Void
	func didTapEmailAddress() -> Void
	func didTapWebAddress() -> Void

	func didTapSummary() -> Void
}

protocol ProfileViewProtocol: class {

	func showActivityIndicator() -> Void
	func hideActivityIndicator() -> Void

	func setName(_ name: String) -> Void
	func setEmail(_ email: String) -> Void
	func setPhone(_ phone: String) -> Void
	func setWWW(_ www: String) -> Void

	func setSummary(_ summary: String) -> Void
	func setSummary(expanded: Bool)
}

class ProfilePresenter: ProfileEventHandlerProtocol, ProfileOutputProtocol {

	var provider: ProfileProviderProtocol?
	unowned var view: ProfileViewProtocol?
	unowned var router: ProfileRouter?

	//MARK: view state

	var summaryExpanded = false

	func setBasicInfo(info: BasicInfo) {
		if let middleName = info.middleName {
			view?.setName("\(info.firstName) \(middleName) \(info.lastName)")
		} else {
			view?.setName("\(info.firstName) \(info.lastName)")
		}

		view?.setPhone(info.phone)
		view?.setEmail(info.email)
		if let www = info.www?.host {
			view?.setWWW(www)
		} else {
			//TODO: hide WWW field
		}

	}

	//MARK: - ProfileEventHandlerProtocol

	func didLoad() {
		provider?.prepareProfile()
	}

	func didTapSummary() {
		summaryExpanded = !summaryExpanded
		view?.setSummary(expanded: summaryExpanded)
	}

	func didTapEmailAddress() {
		do {
			if let provider = provider {
				let basicInfo = try provider.getBasicInfo()
				if MFMailComposeViewController.canSendMail() {
					router?.shownMailComposer(withRecipient: basicInfo.email)
				} else {

				}
			}
		} catch {
			//TODO: handle error
		}
	}

	func didTapMobileNumber() {
		do {
			if let provider = provider {
				let basicInfo = try provider.getBasicInfo()

				if let phoneURL = URL(string: "telprompt://\(basicInfo.phone)") {
					router?.openURL(phoneURL)
				}
			}
		} catch {
			//TODO: handle error
		}
	}

	func didTapWebAddress() {
		do {
			if let provider = provider {
				let basicInfo = try provider.getBasicInfo()
				if let www = basicInfo.www {
					DispatchQueue.main.async {
						self.router?.openURL(www)
					}
				}
			}
		} catch {
			//TODO: handle error
		}
	}

	//MARK: - ProfileOutputProtocol

	func didPrepareProfile() {
		do {
			if let provider = provider {
				let basicInfo = try provider.getBasicInfo()
				DispatchQueue.main.async {
					self.setBasicInfo(info: basicInfo)
				}

				let summary = try provider.getSummary()
				DispatchQueue.main.async {
					self.view?.setSummary(summary)
				}

			}
		} catch ProfileError.empty {
			//TODO: handle error
		} catch {
			//TODO: handle unexpected error
		}
	}

	func didEncounterError() {

	}

	func backgroundActivityStarted() {
		DispatchQueue.main.async {
			self.view?.showActivityIndicator()
		}
	}

	func backgroundActivityEnded() {
		DispatchQueue.main.async {
			self.view?.hideActivityIndicator()
		}
	}

}
