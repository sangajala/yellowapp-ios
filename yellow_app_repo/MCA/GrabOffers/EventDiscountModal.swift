// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let eventDiscountModal = try? newJSONDecoder().decode(EventDiscountModal.self, from: jsonData)

import Foundation

// MARK: - EventDiscountModal
struct EventDiscountModal: Codable {
    let id, eventID: Int
    let title: String
    let url: String
    let discCode: String
    let image: String?
    let message: EventDiscountModalMessage
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case eventID = "EventId"
        case title = "Title"
        case url = "Url"
        case discCode = "DiscCode"
        case image = "Image"
        case message = "Message"
    }
}

// MARK: - Message
struct EventDiscountModalMessage: Codable {
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
