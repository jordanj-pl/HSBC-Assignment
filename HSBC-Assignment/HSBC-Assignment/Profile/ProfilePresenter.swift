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

}

class ProfilePresenter: ProfileEventHandlerProtocol, ProfileOutputProtocol {

	var provider: ProfileProviderProtocol?
	unowned var view: ProfileViewProtocol?
	unowned var router: ProfileRouter?

	//MARK: - ProfileEventHandlerProtocol

	func didLoad() {
		provider?.prepareProfile()
	}

	//MARK: - ProfileOutputProtocol

	func didEncounterError() {

	}

	func backgroundActivityStarted() {

	}

	func backgroundActivityEnded() {

	}

}
