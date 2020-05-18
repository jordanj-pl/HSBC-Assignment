//
//  ProfileEntity.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 19/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import Foundation

struct ProfileEntity: Decodable {

	var firstName: String
	var middleName: String?
	var lastName: String

	var phoneNumber: String
	var email: String
	var website: URL?

	var summary: String

	var keywords: Array<String>

	var technologies: Array<TechnologyEntity>
	var professionalExperience: Array<ProfessionalExperienceEntity>
	var languages: Array<LanguageEntity>
	var certificates: Array<CertificateEntity>
}
