//
//  DetailDescriptionPresenter.swift
//  MCA
//
//  Created by Goutham Devaraju on 28/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class DetailDescriptionPresenterImplementation: DetailDescriptionPresenterProtocol{
    
    //MARK: - Properties
    var detaildescriptionViewController: DetailDescriptionViewController! = nil
    
    var businessIndividualModel: BusinessIndividualModel!
    var eventsIndividualModel: EventsIndividualModel!
    var promotionsIndividualModel: PromotionsIndividualModel!
    var organisationsIndividualModel: OrganisationIndividualModel!
    
    //MARK: - Other Methods
    required init(viewController: DetailDescriptionViewController){
        detaildescriptionViewController = viewController
    }
    
    func fetchBusinessIndividualDetails(serviceid: Int, categoryType: CategoryType) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.detaildescriptionViewController, onCompletion: { (string: String) -> () in })
            return
        }
        
        var user_id = 0
        if (UserDefaults.standard.object(forKey: key_user_id) != nil){
            let user_id_main = UserDefaults.standard.value(forKey: key_user_id) as! Int
            print("user_id : \(user_id_main)")
            if user_id_main != 0 {
                user_id = user_id_main
            } else {
                 user_id = 0
            }
        }
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        var payloadParams = [:] as [String: Any]

        var getRequestType = GET_RequestType.services_individual_get
        
        if categoryType == CategoryType.business{
            payloadParams = ["Serviceid": serviceid,
                             "userid" : user_id] as [String : Any]
            getRequestType = GET_RequestType.services_individual_get
        }
        else if categoryType == CategoryType.events{
            payloadParams = ["Eventid": serviceid,
                             "userid" : user_id] as [String : Any]
            getRequestType = GET_RequestType.events_individual_get
        }
        else if categoryType == CategoryType.promotions {
            payloadParams = ["Promotionid": serviceid,
                             "userid" : user_id] as [String : Any]
            getRequestType = GET_RequestType.promotions_individual_get
        }
        else{
            payloadParams = ["Organisationid": serviceid,
                             "userid" : user_id] as [String : Any]
            getRequestType = GET_RequestType.organisations_individual_get
        }
        
        helper.startLoader(view: self.detaildescriptionViewController.view)
        
        _ = NetworkInterface.getRequest(getRequestType, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                
                print(json as Any)
                
                let decoder = JSONDecoder()

                if categoryType == CategoryType.business{
                    let response = try decoder.decode(BusinessIndividualModel.self, from: data!)
                    self.businessIndividualModel = response
                    self.detaildescriptionViewController.responseBusinessIndividualData(businessModel: self.businessIndividualModel)
                    
                }
                else if categoryType == CategoryType.events{
                    let response = try decoder.decode(EventsIndividualModel.self, from: data!)
                    self.eventsIndividualModel = response
                    
                self.detaildescriptionViewController.responseEventsIndividualData(businessModel: response)
                }
                else if categoryType == CategoryType.promotions{
                    let response = try decoder.decode(PromotionsIndividualModel.self, from: data!)
                    self.promotionsIndividualModel = response
                    self.detaildescriptionViewController.responsePromotionsIndividualData(businessModel: response)
                }
                else{
                    let response = try decoder.decode(OrganisationIndividualModel.self, from: data!)
                    self.organisationsIndividualModel = response
                    self.detaildescriptionViewController.responseOrganisationsIndividualData(businessModel: response)
                }
                
//                let response = try decoder.decode(BusinessIndividualModel.self, from: data!)
//                self.businessIndividualModel = response
//                self.detaildescriptionViewController.responseBusinessIndividualData(businessModel: self.businessIndividualModel)
                
            }
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
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
    
    func addBusinessToWallet(service_id: Int, user_id: Int, eventID : Int,proID : Int, categoryType: CategoryType){
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.detaildescriptionViewController, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.detaildescriptionViewController.view)
        
//        DispatchQueue.main.async {
//            self.detaildescriptionViewController.addActivityIndicatorView()
//        }
        
        var payloadParams = [
            "serviceId": service_id,
            "userid": user_id
            ] as [String : Any]
        
