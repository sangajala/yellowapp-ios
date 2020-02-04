//
//  AppConstants.swift
//  MCA
//
//  Created by Goutham Devaraju on 21/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

let isLocationBased = 0

let key_user_id = "user_id"
let key_location_id = "location_id"
let key_location_name = "location_name"
let key_city_name = "City_name"
let key_select_last_tab = "Select_last_tab"
let key_is_present_to_login = "Is_present_to_login"

let isWelcomeScreenDispalayed = "isWelcomeScreenDispalayed"

struct AlertControlOptions {
    
    static let ok = "Ok"
    static let cancel = "Cancel"
    static let retry = "Retry"
    static let skip = "Skip"
    static let login = "Login"
}

//struct CategoryType {
//
//    static let business = "business"
//    static let promotions = "promotions"
//    static let events = "events"
//    static let organisations = "organisations"
//}

public enum CategoryType{
    case business
    case promotions
    case events
    case organisations
}
