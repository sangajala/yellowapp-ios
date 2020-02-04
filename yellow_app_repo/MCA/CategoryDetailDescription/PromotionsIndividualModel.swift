//
//  PromotionsIndividualModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 02/09/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

//{
//    "Pro_Id": 42,
//    "Title": "Exclusive Offer- Drunken Monkey",
//    "OnView": 0,
//    "Location": "Visakhapatnam",
//    "IsWallet": "False",
//    "Rating": 4,
//    "Views": 1,
//    "Image": "http://mcaindia.bananaapps.co.uk/UpImages/Business/Promotional/promoimage_448_druknenmonkey1.png",
//    "Description": "Exclusive offers for MCA users in Drunken Monkey. We server Milk Shakes, Sandwiches , Thick Shakes.",
//    "IsFeature": null,
//    "ServiceName": "Drunken Monkey",
//    "OfferValiddate": "2019-08-31T00:00:00",
//    "Message": {
//        "isWarning": false,
//        "isError": false,
//        "isSuccess": true,
//        "isInfo": false,
//        "Message": "Promotion details are retrieved successfully",
//        "StatusCode": 200,
//        "Value": 0
//    },
//    "Images": []
//}

class PromotionsIndividualModel: Codable {
    
    var Pro_Id: Int?
    var Title: String?
    var OnView: Int?
    var Description: String?
    var Location: String?
        var Rating: Int?
    var Image: String?
    var Views: Int?
    var IsWallet: String?
        var IsFeature: String?
    var Created_Datetime: String?
    var Updated_Datetime: String?
    
    var ServiceName: String?
    var OfferValiddate: String?
    
    var Message: PromotionsIndividualModelMessage?
    var Images: [PromotionsIndividualModelImages]?

    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Pro_Id = try container.decodeIfPresent(Int.self, forKey: .Pro_Id) ?? 0
        self.Description = try container.decodeIfPresent(String.self, forKey: .Description) ?? ""
        
        self.Title = try container.decodeIfPresent(String.self, forKey: .Title) ?? ""
        self.Location = try container.decodeIfPresent(String.self, forKey: .Location) ?? ""
        self.Image = try container.decodeIfPresent(String.self, forKey: .Image) ?? ""
        self.Views = try container.decodeIfPresent(Int.self, forKey: .Views) ?? 0
        self.IsWallet = try container.decodeIfPresent(String.self, forKey: .IsWallet) ?? ""
        self.Created_Datetime = try container.decodeIfPresent(String.self, forKey: .Created_Datetime) ?? ""
        self.Updated_Datetime = try container.decodeIfPresent(String.self, forKey: .Updated_Datetime) ?? ""
        self.Message = nil//BusinessIndividualModelMessage
        self.Images = nil//BusinessIndividualModelImages
        
    }
}

class PromotionsIndividualModelImages : Codable {
    
    var Image_Id: Int?
    var Image_Url: String?
}
class PromotionsIndividualModelMessage : Codable {
    
    var isWarning: Bool?
    var isError: Bool?
    var isSuccess: Bool?
    var isInfo: Bool?
    var Message: String?
    var StatusCode: Int?
    var Value: Int?
}