//        print("Parm : \(payloadParams)")
        
        var postRequestType = POST_RequestType.add_wallet_business_post
        
        var parmUrl = ""
        
        if categoryType == CategoryType.business{
           
            parmUrl = "?serviceId=\(service_id)&userId=\(user_id)"
            
            payloadParams = [
                "serviceId": service_id,
                "userid": user_id,
                "parmurl": parmUrl
                ] as [String : Any]
            
            postRequestType = POST_RequestType.add_wallet_business_post
        }
        else if categoryType == CategoryType.events{
            
            parmUrl = "?eventID=\(service_id)&userID=\(user_id)"
            
            payloadParams = [
                "eventID": service_id,
                "userid": user_id,
                "parmurl": parmUrl
                ] as [String : Any]
            
//            payloadParams = [
//                "serviceId": service_id,
//                "userid": user_id
//                ] as [String : Any]
            
//            parmUrl = "?serviceId=\(service_id)&userId=\(user_id))"

            postRequestType = POST_RequestType.add_wallet_events_post
        }
        else if categoryType == CategoryType.promotions{
            
            parmUrl = "?proID=\(service_id)&userid=\(user_id)"
            
            payloadParams = [
                "proID": service_id,
                "userid": user_id,
                "parmurl": parmUrl
                ] as [String : Any]
            
//            payloadParams = [
//                "proID": service_id,
//                "userid": user_id
//                ] as [String : Any]
            postRequestType = POST_RequestType.add_wallet_promotions_post
        }
        else{
            
            parmUrl = "?serviceId=\(service_id)&userid=\(user_id)"
            
            payloadParams = [
                "serviceId": service_id,
                "userid": user_id,
                "parmurl": parmUrl
                ] as [String : Any]
            
//            payloadParams = [
//                "serviceId": service_id,
//                "userid": user_id
//                ] as [String : Any]
            
            postRequestType = POST_RequestType.add_wallet_organisations_post
        }
        
        print("Parm : \(payloadParams)")

        print("postRequestType : \(postRequestType)")
        AppManager.shared.printLog(stringToPrint: "Login post parameters: \(payloadParams)")
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        _ = NetworkInterface.postRequest(postRequestType, headers: headers as NSDictionary, params: nil, payload: payloadParams){ (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
//            DispatchQueue.main.async {
//                self.detaildescriptionViewController.removeActivityIndicator()
//            }
            
            guard let data_ = data else{
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData)
                let decoder = JSONDecoder()
                
                let response = try decoder.decode(AddWalletModel.self, from: data_)
                
                //Passing back values to ViewController to make use of the data
                self.detaildescriptionViewController?.responseAddWallet(addWalletModel: response)
            }
            catch{
                if response != nil {
                    
                    AppManager.shared.showOkAlert(title: "Error", message: "API Error. Status Code: \(String(describing: response?.statusCode)).", view: self.detaildescriptionViewController, onCompletion: { (callBack: String) in })
                    
                    AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                }
                else {
                    
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                    
                    AppManager.shared.printLog(stringToPrint: "No response from the server please try again later. ")
                }
            }
        }
    }
    
    func removeToToWallet(categoryType: CategoryType, service_id: Int, user_id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.detaildescriptionViewController, onCompletion: { (string: String) -> () in })
            return
        }
        
//        DispatchQueue.main.async {
//            self.detaildescriptionViewController.addActivityIndicatorView()
//        }
        
        var payloadParams = [
            "serviceId": service_id,
            "userid": user_id
            ] as [String : Any]
        
        //        print("Parm : \(payloadParams)")
        
        var postRequestType = POST_RequestType.remove_wallet_business_post
        
        var parmUrl = ""
        
        if categoryType == CategoryType.business{
            
            parmUrl = "?serviceId=\(service_id)&userid=\(user_id)"
            
            payloadParams = [
                "serviceId": service_id,
                "userid": user_id,
                "parmurl": parmUrl
                ] as [String : Any]
            
            postRequestType = POST_RequestType.remove_wallet_business_post
        }
        else if categoryType == CategoryType.promotions{
            
            parmUrl = "?proID=\(service_id)&userid=\(user_id)"
            
            payloadParams = [
                "proID": service_id,
                "userid": user_id,
                "parmurl": parmUrl
                ] as [String : Any]
            
            //            payloadParams = [
            //                "proID": service_id,
            //                "userid": user_id
            //                ] as [String : Any]
            postRequestType = POST_RequestType.remove_wallet_promotions_post
        }
        else if categoryType == CategoryType.events{
            
            parmUrl = "?eventID=\(service_id)&userID=\(user_id)"
            
            payloadParams = [
                "eventID": service_id,
                "userid": user_id,
                "parmurl": parmUrl
                ] as [String : Any]
            
            //            payloadParams = [
            //                "serviceId": service_id,
            //                "userid": user_id
            //                ] as [String : Any]
            
            //            parmUrl = "?serviceId=\(service_id)&userId=\(user_id))"
            
            postRequestType = POST_RequestType.remove_wallet_events_post
        }
        else{
            
            parmUrl = "?serviceId=\(service_id)&userid=\(user_id)"
            
            payloadParams = [
                "serviceId": service_id,
                "userid": user_id,
                "parmurl": parmUrl
                ] as [String : Any]
            
            postRequestType = POST_RequestType.remove_wallet_organisations_post
        }
        
        print("Parm : \(payloadParams)")
        
        helper.startLoader(view: self.detaildescriptionViewController.view)
        
        print("postRequestType : \(postRequestType)")
        AppManager.shared.printLog(stringToPrint: "remove add to Cart post parameters: \(payloadParams)")
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        _ = NetworkInterface.postRequest(postRequestType, headers: headers as NSDictionary, params: nil, payload: payloadParams){ (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
//            DispatchQueue.main.async {
//                self.detaildescriptionViewController.removeActivityIndicator()
//            }
//
            guard let data_ = data else{
                DispatchQueue.main.async {
                    //                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData)
                let decoder = JSONDecoder()
                
//                let response = try decoder.decode(RemoveWalletModel.self, from: data_)
                
                if categoryType == CategoryType.business {
                    
                    let response = try decoder.decode(RemoveWalletModel.self, from: data!)
                    self.detaildescriptionViewController.responseRemoveWallet(addWalletModel: response)

                
                } else if categoryType == CategoryType.events {
                    
                    let response = try decoder.decode(RemoveWalletModel.self, from: data!)
                    self.detaildescriptionViewController.responseRemoveWallet(addWalletModel: response)
                    
                } else if categoryType == CategoryType.promotions {

                    let response = try decoder.decode(RemoveWalletModel.self, from: data!)
                    self.detaildescriptionViewController.responseRemoveWallet(addWalletModel: response)

                } else if categoryType == CategoryType.organisations {
                    
                    let response = try decoder.decode(RemoveWalletModel.self, from: data!)
                    self.detaildescriptionViewController.responseRemoveWallet(addWalletModel: response)

                } else {
                    
                }
   
            }
            catch{
                    AppManager.shared.printLog(stringToPrint: "No response from the server please try again later. ")
            }
        }
    }
    

}
