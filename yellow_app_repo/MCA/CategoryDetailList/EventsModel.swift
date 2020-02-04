//
//  EventsModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 02/09/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation
import CoreLocation

struct EventsModel: Codable {
    
    var EventsList: [EventsModelList]
    
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


class EventsModelList: Codable {
    
    var Event_Id: Int?
    var Title: String?
    var Location: String?
    var Rating: Double?
    var Image: String?
    var Views: Int?
    var Latitude: String?
    var Longitude: String?
    var IsFeature: String?
    var Created_Datetime: String?
    var Updated_Datetime: String?
    
    var distance: Double?
    var createdDate: Int?
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Event_Id = try container.decodeIfPresent(Int.self, forKey: .Event_Id) ?? 0
        self.Latitude = try container.decodeIfPresent(String.self, forKey: .Latitude) ?? "51.5074"
        self.Longitude = try container.decodeIfPresent(String.self, forKey: .Longitude) ?? "0.1278"
        self.Title = try container.decodeIfPresent(String.self, forKey: .Title) ?? ""
        self.Location = try container.decodeIfPresent(String.self, forKey: .Location) ?? "London"
        self.Rating = try container.decodeIfPresent(Double.self, forKey: .Rating) ?? 0.0
        self.Image = try container.decodeIfPresent(String.self, forKey: .Image) ?? ""
        self.Views = try container.decodeIfPresent(Int.self, forKey: .Views) ?? 0
        self.IsFeature = nil
        self.Created_Datetime = try container.decodeIfPresent(String.self, forKey: .Created_Datetime) ?? ""
        self.Updated_Datetime = try container.decodeIfPresent(String.self, forKey: .Updated_Datetime) ?? ""
        self.distance = try container.decodeIfPresent(Double.self, forKey: .distance) ?? 0.0
        self.createdDate = try container.decodeIfPresent(Int.self, forKey: .createdDate) ?? 0
    }

    
    
}


