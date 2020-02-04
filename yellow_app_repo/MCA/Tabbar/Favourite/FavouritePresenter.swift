//
//  FavouritePresenter.swift
//  MCA
//
//  Created by Goutham Devaraju on 02/09/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

class FavouritesPresenterImplementation: FavouritePresenterProtocol{
    
    var businessModel: BusinessModel!
    var eventsModel: EventsModel!
    var promotionsModel: PromotionsModel!
    var organisationsModel: OrganisationModel!
    
    var favouriteViewController: FavouriteViewController!
    
    required init(viewController: FavouriteViewController){
        favouriteViewController = viewController
    }
    
    func fetchBusinessFavourites(user_id: Int) {
        
        helper.startLoader(view: self.favouriteViewController.view)
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        let payloadParams = ["UserID": user_id] as [String : Any]
        
        _ = NetworkInterface.getRequest(.favourite_businesses_details_get, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                
                AppManager.shared.businessModel = nil
                
                if let vc = self.favouriteViewController.viewControllers[0] as? PagesVC {
                    vc.businessModel = [] //]self.businessModel.ServicesList
                    vc.favouritesVC = self.favouriteViewController
                    
                    DispatchQueue.main.async {
                        vc.tableview?.reloadData()
                    }
                }
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(BusinessModel.self, from: data!)
                self.businessModel = response
                print(self.businessModel.ServicesList)
                
                //Passing back values to ViewController to make use of the data
                self.favouriteViewController.responseFavouriteBusiness(businessModel: response)
            }
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                
                AppManager.shared.businessModel = nil
                
                if let vc = self.favouriteViewController.viewControllers[0] as? PagesVC {
                    vc.businessModel = []//self.businessModel.ServicesList
                    vc.favouritesVC = self.favouriteViewController
                    
                    DispatchQueue.main.async {
                        vc.tableview?.reloadData()
                    }
                }
            }
            do {
                // make sure this JSON is in the format we expect
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("JSON: \(json)")
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchBusinessFavourites_Event(user_id: Int) {
        
        helper.startLoader(view: self.favouriteViewController.view)

        
        let headers = [ ACCEPT : APPLICATION_JSON]
        let payloadParams = ["UserID": user_id] as [String : Any]
        
        _ = NetworkInterface.getRequest(.favourite_businesses_Event, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                
                AppManager.shared.eventsModel = nil
                
                if let vc = self.favouriteViewController.viewControllers[1] as? PagesVC {
                    vc.eventsModel = []//self.eventsModel.EventsList
                    vc.favouritesVC = self.favouriteViewController
                    
                    DispatchQueue.main.async {
                        vc.tableview?.reloadData()
                    }
                }

                DispatchQueue.main.async {
                    //                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(EventsModel.self, from: data!)
                self.eventsModel = response
                print(self.eventsModel.EventsList)
                //Passing back values to ViewController to make use of the data
                self.favouriteViewController.responseFavouriteBusiness_Event(eventsModel: response)
            }
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                
                AppManager.shared.eventsModel = nil
                
                if let vc = self.favouriteViewController.viewControllers[1] as? PagesVC {
                    vc.eventsModel = []//self.eventsModel.EventsList
                    vc.favouritesVC = self.favouriteViewController
                    
                    DispatchQueue.main.async {
                        vc.tableview?.reloadData()
                    }
                }
            }
            do {
                // make sure this JSON is in the format we expect
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("JSON: \(json)")
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchBusinessFavourites_Promotions(user_id: Int) {
        
        helper.startLoader(view: self.favouriteViewController.view)

        
        let headers = [ ACCEPT : APPLICATION_JSON]
        let payloadParams = ["UserID": user_id] as [String : Any]
        
        _ = NetworkInterface.getRequest(.favourite_businesses_Promotions, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                
                AppManager.shared.promotionsModel = nil
                
                if let vc = self.favouriteViewController.viewControllers[2] as? PagesVC {
                    vc.promotionsModel = []//self.promotionsModel.PromotionsList
                    vc.favouritesVC = self.favouriteViewController
                    
                    DispatchQueue.main.async {
                        vc.tableview?.reloadData()
                    }
                }
                DispatchQueue.main.async {
                    //                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(PromotionsModel.self, from: data!)
                self.promotionsModel = response
                print(self.promotionsModel)
                //Passing back values to ViewController to make use of the data
                self.favouriteViewController.responseFavouriteBusiness_Promotions(promotionsModel: response)
            }
            catch{
                
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                
                AppManager.shared.promotionsModel = nil
                
                if let vc = self.favouriteViewController.viewControllers[2] as? PagesVC {
                    vc.promotionsModel = []//self.promotionsModel.PromotionsList
                    vc.favouritesVC = self.favouriteViewController
                    
                    DispatchQueue.main.async {
                        vc.tableview?.reloadData()
                    }
                }

            }
            do {
                // make sure this JSON is in the format we expect
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("JSON: \(json)")
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchBusinessFavourites_Organization(user_id: Int) {
        
        helper.startLoader(view: self.favouriteViewController.view)

        
        let headers = [ ACCEPT : APPLICATION_JSON]
        let payloadParams = ["UserID": user_id] as [String : Any]
        
        _ = NetworkInterface.getRequest(.favourite_businesses_Organization, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                
                AppManager.shared.organisationsModel = nil
                
                if let vc = self.favouriteViewController.viewControllers[3] as? PagesVC {
                    vc.organisationsModel = []//self.organisationsModel.OrganisationsList
                    vc.favouritesVC = self.favouriteViewController
                    
                    DispatchQueue.main.async {
                        vc.tableview?.reloadData()
                    }
                }
                DispatchQueue.main.async {
                    //                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(OrganisationModel.self, from: data!)
                self.organisationsModel = response
                print(self.organisationsModel)
                //Passing back values to ViewController to make use of the data
                self.favouriteViewController.responseFavouriteBusiness_Origanisation(organisationsModel: response)
            }
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                
                AppManager.shared.organisationsModel = nil
                
                if let vc = self.favouriteViewController.viewControllers[3] as? PagesVC {
                    vc.organisationsModel = []//self.organisationsModel.OrganisationsList
                    vc.favouritesVC = self.favouriteViewController
                    
                    DispatchQueue.main.async {
                        vc.tableview?.reloadData()
                    }
                }

            }
            do {
                // make sure this JSON is in the format we expect
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("JSON: \(json)")
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
    
}
