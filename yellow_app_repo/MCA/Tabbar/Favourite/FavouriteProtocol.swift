//
//  FavouriteProtocol.swift
//  MCA
//
//  Created by Goutham Devaraju on 02/09/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

protocol FavouritePresenterProtocol: class {
 
    func fetchBusinessFavourites(user_id: Int)
    func fetchBusinessFavourites_Event(user_id: Int)
    func fetchBusinessFavourites_Promotions(user_id: Int)
    func fetchBusinessFavourites_Organization(user_id: Int)
    
}

protocol FavouriteViewProtocol: class {
    
    func createPresenterInstanceAndFetchFavouritesBusiness()
    
    func responseFavouriteBusiness(businessModel: BusinessModel)
    func responseFavouriteBusiness_Event(eventsModel: EventsModel)
    func responseFavouriteBusiness_Promotions(promotionsModel: PromotionsModel)
    func responseFavouriteBusiness_Origanisation(organisationsModel: OrganisationModel)
    
}
