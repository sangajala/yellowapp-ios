//
//  ContactUsModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 27/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

//{
//    "Service_Id": 6,
//    "Title": "DFC Chicken",
//    "Address1": "Ramatalkies Area, Dwaraka Nagar, Visakhapatnam, Andhra Pradesh, India",
//    "City": "Visakhapatnam",
//    "Postcode": "530001",
//    "Phone": "7207404444",
//    "Latitude": "17.7286243",
//    "Website": "http://mcaindia.bananaapps.co.uk",
//    "Longitude": "83.3104553",
//    "Email": "dummy@gmail.com",
//    "Description": "They have all Chicken items, burgers, ice creams etc",
//    "Message": {
//        "isWarning": false,
//        "isError": false,
//        "isSuccess": true,
//        "isInfo": false,
//        "Message": "Service details are retrieved successfully",
//        "StatusCode": 200,
//        "Value": 0
//    }
//}

struct ContactUsModel: Codable {
    
    var Service_Id: Int?
    var Title: String?
    var Address1: String?
    var City: String?
    var Postcode: String?
    var Phone: String?
    var Latitude: String?
    var Website: String?
    var Longitude: String?
    var Email: String?
    var Description: String?
    
    var Message: Message
    
    struct Message : Codable {
        
        var isWarning: Bool?
        var isError: Bool?
        var isSuccess: Bool?
        var isInfo: Bool?
        var Message: String?
        var StatusCode: Int?
        var Value: Int?
    }
}
