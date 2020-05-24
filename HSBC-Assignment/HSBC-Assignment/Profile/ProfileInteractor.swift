//
//  ProfileInteractor.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 18/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import Foundation

struct BasicInfo {
    let firstName: String
	let middleName: String?
	let lastName: String
	let email: String
	let phone: String
	let www: URL?
}

struct ExperienceInfo {
    let companyName: String
    let position: String
	let startDate: Date
	let endDate: Date?
	let summary: String
}

enum ProfileError: Error {
	case empty
}

protocol ProfileProviderProtocol: class {

	func prepareProfile() -> Void

	func getBasicInfo() throws -> BasicInfo
	func getSummary() throws -> String
	func getExperience() throws -> [ExperienceInfo]
}

protocol ProfileOutputProtocol: class {

	func backgroundActivityStarted() -> Void
	func backgroundActivityEnded() -> Void

	func didPrepareProfile() -> Void
	func didEncounterError() -> Void
}

class ProfileInteractor: ProfileProviderProtocol {

	unowned var output: ProfileOutputProtocol?

	unowned var serverAPI: APICLientProtocol

	var currentProfile: ProfileEntity?

	required init(apiClient: APICLientProtocol) {
		serverAPI = apiClient
	}

	//MARK: - ProfileProviderProtocol

	func prepareProfile() {
		self.output?.backgroundActivityStarted()

		self.serverAPI.retrieveProfile(Constants.profileURL) { [unowned self] result in

			self.output?.backgroundActivityEnded()

			switch result {
				case .success(let profile):
					print(profile)
					self.currentProfile = profile
					self.output?.didPrepareProfile()
				break

				case .failure(let error):
					print(error)
					self.output?.didEncounterError()
				break
			}
		}
	}

	func getBasicInfo() throws -> BasicInfo {
		guard let profile = currentProfile else {
			throw ProfileError.empty
		}

		return BasicInfo(firstName: profile.firstName,
			middleName: profile.middleName,
			lastName: profile.lastName,
			email: profile.email,
			phone: profile.phoneNumber,
			www: profile.website
		)
	}

	func getSummary() throws -> String {
		guard let profile = currentProfile else {
			throw ProfileError.empty
		}

		return profile.summary
	}

	func getExperience() throws -> [ExperienceInfo] {
		var experiences: [ExperienceInfo] = []

		guard let professionalExperience = currentProfile?.professionalExperience else {
			throw ProfileError.empty
		}

		for pe in professionalExperience {
			let ei = ExperienceInfo(companyName: pe.companyName, position: pe.position, startDate: pe.dateStarted, endDate: pe.dateEnded, summary: pe.summary)
			experiences.append(ei)
		}

		return experiences
	}
}
