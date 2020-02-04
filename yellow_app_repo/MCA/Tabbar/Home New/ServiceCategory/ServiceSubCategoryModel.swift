// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let serviceSubCategoryModel = try? newJSONDecoder().decode(ServiceSubCategoryModel.self, from: jsonData)

import Foundation

// MARK: - ServiceSubCategoryModel
struct ServiceSubCategoryModel: Codable {
    let subCategoriesDetails: [SubCategoriesDetail1]
    let message: Message
    
    enum CodingKeys: String, CodingKey {
        case subCategoriesDetails = "SubCategoriesDetails"
        case message = "Message"
    }
}

// MARK: - SubCategoriesDetail
struct SubCategoriesDetail1: Codable {
    let subcategoryID, categoryID: Int
    let categoryName, subcatName: String
    let subcatIcon: String
    let r, g, b: Int
    
    enum CodingKeys: String, CodingKey {
        case subcategoryID = "Subcategory_Id"
        case categoryID = "Category_Id"
        case categoryName = "Category_Name"
        case subcatName = "Subcat_name"
        case subcatIcon = "Subcat_Icon"
        case r = "R"
        case g = "G"
        case b = "B"
    }
}
