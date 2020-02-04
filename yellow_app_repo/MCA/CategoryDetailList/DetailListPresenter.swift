//
//  DetailListPresenter.swift
//  MCA
//
//  Created by Goutham Devaraju on 14/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class DetailListPresenterImplementation: DetailListPresenterProtocol {
    
    //MARK: - Properties
    let detailListViewController: DetailListViewController!
    
    var businessModel: BusinessModel!
    var eventsModel: EventsModel!
    var promotionsModel: PromotionsModel!
    var organisationsModel: OrganisationModel!
    
    let locationManager = CLLocationManager()
    
    //MARK: - Other Methods
    required init(viewController: DetailListViewController){
        detailListViewController = viewController
    }
    
    func resignAllResponders() {
        detailListViewController.textFieldSearch.resignFirstResponder()
    }
    
    func sortByRatings(){
        
        if detailListViewController.categoryType == CategoryType.business{
            if businessModel != nil {
//                print("before filter : \(businessModel.ServicesList[0].Rating)")
                businessModel.ServicesList = businessModel.ServicesList.sorted(by: { $0.Rating! > $1.Rating! })
//                print(businessModel.ServicesList)
//                print("After filter : \(businessModel.ServicesList[0].Rating)")
                
//                let seconds = 1.0
//                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//                    self.detailListViewController.reloadDetailedTableView()
//                }
                
                self.detailListViewController.reloadDetailedTableView()
                
            }
        } else  if detailListViewController.categoryType == CategoryType.events{
            if eventsModel != nil{
                eventsModel.EventsList = eventsModel.EventsList.sorted(by: { $0.Rating! > $1.Rating!  })
                
                self.detailListViewController.reloadDetailedTableView()
            }
        }  else  if detailListViewController.categoryType == CategoryType.organisations{
            if organisationsModel != nil{
                organisationsModel.OrganisationsList = organisationsModel.OrganisationsList.sorted(by: { $0.Rating! > $1.Rating!  })
                
                self.detailListViewController.reloadDetailedTableView()
            }
        }   else  if detailListViewController.categoryType == CategoryType.promotions{
            if promotionsModel != nil{
                promotionsModel.PromotionsList = promotionsModel.PromotionsList.sorted(by: { $0.Rating! > $1.Rating!  })
                
                self.detailListViewController.reloadDetailedTableView()
            }
        }
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.detailListViewController.tableViewDetailList.reloadData()
        }
        
        
//        DispatchQueue.main.async {
////            self.reloadDetailedTableView()
//            self.detailListViewController.reloadDetailedTableView()
//        }
//        DispatchQueue.main.async {
//            self.detailListViewController.reloadDetailedTableView()
//        }
        
        
        
    }
    
    func sortByViews(){
        
        if detailListViewController.categoryType == CategoryType.business{
            if businessModel != nil{
                businessModel.ServicesList = businessModel.ServicesList.sorted(by: { $0.Views! > $1.Views!  })
            }
        } else  if detailListViewController.categoryType == CategoryType.events{
            if eventsModel != nil{
                eventsModel.EventsList = eventsModel.EventsList.sorted(by: { $0.Views! > $1.Views!  })
            }
        }  else  if detailListViewController.categoryType == CategoryType.organisations{
            if organisationsModel != nil{
                organisationsModel.OrganisationsList = organisationsModel.OrganisationsList.sorted(by: { $0.Views! > $1.Views!  })
            }
        }   else  if detailListViewController.categoryType == CategoryType.promotions{
            if promotionsModel != nil{
                promotionsModel.PromotionsList = promotionsModel.PromotionsList.sorted(by: { $0.Views! > $1.Views!  })
            }
        }
        
//        detailListViewController.reloadDetailedTableView()
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.detailListViewController.tableViewDetailList.reloadData()
        }

