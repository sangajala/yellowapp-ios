// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bussinessList = try? newJSONDecoder().decode(BussinessList.self, from: jsonData)

import Foundation

// MARK: - BussinessList
struct BussinessListModal: Codable {
    let servicesUserList: [ServicesUserList]
    let images: [BussinessList_Image]
    let message: BussinessList_Message
    
    enum CodingKeys: String, CodingKey {
        case servicesUserList = "ServicesUserList"
        case images = "Images"
        case message = "Message"
    }
}

// MARK: - Image
class BussinessList_Image: Codable {
    let imageURL: String?
    let imageID: Int?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "Image_Url"
        case imageID = "Image_Id"
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        self.imageID = try container.decodeIfPresent(Int.self, forKey: .imageID) ?? 0
        
    }
}

// MARK: - Message
struct BussinessList_Message: Codable {
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

// MARK: - ServicesUserList
class ServicesUserList: Codable {
    let serviceID: Int
    let title, location: String
    let rating: Double
    let image: String
    let views: Int
    let latitude, longitude, isFeature, address: String?
    let servicesUserListDescription: String
    let catid, subcatid: Int
    let city, postcode, phone, email: String
    let website, catname, subcatname, createdDatetime: String
    let images: [BussinessList_Image]?
    let updatedDatetime, withinCommunity: String
    
    enum CodingKeys: String, CodingKey {
        case serviceID = "ServiceId"
        case title = "Title"
        case location = "Location"
        case rating = "Rating"
        case image = "Image"
        case views = "Views"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case isFeature = "IsFeature"
        case address = "Address"
        case servicesUserListDescription = "Description"
        case catid, subcatid
        case city = "City"
        case postcode = "Postcode"
        case phone = "Phone"
        case email = "Email"
        case website = "Website"
        case catname = "Catname"
        case subcatname = "Subcatname"
        case createdDatetime = "Created_Datetime"
        case images = "Images"
        case updatedDatetime = "Updated_Datetime"
        case withinCommunity = "WithinCommunity"
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.serviceID = try container.decodeIfPresent(Int.self, forKey: .serviceID) ?? 0
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 0.0
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.views = try container.decodeIfPresent(Int.self, forKey: .views) ?? 0
        self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude) ?? "51.5074"
        self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude) ?? "0.1278"
        self.isFeature = try container.decodeIfPresent(String.self, forKey: .isFeature) ?? ""
        self.address = try container.decodeIfPresent(String.self, forKey: .address) ?? ""
        self.servicesUserListDescription = try container.decodeIfPresent(String.self, forKey: .servicesUserListDescription) ?? ""

        self.catid = try container.decodeIfPresent(Int.self, forKey: .catid) ?? 0
        self.subcatid = try container.decodeIfPresent(Int.self, forKey: .subcatid) ?? 0

        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.postcode = try container.decodeIfPresent(String.self, forKey: .postcode) ?? ""
        self.phone = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.website = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.catname = try container.decodeIfPresent(String.self, forKey: .catname) ?? ""
        self.subcatname = try container.decodeIfPresent(String.self, forKey: .subcatname) ?? ""
//        self.images = [BussinessList_Image]
        self.images = try container.decodeIfPresent(Array.self, forKey: .images) ?? []
        self.createdDatetime = try container.decodeIfPresent(String.self, forKey: .createdDatetime) ?? ""
        self.updatedDatetime = try container.decodeIfPresent(String.self, forKey: .updatedDatetime) ?? ""
        self.withinCommunity = try container.decodeIfPresent(String.self, forKey: .withinCommunity) ?? ""
        //        self.distance = try container.decodeIfPresent(Double.self, forKey: .distance) ?? 0.0
        //        self.createdDate = try container.decodeIfPresent(Int.self, forKey: .createdDate) ?? 0
    }
}



