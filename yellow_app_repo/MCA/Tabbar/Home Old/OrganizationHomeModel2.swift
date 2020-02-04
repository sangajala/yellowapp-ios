// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let organizationHomeModel = try? newJSONDecoder().decode(OrganizationHomeModel.self, from: jsonData)

import Foundation

// MARK: - OrganizationHomeModel
struct OrganizationHomeModel2: Codable {
    let organizationList: [OrganizationList2]
    let message: Message2
    
    enum CodingKeys: String, CodingKey {
        case organizationList = "OrganizationList"
        case message = "Message"
    }
}

// MARK: - Message
struct Message2: Codable {
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

// MARK: - OrganizationList
class OrganizationList2: Codable {
    let orgID: Int?
    let title, location: String?
    let image: String?
    let views: Int?
    let isFeature: String?
    let latitude, longitude, createdDatetime, updatedDatetime: String?
    
    enum CodingKeys: String, CodingKey {
        case orgID = "Org_Id"
        case title = "Title"
        case location = "Location"
        case image = "Image"
        case views = "Views"
        case isFeature = "IsFeature"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case createdDatetime = "Created_Datetime"
        case updatedDatetime = "Updated_Datetime"
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.orgID = try container.decodeIfPresent(Int.self, forKey: .orgID) ?? 0
        self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude) ?? "51.5074"
        self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude) ?? "0.1278"
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.views = try container.decodeIfPresent(Int.self, forKey: .views) ?? 0
        self.isFeature = nil
        self.createdDatetime = try container.decodeIfPresent(String.self, forKey: .createdDatetime) ?? ""
        self.updatedDatetime = try container.decodeIfPresent(String.self, forKey: .updatedDatetime) ?? ""
       
    }
}

// MARK: - Encode/decode helpers

class JSONNull2: Codable, Hashable {
    static func == (lhs: JSONNull2, rhs: JSONNull2) -> Bool {
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
