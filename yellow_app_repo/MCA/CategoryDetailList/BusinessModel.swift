//
//  BusinessModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 15/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation
import CoreLocation

//    {
//    "ServicesList": [
//    {
//    "Service_Id": 16,
//    "Title": "Vishnu's Arrabolu Paradise",
//    "Location": "Visakhapatnam",
//    "Rating": 4.5,
//    "Image": "http://mcaindia.bananaapps.co.uk/UpImages/Business/businessimage_73_residential-apartment-250x250.png",
//    "Views": 1,
//    "Latitude": "17.7294521",
//    "Longitude": "83.30805",
//    "IsFeature": null,
//    "Created_Datetime": "2019-08-13T05:50:14.937",
//    "Updated_Datetime": "2019-08-13T05:59:36.923"
//    },
//    {
//    "Service_Id": 17,
//    "Title": "Vinayagar Annapurba Apartments",
//    "Location": "Visakhapatnam",
//    "Rating": 4,
//    "Image": "http://mcaindia.bananaapps.co.uk/UpImages/Business/businessimage_17_RealEstate.png",
//    "Views": 0,
//    "Latitude": "17.7294521",
//    "Longitude": "83.30805",
//    "IsFeature": null,
//    "Created_Datetime": "2019-08-13T05:52:44.563",
//    "Updated_Datetime": "2019-08-13T05:58:54.237"
//    }
//    ],
//    "Message": {
//    "isWarning": false,
//    "isError": false,
//    "isSuccess": true,
//    "isInfo": false,
//    "Message": "Service details are retrieved successfully",
//    "StatusCode": 200,
//    "Value": 0
//    }
//    }

struct BusinessModel: Codable {
    
    var ServicesList: [BusinessModelServicesList]
    var Message: BusinessModelMessage

}

struct BusinessModelMessage : Codable {
    
    var isWarning: Bool?
    var isError: Bool?
    var isSuccess: Bool?
    var isInfo: Bool?
    var Message: String?
    var StatusCode: Int?
    var Value: Int?
}

class BusinessModelServicesList: Codable {
    
    var Service_Id: Int?
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
        self.Service_Id = try container.decodeIfPresent(Int.self, forKey: .Service_Id) ?? 0
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

////Model with lat long as native locations variables
//struct BusinessModel_location: Codable {
//
//    var ServicesList: [ServicesList]
//    struct ServicesList: Codable {
//
//        var Service_Id: Int?
//        var Title: String?
//        var Location: String?
//        var Rating: Double?
//        var Image: String?
//        var Views: Int?
//        var Latitude: String?
//        var Longitude: String?
//        var IsFeature: Int?
//        var Created_Datetime: String?
//        var Updated_Datetime: String?
//
//        var distance: Double?
//    }
//
//    var Message: Message
//    struct Message: Codable {
//
//        var isWarning: Bool?
//        var isError: Bool?
//        var isSuccess: Bool?
//        var isInfo: Bool?
//        var Message: String?
//        var StatusCode: Int?
//        var Value: Int?
//    }
//
//}

