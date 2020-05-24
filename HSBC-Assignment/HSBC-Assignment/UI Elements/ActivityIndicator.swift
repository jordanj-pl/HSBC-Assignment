//
//  ActivityIndicator.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 21/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import UIKit

class ActivityIndicator: UIView {

	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

		configure()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		configure()
	}

	private func configure() {
		self.translatesAutoresizingMaskIntoConstraints = false

		let spinner = UIActivityIndicatorView(style: .whiteLarge)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		addSubview(spinner)
		spinner.startAnimating()

		spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
	}

	func show(inView view: UIView) {
		view.addSubview(self)

		self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}

	func hide() {
		self.removeFromSuperview()
	}

}
