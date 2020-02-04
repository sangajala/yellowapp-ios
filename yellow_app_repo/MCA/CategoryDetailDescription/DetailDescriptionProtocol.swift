//
//  DetailDescriptionProtocol.swift
//  MCA
//
//  Created by Goutham Devaraju on 28/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation
import CoreLocation

protocol DetailDescriptionPresenterProtocol: class {
    
//    func fetchBusinessIndividualDetails(serviceid: Int)
    func fetchBusinessIndividualDetails(serviceid: Int, categoryType: CategoryType)
    
}

protocol DetailDescriptionViewProtocol: class {
    
    func fetchBusinessIndividualDetails()
    
    func responseBusinessIndividualData(businessModel: BusinessIndividualModel)
    func responseEventsIndividualData(businessModel: EventsIndividualModel)
    func responsePromotionsIndividualData(businessModel: PromotionsIndividualModel)
    func responseOrganisationsIndividualData(businessModel: OrganisationIndividualModel)
    
    func responseAddWallet(addWalletModel: AddWalletModel)
}
