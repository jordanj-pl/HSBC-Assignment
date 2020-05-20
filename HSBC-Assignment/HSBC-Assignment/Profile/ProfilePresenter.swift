//
//  ProfilePresenter.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 18/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import Foundation

protocol ProfileEventHandlerProtocol: class {

	func didLoad() -> Void

}

protocol ProfileViewProtocol: class {

	func setName(_ name: String) -> Void
	func setEmail(_ email: String) -> Void
	func setPhone(_ phone: String) -> Void
	func setWWW(_ www: String) -> Void
}

class ProfilePresenter: ProfileEventHandlerProtocol, ProfileOutputProtocol {

	var provider: ProfileProviderProtocol?
	unowned var view: ProfileViewProtocol?
	unowned var router: ProfileRouter?

	func setBasicInfo(info: BasicInfo) {
		if let middleName = info.middleName {
			view?.setName("\(info.firstName) \(middleName) \(info.lastName)")
		} else {
			view?.setName("\(info.firstName) \(info.lastName)")
		}

		view?.setPhone(info.phone)
		view?.setEmail(info.email)
		if let www = info.www {
			view?.setWWW(www.absoluteString)
		} else {
			//TODO: hide WWW field
		}

	}

	//MARK: - ProfileEventHandlerProtocol

	func didLoad() {
		provider?.prepareProfile()
	}

	//MARK: - ProfileOutputProtocol

	func didPrepareProfile() {
		do {
			if let provider = provider {
				let basicInfo = try provider.getBasicInfo()
				DispatchQueue.main.async {
					self.setBasicInfo(info: basicInfo)
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

	}

	func backgroundActivityEnded() {

	}

}
