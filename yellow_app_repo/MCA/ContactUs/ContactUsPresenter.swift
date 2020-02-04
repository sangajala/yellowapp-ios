//
//  ContactUsPresenter.swift
//  MCA
//
//  Created by Goutham Devaraju on 27/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

class ContactUsPresenterImplementation: ContactUsPresenterProtocol{
    
    var contactUsModel: ContactUsModel!
    var contactUsEventsModel: ContactUsEventsModel!
    var contactUsPromotionsModel: ContactUsPromotionsModel!
    var contactUsOrganisationsModel: ContactUsOrganisationsModel!
    
    var contactUsViewController: ContactUsViewController!
    
    required init(viewController: ContactUsViewController){
        contactUsViewController = viewController
    }
    
    func fetchContactDetails(forService_id service_id: Int, user_id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.contactUsViewController, onCompletion: { (string: String) -> () in })
            contactUsViewController.viewNolocationFound.isHidden = false
            return
        }
        
        contactUsViewController.viewNolocationFound.isHidden = true
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        var payloadParams = [:] as [String: Any]
        var getRequestType = GET_RequestType.services_contact_details_get
        
        
        
        if contactUsViewController.categoryType == CategoryType.business{
            payloadParams = ["Serviceid": service_id, "UserID": user_id] as [String : Any]
            getRequestType = GET_RequestType.services_contact_details_get
        }
        else if contactUsViewController.categoryType == CategoryType.events{
            payloadParams = ["EventID": service_id, "UserID": user_id] as [String : Any]
            getRequestType = GET_RequestType.events_contact_details_get
        }
        else if contactUsViewController.categoryType == CategoryType.promotions{
            payloadParams = ["PromotionID": service_id, "UserID": user_id] as [String : Any]
            getRequestType = GET_RequestType.promotions_contact_details_get
        }
        else{
            payloadParams = ["OrganisationID": service_id, "UserID": user_id] as [String : Any]
            getRequestType = GET_RequestType.organisations_contact_details_get
        }
        
        helper.startLoader(view: self.contactUsViewController.view)

        _ = NetworkInterface.getRequest(getRequestType, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()

            
            guard let _ = data else{
//                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
//                }
                return
            }
            
            do {
                // make sure this JSON is in the format we expect
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                print("JSON: \(json)")
                
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            do{
                let decoder = JSONDecoder()
                
                if self.contactUsViewController.categoryType == CategoryType.business{
                    let response = try decoder.decode(ContactUsModel.self, from: data!)
                    self.contactUsModel = response
                    //Passing back values to ViewController to make use of the data
                    self.contactUsViewController.responseContactDetailsData(contactUsModel: self.contactUsModel)
                }
                else if self.contactUsViewController.categoryType == CategoryType.events{
                    let response = try decoder.decode(ContactUsEventsModel.self, from: data!)
                    self.contactUsEventsModel = response
                    //Passing back values to ViewController to make use of the data
                    self.contactUsViewController.responseEventsContactDetailsData(contactUsModel: response)
                }
                else if self.contactUsViewController.categoryType == CategoryType.promotions{
                    let response = try decoder.decode(ContactUsPromotionsModel.self, from: data!)
                    self.contactUsPromotionsModel = response
                    //Passing back values to ViewController to make use of the data
                    self.contactUsViewController.responsePromotionsContactDetailsData(contactUsModel: response)
                }
                else{
                    let response = try decoder.decode(ContactUsOrganisationsModel.self, from: data!)
                    self.contactUsOrganisationsModel = response
                    //Passing back values to ViewController to make use of the data
                    self.contactUsViewController.responseOrganisationsContactDetailsData(contactUsModel: response)
                }
                
                
            }
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
            
        }
        
    }
    
}
