//
//  HomeProtocol.swift
//  MCA
//
//  Created by Goutham Devaraju on 04/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol: class {
    
    func getHomeData(location_id: Int, user_id: Int)
}

protocol HomeViewProtocol: class {
    
    func homeDataResponse(homeModel: HomeModel)
}
