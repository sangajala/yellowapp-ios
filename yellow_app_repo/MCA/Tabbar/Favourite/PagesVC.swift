//
//  PagesVC.swift
//  YELLOW APP
//
//  Created by Apple on 09/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import AARatingBar

class DetailListTableViewCellFavorites: UITableViewCell {

    
    @IBOutlet var viewBackground: UIView!
    @IBOutlet var viewRatingBar: AARatingBar!
    @IBOutlet var imageViewDetailList: UIImageView!
    @IBOutlet var labelDays: UILabel!
    @IBOutlet var labelViews: UILabel!
    @IBOutlet var labelLocation: UILabel!
    @IBOutlet var imageIconDetailList: UIImageView!
    @IBOutlet var labelTitleDetailedList: UILabel!
    
    
    
}

class PagesVC: UIViewController , IndicatorInfoProvider{

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var viewNoResponce: UIView!
    @IBOutlet weak var lblmassageNoResponce: UILabel!
    
    var presenterFavourites: FavouritesPresenterImplementation!
    var favouritesVC: FavouriteViewController!
    var sliderIndex = 0
    
    var msgArray = ["Here you can find Services  \n  that you grab or the items \n  that you liked","Here you can find Events  \n  that you grab or the items \n  that you liked","Here you can find Discounts and Offers  \n  that you grab or the items \n  that you liked","Here you can find Places of Interest  \n  that you grab or the items \n  that you liked"]
    
    var selectedBusinessID: Int!
    var selectedCategoryType: CategoryType!
    var titleString = ""
    
    var businessModel: [BusinessModelServicesList] = []
    var eventsModel: [EventsModelList] = []
    var promotionsModel: [PromotionsModelList] = []
    var organisationsModel: [OrganisationModelList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        print(organisationsModel)
        
        tableview.dataSource = self
        tableview.delegate = self
        viewNoResponce.isHidden = true
        
        // now no need this
//       setupLongPressGesture()

    }
    
    func ReloadFunction(index : Int) {
        
        print(index)
        
        sliderIndex = index
        
        DispatchQueue.main.async {
            self.tableview?.reloadData()
        }
        
//        if presenterFavourites.businessModel != nil && presenterFavourites.businessModel.ServicesList.count != 0 {
//            tableview.reloadData()
//        }
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: titleString)
    }
}

