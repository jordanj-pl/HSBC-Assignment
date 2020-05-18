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

	//MARK: View life cycle

	override func viewDidLoad() {
		eventHandler?.didLoad()
	}

	//MARK: - ProfileViewProtocol

}
