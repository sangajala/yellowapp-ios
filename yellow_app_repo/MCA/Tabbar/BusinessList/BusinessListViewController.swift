//
//  BusinessListViewController.swift
//  MCA
//
//  Created by Goutham Devaraju on 03/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
import AARatingBar

class BusinessListViewController: UIViewController {
    
    var bussinessListModal : BussinessListModal!
    @IBOutlet weak var noDataFoundView: UIView!
    
    @IBOutlet weak var tableViewBusnessList: UITableView!
    
    var selectedCategoryType: CategoryType!
    var selectedBusinessIDTodayOffers : Int?
    
    var isType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSetup()
        
//        if user_is_Login == false {
//
//            helper.showAlertOKCancelAction(appName, "User is not Login", self, successClosure: { (login) in
//
//                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationLogin") as? UINavigationController {
//                    UserDefaults.standard.set(true, forKey: key_is_present_to_login)
//                    self.present(vc, animated: true, completion: nil)
//                } else{
//                    mainTabbarObj.selectedIndex = 0
//                }
//
//
//
////                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
////                let appDelegate = UIApplication.shared.delegate as! AppDelegate
////                appDelegate.window?.rootViewController = testController
//
//            }) { (skip) in
//
////                mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//                mainTabbarObj.selectedIndex = 0
//
//            }
//        } else {
//
//            if ((UserDefaults.standard.value(forKey: key_location_id) != nil)) {
//
//                let user_id_cached = UserDefaults.standard.value(forKey: key_user_id) as? Int ?? 0
//                let location_id_cached = UserDefaults.standard.value(forKey: key_location_id) as? Int ?? 0
//
//                Api_get_business_List(location_id: location_id_cached, user_Id: user_id_cached)
//
//            }
//        }

        // Do any additional setup after loading the view.
//        AppManager.shared.printLog(stringToPrint: "BusinessListViewController")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dataSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataSetup()
    }
    
    
    func dataSetup(){
        
        noDataFoundView.isHidden = true
        
        AppManager.shared.printLog(stringToPrint: "BusinessListViewController")
        
        if user_is_Login == false {
            
            helper.showAlertOKCancelAction(appName, "User is not Login", self, successClosure: { (login) in
                
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationLogin") as? UINavigationController {
                    UserDefaults.standard.set(true, forKey: key_is_present_to_login)
                    self.present(vc, animated: true, completion: nil)
                } else{
                    mainTabbarObj.selectedIndex = 0
                }
                
                //                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
                //                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                //                appDelegate.window?.rootViewController = testController
                
            }) { (skip) in
                
                //                mainTabbarObj.delegate = self as? UITabBarControllerDelegate
                mainTabbarObj.selectedIndex = 0
                
                //                let application = UIApplication.shared.delegate as! AppDelegate
                //                let tabbarController =
                //                //application.tabBarController as UITabBarController
                //                let selectedIndex = tabBarController.selectedIndex
                
            }
            
            return
        } else {
            
            if ((UserDefaults.standard.value(forKey: key_location_id) != nil)) {
                
                let user_id_cached = UserDefaults.standard.value(forKey: key_user_id) as? Int ?? 0
                let location_id_cached = UserDefaults.standard.value(forKey: key_location_id) as? Int ?? 0
                
                Api_get_business_List(location_id: location_id_cached, user_Id: user_id_cached)
                
            }
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        
//        mainTabbarObj.delegate = self as? UITabBarControllerDelegate
        mainTabbarObj.selectedIndex = 0
        
    }
    
    func Api_get_business_List (location_id : Int, user_Id : Int){
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.view)
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        let payloadParams = ["Communityid": location_id,
                             "Userid": user_Id] as [String : Any]
        print(payloadParams)
        
        _ = NetworkInterface.getRequest(.get_Business_list, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                
                self.noDataFoundView.isHidden = false
                
//                self.tableViewBusnessList.reloadData()
                
                //                DispatchQueue.main.async {
                //                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                //                }
                return
            }
            
            do {
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData)
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(BussinessListModal.self, from: data!)
                
                self.bussinessListModal = response
                
                self.tableViewBusnessList?.reloadData()