extension PagesVC: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        print("itemsForBeginning")
//        return [UIDragItem]
//    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == 0 {
            return 140
        }
        else if indexPath.row != 0 && businessModel.count-1 == indexPath.row{
            return 120
        }
        else{
            return 115
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if user_is_Login == false {
            if sliderIndex == 0 {
                
                viewNoResponce.isHidden = false
                lblmassageNoResponce.text = msgArray[0]
                
            } else if sliderIndex == 1 {
                
                viewNoResponce.isHidden = false
                lblmassageNoResponce.text =  msgArray[1]
                
                
            } else if sliderIndex == 2 {
                
                viewNoResponce.isHidden = false
                lblmassageNoResponce.text =  msgArray[2]
                
            } else if sliderIndex == 3 {
                
                viewNoResponce.isHidden = false
                lblmassageNoResponce.text =  msgArray[3]
                
            }
            return 0
        } else {
            
            if sliderIndex == 0 {
                if businessModel.count == 0 {
                    viewNoResponce.isHidden = false
                    lblmassageNoResponce.text =  msgArray[0]
                }else {
                    viewNoResponce.isHidden = true
                    print(businessModel.count)
                    return businessModel.count
                }
            } else if sliderIndex == 1 {
                if eventsModel.count == 0 {
                    viewNoResponce.isHidden = false
                    lblmassageNoResponce.text =  msgArray[1]
                }else {
                    viewNoResponce.isHidden = true
                    print(eventsModel.count)
                    return eventsModel.count
                }
            } else if sliderIndex == 2 {
                if promotionsModel.count == 0 {
                    viewNoResponce.isHidden = false
                    lblmassageNoResponce.text =  msgArray[2]
                }else {
                    viewNoResponce.isHidden = true
                    print(promotionsModel.count)
                    return promotionsModel.count
                }
            } else if sliderIndex == 3 {
                if organisationsModel.count == 0 {
                    viewNoResponce.isHidden = false
                    lblmassageNoResponce.text =  msgArray[3]
                }else {
                    viewNoResponce.isHidden = true
                    print(organisationsModel.count)
                    return organisationsModel.count
                }
            } else{
                
                viewNoResponce.isHidden = true
                return 0
            }
            
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if sliderIndex == 0 {
            
            var cell_indentifier = ""
            let service = businessModel[indexPath.row]
            var isFeatured = false
            
            if let featured = service.IsFeature{
                isFeatured  = featured == "true"
            }
            
            if isFeatured{
                cell_indentifier = indexPath.row == 0 ? "DetailListTableViewCellID_first_featured" : "DetailListTableViewCellID_featured"
            }
            else{
                cell_indentifier = indexPath.row == 0 ? "DetailListTableViewCellID_first" : "DetailListTableViewCellID"
            }
            
            let category_detailed_cell = tableView.dequeueReusableCell(withIdentifier: cell_indentifier) as! DetailListTableViewCellFavorites
            
            if let title = service.Title{
                category_detailed_cell.labelTitleDetailedList.text = title
            }
            
            if let image_url = service.Image {
                if let url_image = URL(string: image_url){
                    category_detailed_cell.imageViewDetailList.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                    }
                }
            }
            
            if let location = service.Location{
                category_detailed_cell.labelLocation.text = location
            }
            
            if let views = service.Views{
                category_detailed_cell.labelViews.text = views == 1 ? "\(views) view" : "\(views) views"
            }
            
            if let rating = service.Rating{
                category_detailed_cell.viewRatingBar.value = CGFloat(rating)
            }
            
            if let createdDate = service.Created_Datetime{
                
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
                    category_detailed_cell.labelDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
                    //Setting date in integer format
                    businessModel[indexPath.row].createdDate = days
                }
            }
            
             return category_detailed_cell
            
        } else if sliderIndex == 1 {
            
            var cell_indentifier = ""
            let service = eventsModel[indexPath.row]
            var isFeatured = false
            
            if let featured = service.IsFeature{
                isFeatured  = featured == "true"
            }
            
            if isFeatured{
                cell_indentifier = indexPath.row == 0 ? "DetailListTableViewCellID_first_featured" : "DetailListTableViewCellID_featured"
            }
            else{
                cell_indentifier = indexPath.row == 0 ? "DetailListTableViewCellID_first" : "DetailListTableViewCellID"
            }
            
            let category_detailed_cell = tableView.dequeueReusableCell(withIdentifier: cell_indentifier) as! DetailListTableViewCellFavorites
            
            if let title = service.Title{
                category_detailed_cell.labelTitleDetailedList.text = title
            }
            
            if let image_url = service.Image {
                if let url_image = URL(string: image_url){
                    category_detailed_cell.imageViewDetailList.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                    }
                }
            }
            
            if let location = service.Location{
                category_detailed_cell.labelLocation.text = location
            }
            
            if let views = service.Views{
                category_detailed_cell.labelViews.text = views == 1 ? "\(views) view" : "\(views) views"
            }
            
            if let rating = service.Rating{
                category_detailed_cell.viewRatingBar.value = CGFloat(rating)
            }
            
            if let createdDate = service.Created_Datetime{
                
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
                    category_detailed_cell.labelDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
                    //Setting date in integer format
                    eventsModel[indexPath.row].createdDate = days
                }
            }
            
            return category_detailed_cell
            
        } else if sliderIndex == 2 {
            
            var cell_indentifier = ""
            let service = promotionsModel[indexPath.row]
            var isFeatured = false
            
            if let featured = service.IsFeature{
                isFeatured  = featured == "true"
            }
            
            if isFeatured{
                cell_indentifier = indexPath.row == 0 ? "DetailListTableViewCellID_first_featured" : "DetailListTableViewCellID_featured"
            }
            else{
                cell_indentifier = indexPath.row == 0 ? "DetailListTableViewCellID_first" : "DetailListTableViewCellID"
            }
            
            let category_detailed_cell = tableView.dequeueReusableCell(withIdentifier: cell_indentifier) as! DetailListTableViewCellFavorites
            
            if let title = service.Title{
                category_detailed_cell.labelTitleDetailedList.text = title
            }
            
            if let image_url = service.Image {
                if let url_image = URL(string: image_url){
                    category_detailed_cell.imageViewDetailList.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                    }
                }
            }
            
            if let location = service.Location{
                category_detailed_cell.labelLocation.text = location
            }
            
            if let views = service.Views{
                category_detailed_cell.labelViews.text = views == 1 ? "\(views) view" : "\(views) views"
            }
            
            if let rating = service.Rating{
                category_detailed_cell.viewRatingBar.value = CGFloat(rating)
            }
            
            if let createdDate = service.Created_Datetime{
                
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
                    category_detailed_cell.labelDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
                    //Setting date in integer format
                    promotionsModel[indexPath.row].createdDate = days
                }
            }
            
            return category_detailed_cell
            
        } else {
            
            var cell_indentifier = ""
            let service = organisationsModel[indexPath.row]
            var isFeatured = false
            
            if let featured = service.IsFeature{
                isFeatured  = featured == "true"
            }
            
            if isFeatured{
                cell_indentifier = indexPath.row == 0 ? "DetailListTableViewCellID_first_featured" : "DetailListTableViewCellID_featured"
            }
            else{
                cell_indentifier = indexPath.row == 0 ? "DetailListTableViewCellID_first" : "DetailListTableViewCellID"
            }
            
            let category_detailed_cell = tableView.dequeueReusableCell(withIdentifier: cell_indentifier) as! DetailListTableViewCellFavorites
            
            if let title = service.Title{
                category_detailed_cell.labelTitleDetailedList.text = title
            }
            
            if let image_url = service.Image {
                if let url_image = URL(string: image_url){
                    category_detailed_cell.imageViewDetailList.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                    }
                }
            }
            
            if let location = service.Location{
                category_detailed_cell.labelLocation.text = location
            }
            
            if let views = service.Views{
                category_detailed_cell.labelViews.text = views == 1 ? "\(views) view" : "\(views) views"
            }
            
            if let rating = service.Rating{
                category_detailed_cell.viewRatingBar.value = CGFloat(rating)
            }
            
            if let createdDate = service.Created_Datetime{
                
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
                    category_detailed_cell.labelDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
                    //Setting date in integer format
                    organisationsModel[indexPath.row].createdDate = days
                }
            }
            
            return category_detailed_cell
            
        }
       
       return UITableViewCell()

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let user_id_cached = UserDefaults.standard.value(forKey: key_user_id) as? Int ?? 0
//
//        favouritesVC.presenterFavourites.fetchBusinessFavourites(user_id: user_id_cached)
//
//        return
        
        if sliderIndex == 0 {
            
            let service = businessModel[indexPath.row]
            print(service)
            selectedBusinessID = service.Service_Id
            selectedCategoryType = CategoryType.business

//            AppManager.shared.businessModel.ServicesList = businessModel
            AppManager.shared.index_for_report = indexPath.row
            performSegue(withIdentifier: "detailsToDescription", sender: nil)
            
        } else if sliderIndex == 1 {
            
            let service = eventsModel[indexPath.row]
            print(service)
            selectedBusinessID = service.Event_Id
            selectedCategoryType = CategoryType.events

//            AppManager.shared.eventsModel.EventsList = eventsModel
            AppManager.shared.index_for_report = indexPath.row
            performSegue(withIdentifier: "detailsToDescription", sender: nil)
            
        } else if sliderIndex == 2 {
            
            let service = promotionsModel[indexPath.row]
            print(service)
            selectedBusinessID = service.Pro_Id
            selectedCategoryType = CategoryType.promotions

//            AppManager.shared.promotionsModel.PromotionsList = promotionsModel
            AppManager.shared.index_for_report = indexPath.row
            performSegue(withIdentifier: "detailsToDescription", sender: nil)
            
        } else if sliderIndex == 3 {
            
            let service = organisationsModel[indexPath.row]
            print(service)
            selectedBusinessID = service.Organisation_Id
            selectedCategoryType = CategoryType.organisations
//            AppManager.shared.organisationsModel.OrganisationsList = organisationsModel
            AppManager.shared.index_for_report = indexPath.row
            performSegue(withIdentifier: "detailsToDescription", sender: nil)
            
        } else {
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            if sliderIndex == 0 {
                
                let service = businessModel[indexPath.row]
                print(service)
                removeAddtoWallet(selectedServiceID: service.Service_Id ?? 0)
                
            } else if sliderIndex == 1 {
                
                let service = eventsModel[indexPath.row]
                print(service)
                removeAddtoWallet(selectedServiceID: service.Event_Id ?? 0)
                
            } else if sliderIndex == 2 {
                
                let service = promotionsModel[indexPath.row]
                print(service)
                removeAddtoWallet(selectedServiceID: service.Pro_Id ?? 0)
                
            } else if sliderIndex == 3 {
                
                let service = organisationsModel[indexPath.row]
                print(service)
                removeAddtoWallet(selectedServiceID: service.Organisation_Id ?? 0)
                
            } else {
                
                
             }
           }
        }
    
