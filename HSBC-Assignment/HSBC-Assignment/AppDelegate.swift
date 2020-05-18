//
//  AppDelegate.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 18/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var mainRouter = MainRouter()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let rootVC = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()

		guard let rootViewController = rootVC else {
			return false
		}

		let nc = UINavigationController(rootViewController: rootViewController)

		window = UIWindow(frame: UIScreen.main.bounds)

		guard let w = window else {
			return false
		}

		w.rootViewController = nc
		w.makeKeyAndVisible()

		mainRouter.navController = nc
		mainRouter.showMainView()

		return true
	}



}