//class JSONAny: Codable {
//
//    let value: Any
//
//    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
//        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
//        return DecodingError.typeMismatch(JSONAny.self, context)
//    }
//
//    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
//        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
//        return EncodingError.invalidValue(value, context)
//    }
//
//    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
//        if let value = try? container.decode(Bool.self) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self) {
//            return value
//        }
//        if let value = try? container.decode(Double.self) {
//            return value
//        }
//        if let value = try? container.decode(String.self) {
//            return value
//        }
//        if container.decodeNil() {
//            return JSONNull()
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
//        if let value = try? container.decode(Bool.self) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self) {
//            return value
//        }
//        if let value = try? container.decode(Double.self) {
//            return value
//        }
//        if let value = try? container.decode(String.self) {
//            return value
//        }
//        if let value = try? container.decodeNil() {
//            if value {
//                return JSONNull()
//            }
//        }
//        if var container = try? container.nestedUnkeyedContainer() {
//            return try decodeArray(from: &container)
//        }
//        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
//            return try decodeDictionary(from: &container)
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
//        if let value = try? container.decode(Bool.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(Double.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(String.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decodeNil(forKey: key) {
//            if value {
//                return JSONNull()
//            }
//        }
//        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
//            return try decodeArray(from: &container)
//        }
//        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
//            return try decodeDictionary(from: &container)
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
//        var arr: [Any] = []
//        while !container.isAtEnd {
//            let value = try decode(from: &container)
//            arr.append(value)
//        }
//        return arr
//    }
//
//    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
//        var dict = [String: Any]()
//        for key in container.allKeys {
//            let value = try decode(from: &container, forKey: key)
//            dict[key.stringValue] = value
//        }
//        return dict
//    }
//
//    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
//        for value in array {
//            if let value = value as? Bool {
//                try container.encode(value)
//            } else if let value = value as? Int64 {
//                try container.encode(value)
//            } else if let value = value as? Double {
//                try container.encode(value)
//            } else if let value = value as? String {
//                try container.encode(value)
//            } else if value is JSONNull {
//                try container.encodeNil()
//            } else if let value = value as? [Any] {
//                var container = container.nestedUnkeyedContainer()
//                try encode(to: &container, array: value)
//            } else if let value = value as? [String: Any] {
//                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
//                try encode(to: &container, dictionary: value)
//            } else {
//                throw encodingError(forValue: value, codingPath: container.codingPath)
//            }
//        }
//    }
//
//    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
//        for (key, value) in dictionary {
//            let key = JSONCodingKey(stringValue: key)!
//            if let value = value as? Bool {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? Int64 {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? Double {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? String {
//                try container.encode(value, forKey: key)
//            } else if value is JSONNull {
//                try container.encodeNil(forKey: key)
//            } else if let value = value as? [Any] {
//                var container = container.nestedUnkeyedContainer(forKey: key)
//                try encode(to: &container, array: value)
//            } else if let value = value as? [String: Any] {
//                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
//                try encode(to: &container, dictionary: value)
//            } else {
//                throw encodingError(forValue: value, codingPath: container.codingPath)
//            }
//        }
//    }
//
//    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
//        if let value = value as? Bool {
//            try container.encode(value)
//        } else if let value = value as? Int64 {
//            try container.encode(value)
//        } else if let value = value as? Double {
//            try container.encode(value)
//        } else if let value = value as? String {
//            try container.encode(value)
//        } else if value is JSONNull {
//            try container.encodeNil()
//        } else {
//            throw encodingError(forValue: value, codingPath: container.codingPath)
//        }
//    }
//
//    public required init(from decoder: Decoder) throws {
//        if var arrayContainer = try? decoder.unkeyedContainer() {
//            self.value = try JSONAny.decodeArray(from: &arrayContainer)
//        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
//            self.value = try JSONAny.decodeDictionary(from: &container)
//        } else {
//            let container = try decoder.singleValueContainer()
//            self.value = try JSONAny.decode(from: container)
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        if let arr = self.value as? [Any] {
//            var container = encoder.unkeyedContainer()
//            try JSONAny.encode(to: &container, array: arr)
//        } else if let dict = self.value as? [String: Any] {
//            var container = encoder.container(keyedBy: JSONCodingKey.self)
//            try JSONAny.encode(to: &container, dictionary: dict)
//        } else {
//            var container = encoder.singleValueContainer()
//            try JSONAny.encode(to: &container, value: self.value)
//        }
//    }
//}
