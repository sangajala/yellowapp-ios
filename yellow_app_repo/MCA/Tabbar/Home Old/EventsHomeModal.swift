//
//  EventsHomeModal.swift
//  YELLOW APP
//
//  Created by Apple on 06/11/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

import Foundation

// MARK: - EventListModel
struct HomeEventListModel: Codable {
    let eventsList: [HomeEventsList]
    let message: Message
    
    enum CodingKeys: String, CodingKey {
        case eventsList = "EventsList"
        case message = "Message"
    }
}

// MARK: - EventsList
struct HomeEventsList: Codable {
    let eventID: Int
    let title: String
    let latitude, longitude: String?
    let createdDatetime, updatedDatetime, eventFromDate, eventToDate: String
    let location: String
    let views: Int
    let isFeature: String?
    let rating: Double
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case eventID = "Event_Id"
        case title = "Title"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case createdDatetime = "Created_Datetime"
        case updatedDatetime = "Updated_Datetime"
        case eventFromDate = "Event_FromDate"
        case eventToDate = "Event_ToDate"
        case location = "Location"
        case views = "Views"
        case isFeature = "IsFeature"
        case rating = "Rating"
        case image = "Image"
    }
}
