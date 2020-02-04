//
//  ReportPresenter.swift
//  MCA
//
//  Created by Goutham Devaraju on 30/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

class ReportPresenterImplementation: ReportPresenterProtocol {
    
    var reportViewController: ReportViewController!
    
    required init(viewController: ReportViewController){
        reportViewController = viewController
    }
    
    func sendReportDetails(comments: String, user_id: Int, categoryType: CategoryType) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.reportViewController, onCompletion: { (string: String) -> () in })
            return
        }
        
//        DispatchQueue.main.async {
//            self.reportViewController.addActivityIndicatorView()
//        }
        
        var community_id = 1
        
        if ((UserDefaults.standard.value(forKey: key_location_id) != nil)){
            community_id = UserDefaults.standard.value(forKey: key_location_id) as! Int
        }
        
        var payloadParams = NSDictionary()
        
//            "Type": 1,
//            "Concern_Id": 1,
//            "Comments": comments,
//            "Userid": user_id,
//            "Communityid": community_id
//            ] as [String : Any]
        
        if categoryType == CategoryType.business {
            
            payloadParams = ["Type": 1,
                             "Concern_Id": self.reportViewController.selectedService_ID, //self.reportViewController.businessIndividualModel.Service_Id as Any,
                             "Comments": comments,
                             "Userid": user_id,
                             "Communityid": community_id] as [String : Any] as NSDictionary
            
            
        } else if categoryType == CategoryType.promotions {
            
            payloadParams = ["Type": 3,
                             "Concern_Id": self.reportViewController.selectedService_ID, //self.reportViewController.promotionsIndividualModel.Pro_Id as Any,
                             "Comments": comments,
                             "Userid": user_id,
                             "Communityid": community_id] as [String : Any] as NSDictionary
            
        } else if categoryType == CategoryType.events {
            
            payloadParams = ["Type": 2,
                             "Concern_Id": self.reportViewController.selectedService_ID, //self.reportViewController.eventsIndividualModel.Events_Id as Any,
                             "Comments": comments,
                             "Userid": user_id,
                             "Communityid": community_id] as [String : Any] as NSDictionary
            
        } else if categoryType == CategoryType.organisations {
            
            payloadParams = ["Type": 4,
                             "Concern_Id": self.reportViewController.selectedService_ID,//self.reportViewController.organisationsIndividualModel.Organisation_Id as Any,
                             "Comments": comments,
                             "Userid": user_id,
                             "Communityid": community_id] as [String : Any] as NSDictionary
            
        }

        print(payloadParams)
        
        helper.startLoader(view: self.reportViewController.view)
        
        AppManager.shared.printLog(stringToPrint: "Login post parameters: \(payloadParams)")
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        _ = NetworkInterface.postRequest(.report_post, headers: headers as NSDictionary, params: nil, payload: payloadParams as! [String : Any]){ (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
//
//            DispatchQueue.main.async {
//                self.reportViewController.removeActivityIndicator()
//            }
            
            guard let data_ = data else {
//                DispatchQueue.main.async {
////                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in
////                    })
//                }
                
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(ReportModel.self, from: data_)
                
                //Passing back values to ViewController to make use of the data
                self.reportViewController?.responseReportData(reportModel: response)
            }
            catch{
                if response != nil{
                    
                    AppManager.shared.showOkAlert(title: "Error", message: "API Error. Status Code: \(String(describing: response?.statusCode)).", view: self.reportViewController, onCompletion: { (callBack: String) in })
                    
                    AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                }
                else{
                    
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                    
                    AppManager.shared.printLog(stringToPrint: "No response from the server please try again later. ")
                }
            }
        }
        
    }
    
}

