//
//  ProfileInteractorTests.swift
//  HSBC-AssignmentTests
//
//  Created by Jordan Jasinski on 26/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import XCTest
@testable import HSBC_Assignment

class ProfileInteractorTests: XCTestCase {

	var interactor: ProfileInteractor?
	let apiClient = APIClientMock()
	var output: ProfileOutputMock?

	override func setUp() {
		interactor = ProfileInteractor(apiClient: apiClient)
		output = ProfileOutputMock()
		interactor?.output = output
	}

	func testPrepareProfileWithSuccess() -> Void {

		guard interactor != nil else {
			XCTFail("Internal test failure. Interactor must not be nil.")
			return
		}

		//WHEN
		let url = URL(string: "https://success")!
		interactor?.currentProfileURL = url

		//THEN
		interactor?.prepareProfile()

		guard let output = self.output else {
			XCTFail("Internal test failure. Output must not be nil.")
			return
		}

		//GIVEN
		XCTAssertTrue(output.backgroundActivityStartedCalled)
		XCTAssertTrue(output.backgroundActivityEndedCalled)
		XCTAssertTrue(output.didPrepareProfileCalled)
		XCTAssertFalse(output.didRetrievePhotoCalled)
		XCTAssertFalse(output.didEncounterErrorCalled)

		XCTAssertNotNil(interactor?.currentProfile)
	}

	func testPrepareProfileWithFailure() -> Void {
		guard interactor != nil else {
			XCTFail("Internal test failure. Interactor must not be nil.")
			return
		}

		//WHEN
		let url = URL(string: "https://httpProblem")!
		interactor?.currentProfileURL = url

		//THEN
		interactor?.prepareProfile()

		guard let output = self.output else {
			XCTFail("Internal test failure. Output must not be nil.")
			return
		}

		//GIVEN
		XCTAssertTrue(output.backgroundActivityStartedCalled)
		XCTAssertTrue(output.backgroundActivityEndedCalled)
		XCTAssertFalse(output.didPrepareProfileCalled)
		XCTAssertFalse(output.didRetrievePhotoCalled)
		XCTAssertTrue(output.didEncounterErrorCalled)

		XCTAssertNil(interactor?.currentProfile)
	}

}
