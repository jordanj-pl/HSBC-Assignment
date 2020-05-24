//
//  ProfileRouter.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 18/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import UIKit
import MessageUI

protocol ProfileRouterProtocol: class {

	func openURL(_ url: URL) -> Void
	func shownMailComposer(withRecipient recipient: String) -> Void
}

class ProfileRouter: NSObject, RouterProtocol, ChildRouterProtocol, ProfileRouterProtocol, MFMailComposeViewControllerDelegate {

	unowned var parentRouter: RouterProtocol

	//MARK: - ChildRouterProtocol

	required init(parentRouter: RouterProtocol) {
		if !(parentRouter is MainRouterProtocol) {
			assertionFailure("Expecting router that conforms to MainRouterProtocol")
		}

		self.parentRouter = parentRouter
	}

	//MARK: - ProfileRouterProtocol

	func openURL(_ url: URL) {
		UIApplication.shared.open(url)
	}

	func shownMailComposer(withRecipient recipient: String) {
		let mc = MFMailComposeViewController()
		mc.setToRecipients([recipient])
		mc.mailComposeDelegate = self

		parentRouter.present(viewController: mc)

	}

	//MARK: - RouterProtocol

	func mainView() -> UIViewController {
		let view: ProfileView = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "Profile") as! ProfileView

		let presenter = ProfilePresenter()
		presenter.view = view
		presenter.router = self

		view.eventHandler = presenter

		let parentRouter = self.parentRouter as! MainRouterProtocol

		let interactor = ProfileInteractor(apiClient: parentRouter.serverAPI())
		interactor.output = presenter

		presenter.provider = interactor

		return view
	}

	func showMainView() {

	}

	func push(viewController: UIViewController) {
		parentRouter.push(viewController: viewController)
	}

	func present(viewController: UIViewController) {
		parentRouter.present(viewController: viewController)
	}

	func popViewController() {
		parentRouter.popViewController()
	}

	//MARK: - MFMailComposeViewControllerDelegate

	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		parentRouter.popViewController()
	}

}
