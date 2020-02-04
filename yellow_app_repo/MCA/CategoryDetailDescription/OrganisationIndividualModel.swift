//
//  OrganisationIndividualModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 02/09/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

class OrganisationIndividualModel: Codable {
    
    var Organisation_Id: Int?
    var Title: String?
    var Description: String?
    var Location: String?
    var Rating: Int?
    var Image: String?
    var Views: Int?
    var IsWallet: String?
    var IsFeature: String?
    var Created_Datetime: String?
    var Updated_Datetime: String?
    
    var Message: OrganisationIndividualModelMessage?
    var Images: [OrganisationIndividualModelImages]?
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Organisation_Id = try container.decodeIfPresent(Int.self, forKey: .Organisation_Id) ?? 0
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

class OrganisationIndividualModelMessage : Codable {
    
    var isWarning: Bool?
    var isError: Bool?
    var isSuccess: Bool?
    var isInfo: Bool?
    var Message: String?
    var StatusCode: Int?
    var Value: Int?
}

class OrganisationIndividualModelImages : Codable {
    
    var Image_Id: Int?
    var Image_Url: String?
}

