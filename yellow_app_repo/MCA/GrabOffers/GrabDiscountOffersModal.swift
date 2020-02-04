// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let promotionDiscountModal = try? newJSONDecoder().decode(PromotionDiscountModal.self, from: jsonData)

import Foundation

// MARK: - PromotionDiscountModal
struct PromotionDiscountModal: Codable {
    let id, promotionID: Int
    let image: String
    let discCode: String
    let url: String?
    let title: String
    let message: PromotionDiscountModalMessage
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case promotionID = "PromotionID"
        case image = "Image"
        case discCode = "DiscCode"
        case url = "Url"
        case title = "Title"
        case message = "Message"
    }
}

// MARK: - Message
struct PromotionDiscountModalMessage: Codable {
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