//        if businessModel != nil{
//            businessModel.ServicesList = businessModel.ServicesList.sorted(by: { $0.Views! > $1.Views!  })
//        }
    }
    
    func sortByLocation(){
        
        if detailListViewController.categoryType == CategoryType.business{
            
            if businessModel != nil{
                
                if businessModel.ServicesList[0].distance != nil{
                    businessModel.ServicesList.sort(by: { $0.distance! > $1.distance! })
                    detailListViewController.reloadDetailedTableView()
                }
                else{
                    
                    //Sorting by ratings as location permissions are not found
                    detailListViewController.viewSegmentController.setSelectedIndex(1)
                    sortByRatings()
                    detailListViewController.reloadDetailedTableView()
                    
                    AppManager.shared.showLocationNotFoundAlert(title: "Location permissions required", message: "Unable to fetch location details. To grant location permissions please goto Settings and Allow Location Access.", onCompletion: {(callBackString: String) in
                        
                        if AlertControlOptions.retry == callBackString{
                            
                            if !CLLocationManager.locationServicesEnabled() {
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    // If general location settings are disabled then open general location settings
                                    UIApplication.shared.open(url)
                                }
                            } else {
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    // If general location settings are enabled then open location settings for the app
                                    UIApplication.shared.open(url)
                                }
                            }
                            
                        }
                        else{
                            AppManager.shared.printLog(stringToPrint: "Location persmissions not found hence ignoring")
                        }
                    })
                }
            }
            
        } else if detailListViewController.categoryType == CategoryType.events{
            
            
            if eventsModel != nil{
                
                if eventsModel.EventsList[0].distance != nil{
                    eventsModel.EventsList.sort(by: { $0.distance! > $1.distance! })
                    detailListViewController.reloadDetailedTableView()

                }
                else{
                    
                    //Sorting by ratings as location permissions are not found
                    detailListViewController.viewSegmentController.setSelectedIndex(1)
                    sortByRatings()
                    detailListViewController.reloadDetailedTableView()
                    
                    AppManager.shared.showLocationNotFoundAlert(title: "Location permissions required", message: "Unable to fetch location details. To grant location permissions please goto Settings and Allow Location Access.", onCompletion: {(callBackString: String) in
                        
                        if AlertControlOptions.retry == callBackString{
                            
                            if !CLLocationManager.locationServicesEnabled() {
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    // If general location settings are disabled then open general location settings
                                    UIApplication.shared.open(url)
                                }
                            } else {
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    // If general location settings are enabled then open location settings for the app
                                    UIApplication.shared.open(url)
                                }
                            }
                            
                        }
                        else{
                            AppManager.shared.printLog(stringToPrint: "Location persmissions not found hence ignoring")
                        }
                    })
                }
            }
            
        }  else if detailListViewController.categoryType == CategoryType.organisations{
            
            
            if organisationsModel != nil{
                
                if organisationsModel.OrganisationsList[0].distance != nil{
                    organisationsModel.OrganisationsList.sort(by: { $0.distance! > $1.distance! })
                    detailListViewController.reloadDetailedTableView()

                }
                else{
                    
                    //Sorting by ratings as location permissions are not found
                    detailListViewController.viewSegmentController.setSelectedIndex(1)
                    sortByRatings()
                    detailListViewController.reloadDetailedTableView()
                    
                    AppManager.shared.showLocationNotFoundAlert(title: "Location permissions required", message: "Unable to fetch location details. To grant location permissions please goto Settings and Allow Location Access.", onCompletion: {(callBackString: String) in
                        
                        if AlertControlOptions.retry == callBackString{
                            
                            if !CLLocationManager.locationServicesEnabled() {
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    // If general location settings are disabled then open general location settings
                                    UIApplication.shared.open(url)
                                }
                            } else {
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    // If general location settings are enabled then open location settings for the app
                                    UIApplication.shared.open(url)
                                }
                            }
                            
                        }
                        else{
                            AppManager.shared.printLog(stringToPrint: "Location persmissions not found hence ignoring")
                        }
                    })
                }
            }
            
        } else if detailListViewController.categoryType == CategoryType.promotions {
            
            if promotionsModel != nil{
                
                if promotionsModel.PromotionsList[0].distance != nil{
                    promotionsModel.PromotionsList.sort(by: { $0.distance! > $1.distance! })
                    detailListViewController.reloadDetailedTableView()

                }
                else{
                    
                    //Sorting by ratings as location permissions are not found
                    detailListViewController.viewSegmentController.setSelectedIndex(1)
                    sortByRatings()
                    detailListViewController.reloadDetailedTableView()
                    
                    AppManager.shared.showLocationNotFoundAlert(title: "Location permissions required", message: "Unable to fetch location details. To grant location permissions please goto Settings and Allow Location Access.", onCompletion: {(callBackString: String) in
                        
                        if AlertControlOptions.retry == callBackString{
                            
                            if !CLLocationManager.locationServicesEnabled() {
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    // If general location settings are disabled then open general location settings
                                    UIApplication.shared.open(url)
                                }
                            } else {
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    // If general location settings are enabled then open location settings for the app
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                        else{
                            AppManager.shared.printLog(stringToPrint: "Location persmissions not found hence ignoring")
                        }
                    })
                }
            }
            
        } else {
            return
        }
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.detailListViewController.tableViewDetailList.reloadData()
        }
    }
    
    func sortByDate(){
        
        if detailListViewController.categoryType == CategoryType.business{
            if businessModel != nil{
                businessModel.ServicesList = businessModel.ServicesList.sorted(by: { $0.createdDate! < $1.createdDate!  })
            }
        } else  if detailListViewController.categoryType == CategoryType.events{
            if eventsModel != nil{
                eventsModel.EventsList = eventsModel.EventsList.sorted(by: { $0.createdDate! < $1.createdDate!  })
            }
        }  else  if detailListViewController.categoryType == CategoryType.organisations{
            if organisationsModel != nil{
                organisationsModel.OrganisationsList = organisationsModel.OrganisationsList.sorted(by: { $0.createdDate! < $1.createdDate!  })
            }
        }  else  if detailListViewController.categoryType == CategoryType.promotions {
            if promotionsModel != nil{
                promotionsModel.PromotionsList = promotionsModel.PromotionsList.sorted(by: { $0.createdDate! < $1.createdDate!  })
            }
        }
        
//        if businessModel != nil{
//
//            businessModel.ServicesList.sort(by: { $0.createdDate! < $1.createdDate! })
//        }
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
             self.detailListViewController.tableViewDetailList.reloadData()
        }
        
       
    }
    
    //MARK: - Location Related
    
    func processDistanceAndStore(currentLocation: CLLocation){
        
//        if businessModel != nil && eventsModel != nil && promotionsModel != nil && organisationsModel != nil {
//            return
//        } else if businessModel.ServicesList.count != 0 && eventsModel.EventsList.count != 0 && promotionsModel.PromotionsList.count != 0 && organisationsModel.OrganisationsList.count != 0 {
//            return
//        }
        
        if detailListViewController.categoryType == CategoryType.business{
            
            if businessModel == nil {
                return
            }
            
            if businessModel.ServicesList.count > 0 {
                
                for index in 0..<businessModel.ServicesList.count{
                    
                    let service = businessModel.ServicesList[index]
                    
                    if let latitude = service.Latitude, let longitude = service.Longitude{
                        
                        let lat = (latitude as NSString).doubleValue
                        let long = (longitude as NSString).doubleValue
                        
                        businessModel.ServicesList[index].distance = CLLocation(latitude: lat, longitude: long).distance(from: currentLocation)
                    }
                    else{
                        businessModel.ServicesList[index].distance = 0.0
                    }
                }
                
                sortByLocation()
                detailListViewController.reloadDetailedTableView()
                
            }
        }
        else if detailListViewController.categoryType == CategoryType.events{
            
            if eventsModel == nil {
                return
            }
            if eventsModel.EventsList.count > 0 {
                
                for index in 0..<eventsModel.EventsList.count{
                    
                    let service = eventsModel.EventsList[index]
                    
                    if let latitude = service.Latitude, let longitude = service.Longitude{
                        
                        let lat = (latitude as NSString).doubleValue
                        let long = (longitude as NSString).doubleValue
                        
                        eventsModel.EventsList[index].distance = CLLocation(latitude: lat, longitude: long).distance(from: currentLocation)
                    }
                    else{
                        eventsModel.EventsList[index].distance = 0.0
                    }
                }
                
                sortByLocation()
                
                detailListViewController.reloadDetailedTableView()
                
            }
           
        }
        else if detailListViewController.categoryType == CategoryType.promotions{
            
            if promotionsModel == nil {
                return
            }
            
            if promotionsModel.PromotionsList.count > 0 {
                
                for index in 0..<promotionsModel.PromotionsList.count{
                    
                    let service = promotionsModel.PromotionsList[index]
                    
                    if let latitude = service.Latitude, let longitude = service.Longitude{
                        
                        let lat = (latitude as NSString).doubleValue
                        let long = (longitude as NSString).doubleValue
                        
                        promotionsModel.PromotionsList[index].distance = CLLocation(latitude: lat, longitude: long).distance(from: currentLocation)
                    }
                    else{
                        promotionsModel.PromotionsList[index].distance = 0.0
                    }
                }
                
                sortByLocation()
                detailListViewController.reloadDetailedTableView()
                
            }
          
        }
        else if detailListViewController.categoryType == CategoryType.organisations{
            
            if organisationsModel == nil {
                return
            }
            
            if organisationsModel.OrganisationsList.count > 0 {
                
                for index in 0..<organisationsModel.OrganisationsList.count{
                    
                    let service = organisationsModel.OrganisationsList[index]
                    
                    if let latitude = service.Latitude, let longitude = service.Longitude{
                        
                        let lat = (latitude as NSString).doubleValue
                        let long = (longitude as NSString).doubleValue
                        
                        organisationsModel.OrganisationsList[index].distance = CLLocation(latitude: lat, longitude: long).distance(from: currentLocation)
                    }
                    else{
                        organisationsModel.OrganisationsList[index].distance = 0.0
                    }
                }
                
                sortByLocation()
                detailListViewController.reloadDetailedTableView()
                
            }
            
        }
//
//        else if businessModel.ServicesList.count != 0 {
//
//
//
//        }
        else{
            
        }
    }
    
    func InitialiseAndFetchLocation(){
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = detailListViewController.self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    //MARK: - Date related
    func formateAndStoreCreatedDate(){
        
        
        
    }
    
    //MARK: - Parsing data from model
//    func parseDataFromModels(forCategory categoryType: CategoryType, indexPath_row: Int) -> T {
//
//        if categoryType == CategoryType.business{
//            let service = businessModel.ServicesList[indexPath_row]
//            return [service]
//        }
//        else if categoryType == CategoryType.events{
//            let service = eventsModel.EventsList[indexPath_row]
//            return [service]
//        }
//        else if categoryType == CategoryType.promotions{
//            let service = promotionsModel.PromotionsList[indexPath_row]
//            return [service]
//        }
//        else {
//            let service = organisationsModel.OrganisationsList[indexPath_row]
//            return [service]
//        }
//
//    }
    
    
    //MARK: - API Call

    
    func fetchBusinessDetails(location_id: Int, user_id: Int, Req_cat_ID : Int, Req_title : String, Req_sub_Cat_ID : Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.detailListViewController, onCompletion: { (string: String) -> () in })
            return
        }

        let headers = [ ACCEPT : APPLICATION_JSON]
        
        var payloadParams = [:] as [String: Any]
        
        if isLocationBased == 0 {
            payloadParams = [
                "CommunityId": location_id,
                "cat_ID": Req_cat_ID,
                "sub_Cat_ID" : Req_sub_Cat_ID
                ] as [String : Any]

        } else {
            payloadParams = [
                "Location_ID": location_id,
                "User_ID": user_id
                ] as [String : Any]
        }
        
