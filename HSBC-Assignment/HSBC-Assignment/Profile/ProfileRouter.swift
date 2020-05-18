//
//  ProfileRouter.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 18/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import UIKit

protocol ProfileRouterProtocol: class {

}

class ProfileRouter: ChildRouterProtocol, ProfileRouterProtocol {

	unowned var parentRouter: MainRouterProtocol

	//MARK: - ChildRouterProtocol

	required init(parentRouter: RouterProtocol) {
		if !(parentRouter is MainRouterProtocol) {
			assertionFailure("Expecting router that conforms to MainRouterProtocol")
		}

		self.parentRouter = parentRouter as! MainRouterProtocol
	}

	//MARK: - ProfileRouterProtocol


	//MARK: - RouterProtocol

	func mainView() -> UIViewController {
		let view: ProfileView = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "Profile") as! ProfileView

		let presenter = ProfilePresenter()
		presenter.view = view
		presenter.router = self

		view.eventHandler = presenter

		let interactor = ProfileInteractor(apiClient: parentRouter.serverAPI())
		interactor.output = presenter

		presenter.provider = interactor

		return view
	}

	func showMainView() {

	}

}
