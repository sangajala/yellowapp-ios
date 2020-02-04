// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bussinessCategory = try? newJSONDecoder().decode(BussinessCategory.self, from: jsonData)

import Foundation
//
//"serviceid" : "2",
//"subcatid" : "2",
//"title" : "test",
//"userid" : "2",

// MARK: - BussinessCategory
struct BussinessCategory1: Codable {
    let categoriesDetails: [CategoriesDetail1]
    let message: Message1
    
    enum CodingKeys: String, CodingKey {
        case categoriesDetails = "CategoriesDetails"
        case message = "Message"
    }
}

// MARK: - CategoriesDetail
struct CategoriesDetail1: Codable {
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
struct Message1: Codable {
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

// MARK: - BussinessSubCategory
struct BussinessSubCategory: Codable {
    let subCategoriesDetails: [SubCategoriesDetail]
    let message: bSubCatMessage
    
    enum CodingKeys: String, CodingKey {
        case subCategoriesDetails = "SubCategoriesDetails"
        case message = "Message"
    }
}

// MARK: - Message
struct bSubCatMessage: Codable {
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

// MARK: - SubCategoriesDetail
struct SubCategoriesDetail: Codable {
    let subcategoryID, categoryID: Int?
    let categoryName, subcatName: String?
    let subcatIcon: String?
    let r, g, b: Int?
    
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

