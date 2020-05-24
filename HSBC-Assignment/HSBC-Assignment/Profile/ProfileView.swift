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

	@IBOutlet var summaryLabel: UILabel!

	let activityIndicator = ActivityIndicator()

	//MARK: View life cycle

	override func viewDidLoad() {
		navigationController?.setNavigationBarHidden(true, animated: false)
		eventHandler?.didLoad()

		activityIndicator.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
	}

	//MARK: - UI Interactions

	@IBAction func didTapEmail() {
		eventHandler?.didTapEmailAddress()
	}

	@IBAction func didTapPhone() {
		eventHandler?.didTapMobileNumber()
	}

	@IBAction func didTapWWW() {
		eventHandler?.didTapWebAddress()
	}

	@IBAction func didTapSummary(_ gr: UITapGestureRecognizer) {
		eventHandler?.didTapSummary()
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

	func setSummary(_ summary: String) {
		summaryLabel.text = summary
	}

	func setSummary(expanded: Bool) {
		if expanded {
			summaryLabel.numberOfLines = 0
			summaryLabel.lineBreakMode = .byWordWrapping
		} else {
			summaryLabel.numberOfLines = 2
			summaryLabel.lineBreakMode = .byTruncatingTail
		}
		UIView.animate(withDuration: 0.5) {
			self.view.layoutIfNeeded()
		}
	}

	func showActivityIndicator() {
		activityIndicator.show(inView: self.view)
	}

	func hideActivityIndicator() {
		activityIndicator.hide()
	}

}
