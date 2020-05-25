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

	@IBOutlet var basicInfoView: UIView!
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var photoView: UIImageView!
	@IBOutlet var emailLabel: UILabel!
	@IBOutlet var phoneLabel: UILabel!
	@IBOutlet var wwwLabel: UILabel!

	@IBOutlet var summaryLabel: UILabel!

	@IBOutlet var experienceView: UIView!
	@IBOutlet var experienceViewHeight: NSLayoutConstraint!

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

	func setPhoto(_ photo: UIImage) {
		photoView.image = photo
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

	//TODO: consider if this is the most optimal way to manage constraints. UITableView may be a solution but it also brings other problems and does not seem to be necessary if volume of data to be shown is really small.
	func addExperience(companyName: String, position: String, period: String, summary: String, viewPosition: SubviewPosition = .middle) {
		let ev = ExperienceView.view()
		ev.companyNameLabel.text = companyName
		ev.positionLabel.text = position
		ev.datesLabel.text = period
		ev.positionSummaryLabel.text = summary

		if viewPosition == .first {
			experienceView.addSubview(ev)
			ev.translatesAutoresizingMaskIntoConstraints = false

			ev.topAnchor.constraint(equalTo: experienceView.topAnchor, constant: 8.0).isActive = true
		} else {
			var previousView: UIView = experienceView

			for v in experienceView.subviews {
				if v is ExperienceView {
					previousView = v
				}
			}

			experienceView.addSubview(ev)
			ev.translatesAutoresizingMaskIntoConstraints = false

			ev.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 8.0).isActive = true
		}

		ev.leadingAnchor.constraint(equalTo: experienceView.leadingAnchor).isActive = true
		ev.trailingAnchor.constraint(equalTo: experienceView.trailingAnchor).isActive = true

		if viewPosition == .last {
			ev.bottomAnchor.constraint(equalTo: experienceView.bottomAnchor, constant: 8.0).isActive = true
		}
	}

	func showActivityIndicator() {
		activityIndicator.show(inView: self.view)
	}

	func hideActivityIndicator() {
		activityIndicator.hide()
	}

}
