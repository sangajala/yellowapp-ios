//
//  AddWalletModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 30/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

struct AddWalletModel: Codable {
    
    var isWarning: Bool?
    var isError: Bool?
    var isSuccess: Bool?
    var isInfo: Bool?
    var Message: String?
    var StatusCode: Int?
    var Value: Int?
}


struct RemoveWalletModel: Codable {
    
    var isWarning: Bool?
    var isError: Bool?
    var isSuccess: Bool?
    var isInfo: Bool?
    var Message: String?
    var StatusCode: Int?
    var Value: Int?
    

}

