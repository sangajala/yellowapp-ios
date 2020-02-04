//
//  ReportModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 30/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

//{
//    "isWarning": false,
//    "isError": false,
//    "isSuccess": true,
//    "isInfo": false,
//    "Message": "Report sent successfully",
//    "StatusCode": 200,
//    "Value": 0
//}

struct ReportModel: Codable {
    
    var isWarning: Bool?
    var isError: Bool?
    var isSuccess: Bool?
    var isInfo: Bool?
    var Message: String?
    var StatusCode: Int?
    var Value: Int?
    
}
