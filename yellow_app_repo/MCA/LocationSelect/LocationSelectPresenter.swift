//
//  LocationSelectPresenter.swift
//  MCA
//
//  Created by Goutham Devaraju on 02/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

class LocationSelectPresenterImplementation: LocationSelectPresenterProtocol {
    
    var locationSelectViewController: LocationSelectViewController!
    
    required init(viewController: LocationSelectViewController){
        locationSelectViewController = viewController
    }
    
    func getLocationsFromServer() {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.locationSelectViewController, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.locationSelectViewController.view)
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        _ = NetworkInterface.getRequest(.community_locations_get , headers: headers as NSDictionary , params: nil) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
//            DispatchQueue.main.async {
//                self.locationSelectViewController?.removeActivityIndicator()
//            }
            
            guard let _ = data else{
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            if data != nil{
                
                do{
                    
                    
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(LocationSelectModel.self, from: data!)
                    
                    //Passing back values to ViewController to make use of the data
                    self.locationSelectViewController?.locationSelectResponse(locationSelectModel: response)
                    
                }
                catch{
                    AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                }
            }
            else{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
    
    func getCommunityUsers() {
        
//        DispatchQueue.main.async {
//            self.locationSelectViewController?.addActivityIndicatorView()
//        }
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.locationSelectViewController, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.locationSelectViewController.view)

        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        _ = NetworkInterface.getRequest(.community_users_get , headers: headers as NSDictionary , params: nil) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
//            DispatchQueue.main.async {
//                self.locationSelectViewController?.removeActivityIndicator()
//            }
            
            guard let _ = data else{
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            if data != nil{
                
//                do {
//                    // make sure this JSON is in the format we expect
//                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                        // try to read out a string array
////                        if let names = json["names"] as? [String] {
//                            print(json)
////                        }
//                    }
//                } catch let error as NSError {
//                    print("Failed to load: \(error.localizedDescription)")
//                }
                
                do {
                    
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(CommunitySelectModel.self, from: data!)
                    
                    //Passing back values to ViewController to make use of the data
                    self.locationSelectViewController.communitySelectResponse(communitySelectModel: response)
                    
                }
                catch {
                    AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                }
                
            }
            else{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
}


