//
//  LocationSelectModel.swift
//  MCA
//
//  Created by Goutham Devaraju on 02/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

struct LocationSelectModel: Codable {
    
//    {
//    "Locations": [
//    {
//    "Location_ID": 2,
//    "Location": "London",
//    "Latitude": "50.5095",
//    "Longitude": "0.1278",
//    "Image": "http://mca.bananaapps.co.uk/UpImages/Master/Community/commimage_171_west_london.png"
//    },
//    {
//    "Location_ID": 3,
//    "Location": "Edgbaston",
//    "Latitude": "52.4608",
//    "Longitude": "1.9150",
//    "Image": "http://mca.bananaapps.co.uk/UpImages/Master/Community/commimage_455_edgebaston.png"
//    },
//    {
//    "Location_ID": 4,
//    "Location": "East London",
//    "Latitude": "33.0292",
//    "Longitude": "27.8546",
//    "Image": "http://mca.bananaapps.co.uk/UpImages/Master/Community/commimage_412_edgebaston.png"
//    }
//    ],
//    "Message": {
//    "isWarning": false,
//    "isError": false,
//    "isSuccess": true,
//    "isInfo": false,
//    "Message": "Location details are retrieved successfully",
//    "StatusCode": 200,
//    "Value": 0
//    }
//    }
    
    
    var Locations: [Locations]
    struct Locations: Codable {
        
        var Location_ID: Int?
        var Location: String?
        var Latitude: String?
        var Longitude: String?
        var Image: String?
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

struct Locations {
    
    var Location_ID: Int?
    var Location: String?
    var Latitude: String?
    var Longitude: String?
    var Image: String?
    
    
}
    

