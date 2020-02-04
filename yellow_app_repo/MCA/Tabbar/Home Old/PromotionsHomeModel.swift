//
//  PromotionsModel.swift
//  MCA
//
//  Created by Arthonsys Ben on 02/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

// MARK: - PromotionsModel
struct PromotionsHomeModel: Codable {
    let promotionsList: [PromotionsList]
    let message: Message
    
    enum CodingKeys: String, CodingKey {
        case promotionsList = "PromotionsList"
        case message = "Message"
    }
}

// MARK: - Message
struct Message: Codable {
    let isWarning, isError, isSuccess, isInfo: Bool?
    let message: String?
    let statusCode, value: Int?
    
    enum CodingKeys: String, CodingKey {
        case isWarning, isError, isSuccess, isInfo
        case message = "Message"
        case statusCode = "StatusCode"
        case value = "Value"
    }
}

// MARK: - PromotionsList
class PromotionsList: Codable {
    
    let proID: Int?
    let title, latitude, longitude, createdDatetime: String?
    let updatedDatetime: String?
    let location: String?//Location
    let rating: Double?
    let isFeature: String?
    let image: String?
    let views: Int?
    
//    let serviceID: Int
//    let title, location: String
//    let rating: Int
//    let image: String
//    let views: Int
//    var latitude, longitude: String
//    let isFeature: HomePageServicesListJSONNull?
//    let createdDatetime, updatedDatetime: String
    
    enum CodingKeys: String, CodingKey {
        case proID = "Pro_Id"
        case title = "Title"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case createdDatetime = "Created_Datetime"
        case updatedDatetime = "Updated_Datetime"
        case location = "Location"
        case rating = "Rating"
        case isFeature = "IsFeature"
        case image = "Image"
        case views = "Views"
    }
    
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.proID = try container.decodeIfPresent(Int.self, forKey: .proID) ?? 0
        self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude) ?? "51.5074"
        self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude) ?? "0.1278"
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 0.0
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.views = try container.decodeIfPresent(Int.self, forKey: .views) ?? 0
        self.isFeature = try container.decodeIfPresent(String.self, forKey: .isFeature) ?? "nil"
        self.createdDatetime = try container.decodeIfPresent(String.self, forKey: .createdDatetime) ?? ""
        self.updatedDatetime = try container.decodeIfPresent(String.self, forKey: .updatedDatetime) ?? ""
    }
    
    
    
    
}

enum Location: String, Codable {
    case visakhapatnam = "Visakhapatnam"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}




// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeServicesList = try? newJSONDecoder().decode(HomeServicesList.self, from: jsonData)


// MARK: - HomeServicesList
struct HomeServicesList: Codable {
    var servicesList: [HomePageServicesList]
    let message: HomeServicesListMessage
    
    enum CodingKeys: String, CodingKey {
        case servicesList = "ServicesList"
        case message = "Message"
    }
}

// MARK: - Message
struct HomeServicesListMessage: Codable {
    let isWarning, isError, isSuccess, isInfo: Bool?
    let message: String?
    let statusCode, value: Int?
    
    enum CodingKeys: String, CodingKey {
        case isWarning, isError, isSuccess, isInfo
        case message = "Message"
        case statusCode = "StatusCode"
        case value = "Value"
    }
}

// MARK: - ServicesList
class HomePageServicesList: Codable {
    let serviceID: Int?
    let title, location: String?
    let rating: Int?
    let image: String?
    let views: Int?
    var latitude, longitude: String?
    let isFeature: String?
    let createdDatetime, updatedDatetime: String?
    
    enum CodingKeys: String, CodingKey {
        case serviceID = "Service_Id"
        case title = "Title"
        case location = "Location"
        case rating = "Rating"
        case image = "Image"
        case views = "Views"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case isFeature = "IsFeature"
        case createdDatetime = "Created_Datetime"
        case updatedDatetime = "Updated_Datetime"
       
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude) ?? "51.5074"
        self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude) ?? "0.1278"
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        self.rating = try container.decodeIfPresent(Int.self, forKey: .rating) ?? 0
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.views = try container.decodeIfPresent(Int.self, forKey: .views) ?? 0
        self.isFeature = try container.decodeIfPresent(String.self, forKey: .views) ?? " "
        self.createdDatetime = try container.decodeIfPresent(String.self, forKey: .createdDatetime) ?? ""
        self.updatedDatetime = try container.decodeIfPresent(String.self, forKey: .updatedDatetime) ?? ""
        self.serviceID = try container.decodeIfPresent(Int.self, forKey: .serviceID) ?? 0
    }
//     latitude == nil ? "0.9999" : latitude
}

// MARK: - Encode/decode helpers

//class HomePageServicesListJSONNull: Codable, Hashable {
//    static func == (lhs: HomePageServicesListJSONNull, rhs: HomePageServicesListJSONNull) -> Bool {
//         return true
//    }
//    //    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
////        return true
////    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}




// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeServicesList = try? newJSONDecoder().decode(HomeServicesList.self, from: jsonData)

import Foundation

// MARK: - HomeServicesList
struct HomeServices_List: Codable {
    let servicesList: [HomeServices_ListServicesList]
    let message: HomeServices_ListMessage
    
    enum CodingKeys: String, CodingKey {
        case servicesList = "ServicesList"
        case message = "Message"
    }
}

// MARK: - Message
struct HomeServices_ListMessage: Codable {
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

// MARK: - ServicesList
class HomeServices_ListServicesList: Codable {
    let serviceID: Int
    let title, location: String?
    let rating: Double?
    let image: String?
    let views: Int?
    let latitude, longitude: String?
    let isFeature: HomeServices_ListJSONNull?
    let createdDatetime, updatedDatetime: String?
    
    enum CodingKeys: String, CodingKey {
        case serviceID = "Service_Id"
        case title = "Title"
        case location = "Location"
        case rating = "Rating"
        case image = "Image"
        case views = "Views"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case isFeature = "IsFeature"
        case createdDatetime = "Created_Datetime"
        case updatedDatetime = "Updated_Datetime"
    }
   
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.serviceID = try container.decodeIfPresent(Int.self, forKey: .serviceID) ?? 0
        self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude) ?? "51.5074"
        self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude) ?? "0.1278"
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 0.0
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.views = try container.decodeIfPresent(Int.self, forKey: .views) ?? 0
        self.isFeature = nil
        self.createdDatetime = try container.decodeIfPresent(String.self, forKey: .createdDatetime) ?? "\(Data())"
        self.updatedDatetime = try container.decodeIfPresent(String.self, forKey: .updatedDatetime) ?? ""
    }
}

// MARK: - Encode/decode helpers

class HomeServices_ListJSONNull: Codable, Hashable {
    static func == (lhs: HomeServices_ListJSONNull, rhs: HomeServices_ListJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}




