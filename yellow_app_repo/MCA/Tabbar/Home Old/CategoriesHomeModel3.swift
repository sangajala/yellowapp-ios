// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categoriesHomeModel = try? newJSONDecoder().decode(CategoriesHomeModel.self, from: jsonData)

import Foundation

// MARK: - CategoriesHomeModel
struct CategoriesHomeModel3: Codable {
    let categoriesDetails: [CategoriesDetail]
    let message: Message3
    
    enum CodingKeys: String, CodingKey {
        case categoriesDetails = "CategoriesDetails"
        case message = "Message"
    }
}

// MARK: - CategoriesDetail
struct  CategoriesDetail: Codable {
    let categoryID: Int?
    let categoryName: String?
    let catIcon: String?
    let subCatcount: Int?
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "Category_Id"
        case categoryName = "Category_name"
        case catIcon = "Cat_Icon"
        case subCatcount
    }
}

// MARK: - Message
struct Message3: Codable {
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