//    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
//        print("cell dragSessionDidEnd")
//    }

//    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
//        print("dragPreviewParametersForRowAt")
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsToDescription" {
            let viewController:DetailDescriptionViewController = segue.destination as! DetailDescriptionViewController
            viewController.selectedServiceID = selectedBusinessID
            viewController.categoryType = selectedCategoryType
        }
    }
    
    func removeAddtoWallet(selectedServiceID : Int) {
        print("remove to wallet function")
        
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
            }
        } else if (UserDefaults.standard.value(forKey: key_user_id) != nil) {
            
            let user_id_cached = UserDefaults.standard.value(forKey: key_user_id) as? Int ?? 0
            print(user_id_cached,selectedCategoryType)
            
            removeToToWallet(service_id: selectedServiceID, user_id: user_id_cached)
            
//            if sliderIndex == 0 {
//
//                removeToToWallet(categoryType: selectedCategoryType, service_id: selectedServiceID, user_id: user_id_cached)
//            } else if sliderIndex == 1{
//
//            } else if sliderIndex == 2{
//
//            } else if sliderIndex == 3{
//
//            }
        }
    }
    
    
    func removeToToWallet(service_id: Int, user_id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        //        DispatchQueue.main.async {
        //            self.addActivityIndicatorView()
        //        }
        
        var payloadParams = [
            "serviceId": service_id,
            "userid": user_id
            ] as [String : Any]
        
        //        print("Parm : \(payloadParams)")
        
        var postRequestType = POST_RequestType.remove_wallet_business_post
        
        var parmUrl = ""
        
        if sliderIndex == 0 {
            
            parmUrl = "?serviceId=\(service_id)&userid=\(user_id)"
            
            payloadParams = [
                "serviceId": service_id,
                "userid": user_id,
                "parmurl": parmUrl
                ] as [String : Any]
            
            postRequestType = POST_RequestType.remove_wallet_business_post
        }
        
        else if sliderIndex == 1 {
            
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
        } else if sliderIndex == 2{
            
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
        
        helper.startLoader(view: self.view)
        
        print("postRequestType : \(postRequestType)")
        AppManager.shared.printLog(stringToPrint: "remove add to Cart post parameters: \(payloadParams)")
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        _ = NetworkInterface.postRequest(postRequestType, headers: headers as NSDictionary, params: nil, payload: payloadParams){ (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            //            DispatchQueue.main.async {
            //                self.removeActivityIndicator()
            //            }
            //
            guard let data_ = data else{
                DispatchQueue.main.async {
                }
                return
            }
            
            do{
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData)
                let decoder = JSONDecoder()
                
                if self.sliderIndex == 0 {
                    
                    let response = try decoder.decode(RemoveWalletModel.self, from: data!)
                    self.responseRemoveWallet(addWalletModel: response)
                    
                    
                } else if self.sliderIndex == 1 {
                    
                    let response = try decoder.decode(RemoveWalletModel.self, from: data!)
                    self.responseRemoveWallet(addWalletModel: response)
                    
                } else if self.sliderIndex == 2 {
                    
                    let response = try decoder.decode(RemoveWalletModel.self, from: data!)
                    self.responseRemoveWallet(addWalletModel: response)
                    
                } else if self.sliderIndex == 3 {
                    
                    let response = try decoder.decode(RemoveWalletModel.self, from: data!)
                    self.responseRemoveWallet(addWalletModel: response)
                    
                } else {
                    
                }
                
            }
            catch {
                //                    AppManager.shared.printLog(stringToPrint: "No response from the server please try again later. ")
            }
        }
    }
    
    
    func responseRemoveWallet(addWalletModel: RemoveWalletModel) {
        
        print(addWalletModel)
        
        let user_id_cached = UserDefaults.standard.value(forKey: key_user_id) as? Int ?? 0
        let messgae = addWalletModel.Message
        
        if addWalletModel.isSuccess == true {
            
            self.showToast(message: messgae ?? "", font: UIFont.systemFont(ofSize: 16.0))

            
            if sliderIndex == 0 {
                
                favouritesVC.presenterFavourites.fetchBusinessFavourites(user_id: user_id_cached)
                
            } else if sliderIndex == 1 {
                favouritesVC.presenterFavourites.fetchBusinessFavourites_Event(user_id: user_id_cached)

                
            } else if sliderIndex == 2 {
                
                favouritesVC.presenterFavourites.fetchBusinessFavourites_Promotions(user_id: user_id_cached)

                
            } else if sliderIndex == 3 {
                
                favouritesVC.presenterFavourites.fetchBusinessFavourites_Organization(user_id: user_id_cached)

                
            } else {
                
            }
            
        } else {
            
            self.showToast(message: messgae ?? "", font: UIFont.systemFont(ofSize: 16.0))
            
//            let alert = UIAlertController(title: "Alert", message: messgae ?? "", preferredStyle: UIAlertController.Style.alert)
//
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
//            }))
//            // show the alert
//            self.present(alert, animated: true, completion: nil)
            
        }
    }
}


