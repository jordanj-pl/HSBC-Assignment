//
//  MainRouter.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 18/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import UIKit

protocol RouterProtocol: class {

	func mainView() -> UIViewController
    func showMainView() -> Void

}

protocol ChildRouterProtocol: RouterProtocol {

    init(parentRouter: RouterProtocol)
}

protocol MainRouterProtocol: class {

	func serverAPI() -> APICLientProtocol

}

class MainRouter: RouterProtocol, MainRouterProtocol {

	var navController: UINavigationController!
	let apiClient = APIClient()
	var childRouter: ChildRouterProtocol?

	//MARK: - RouterProtocol

	func mainView() -> UIViewController {
		let profileRouter = ProfileRouter(parentRouter: self)
		childRouter = profileRouter
		return profileRouter.mainView()
	}

	func showMainView() {
		navController.viewControllers = [mainView()]
	}

	//MARK: - MainRouterProtocol

	func serverAPI() -> APICLientProtocol {
		return apiClient
	}

}
