// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let serviceCategoryListModel = try? newJSONDecoder().decode(ServiceCategoryListModel.self, from: jsonData)

import Foundation

// MARK: - ServiceCategoryListModel
struct ServiceCategoryListModel: Codable {
    let categoryimagesDetails: [CategoryimagesDetail]
    let moduleCount: ModuleCount
    let message: Message
    
    enum CodingKeys: String, CodingKey {
        case categoryimagesDetails = "CategoryimagesDetails"
        case moduleCount = "ModuleCount"
        case message = "Message"
    }
}

// MARK: - CategoryimagesDetail
struct CategoryimagesDetail: Codable {
    let imageid: Int
    let category: String
    let url: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case imageid
        case category = "Category"
        case url = "Url"
        case image = "Image"
    }
}

// MARK: - ModuleCount
struct ModuleCount: Codable {
    let business, promotions, events, organizations: Int
    
    enum CodingKeys: String, CodingKey {
        case business = "Business"
        case promotions = "Promotions"
        case events = "Events"
        case organizations = "Organizations"
    }
}
