//
//  ExperienceView.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 24/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import UIKit

class ExperienceView: UIView {

	@IBOutlet var companyNameLabel: UILabel!
	@IBOutlet var positionLabel: UILabel!
	@IBOutlet var datesLabel: UILabel!
	@IBOutlet var positionSummaryLabel: UILabel!

	class func view() -> ExperienceView {
		return UINib(nibName: "ExperienceView", bundle: .main).instantiate(withOwner: nil, options: nil)[0] as! ExperienceView
	}
}
