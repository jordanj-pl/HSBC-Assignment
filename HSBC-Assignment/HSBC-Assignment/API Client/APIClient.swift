//
//  APIClient.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 19/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import Foundation

typealias FailureHandler = (_ error: Error) -> Void
typealias ProfileSuccessHandler = (_ documents: ProfileEntity) -> Void

protocol APICLientProtocol: class {

	func retrieveProfile(_ url: URL, result: @escaping (Result<ProfileEntity, NSError>) -> Void ) -> Void
}

class APIClient: APICLientProtocol {

	func retrieveProfile(_ url: URL, result: @escaping (Result<ProfileEntity, NSError>) -> Void) {
		print(url)

		result(.failure(NSError(domain: "server.api.missingimplementation", code: 0, userInfo: nil)))
	}
}