extension PagesVC : UIGestureRecognizerDelegate {
    
    func setupLongPressGesture() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        longPressGesture.minimumPressDuration = 0.5 // 1 second press
        longPressGesture.delegate = self as UIGestureRecognizerDelegate
        self.tableview.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .ended {
            let touchPoint = gestureRecognizer.location(in: tableview)
            if let indexPath = tableview.indexPathForRow(at: touchPoint) {
                
                print("tuch Index \(indexPath)")
                
            }
        } else if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: tableview)
            if let indexPath = tableview.indexPathForRow(at: touchPoint) {
                
                helper.showAlertOKCancelWithAction(appName, "Are you sure want to remove in favourites list", self, cancelClosure: { (cancel ) in
                    
                    
                    
                }) { (ok) in
                    
                    
                    if self.sliderIndex == 0 {
                        
                        let service = self.businessModel[indexPath.row]
                        print(service)
                        self.removeAddtoWallet(selectedServiceID: service.Service_Id ?? 0)
                        
                        
                    } else if self.sliderIndex == 1 {
                        
                        let service = self.eventsModel[indexPath.row]
                        print(service)
                        self.removeAddtoWallet(selectedServiceID: service.Event_Id ?? 0)
                        
                    } else if self.sliderIndex == 2 {
                        
                        let service = self.promotionsModel[indexPath.row]
                        print(service)
                        self.removeAddtoWallet(selectedServiceID: service.Pro_Id ?? 0)
                        
                        
                        
                    } else if self.sliderIndex == 3 {
                        
                        let service = self.organisationsModel[indexPath.row]
                        print(service)
                        self.removeAddtoWallet(selectedServiceID: service.Organisation_Id ?? 0)
                        
                        
                    } else {
                        
                        
                    }

                    
                    
                
                }
                
                
                print("tuch Index \(indexPath)")
                
            }
        }
    }
}
