//
//  ForgotpasswordModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 26/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation
struct ForgotpasswordModel: Codable {
    
    //    {
    //    "isWarning": false,
    //    "isError": false,
    //    "isSuccess": true,
    //    "isInfo": false,
    //    "Message": "User registered successfully.",
    //    "StatusCode": 200,
    //    "Value": 180
    //    }
    
    var isWarning: Bool?
    var isError: Bool?
    var isSuccess: Bool?
    var isInfo: Bool?
    var Message: String?
    var StatusCode: Int?
    var Value: Int?
    
    
}