//        print("parm : \(payloadParams)")
        
        var requestType = GET_RequestType.services_get
        
        //Set segment color accordingly
        if detailListViewController.categoryType == CategoryType.business{
            requestType = GET_RequestType.services_get
        }
        else if detailListViewController.categoryType == CategoryType.events{
            requestType = GET_RequestType.events_get
        }
        else if detailListViewController.categoryType == CategoryType.promotions{
            requestType = GET_RequestType.promotions_get
        }
        else if detailListViewController.categoryType == CategoryType.organisations{
            requestType = GET_RequestType.organisations_get
        }
        print("send Parm : \(payloadParams)")
    
        helper.startLoader(view: self.detailListViewController.view)
        
        _ = NetworkInterface.getRequest(requestType, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                DispatchQueue.main.async {
                    
                    self.detailListViewController.viewNodataFound.isHidden = false
                    
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                print("JSON: \(json)")
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(BusinessModel.self, from: data!)
                print(response.ServicesList)
                
                self.businessModel = response
                self.detailListViewController.businessModelMain = self.businessModel
                
                self.detailListViewController.locationArray.removeAllObjects()
                for i in self.businessModel.ServicesList {
                    let dic = ["locationType" : "business",
                               "title" : i.Title,
                               "Latitude" : i.Latitude,
                               "Longitude" : i.Longitude]
                    self.detailListViewController.locationArray.add(dic)
                }
                
                //Passing back values to ViewController to make use of the data
                self.detailListViewController.responseBusinessData(businessModel: response)
                
                DispatchQueue.main.async {
                    self.detailListViewController.tableViewDetailList.reloadData()
                }
                
            }
            catch {
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
//
//
//            do {
//                // make sure this JSON is in the format we expect
//
//            } catch let error as NSError {
//                print("Failed to load: \(error.localizedDescription)")
//            }
        }
    }
    
    func fetchEventsDetails(location_id: Int, user_id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.detailListViewController, onCompletion: { (string: String) -> () in })
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
        
        print("send Parm : \(payloadParams)")
        
        helper.startLoader(view: self.detailListViewController.view)
        
        
        
        _ = NetworkInterface.getRequest(.events_get, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()

            guard let _ = data else{
                DispatchQueue.main.async {
                    
                    self.detailListViewController.viewNodataFound.isHidden = false

//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(EventsModel.self, from: data!)
                
                self.eventsModel = response
                self.detailListViewController.eventsModelMain = self.eventsModel

                
                self.detailListViewController.locationArray.removeAllObjects()
                for i in self.eventsModel.EventsList {
                    let dic = ["locationType" : "events",
                               "title" : i.Title,
                               "Latitude" : i.Latitude,
                               "Longitude" : i.Longitude]
                    self.detailListViewController.locationArray.add(dic)
                }
                
                //Passing back values to ViewController to make use of the data
                self.detailListViewController.responseEventsData(businessModel: response)
                
                DispatchQueue.main.async {
                    self.detailListViewController.tableViewDetailList.reloadData()
                }
                
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
    
    func fetchPromotionsDetails(location_id: Int, user_id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.detailListViewController, onCompletion: { (string: String) -> () in })
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
        
        print("send Parm : \(payloadParams)")
        
        helper.startLoader(view: self.detailListViewController.view)
        
        _ = NetworkInterface.getRequest(.promotions_get, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()

            
            guard let _ = data else{
                DispatchQueue.main.async {
                    
                    self.detailListViewController.viewNodataFound.isHidden = false

//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(PromotionsModel.self, from: data!)
                
                self.promotionsModel = response
                self.detailListViewController.promotionsModelMain = self.promotionsModel
                
                DispatchQueue.main.async {
                    
                    self.detailListViewController.locationArray.removeAllObjects()
                    for i in self.promotionsModel.PromotionsList {
                        let dic = ["locationType" : "promotions",
                                   "title" : i.Title,
                                   "Latitude" : i.Latitude,
                                   "Longitude" : i.Longitude]
                        self.detailListViewController.locationArray.add(dic)
                    }
                    
                }
                
                //Passing back values to ViewController to make use of the data
                self.detailListViewController.responsePromotionsData(businessModel: response)
                
                self.detailListViewController.tableViewDetailList.reloadData()
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
////                     self.detailListViewController.tableViewDetailList.reloadData()
//                }
                
                
                
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
    
    func fetchOrganisationDetails(location_id: Int, user_id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.detailListViewController, onCompletion: { (string: String) -> () in })
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
        
        print("send Parm : \(payloadParams)")
        
        helper.startLoader(view: self.detailListViewController.view)
        
        _ = NetworkInterface.getRequest(.organisations_get, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()

            guard let _ = data else{
                DispatchQueue.main.async {
                    
                    self.detailListViewController.viewNodataFound.isHidden = false

//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(OrganisationModel.self, from: data!)
                
                self.organisationsModel = response
                self.detailListViewController.organisationsModelMain = self.organisationsModel

                
                self.detailListViewController.locationArray.removeAllObjects()
                for i in self.organisationsModel.OrganisationsList {
                    let dic = ["locationType" : "organisations",
                               "title" : i.Title,
                               "Latitude" : i.Latitude,
                               "Longitude" : i.Longitude]
                    self.detailListViewController.locationArray.add(dic)
                }
                
                //Passing back values to ViewController to make use of the data
                self.detailListViewController.responseOrganisationsData(businessModel: response)
                
                DispatchQueue.main.async {
                    self.detailListViewController.tableViewDetailList.reloadData()
                }
                
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
    
}

