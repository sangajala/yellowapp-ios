//
//  LocationPresenterProtocol.swift
//  MCA
//
//  Created by Goutham Devaraju on 02/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

protocol LocationSelectPresenterProtocol: class {
    
    func getLocationsFromServer()
    
}

protocol LocationSelectViewProtocol: class {
    
    func communitySelectResponse(communitySelectModel: CommunitySelectModel)
    
    func locationSelectResponse(locationSelectModel: LocationSelectModel)
}


protocol HomeLocationSelectPresenterProtocol: class {
    
    func getLocationsFromServer()
    
}

protocol HomeLocationSelectViewProtocol: class {
    
    func communitySelectResponse(communitySelectModel: CommunitySelectModel)
    
    func locationSelectResponse(locationSelectModel: LocationSelectModel)
}
