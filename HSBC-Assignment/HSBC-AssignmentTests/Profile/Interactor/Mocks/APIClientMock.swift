//
//  APIClientOK.swift
//  HSBC-AssignmentTests
//
//  Created by Jordan Jasinski on 26/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import Foundation
import UIKit
@testable import HSBC_Assignment

class APIClientMock: APICLientProtocol {

	func retrieveProfile(_ url: URL, result: @escaping (Result<ProfileEntity, NSError>) -> Void) {

		if url.host == "success" {
			let profile = ProfileEntity(
				firstName: "Jan",
				middleName: "Jerzy",
				lastName: "Kowalski",
				profilePhoto: URL(string: "http://jan.kowalski.pl/photo.png"),
				phoneNumber: "48501234567",
				email: "jan@kowalski.pl",
				website: URL(string: "http://www.jankowalski.pl"),
				summary: "Something about Jan Kowalski.",
				keywords: ["keyword 1", "keyword 2"],
				technologies: [
					TechnologyEntity(name: "iOS development", yearsOfExperience: 9, level: "expert"),
					TechnologyEntity(name: "objective-c", yearsOfExperience: 9, level: "expert")
				],
				professionalExperience: [],
				languages: [
					LanguageEntity(language: "Polish", level: "native"),
					LanguageEntity(language: "English", level: "advanced")
				],
				certificates: [
				]
			)

			result(.success(profile))

		} else if url.host == "httpProblem" {
			result(.failure(NSError(domain: "server.profile.response.unexpectedHttpStatus", code: 0, userInfo: nil)))
		}

	}

	func retrieveImage(_ url: URL, result: @escaping (Result<UIImage, NSError>) -> Void) {

	}
}
