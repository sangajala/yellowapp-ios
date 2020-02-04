//
//  ContactUsProtocol.swift
//  MCA
//
//  Created by Goutham Devaraju on 27/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

protocol ContactUsPresenterProtocol: class{
    
    func fetchContactDetails(forService_id service_id: Int, user_id: Int)
    
}

protocol ContactUsViewProtocol: class {
    
    func responseContactDetailsData(contactUsModel: ContactUsModel)
    func responseEventsContactDetailsData(contactUsModel: ContactUsEventsModel)
    func responsePromotionsContactDetailsData(contactUsModel: ContactUsPromotionsModel)
    func responseOrganisationsContactDetailsData(contactUsModel: ContactUsOrganisationsModel)
    
}
