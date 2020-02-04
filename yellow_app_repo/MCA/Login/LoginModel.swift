//
//  LoginModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 21/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

struct LoginModel: Codable {
    
//    {
//    "UserID": 0,
//    "username": null,
//    "phone": null,
//    "Prof_Pic": null,
//    "Message": {
//    "isWarning": false,
//    "isError": true,
//    "isSuccess": false,
//    "isInfo": false,
//    "Message": "Invalid Email or Password.",
//    "StatusCode": 401,
//    "Value": 0
//    }
//    }

    
    var UserID: Int?
    var username: String?
    var phone: String?
    var Prof_Pic: String?
    
    let Message: Message
    
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
