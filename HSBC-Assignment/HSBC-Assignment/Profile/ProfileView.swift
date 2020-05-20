//
//  ProfileView.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 18/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import UIKit

class ProfileView: UIViewController, ProfileViewProtocol {

	var eventHandler: ProfileEventHandlerProtocol?

	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var emailLabel: UILabel!
	@IBOutlet var phoneLabel: UILabel!
	@IBOutlet var wwwLabel: UILabel!

	//MARK: View life cycle

	override func viewDidLoad() {
		eventHandler?.didLoad()
	}

	//MARK: - ProfileViewProtocol

	func setName(_ name: String) {
		nameLabel.text = name
	}

	func setEmail(_ email: String) {
		emailLabel.text = email
	}

	func setPhone(_ phone: String) {
		phoneLabel.text = phone
	}

	func setWWW(_ www: String) {
		wwwLabel.text = www
	}

}
