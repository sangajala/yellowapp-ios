//
//  BusinessIndividualModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 28/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

//{
//    "Service_Id": 6,
//    "Title": "DFC Chicken",
//    "Description": "They have all Chicken items, burgers, ice creams etc",
//    "Location": "Visakhapatnam",
//    "Rating": 4,
//    "Image": "http://mcaindia.bananaapps.co.uk/UpImages/Business/businessimage_239_dfc.jpg",
//    "Views": 0,
//    "IsWallet": "False",
//    "IsFeature": null,
//    "Created_Datetime": "2019-08-07T10:46:53.163",
//    "Updated_Datetime": "2019-08-20T08:27:08.463",
//    "Message": {
//        "isWarning": false,
//        "isError": false,
//        "isSuccess": true,
//        "isInfo": false,
//        "Message": "Service details are retrieved successfully",
//        "StatusCode": 200,
//        "Value": 0
//    },
//    "Images": [
//    {
//    "Image_Id": 3,
//    "Image_Url": "http://mcaindia.bananaapps.co.uk/UpImages/Business/businessimage_261_6.jpg"
//    }
//    ]
//}

class BusinessIndividualModel: Codable {
    
    var Service_Id: Int?
    var Title: String?
    var Description: String?
    var Location: String?
    var rating: Int?
    var Image: String?
    var Views: Int?
    var IsWallet: String?
    var IsFeature: String?
    var Created_Datetime: String?
    var Updated_Datetime: String?
    
    var Message: BusinessIndividualModelMessage?
    var Images: [BusinessIndividualModelImages]?
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Service_Id = try container.decodeIfPresent(Int.self, forKey: .Service_Id) ?? 0
        self.Description = try container.decodeIfPresent(String.self, forKey: .Description) ?? ""

        self.Title = try container.decodeIfPresent(String.self, forKey: .Title) ?? ""
        self.Location = try container.decodeIfPresent(String.self, forKey: .Location) ?? ""
        self.Image = try container.decodeIfPresent(String.self, forKey: .Image) ?? ""
        self.Views = try container.decodeIfPresent(Int.self, forKey: .Views) ?? 0
        self.IsWallet = try container.decodeIfPresent(String.self, forKey: .IsWallet) ?? ""
        self.Created_Datetime = try container.decodeIfPresent(String.self, forKey: .Created_Datetime) ?? "\(Date())"
        self.Updated_Datetime = try container.decodeIfPresent(String.self, forKey: .Updated_Datetime) ?? ""
        self.Message = nil//BusinessIndividualModelMessage
        self.Images = nil//BusinessIndividualModelImages
        
    }
}

class BusinessIndividualModelMessage : Codable {
    
    var isWarning: Bool?
    var isError: Bool?
    var isSuccess: Bool?
    var isInfo: Bool?
    var Message: String?
    var StatusCode: Int?
    var Value: Int?
    
}

class BusinessIndividualModelImages : Codable {
    
    var Image_Id: Int?
    var Image_Url: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Image_Id = try container.decodeIfPresent(Int.self, forKey: .Image_Id) ?? 0
        self.Image_Url = try container.decodeIfPresent(String.self, forKey: .Image_Url) ?? ""

    }
}
