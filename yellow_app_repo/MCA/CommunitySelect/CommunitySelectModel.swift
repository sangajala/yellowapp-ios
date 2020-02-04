//
//  CommunitySelectModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 14/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

struct CommunitySelectModel: Codable{
    
//    {
//    "CommUsers": [
//    {
//    "Id": 2,
//    "CommunityName": "Gateway",
//    "Heroimage": "http://mcaindia.bananaapps.co.uk/Content/CommunityUser/Heroimage/heroimage_108__dsc7025_edited.jpg",
//    "Logo": "http://mcaindia.bananaapps.co.uk/Content/CommunityUser/Logo/logoimage_385_house_PNG44.png"
//    },
//    {
//    "Id": 4,
//    "CommunityName": "Karthikeya",
//    "Heroimage": "http://mcaindia.bananaapps.co.uk/Content/CommunityUser/Heroimage/heroimage_486_BhoomathaHero.png",
//    "Logo": "http://mcaindia.bananaapps.co.uk/Content/CommunityUser/Logo/logoimage_326_BhoomathaHero.png"
//    },
//    {
//    "Id": 5,
//    "CommunityName": "Annanya",
//    "Heroimage": "http://mcaindia.bananaapps.co.uk/Content/CommunityUser/Heroimage/heroimage_29_residential-apartment-250x250.png",
//    "Logo": "http://mcaindia.bananaapps.co.uk/Content/CommunityUser/Logo/logoimage_485_residential-apartment-250x250.png"
//    }
//    ],
//    "Message": {
//    "isWarning": false,
//    "isError": false,
//    "isSuccess": true,
//    "isInfo": false,
//    "Message": "User details are retrieved successfully",
//    "StatusCode": 200,
//    "Value": 0
//    }
//    }

    var CommUsers : [CommunityUsers]
    struct CommunityUsers: Codable {
        
        var Id: Int?
        var CommunityName: String?
        var Heroimage: String?
        var Logo: String?
    }
    
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

struct CommunityUsers: Codable {
    
    var Id: Int?
    var CommunityName: String?
    var Heroimage: String?
    var Logo: String?
    
}
