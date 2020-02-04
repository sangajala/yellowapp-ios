//
//  ContactUsEventsModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 03/09/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

class ContactUsEventsModel: Codable {
    
    var Event_Id: Int?
    var Title: String?
    var Address1: String?
    var City: String?
    var Postcode: String? 
    var Phone: String?
    var Latitude: String?
    var Website: String?
    var Longitude: String?
    var Email: String?
//    var Description: String?
    
    var Message: ContactUsEventsModelMessage?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Event_Id = try container.decodeIfPresent(Int.self, forKey: .Event_Id) ?? 0
        self.Latitude = try container.decodeIfPresent(String.self, forKey: .Latitude) ?? ""
        self.Longitude = try container.decodeIfPresent(String.self, forKey: .Longitude) ?? ""
        self.Title = try container.decodeIfPresent(String.self, forKey: .Title) ?? ""
        self.Address1 = try container.decodeIfPresent(String.self, forKey: .Address1) ?? ""
        self.City = try container.decodeIfPresent(String.self, forKey: .City) ?? ""
        self.Postcode = try container.decodeIfPresent(String.self, forKey: .Postcode) ?? ""
        self.Phone = try container.decodeIfPresent(String.self, forKey: .Website) ?? ""
        self.Website = try container.decodeIfPresent(String.self, forKey: .Postcode) ?? ""
        self.Email = try container.decodeIfPresent(String.self, forKey: .Email) ?? ""
        self.Message = nil

    }
}


class ContactUsEventsModelMessage : Codable {
    
    var isWarning: Bool?
    var isError: Bool?
    var isSuccess: Bool?
    var isInfo: Bool?
    var Message: String?
    var StatusCode: Int?
    var Value: Int?
}
