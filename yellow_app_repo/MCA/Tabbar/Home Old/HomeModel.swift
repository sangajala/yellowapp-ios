//
//  HomeModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 04/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

//struct HomeModel: Codable {
//
//
//    var Profile: Profile
//    struct Profile: Codable {
//
//        var User_ID: Int?
//        var Name : String?
//        var Profile_Pic: String?
//    }
//
//    var ModuleCount: ModuleCount
//    struct ModuleCount: Codable {
//
//        var Business: Int?
//        var Promotions: Int?
//        var Events: Int?
//        var Organizations: Int?
//    }
//
//    var HomeData: [HomeData]
//    struct HomeData: Codable {
//
//        var ModuleName: String?
//        var Description: String?
//
//        var Data: [Data]
//        struct Data: Codable {
//
//            var title: String?
//            var location: String?
//            var id: Int?
//            var image: String?
//            var createdDatetime: String?
//        }
//    }
//
//    var sliderimages: [Sliderimages]
//    struct Sliderimages: Codable {
//
//        var Id: Int?
//        var Image: String?
//        var Url: String?
//    }
//
//    var Message: Message
//    struct Message : Codable {
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


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeModel = try? newJSONDecoder().decode(HomeModel.self, from: jsonData)

import Foundation

// MARK: - HomeModel
struct HomeModel: Codable {
    let profile: HomeModelProfile
    let moduleCount: HomeModelModuleCount
    let homeData: [HomeModelHomeDatum]
    let sliderimages: [HomeModelProfileSliderimage]
    let message: HomeModelMessage
    
    enum CodingKeys: String, CodingKey {
        case profile = "Profile"
        case moduleCount = "ModuleCount"
        case homeData = "HomeData"
        case sliderimages
        case message = "Message"
    }
}

// MARK: - HomeDatum
class HomeModelHomeDatum: Codable {
    let moduleName, homeDatumDescription: String
    let data: [Datum]
    
    enum CodingKeys: String, CodingKey {
        case moduleName = "ModuleName"
        case homeDatumDescription = "Description"
        case data = "Data"
    }
}

// MARK: - Datum
class Datum: Codable {
    let title, location: String
    let id: Int
    let image: String
    let createdDatetime, latitude, longitude: String
    
    enum CodingKeys: String, CodingKey {
        case title, location, id, image, createdDatetime
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude) ?? "51.5074"
        self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude) ?? "0.1278"
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.createdDatetime = try container.decodeIfPresent(String.self, forKey: .createdDatetime) ?? ""
    }
    
}

// MARK: - Message
class HomeModelMessage: Codable {
    let isWarning, isError, isSuccess, isInfo: Bool
    let message: String
    let statusCode, value: Int
    
    enum CodingKeys: String, CodingKey {
        case isWarning, isError, isSuccess, isInfo
        case message = "Message"
        case statusCode = "StatusCode"
        case value = "Value"
    }
}

// MARK: - ModuleCount
class HomeModelModuleCount: Codable {
    let business, promotions, events, organizations: Int?
    
    enum CodingKeys: String, CodingKey {
        case business = "Business"
        case promotions = "Promotions"
        case events = "Events"
        case organizations = "Organizations"
    }
}

// MARK: - Profile
class HomeModelProfile: Codable {
    let userID: Int
    let name, profilePic: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "User_ID"
        case name = "Name"
        case profilePic = "Profile_Pic"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userID = try container.decodeIfPresent(Int.self, forKey: .userID) ?? 0
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.profilePic = try container.decodeIfPresent(String.self, forKey: .profilePic) ?? ""
    }
}

// MARK: - Sliderimage
class HomeModelProfileSliderimage: Codable {
    let id: Int
    let image: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case image = "Image"
        case url = "Url"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
    
    
}
