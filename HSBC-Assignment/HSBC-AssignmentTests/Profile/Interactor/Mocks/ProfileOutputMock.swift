//
//  ProfileOutputMock.swift
//  HSBC-AssignmentTests
//
//  Created by Jordan Jasinski on 26/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import Foundation
import UIKit

@testable import HSBC_Assignment

class ProfileOutputMock: ProfileOutputProtocol {

	var backgroundActivityStartedCalled = false
	var backgroundActivityEndedCalled = false
	var didPrepareProfileCalled = false
	var didRetrievePhotoCalled = false
	var didEncounterErrorCalled = false


	func backgroundActivityStarted() {
		backgroundActivityStartedCalled = true
	}

	func backgroundActivityEnded() {
		backgroundActivityEndedCalled = true
	}

	func didPrepareProfile() {
		didPrepareProfileCalled = true
	}

	func didRetrievePhoto(photo: UIImage) {
		didRetrievePhotoCalled = true
	}

	func didEncounterError() {
		didEncounterErrorCalled = true
	}

}
