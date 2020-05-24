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

class APIClient: NSObject, APICLientProtocol, URLSessionDelegate {

	private let operationQueue: OperationQueue = OperationQueue()
	private var urlSession: URLSession!

	override init() {
		super.init()

		let config = URLSessionConfiguration.default
		urlSession = URLSession(configuration: config, delegate: self, delegateQueue: operationQueue)

	}

	//MARK: - APICLientProtocol

	func retrieveProfile(_ url: URL, result: @escaping (Result<ProfileEntity, NSError>) -> Void) {
		print(url)

		urlSession.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in

			if let error = error {
				result(.failure(error as NSError))
				return
			}

			guard let response = response else {
				result(.failure(NSError(domain: "server.profile.response.empty", code: 0, userInfo: nil)))
				return
			}

			guard let data = data else {
				result(.failure(NSError(domain: "server.profile.response.emptydata", code: 0, userInfo: nil)))
				return
			}

			if response is HTTPURLResponse {
				let response: HTTPURLResponse = response as! HTTPURLResponse
				if response.statusCode != 200 {
					result(.failure(NSError(domain: "server.profile.response.unexpectedHttpStatus", code: 0, userInfo: nil)))
					return
				}

				let jsonDecoder = JSONDecoder.init()
				jsonDecoder.dateDecodingStrategy = .iso8601

				do {
					let model = try jsonDecoder.decode(ProfileEntity.self, from: data)
					result(.success(model))
					return
				} catch let e {
					result(.failure(e as NSError))
					return
				}

			}

		}.resume()

		//result(.failure(NSError(domain: "server.api.missingimplementation", code: 0, userInfo: nil)))
	}

	//MARK: - URLSessionDelegate
}
