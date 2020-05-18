//
//  ProfessionalExperienceEntity.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 19/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import Foundation

struct ProfessionalExperienceEntity: Decodable {

    var companyName: String
    var position: String
    var dateStarted: Date
    var dateEnded: Date?
    var summary: String
}
