//
//  CertificateEntity.swift
//  HSBC-Assignment
//
//  Created by Jordan Jasinski on 19/05/2020.
//  Copyright © 2020 skyisthelimit.aero. All rights reserved.
//

import Foundation

struct CertificateEntity: Decodable {

	var name: String
	var issuingAuthority: String
	var issueDate: Date
	var validDate: Date?
	var serialNumber: String?
	var additionalInfo: String?

}