//                DispatchQueue.main.sync {
//                     self.tableViewBusnessList?.reloadData()
//                }
                
//                self.tableViewBusnessList?.reloadData()
 
            }
            catch {
                
                self.noDataFoundView.isHidden = false
                
//                self.tableViewBusnessList.reloadData()
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
    
    @IBAction func btnAddmyBusinessEvent(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToAddBusiness", sender: self)
    }
    
}

extension BusinessListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bussinessListModal != nil {
            
            if bussinessListModal.servicesUserList.count == 0 {
                noDataFoundView.isHidden = false
                return 0
            } else {
                noDataFoundView.isHidden = true
                
                return bussinessListModal.servicesUserList.count > 0 ? bussinessListModal.servicesUserList.count : 0
            }
        }
        else{
            noDataFoundView.isHidden = true
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessListCell", for: indexPath) as! businessListCell

        let index = bussinessListModal.servicesUserList[indexPath.row]
        print(index)

        cell.labelTitleDetailedList.text = index.title

        if let image_url: String = index.image {

            if let url_image = URL(string: image_url){

                cell.imageViewDetailList.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                }
            }
        }

        cell.labelLocation.text = index.location

        cell.viewRatingBar.value = CGFloat(index.rating)

        if let createdDate : String = index.createdDatetime {

            //2019-08-13T05:50:14.937
            let isoDate = createdDate//"2016-04-14T10:44:00"

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            let date = dateFormatter.date(from:isoDate)!

            let calendar = Calendar.current

            // Replace the hour (time) of both dates with 00:00
            let date1 = calendar.startOfDay(for: date)
            let date2 = calendar.startOfDay(for: Date())

            let components = calendar.dateComponents([.day], from: date1, to: date2)

            if let days = components.day{
                cell.labelDays.text = days == 1 ? "\(days) day ago" : "\(days) days ago"

                //Setting date in integer format
//                presenterDetailList.businessModel.ServicesList[indexPath.row].createdDate = days
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "") { (action, sourceView, completionHandler) in
            print("index path of delete: \(indexPath)")
            completionHandler(true)
            
            if self.bussinessListModal == nil {
                return
            }
            else {
                
                let index = self.bussinessListModal.servicesUserList[indexPath.row]
                let Serviceid = index.serviceID
                self.deletService(serviceID: Serviceid)
                
            }
            
        }
        
        let rename = UIContextualAction(style: .normal, title: "") { (action, sourceView, completionHandler) in
            print("index path of edit: \(indexPath)")
            
            self.isType = "Edit"
            let index = self.bussinessListModal.servicesUserList[indexPath.row]
            self.performSegue(withIdentifier: "segueToUpdateBusiness", sender: index)
            completionHandler(true)
        }
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete,rename])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        
        // Set bg color
        rename.backgroundColor = UIColor.init(named: "ButtonColor")
        delete.backgroundColor = UIColor.init(named: "ButtonColor")
        
        // Set bg Image
        rename.image = UIImage(named: "edit")
        delete.image = UIImage(named: "delete")
        return swipeActionConfig
        
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == .delete) {
//
//            if bussinessListModal == nil {
//                return
//            }
//            else {
//
//                let index = bussinessListModal.servicesUserList[indexPath.row]
//                let Serviceid = index.serviceID
//                deletService(serviceID: Serviceid)
//
//            }
//        }
//    }
    
    func deletService(serviceID: Int){
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        let payloadParams = [
            "Serviceid": serviceID] as [String : Any]
        
        var postRequestType = POST_RequestType.service_delete
//
//        if categoryType == CategoryType.business{
//            payloadParams = [
//                "serviceId": service_id,
//                "userid": user_id
//                ] as [String : Any]
//            postRequestType = POST_RequestType.add_wallet_business_post
//        }
//        else if categoryType == CategoryType.events{
//            payloadParams = [
//                "serviceId": service_id,
//                "userid": user_id
//                ] as [String : Any]
//            postRequestType = POST_RequestType.add_wallet_events_post
//        }
//        else if categoryType == CategoryType.promotions{
//            payloadParams = [
//                "proID": service_id,
//                "userid": user_id
//                ] as [String : Any]
//            postRequestType = POST_RequestType.add_wallet_promotions_post
//        }
//        else{
//            payloadParams = [
//                "serviceId": service_id,
//                "userid": user_id
//                ] as [String : Any]
//            postRequestType = POST_RequestType.add_wallet_organisations_post
//        }
        
        
        helper.startLoader(view: self.view)

        AppManager.shared.printLog(stringToPrint: "service delete post parameters: \(payloadParams)")
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        print(postRequestType)
        _ = NetworkInterface.postRequest(.service_delete, headers: headers as NSDictionary, params: nil, payload: payloadParams){ (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()

            
            guard let data_ = data else {
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do {
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData)
                
                if success == true {
                    if ((UserDefaults.standard.value(forKey: key_location_id) != nil)) {
                        
                        let user_id_cached = UserDefaults.standard.value(forKey: key_user_id) as? Int ?? 0
                        let location_id_cached = UserDefaults.standard.value(forKey: key_location_id) as? Int ?? 0
                        
                        self.Api_get_business_List(location_id: location_id_cached, user_Id: user_id_cached)
                        
                    }
                    
                } else {
                    
                    if jsonData != nil {
                        
                        AppManager.shared.showOkAlert(title: appName, message: (jsonData as! NSDictionary)["Message"] as? String ?? "", view: self, onCompletion: { (ok) in
                            
                        })
                    }
                    
                    
                    
                    
                }
                
                
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(BussinessListModal.self, from: data!)
//
//                self.bussinessListModal = response
//                self.tableViewBusnessList.reloadData()
                
                //                print(response)
                //                do {
                //                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                //                    print(jsonData)
                //                } catch let myJSONError {
                //                    print(myJSONError)
                //                }
                
                //                self.homeAllData = response
                //                self.collectionViewSliderTop.reloadData()
                //                //Passing back values to ViewController to make use of the data
                //                //                self.homeViewController?.homeDataResponse(homeModel: response)
            }
            catch{
                
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return bussinessListModal.servicesUserList.count-1 == indexPath.row ? 200 : 140
//    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == .delete) {
//            // handle delete (by removing the data from your array and updating the tableview)
//        }
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if bussinessListModal == nil {
            return
        }
        else {
            
            let index = bussinessListModal.servicesUserList[indexPath.row]
            selectedBusinessIDTodayOffers = index.serviceID
            selectedCategoryType = CategoryType.business
            performSegue(withIdentifier: "detailsToDescription", sender: nil)
            
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailsToDescription" {
            let viewController:DetailDescriptionViewController = segue.destination as! DetailDescriptionViewController
            viewController.selectedServiceID = selectedBusinessIDTodayOffers
            viewController.categoryType = selectedCategoryType
        }
        
        if segue.identifier == "segueToAddBusiness" {
            
            if let viewController = segue.destination as? AddBusiness {
                
            }
        }
        
        if segue.identifier == "segueToUpdateBusiness" {
            
            if let viewController = segue.destination as? UpdateBusinessService {
                
                viewController.isType = isType
                viewController.isFrome = "AddBusiness"
                viewController.recivedData = sender as? ServicesUserList

            }
        }
        
        
        
//        if isType == "Edit" {
//            viewController.isType = isType
//            viewController.isFrome = "AddBusiness"
//            viewController.recivedData = sender as! ServicesUserList
//        } else {
//            viewController.isType = ""
//            viewController.isFrome = ""
//        }
    }
    
    
        
        
        
}




class businessListCell : UITableViewCell {
    
    @IBOutlet var viewBackground: UIView!
    @IBOutlet var viewRatingBar: AARatingBar!
    @IBOutlet var imageViewDetailList: UIImageView!
    @IBOutlet var labelDays: UILabel!
//    @IBOutlet var labelViews: UILabel!
    @IBOutlet var labelLocation: UILabel!
//    @IBOutlet var imageIconDetailList: UIImageView!
    @IBOutlet var labelTitleDetailedList: UILabel!
    
}
