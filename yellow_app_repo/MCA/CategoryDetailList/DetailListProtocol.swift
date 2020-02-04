//
//  DetailListProtocol.swift
//  MCA
//
//  Created by Goutham Devaraju on 14/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation
import CoreLocation

protocol DetailListPresenterProtocol: class {
    
    func resignAllResponders()
    
//    "Req.cat_ID" : "",
//    "Req.title" : "",
//    "Req.sub_Cat_ID"
    func fetchBusinessDetails(location_id: Int, user_id: Int, Req_cat_ID : Int, Req_title : String, Req_sub_Cat_ID : Int)
    
    func sortByRatings()
    
    func sortByViews()
    
    func sortByLocation()
    
    func sortByDate()
    
    func processDistanceAndStore(currentLocation: CLLocation)
    
}

protocol DetailListViewProtocol: class {
    
    func responseBusinessData(businessModel: BusinessModel)
    func responseEventsData(businessModel: EventsModel)
    func responsePromotionsData(businessModel: PromotionsModel)
    func responseOrganisationsData(businessModel: OrganisationModel)
    
}
