//
//  ContactUsOrganisationsModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 03/09/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

struct ContactUsOrganisationsModel: Codable {
    
    var OrganisationID: Int?
    var Title: String?
    var Address1: String?
    var City: String?
    var Postcode: String?
    var Phone: String?
    var Latitude: String?
    var Website: String?
    var Longitude: String?
    var Email: String?
    var Description: String?
    
    var Message: Message
    struct Message : Codable {
        
        var isWarning: Bool?
        var isError: Bool?
        var isSuccess: Bool?
        var isInfo: Bool?
        var Message: String?
        var StatusCode: Int?
        var Value: Int?
    }
    
}
