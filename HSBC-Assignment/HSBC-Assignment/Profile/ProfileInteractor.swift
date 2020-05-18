//
//  ProfileInteractor.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 18/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import Foundation

protocol ProfileProviderProtocol: class {

	func prepareProfile() -> Void
}

protocol ProfileOutputProtocol: class {

	func backgroundActivityStarted() -> Void
	func backgroundActivityEnded() -> Void
}

class ProfileInteractor: ProfileProviderProtocol {

	unowned var output: ProfileOutputProtocol?

	unowned var serverAPI: APICLientProtocol

	required init(apiClient: APICLientProtocol) {
		serverAPI = apiClient
	}

	//MARK: - ProfileProviderProtocol

	func prepareProfile() {
		self.output?.backgroundActivityStarted()

		self.serverAPI.retrieveProfile(Constants.profileURL) { [unowned self] result in

			self.output?.backgroundActivityEnded()
		}

	}
}
