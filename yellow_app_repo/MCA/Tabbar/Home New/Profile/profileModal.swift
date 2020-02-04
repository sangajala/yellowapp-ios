// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profileData = try? newJSONDecoder().decode(ProfileData.self, from: jsonData)

import Foundation

// MARK: - ProfileData
class ProfileData: Codable {
    let userid: Int
    let deviceid: String?
    let firstname, lastname, email, createdOn: String
    let updatedOn, profilePic: String
    var socialLoginID, socialLoginType, isSocial: String?
    let status: Bool
    let phone: String
    let msg: ProfileDataMsg?
    
    enum CodingKeys: String, CodingKey {
        case userid = "Userid"
        case deviceid = "Deviceid"
        case firstname = "Firstname"
        case lastname = "Lastname"
        case email = "Email"
        case createdOn = "CreatedOn"
        case updatedOn = "UpdatedOn"
        case profilePic = "Profile_Pic"
        case socialLoginID = "Social_LoginId"
        case socialLoginType = "Social_LoginType"
        case isSocial = "IsSocial"
        case status = "Status"
        case phone = "Phone"
        case msg = "Msg"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userid = try container.decodeIfPresent(Int.self, forKey: .userid) ?? 0
        self.deviceid = try container.decodeIfPresent(String.self, forKey: .deviceid) ?? ""
        self.firstname = try container.decodeIfPresent(String.self, forKey: .firstname) ?? ""
        self.lastname = try container.decodeIfPresent(String.self, forKey: .lastname) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn) ?? ""
        self.updatedOn = try container.decodeIfPresent(String.self, forKey: .updatedOn) ?? ""
        self.status = try container.decodeIfPresent(Bool.self, forKey: .status) ?? false
//        self.status = try container.decodeIfPresent(Bool.self, forKey: .status) ?? false
        self.profilePic = try container.decodeIfPresent(String.self, forKey: .profilePic) ?? ""
        self.socialLoginID = try container.decodeIfPresent(String.self, forKey: .socialLoginID) ?? ""
        self.socialLoginType = try container.decodeIfPresent(String.self, forKey: .socialLoginType) ?? ""
        self.isSocial = try container.decodeIfPresent(String.self, forKey: .isSocial) ?? ""
//        self.socialLoginType = try container.decodeIfPresent(String.self, forKey: .socialLoginType) ?? ""
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
//        self.phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        self.msg = try container.decodeIfPresent(ProfileDataMsg.self, forKey: .msg)
    }
}

// MARK: - Msg
struct ProfileDataMsg: Codable {
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

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
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
