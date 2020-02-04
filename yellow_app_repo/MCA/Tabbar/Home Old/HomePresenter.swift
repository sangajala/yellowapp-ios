//
//  HomePresenter.swift
//  MCA
//
//  Created by Goutham Devaraju on 04/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

class HomePresenterImplementation: HomePresenterProtocol {
    
    var homeViewController: HomeViewController!
    
    var homeModel: HomeModel!
    
    required init(viewController: HomeViewController){
        homeViewController = viewController
    }
    
    //MARK: - Get Home Locations
    func getHomeData(location_id: Int, user_id: Int){
        

        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.homeViewController, onCompletion: { (string: String) -> () in })
            return
        }
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        var payloadParams = [:] as [String: Any]
        
        if isLocationBased == 0{
            payloadParams = [
                "CommunityId": location_id,
                "User_ID": user_id
                ] as [String : Any]
        }
        else{
            payloadParams = [
                "Location_ID": location_id,
                "User_ID": user_id
                ] as [String : Any]
        }
        
        _ = NetworkInterface.getRequest(.home_get, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
//            DispatchQueue.main.async {
//                self.homeViewController?.removeActivityIndicator()
//            }
            
            guard let _ = data else{
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("JSON: \(json)")
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(HomeModel.self, from: data!)
                
                self.homeModel = response
                
                //Passing back values to ViewController to make use of the data
                self.homeViewController?.homeDataResponse(homeModel: response)
                
            }
            catch {
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
        
    }
    
}
