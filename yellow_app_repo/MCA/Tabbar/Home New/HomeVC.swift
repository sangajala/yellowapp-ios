//
//  HomeVC.swift
//  MCA
//
//  Created by Arthonsys Ben on 01/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//
//print("****** json Data\(jsonData)")

import UIKit
import SafariServices
import Kingfisher
import MapKit
import AARatingBar

class HomeVC: UIViewController {
    
    @IBOutlet weak var viewNoDataFound: UIView!
    @IBOutlet weak var viewLocationSelectTable: UIView!

    @IBOutlet weak var collectionViewSliderTop: UICollectionView!
    @IBOutlet weak var collectionViewPromotions: UICollectionView!
    @IBOutlet weak var collectionViewServices: UICollectionView!
    
    @IBOutlet weak var collectionViewEvents: UICollectionView!
    
    @IBOutlet weak var btnAboutUs: UIButton!
    @IBOutlet weak var imgItemBottom: UIImageView!
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var lblItemName: UILabel!
    
    var homeAllData: HomeModel!
    var promotionsData: PromotionsHomeModel!
    var organizationData: OrganizationHomeModel2!
    var categoriesData: CategoriesHomeModel3!
    var servicesListData : HomeServices_List!
    var EventsListData : HomeEventListModel!
    
    var In_Store_Offers : [PromotionsList] = []
    var In_Online_Offers : [PromotionsList] = []

    var selectedCategoryType: CategoryType!
    var selectedBusinessIDTodayOffers : Int?
    
    var hedertitlePass : String?

    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    @IBOutlet weak var btnLocationEvent: UIButton!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var btnProfileImage: UIButton!
    
    // Map View
    @IBOutlet weak var mapViewMain: UIView!
    @IBOutlet weak var mapViewKit: MKMapView!
    
    @IBOutlet weak var mapViewConstantHi: NSLayoutConstraint!
    
    //Home View All
    
    @IBOutlet weak var viewServiceMain: UIView!
    @IBOutlet weak var viewServiceMianHightCon: NSLayoutConstraint!
    
    @IBOutlet weak var viewAddmyBusOutlet: UIView!
    @IBOutlet weak var viewAddmybusHigthCon: NSLayoutConstraint!
    
    @IBOutlet weak var viewOnlineOffersMain: UIView!
    @IBOutlet weak var viewOnlineOffersMainHightCon: NSLayoutConstraint!
    
    @IBOutlet weak var viewInstoreOffers: UIView!
    @IBOutlet weak var viewInStoreOffersHight: NSLayoutConstraint!
    
    @IBOutlet weak var viewEvents: UIView!
    
    // About view
    @IBOutlet weak var viewEventMore: UIView!
    @IBOutlet weak var ViewAboutusCon: NSLayoutConstraint!
    @IBOutlet weak var viewAboutTopCon: NSLayoutConstraint!
    
    // Event View
    @IBOutlet weak var viewEvents1Con: NSLayoutConstraint!
    //    @IBOutlet weak var viewEventsCon: NSLayoutConstraint!
    
    @IBOutlet weak var viewServicesOutlet: UIView!
    @IBOutlet weak var viewTodayOfferOutlet: UIView!
    
    @IBOutlet weak var collectionTopSliderConstant: NSLayoutConstraint!
    
    @IBOutlet weak var viewServices1Con: NSLayoutConstraint!
//    @IBOutlet weak var ViewservicesCon: NSLayoutConstraint!
    
    // Offers View
//    @IBOutlet weak var ViewTodays1OffCon: NSLayoutConstraint!
    @IBOutlet weak var ViewTodaysOffCon: NSLayoutConstraint!
    

    
    @IBOutlet weak var viewAboutus: UIView!
    
    // When user select location Offers todays view
    @IBOutlet weak var viewLocationSelect: UIView!
    
    @IBOutlet weak var imageLocation: UIImageView!
    @IBOutlet weak var btnCloseLocation: UIButton!
    @IBOutlet weak var imageLocationView: UIImageView!
    @IBOutlet weak var lbltitleName: UILabel!
    @IBOutlet weak var lblLocationName: UILabel!
    
    @IBOutlet weak var lblitemStatusDays: UILabel!
    @IBOutlet weak var lblreviews: UILabel!
    @IBOutlet weak var viewRating: AARatingBar!
    
    // Map View Top view Promotion Services
    
    @IBOutlet weak var viewPromotions: UIView!
    @IBOutlet weak var viewServices: UIView!

    let allLocationArray = NSMutableArray()
    
//    var inboundGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewDataSetup()
        
    }
    
    func viewDataSetup(){
        
        viewNoDataFound.isHidden = true
        viewLocationSelectTable.isHidden = true
        
        if (UserDefaults.standard.object(forKey: key_user_id) != nil){
            let user_id = UserDefaults.standard.value(forKey: key_user_id) as! Int
            print(user_id)
            if user_id != 0 {
                user_is_Login = true
            } else {
                user_is_Login = false
            }
        }
        
        mapViewKit.delegate = self
        
        btnAboutUs.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // Do any additional setup after loading the view.
        getHomeDataFromServer()
        
        // revealViewController
        self.revealViewController().panGestureRecognizer().isEnabled = true
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        mapViewHide()
        addGradient()
        
    }
    
    func addGradient() {
        
        let gradient1 = CAGradientLayer()
        
        gradient1.frame = viewServices.bounds

        gradient1.colors = [hexStringToUIColor(hex: "E6E3F6").cgColor,  hexStringToUIColor(hex: "E6E3F6").cgColor]
        
        viewServices.layer.insertSublayer(gradient1, at: 0)
        
        let gradient2 = CAGradientLayer()
        
        gradient2.frame = viewPromotions.bounds
        gradient2.colors = [hexStringToUIColor(hex: "E5F9EE").cgColor, hexStringToUIColor(hex: "E5F9EE").cgColor]

        viewPromotions.layer.insertSublayer(gradient2, at: 0)
        
    }
    
    func mapViewHide() {
        
        mapViewMain.isHidden = true
        self.viewLocationSelect.isHidden = true
        mapViewConstantHi.constant = 0
        
        viewServiceMain.isHidden = false
        viewServiceMianHightCon.constant = 245
        
        viewAddmyBusOutlet.isHidden = false
        viewAddmybusHigthCon.constant = 50
        
        viewOnlineOffersMain.isHidden = false
        viewOnlineOffersMainHightCon.constant = 216
       
        viewEvents.isHidden = false
        ViewAboutusCon.constant = 180
        
        viewAboutus.isHidden = false
        viewAboutTopCon.constant = 100
        
        if In_Store_Offers.count > 0 {
            viewInstoreOffers.isHidden = false
            viewInStoreOffersHight.constant = 211
        } else{
            viewInstoreOffers.isHidden = true
            viewInStoreOffersHight.constant = 0
        }
        
        
       
//        mapViewConstantHi.constant = 0
//
//        viewServicesOutlet.isHidden = false
//        viewAddmyBusOutlet.isHidden = false
//        viewTodayOfferOutlet.isHidden = false
//        viewEvents.isHidden = false
//
//        viewServices1Con.constant = 35
//        ViewservicesCon.constant = 200
//        ViewTodays1OffCon.constant = 42
//        ViewTodaysOffCon.constant = 176
//        ViewAboutusCon.constant = 180
//
//        viewEvents1Con.constant = 35
//        viewInStoreOffersHight.constant = 211
//
//        viewAboutTopCon.constant = 10
//        viewAboutus.isHidden = false

//        collectionViewServices.reloadData()
        
//        if categoriesData != nil {
//            if categoriesData.categoriesDetails.count != nil {
//                if categoriesData.categoriesDetails.count >= 6 {
//
//                    ViewservicesCon.constant = 200
//
//                } else {
//
//                    ViewservicesCon.constant = 110
//
//                }
//
//            } else{
//
//                ViewservicesCon.constant = 110
//
//            }
//
//        } else {
//
//            ViewservicesCon.constant = 110
//
//        }
        
//        if homeAllData == nil {
//            mapViewConstantHi.constant = 400
//        } else if homeAllData.sliderimages.count == 0 {
//            mapViewConstantHi.constant = 400
//        } else {
//            mapViewConstantHi.constant = 400
//        }

    }
    
    func mapViewShow() {
        
//        let middleSpace = -55
        
        mapViewMain.isHidden = false
        mapViewConstantHi.constant = 400
        
        viewServiceMain.isHidden = true
        viewServiceMianHightCon.constant = 0
        
        viewAddmyBusOutlet.isHidden = true
        viewAddmybusHigthCon.constant = 0
        
        viewOnlineOffersMain.isHidden = true
        viewOnlineOffersMainHightCon.constant = 0
        
        viewInstoreOffers.isHidden = true
        viewInStoreOffersHight.constant = 0
        
        viewEvents.isHidden = true
        ViewAboutusCon.constant = 0
        
        viewAboutus.isHidden = true
        viewAboutTopCon.constant = 0
        
//        viewServicesOutlet.isHidden = true
//        viewAddmyBusOutlet.isHidden = true
//        viewTodayOfferOutlet.isHidden = true
//        viewEvents.isHidden = true

//        viewServices1Con.constant = 0
//        ViewservicesCon.constant = 0
//        ViewTodays1OffCon.constant = 0
//        ViewTodaysOffCon.constant = 0
//        ViewAboutusCon.constant = 0
        
//        viewEvents1Con.constant = 0
//        viewInStoreOffersHight.constant = 0
        
//        viewAboutTopCon.constant = -200
//        viewAboutus.isHidden = true
        
    }
    
    @IBAction func btnLocationDetailsViewCloseEvent(_ sender: UIButton) {
        self.viewLocationSelect.isHidden = true
    }
    
    @IBAction func btnOpenselectLocationpage(_ sender: UIButton) {
        performSegue(withIdentifier: "detailsToDescription", sender: nil)
    }
    
    func getHomeDataFromServer() {
        
        viewNoDataFound.isHidden = true
       
        // (UserDefaults.standard.value(forKey: key_user_id) != nil) &&
        if ((UserDefaults.standard.value(forKey: key_location_id) != nil)){
            let user_id_cached = UserDefaults.standard.value(forKey: key_user_id) as? Int ?? 0
            let location_id_cached = UserDefaults.standard.value(forKey: key_location_id) as! Int
            let location_name = UserDefaults.standard.value(forKey: key_location_name) as? String ?? ""
            
            btnLocationEvent.setTitle(location_name, for: .normal)
            
            if (UserDefaults.standard.value(forKey: key_city_name) != nil) {
                let cityName = UserDefaults.standard.value(forKey: key_city_name) as? String ?? ""
                lblCityName.text = cityName
            }
            
            allLocationArray.removeAllObjects()

            getHomeData(location_id: location_id_cached, user_id: user_id_cached)
            getHomeDataEvent(Community_Id: location_id_cached)
            getHomeDataPromotions(location_id: location_id_cached)
            getHomeDataOrganizations(location_id: location_id_cached)
            getHomeDataCategories(location_id: location_id_cached)
            getHomeDataServices(location_id: location_id_cached)
            Api_Profile_Data(user_Id: user_id_cached)
            
        }
        else{
            AppManager.shared.showOkAlert(title: "Message", message: "Unable to fetch location data. Please try again later.", view: self, onCompletion: { (callBack: String) in })
        }
        
        //        if let location_id = AppManager.shared.locationSelectedModel_shared.Location_ID, let user_id = AppManager.shared.user_details.UserID{
        //            let user_id_cached = UserDefaults.standard.value(forUndefinedKey: key_user_id) as! Int
        //            presenterHome.getHomeData(location_id: location_id, user_id: user_id_cached)
        //        }
        //        else{
        //            print("Unable to fetch Home data.")
        //        }
    }
    
    
    
//    inboundGroup.noti
    
    
//    inboundGroup.notify(queue: .main, execute: {
//        DispatchQueue.main.async {
//
//           GlobalClass.hideHud()
//          self.alert.dismiss(animated: true, completion: nil)
//           self.imgView.rotate360Degrees(show: false)
//    }
//    })
    
    override func viewWillAppear(_ animated: Bool) {
//        mapViewHide()
    }
    
    //  : - API 1
    func getHomeData(location_id: Int, user_id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.view)

        let headers = [ ACCEPT : APPLICATION_JSON]
        
        let payloadParams = ["CommunityId": location_id] as [String : Any]
        
        //,  "User_ID": user_id
        
        
        ////inboundGroup.enter()
        
        _ = NetworkInterface.getRequest(.home_get, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            ////inboundGroup.leave()
            
            helper.stopLoader()
           
            guard let _ = data else {
                
                //self.//viewNoDataFound.isHidden = false
                //inboundGroup.leave()
                
//                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
//                }
                return
            }
            
            do {
                
                self.viewNoDataFound.isHidden = true
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                print("homeAllData Slider Images top : \(jsonData)")
                let decoder = JSONDecoder()
                let response = try decoder.decode(HomeModel.self, from: data!)
//                print(response)
                
//                do {
//                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
//                    print(jsonData)
//                } catch let myJSONError {
//                    print(myJSONError)
//                }
                
                self.homeAllData = response
                 //inboundGroup.leave()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.startTimer()
                    self.collectionViewSliderTop.reloadData()
                }
                //Passing back values to ViewController to make use of the data
//                self.homeViewController?.homeDataResponse(homeModel: response)
            }
            catch {
                
                //self.//viewNoDataFound.isHidden = false
                 //inboundGroup.leave()
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code : *\(String(describing: response?.statusCode)).")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.collectionViewSliderTop.reloadData()
                }
            }
        }
    }
    
    
    //  : - API 2

    func getHomeDataCategories(location_id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.view)
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        //self.inboundGroup.enter()
        
        let payloadParams = ["CommunityId": location_id] as [String : Any]
        
        _ = NetworkInterface.getRequest(.home_categories, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            
            helper.stopLoader()
            
            guard let _ = data else {
                
                self.viewNoDataFound.isHidden = false
                //inboundGroup.leave()

//                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
//                }
                return
            }
            
            do {
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                print("categoriesData get Services : \(jsonData)")
                let decoder = JSONDecoder()
                let response = try decoder.decode(CategoriesHomeModel3.self, from: data!)
//                print(response)
                
//                do {
//                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
//                    print(jsonData)
//                } catch let myJSONError {
//                    print(myJSONError)
//                }
                
                self.categoriesData = response
                //inboundGroup.leave()
                print(self.categoriesData)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.collectionViewServices.reloadData()
                }
                
                //Passing back values to ViewController to make use of the data
                //                self.homeViewController?.homeDataResponse(homeModel: response)
            }
            catch{
                //inboundGroup.leave()
                self.viewNoDataFound.isHidden = false
                AppManager.shared.printLog(stringToPrint: "home_categories API Error. Status Code: **\(String(describing: response?.statusCode)).")
                self.collectionViewServices.reloadData()

            }
        }
    }
    
    
    
    //  : - API 3

    func getHomeDataEvent(Community_Id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        let payloadParams = ["Communityid": Community_Id] as [String : Any]
        
        _ = NetworkInterface.getRequest(.get_event, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            guard let _ = data else {
                DispatchQueue.main.async {
                    //                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                print("EventsListData : \(jsonData)")
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(HomeEventListModel.self, from: data!)
//                print(response)
//                do {
//                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
//                    print(jsonData)
//                } catch let myJSONError {
//                    print(myJSONError)
//                }
                self.EventsListData = response
                self.collectionViewEvents.reloadData()
                
                //Passing back values to ViewController to make use of the data
                //                self.homeViewController?.homeDataResponse(homeModel: response)
            }
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
    
    //  : - API 4

    func getHomeDataPromotions(location_id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.view)

        let headers = [ ACCEPT : APPLICATION_JSON]
        
        let payloadParams = ["CommunityId": location_id] as [String : Any]
        
        //self.inboundGroup.enter()
        
        _ = NetworkInterface.getRequest(.home_get_promotions, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()

            
            guard let _ = data else {
                
                //self.//viewNoDataFound.isHidden = false
                //inboundGroup.leave()

//                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
//                }
                return
            }
            
            do{
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                print("promotionsData : \(jsonData)")
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(PromotionsHomeModel.self, from: data!)
//                print(response)
                
//                do {
//                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
//                    print(jsonData)
//                } catch let myJSONError {
//                    print(myJSONError)
//                }
                
                self.promotionsData = response
                if response.promotionsList.count > 0{
                    
                    let filterDataOnlinestore = response.promotionsList.filter{$0.isFeature == "nil" || $0.isFeature == "false" }
                    self.In_Online_Offers = filterDataOnlinestore
                    
                    let filterDataInstore = response.promotionsList.filter{$0.isFeature != "nil" || $0.isFeature == "true"}
                    self.In_Store_Offers = filterDataInstore//self.promotionsData.promotionsList
                    
                }
                //inboundGroup.leave()
                
//                AppManager.shared.promotionsModel = self.promotionsData

                
                for i in self.promotionsData.promotionsList {
                    
                    if i.longitude == nil || i.latitude == nil || (i.longitude ?? "").count == 0 || (i.latitude ?? "").count == 0  {
                        return
                    }
                    
                    let lat = Double(i.latitude ?? "51.5074")
                    let long = Double(i.longitude ?? "0.1278")
                    
                    let dic = ["latitude" : "\(lat!)",
                        "longitude" : "\(long!)",
                        "locationType" : "promotions",
                        "title" : "\(i.title ?? "")"]
                    self.allLocationArray.add(dic)
                }
                
                print(self.allLocationArray)
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.collectionViewPromotions.reloadData()
                    self.collectionViewEvents.reloadData()
                    
                }

                
//                self.mapViewAddAnnotationPromotions(PromotionsHome: self.promotionsData)
                
                //Passing back values to ViewController to make use of the data
                //                self.homeViewController?.homeDataResponse(homeModel: response)
            }
            catch {
                //inboundGroup.leave()
                AppManager.shared.printLog(stringToPrint: "home_get_promotions API Error. Status Code: \(String(describing: response?.statusCode)).")
                self.collectionViewPromotions.reloadData()
            }
        }
    }
    
    //  : - API 5

    func Api_Profile_Data (user_Id : Int){
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.view)
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        let payloadParams = ["userid": user_Id] as [String : Any]
        
        print(payloadParams)
        
        _ = NetworkInterface.getRequest(.get_Profile_data, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            ////inboundGroup.leave()
            
            helper.stopLoader()
            
            guard let _ = data else {
                
                //                DispatchQueue.main.async {
                //                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                //                }
                return
            }
            
            do {
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                
                print("ProfileData : \(jsonData)")

                let decoder = JSONDecoder()
                let response = try decoder.decode(ProfileData.self, from: data!)
                AppManager.shared.profileDataModal = response

//                print(response)
                
                // user Data set
//                self.lblName.text? = (response.firstname)
//                self.lblLastName.text? = (response.lastname)
//                self.lblMonumber.text? = (response.phone)
//                self.lblGmail.text? = (response.email)
                let imageurl = response.profilePic
                if imageurl != nil && imageurl != "" {
                    self.imageProfile.kf.setImage(with: URL(string: imageurl), placeholder: UIImage(named :"man_placeholder"), options: nil, progressBlock: nil) { (result) in
                    }}
                //
                //                self.bussinessListModal = response
                //                self.tableViewBusnessList.reloadData()
                
            }
            catch {
                
                AppManager.shared.printLog(stringToPrint: "get_Profile_data API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
    
    //  : - API 6

    func getHomeDataServices(location_id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.view)
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        let payloadParams = ["CommunityId": location_id] as [String : Any]
        
        _ = NetworkInterface.getRequest(.home_get_services, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                
                //self.//viewNoDataFound.isHidden = false

                //                DispatchQueue.main.async {
                //                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                //                }
                return
            }
            
            do {
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                print("HomeServices_List : \(jsonData)")

                let decoder = JSONDecoder()
                let response = try decoder.decode(HomeServices_List.self, from: data!)
                
//                print(response)
                print(response.servicesList)
                
                for i in response.servicesList {
                    
                    if i.longitude == nil || i.latitude == nil || i.longitude!.count == 0 || i.latitude!.count == 0  {
                        return
                    }
                    
                    let lat = Double(i.latitude ?? "0.0")
                    let long = Double(i.longitude ?? "0.0")
                    let dic = ["latitude" : "\(lat!)",
                               "longitude" : "\(long!)",
                        "locationType" : "Services",
                        "title" : "\(i.title  ?? "")"]
                    
                    self.allLocationArray.add(dic)
                }
                
                print(self.allLocationArray)
                
                self.servicesListData = response
                self.collectionViewSliderTop.reloadData()
 
            }
            catch {
                //inboundGroup.leave()
                self.collectionViewSliderTop.reloadData()
                AppManager.shared.printLog(stringToPrint: "HomeServicesList API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
    
//    func select(partner: Partner){
//
//    }
    
    //  : - API 7

    func getHomeDataOrganizations(location_id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.view)

        let headers = [ ACCEPT : APPLICATION_JSON]
        
        
        //self.inboundGroup.enter()
        
        let payloadParams = ["CommunityId": location_id] as [String : Any]
        
        _ = NetworkInterface.getRequest(.home_organizations, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                
                //inboundGroup.leave()
//                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
//                }
                
                return
            }
            
            do{
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                print("OrganizationHomeModel2 : \(jsonData)")

                let decoder = JSONDecoder()
                let response = try decoder.decode(OrganizationHomeModel2.self, from: data!)
                print(response)

//
//                do {
//
//                } catch let myJSONError {
//                    print(myJSONError)
//                }
                
                self.organizationData = response
                //inboundGroup.leave()
                
//                AppManager.shared.organisationsModel = response

                
                let organizationModel = self.organizationData.organizationList[0]
                let image_url = organizationModel.image
                
                let url = URL(string: image_url ?? "")
                //             ?? ""    self.imgItemBottom.kf.setImage(with: url)
//                if real_url = url {
                    self.imgItemBottom.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                    }
//                }
                
//                print(organizationModel.title)
                self.lblItemName.text? = organizationModel.title ?? ""
//                self.collectionViewSliderTop.reloadData()

                
                //Passing back values to ViewController to make use of the data
                //                self.homeViewController?.homeDataResponse(homeModel: response)
            }
            catch {
//                self.collectionViewSliderTop.reloadData()
                //inboundGroup.leave()
                AppManager.shared.printLog(stringToPrint: "home_organizations API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
    
    @IBAction func btnSeeAllServiceAction(_ sender: UIButton) {
        
        mainTabbarObj?.selectedIndex = 2
        
    }
    
    @IBAction func btnAboutUsAction(_ sender: UIButton) {
        btnAboutUsPage()
    }
    
    public func btnAboutUsPage() {
        
        helper.startLoader(view: self.view)
        
        if self.organizationData == nil {
            
            helper.stopLoader()
            
            return
        } else {
            
            helper.stopLoader()
            
            DispatchQueue.main.async {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
                let organizationModel = self.organizationData.organizationList[0]
                vc.organizID = organizationModel.orgID
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        
    }
    
    @IBAction func btnProfileEvent(_ sender: UIButton) {
        
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
            
            return
        } else{
            performSegue(withIdentifier: "seguetoProfile", sender: nil)
            
        }
    }
    
    func openDiscount() {
        
//        selectedCategoryType = CategoryType.promotions
//        performSegue(withIdentifier: "mainToDetail", sender: nil)
        
        if let viewController = ((self.tabBarController?.viewControllers?[1] as! UINavigationController).viewControllers[0]) as? DetailListViewController {
            
            print(viewController)
            viewController.categoryType = CategoryType.promotions
            //            viewController.Req_cat_ID = catID ?? 0
            //            viewController.Req_sub_Cat_ID = selectSubCat
            //            viewController.Req_title = selectSubCatTitle
            
            tabBarController?.selectedIndex = 1
            
        }
        
    }
    
    func openEvents() {
        
//        selectedCategoryType = CategoryType.events
//        performSegue(withIdentifier: "mainToDetail", sender: nil)
        
        if let viewController = ((self.tabBarController?.viewControllers?[1] as! UINavigationController).viewControllers[0]) as? DetailListViewController {
            
            print(viewController)
            viewController.categoryType = CategoryType.events
            //            viewController.Req_cat_ID = catID ?? 0
            //            viewController.Req_sub_Cat_ID = selectSubCat
            //            viewController.Req_title = selectSubCatTitle
            
            tabBarController?.selectedIndex = 1
            
        }
        
//        if user_is_Login == false {
//
//            helper.showAlertOKCancelAction(appName, "User is not Login", self, successClosure: { (login) in
//
//                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = testController
//
//            }) { (skip) in
//
////                mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//                mainTabbarObj.selectedIndex = 0
//
//            }
//            return
//        } else{
//
//            selectedCategoryType = CategoryType.events
//            performSegue(withIdentifier: "mainToDetail", sender: nil)
//
//        }
    }
    
    @IBAction func btnAddmyBusinessEvent(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "segueToAddBusiness", sender: self)
        
//        if user_is_Login == false {
//
//            helper.showAlertOKCancelAction(appName, "User is not Login", self, successClosure: { (login) in
//
//                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = testController
//
//            }) { (skip) in
//
//                mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//                mainTabbarObj.selectedIndex = 0
//
//            }
//
//            return
//        } else{
//
//            self.performSegue(withIdentifier: "segueToAddBusiness", sender: self)
//
//
//        }
        
    }
    
    
    func openFavouriteList() {
        performSegue(withIdentifier: "segueToFavouriteList", sender: self)
    }
    
    @IBAction func btnShareEvent(_ sender: UIButton) {
        
        let textToShare = ["yellowapp.co.uk"]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.copyToPasteboard]
        //UIActivity.ActivityType.airDrop
        //UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.assignToContact ,UIActivity.ActivityType.mail, UIActivity.ActivityType.markupAsPDF, UIActivity.ActivityType.message
        
        // present the view controller
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func btnOpenMapEvent(_ sender: UIButton) {
        
        if sender.isSelected == true {
            sender.isSelected = false
            mapViewHide()

        } else{
            sender.isSelected = true
            mapViewShow()
            setupLatLong()
        }
        
        print("Tap Map Event")
        
    }
    
    @IBAction func btnSeeAllTodayOffersEvent(_ sender: UIButton) {
        
//        selectedCategoryType = CategoryType.promotions
//        performSegue(withIdentifier: "mainToDetail", sender: nil)
        
        if let viewController = ((self.tabBarController?.viewControllers?[1] as! UINavigationController).viewControllers[0]) as? DetailListViewController {
            
            print(viewController)
            viewController.categoryType = CategoryType.promotions
            //            viewController.Req_cat_ID = catID ?? 0
            //            viewController.Req_sub_Cat_ID = selectSubCat
            //            viewController.Req_title = selectSubCatTitle
            
            tabBarController?.selectedIndex = 1
            
        }
        
//        if user_is_Login == false {
//
//            helper.showAlertOKCancelAction(appName, "User is not Login", self, successClosure: { (login) in
//
//                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = testController
//
//            }) { (skip) in
//
//                mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//                mainTabbarObj.selectedIndex = 0
//
//            }
//
//            return
//        } else {
//
//            performSegue(withIdentifier: "mainToDetail", sender: nil)
//            selectedCategoryType = CategoryType.promotions
//
//        }
    }
    
    @IBAction func btnSelectLocationEvent(_ sender: UIButton) {
        
//        performSegue(withIdentifier: "segueToSelectLocation", sender: nil)
        
    }
    
    @IBAction func btnSeeAllEvent(_ sender: UIButton) {
        
        if let viewController = ((self.tabBarController?.viewControllers?[1] as! UINavigationController).viewControllers[0]) as? DetailListViewController {
            
            print(viewController)
            viewController.categoryType = CategoryType.promotions
            tabBarController?.selectedIndex = 1
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        print("scrollviewHight  :\(scrollView.frame.width)")
//        print("scrollviewHight  :\(scrollView.frame.height)")
        
//        if scrollView == collectionViewPromotions {
//
//        } else if scrollView == collectionViewEvents {
//
//        } else  {
//
//        }
    }
    
    
    
    
}
extension HomeVC : MKMapViewDelegate {   
    
    func setupLatLong() {
        print(allLocationArray)
        if allLocationArray.count != 0 {
            
            for location in allLocationArray {
                
                let locationDic = location as? NSDictionary ?? [:]
                let title = locationDic["title"] as? String ?? ""
                let latitude = locationDic["latitude"] as? String ?? ""
                let longitude = locationDic["longitude"] as? String ?? ""
                
                let serviceType = locationDic["locationType"] as? String ?? ""
                
                let annotation = CustomPointAnnotation()
                
                print("latitude : \(latitude)")
                print("longitude : \(longitude)")
                
                if serviceType == "Services" {
                    
                    annotation.title = title
                    annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 51.5074, longitude: Double(longitude) ?? 0.1278)
                    annotation.imageName = "business_map"
                    
                } else if serviceType == "promotions" {
                    
                    annotation.title = title
                    annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 51.5074, longitude: Double(longitude) ?? 0.1278)
                    annotation.imageName = "promo_map"
                    
                }
                
                if allLocationArray[0] as? NSDictionary ?? [:] == locationDic {
                    let coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 51.5074, longitude: Double(longitude) ?? 0.1278)
                    let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
                    mapViewKit.setRegion(viewRegion, animated: true)
                }

                mapViewKit.addAnnotation(annotation)
                
            }
        }
    }
    
    func animateToUserLocation() {
        
        if let annoation = mapViewKit.annotations.filter ({ $0 is MKUserLocation }).first {
            let coordinate = annoation.coordinate
            let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            mapViewKit.setRegion(viewRegion, animated: true)
        }
        
//        let a = CLLocationCoordinate2DMake(<#T##latitude: CLLocationDegrees##CLLocationDegrees#>, <#T##longitude: CLLocationDegrees##CLLocationDegrees#>)
    }
    
    
//    func mapViewAddAnnotationPromotions(PromotionsHome : PromotionsHomeModel) {
//
//        if PromotionsHome != nil || PromotionsHome.promotionsList.count != 0 {
//
//            for location in PromotionsHome.promotionsList {
//                let annotation = MKPointAnnotation()
//                //                let mKAnnotationView = MKAnnotationView()
//                annotation.title = location.title
//                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude) ?? 0.0, longitude: Double(location.longitude) ?? 0.0)
//                mapViewKit.addAnnotation(annotation)
//                //                mKAnnotationView.
//            }
//        }
//    }
    
//    func mapViewAddAnnotationServices(homeServicesList : HomeServicesList) {
//
//        if homeServicesList != nil || homeServicesList.servicesList.count != 0 {
//
//
//
//
//            for location in homeServicesList.servicesList {
//                let annotation = MKPointAnnotation()
//                annotation.title = location.title
//
//                if location.latitude == nil && location.latitude == nil {
//                    annotation.coordinate = CLLocationCoordinate2D(latitude: Double(51.5074), longitude: Double(0.1278))
//                }else {
//                    annotation.coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude as? String ?? "0.0") ?? 0.0, longitude: Double(location.longitude as? String ?? "0.0") ?? 0.0)
//                }
//
//
//                //                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude) ?? 0.0, longitude: Double(location.longitude) ?? 0.0)
//                mapViewKit.addAnnotation(annotation)
//
//            }
//        }
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        print("delegate called")
        
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "AnnotationIdentifier"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
        }
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        let cpa = annotation as! CustomPointAnnotation
        anView?.image = UIImage(named:cpa.imageName)
        
        return anView

        
//        guard !(annotation is MKUserLocation) else {
//            return nil
//        }
//
//        // Better to make this class property
//        let annotationIdentifier = "AnnotationIdentifier"
//
//        var annotationView: MKAnnotationView?
//        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
//            annotationView = dequeuedAnnotationView
//            annotationView?.annotation = annotation
//        }
//        else {
//            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            annotationView = av
//        }
//
//        if let annotationView = annotationView {
//            // Configure your annotation view here
//            annotationView.canShowCallout = true
//            annotationView.image = UIImage(named: "business_map")
//        }
//
//        return annotationView
//
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        print(view.annotation?.debugDescription as Any)
        
        // refress to center position map
        mapView.setCenter(CLLocationCoordinate2D(latitude: view.annotation?.coordinate.latitude ?? 0.0, longitude: view.annotation?.coordinate.longitude ?? 0.0), animated: true)
        
        // get select let long
        let latitude = view.annotation?.coordinate.latitude ?? 0.0
        let longitude = view.annotation?.coordinate.longitude ?? 0.0
        
        print("Select coordinate : \(latitude, longitude)")
        
        var isTypeLocationArray = allLocationArray.filter {((($0 as! NSDictionary)["latitude"] as! String) == "\(latitude)") && (($0 as! NSDictionary)["longitude"] as! String) == "\(longitude)"}
        
        print(isTypeLocationArray)
        
        if isTypeLocationArray.count == 0 {
            return
        }
        
        if isTypeLocationArray[0] != nil {
            let locationType = (isTypeLocationArray[0] as! NSDictionary)["locationType"] as? String ?? ""
            
            if locationType == "Services" {
                
                if servicesListData != nil || self.servicesListData.servicesList.count != 0 {
                    
                    let promotionsListAll = servicesListData.servicesList
                    
                    let filteredLocation = promotionsListAll.filter { promotionsListAll in
                        return ((promotionsListAll.latitude as! NSString).doubleValue == latitude && (promotionsListAll.longitude as! NSString).doubleValue == longitude)
                    }
                    
//                    if filteredLocation[]
                    //
                    print("Search Found Data All: \(filteredLocation)")
                    print("Search Found Data First Array : \(filteredLocation)")
                    
                    if filteredLocation[0] != nil && filteredLocation.count != 0 {
                        
                        self.viewLocationSelect.isHidden = false
                        
                        let url = URL(string: filteredLocation[0].image ?? "")
                        imageLocation.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                        }
                        
                        lbltitleName.text = filteredLocation[0].title
                        lblLocationName.text = filteredLocation[0].location
                        //                lblitemStatusDays.text = selectData["title"] as? String ?? ""
                        lblreviews.text = "\(filteredLocation[0].views ?? 0)"
                        viewRating.value = CGFloat(filteredLocation[0].rating ?? 0.0)
                        
                        if (filteredLocation[0].createdDatetime)?.count != 0  {
                            
                            //2019-08-13T05:50:14.937
                            let createdDate = filteredLocation[0].createdDatetime
                            let isoDate = helper.StringDateToDate(dateString: createdDate ?? "", dateFormatte: "yyyy-MM-dd'T'HH:mm:ss.SSS")
                            //                    let isoDate = he//"2016-04-14T10:44:00"
                            print(isoDate)
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                            let date = dateFormatter.date(from:createdDate!)!
                            //                    let a = dateFormatter.date(from: createdDate)
                            
                            let calendar = Calendar.current
                            
                            // Replace the hour (time) of both dates with 00:00
                            let date1 = calendar.startOfDay(for: date)
                            let date2 = calendar.startOfDay(for: Date())
                            
                            let components = calendar.dateComponents([.day], from: date1, to: date2)
                            
                            if let days = components.day{
                                
                                lblitemStatusDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
                                
                                //Setting date in integer format
                                //                        presenterDetailList.eventsModel.EventsList[indexPath.row].createdDate = days
                            }
                        }
                        
                        selectedBusinessIDTodayOffers = filteredLocation[0].serviceID
                        selectedCategoryType = CategoryType.business
                        
                    }
                }
                
                
                
            } else if locationType == "promotions" {
                
                
                if promotionsData != nil || promotionsData.promotionsList.count != 0 {
                    
                    let promotionsListAll = promotionsData.promotionsList
                    
                    let filteredLocation = promotionsListAll.filter { promotionsListAll in
                        return ((promotionsListAll.latitude! as NSString).doubleValue == latitude && (promotionsListAll.longitude! as NSString).doubleValue == longitude)
                    }
                    //
                    print("Search Found Data All: \(filteredLocation)")
                    print("Search Found Data First Array : \(filteredLocation[0])")
                    
                    if filteredLocation[0] != nil && filteredLocation.count != 0 {
                        
                        self.viewLocationSelect.isHidden = false
                        
                        let url = URL(string: filteredLocation[0].image ?? "")
                        imageLocation.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                        }
                        
                        lbltitleName.text = filteredLocation[0].title
                        lblLocationName.text = filteredLocation[0].location ?? "Visakhapatnam"
                        //                lblitemStatusDays.text = selectData["title"] as? String ?? ""
//                        lblreviews.text = "\(filteredLocation[0].views ?? 0)"
                        let locationViews = (filteredLocation[0].views ?? 0)
                        let views = locationViews == 1 ||  locationViews == 0  ? "\(locationViews) view" : "\(locationViews) views"
                        lblreviews.text = views

                        viewRating.value = CGFloat(filteredLocation[0].rating ?? 0.0)
                        
                        
                        if (filteredLocation[0].createdDatetime)?.count != 0  {
                            
                            //2019-08-13T05:50:14.937
                            let createdDate = filteredLocation[0].createdDatetime
                            let isoDate = helper.StringDateToDate(dateString: createdDate ?? "\(Date())", dateFormatte: "yyyy-MM-dd'T'HH:mm:ss.SSS")
                            //                    let isoDate = he//"2016-04-14T10:44:00"
                            print(isoDate)
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                            let date = dateFormatter.date(from:createdDate ?? "\(Date())")!
                            //                    let a = dateFormatter.date(from: createdDate)
                            
                            let calendar = Calendar.current
                            
                            // Replace the hour (time) of both dates with 00:00
                            let date1 = calendar.startOfDay(for: date)
                            let date2 = calendar.startOfDay(for: Date())
                            
                            let components = calendar.dateComponents([.day], from: date1, to: date2)
                            
                            if let days = components.day{
                                
                                lblitemStatusDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"

                                //Setting date in integer format
                                //                        presenterDetailList.eventsModel.EventsList[indexPath.row].createdDate = days
                            }
                        }
                        
                        selectedBusinessIDTodayOffers = filteredLocation[0].proID
                        selectedCategoryType = CategoryType.promotions
                        
                    }
                }
                
                
            }
            
            
        }
        
//        if
        
//            return (Double((allLocationArray as! NSMutableArray)["latitude"] as? String ?? "0.0") == latitude && Double(allLocationArray["longitude"] as? String ?? "0.0") == longitude)
//        }

    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: view.annotation?.coordinate.latitude ?? 0.0, longitude: view.annotation?.coordinate.longitude ?? 0.0), animated: true)
        
        // get select let long
        let latitude = view.annotation?.coordinate.latitude ?? 0.0
        let longitude = view.annotation?.coordinate.latitude ?? 0.0
        
        print("Select coordinate : \(latitude, longitude)")
        
//        if promotionsData != nil || promotionsData.promotionsList.count != 0 {
//
//            let promotionsListAll = promotionsData.promotionsList
//
//            let filteredLocation = promotionsListAll.filter { promotionsListAll in
//                return (Double(promotionsListAll.latitude) == latitude && Double(promotionsListAll.latitude) == longitude)
//            }
//
//            print("Search Found Data All: \(filteredLocation)")
//            print("Search Found Data First Array : \(filteredLocation[0])")
//
//            if filteredLocation[0] != nil && filteredLocation.count != 0 {
//
//                self.viewLocationSelect.isHidden = false
//
//                let url = URL(string: filteredLocation[0].image)
//                imageLocation.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
//                }
//
//                lbltitleName.text = filteredLocation[0].title
//                lblLocationName.text = filteredLocation[0].location.rawValue
//                //                lblitemStatusDays.text = selectData["title"] as? String ?? ""
//                lblreviews.text = "\(filteredLocation[0].views)"
//                viewRating.value = CGFloat(filteredLocation[0].rating)
//
//
//                if (filteredLocation[0].createdDatetime).count != 0  {
//
//                    //2019-08-13T05:50:14.937
//                    let createdDate = filteredLocation[0].createdDatetime
//                    let isoDate = helper.StringDateToDate(dateString: createdDate, dateFormatte: "yyyy-MM-dd'T'HH:mm:ss.SSS")
//                    //                    let isoDate = he//"2016-04-14T10:44:00"
//                    print(isoDate)
//
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
//                    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//                    let date = dateFormatter.date(from:createdDate)!
//                    //                    let a = dateFormatter.date(from: createdDate)
//
//                    let calendar = Calendar.current
//
//                    // Replace the hour (time) of both dates with 00:00
//                    let date1 = calendar.startOfDay(for: date)
//                    let date2 = calendar.startOfDay(for: Date())
//
//                    let components = calendar.dateComponents([.day], from: date1, to: date2)
//
//                    if let days = components.day{
//
//        lblitemStatusDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
//
//                        //Setting date in integer format
//                        //                        presenterDetailList.eventsModel.EventsList[indexPath.row].createdDate = days
//                    }
//                }
//
//                selectedBusinessIDTodayOffers = filteredLocation[0].proID
//                selectedCategoryType = CategoryType.promotions
//
//            }
//        }
    }
}


class CollectionViewSliderCell: UICollectionViewCell {
    @IBOutlet weak var imageViewLinkSlider: UIImageView!
}

class CollectionViewItemCell: UICollectionViewCell {
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var viewRightLine: UIView!
    @IBOutlet weak var viewBottomLine: UIView!
}

class CollectionViewSlider2Cell: UICollectionViewCell {
    @IBOutlet weak var imageViewLinkSlider: UIImageView!
    @IBOutlet weak var lblTitleName: UILabel!
    
}


class CollectionViewEventsHomeCell: UICollectionViewCell {
    @IBOutlet weak var imageViewLinkSlider: UIImageView!
    @IBOutlet weak var lblTitleName: UILabel!
    
}



extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SFSafariViewControllerDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewSliderTop {
            if homeAllData == nil {
//                collectionTopSliderConstant.constant = 0
                // //viewNoDataFound.isHidden = false
                return 0
            } else if homeAllData.sliderimages.count == 0 {
//                collectionTopSliderConstant.constant = 0
                //viewNoDataFound.isHidden = false
                return 0
            }
            else {
                viewNoDataFound.isHidden = true
//                collectionTopSliderConstant.constant = 176
//                return homeAllData.sliderimages.count

                return homeAllData.sliderimages.count > 0 ? homeAllData.sliderimages.count : 0
            }
        }  else if collectionView == collectionViewPromotions {
            if In_Online_Offers == nil {
                //                //viewNoDataFound.isHidden = false
                return 0
                
            } else if In_Online_Offers.count == 0 {
                
            }
            else {
                viewNoDataFound.isHidden = true
                return promotionsData.promotionsList.count > 0 ? promotionsData.promotionsList.count : 0
            }
        } else if collectionView == collectionViewEvents {
            if In_Store_Offers == nil{
                viewInStoreOffersHight.constant = 0
                viewInstoreOffers.isHidden = true
                //                //viewNoDataFound.isHidden = false
                return 0
                
            } else if In_Store_Offers.count == 0{
                viewInStoreOffersHight.constant = 0
                viewInstoreOffers.isHidden = true

                return 0
            }
            else{
                viewInstoreOffers.isHidden = false
                viewInStoreOffersHight.constant = 176
                return In_Store_Offers.count > 0 ? In_Store_Offers.count : 0
            }
        } else {
            if categoriesData == nil {
//                viewNoDataFound.isHidden = false
                return 0
            } else if categoriesData.categoriesDetails.count == 0 {
                viewNoDataFound.isHidden = false
                return 0
            }
            else {
                if categoriesData.categoriesDetails.count >= 6{
                    return 6
                } else{
                    return categoriesData.categoriesDetails.count
                }
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionViewSliderTop {
            
            collectionTopSliderConstant.constant = 176
            
            let sliderImage_model = homeAllData.sliderimages[indexPath.row]
            let image_url = (sliderImage_model.image)
            
//            print("top slider images : \(image_url)")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewSliderCell", for: indexPath) as! CollectionViewSliderCell
            
            let url = URL(string: image_url)
            cell.imageViewLinkSlider.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
            }
            
//            if image_url != "" {
//                let url = URL(string: image_url ?? "" )
//                cell.imageViewLinkSlider.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
//                }
//            }
            
//            if image_url == nil {
//                cell.imageViewLinkSlider.image = UIImage(named :"default_big")
//            }
            
            return cell
            
        } else if collectionView == collectionViewPromotions {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewSlider2Cell", for: indexPath) as! CollectionViewSlider2Cell
            
            let sliderImage_model = In_Online_Offers[indexPath.row]
            let image_url = sliderImage_model.image
            let name = sliderImage_model.title
//            if let image_url_ = image_url{
            let url = URL(string: image_url ?? "")
            cell.imageViewLinkSlider.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
            }
            cell.lblTitleName.text = name
            
            return cell
            
        } else if collectionView == collectionViewEvents {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewEventsHomeCell", for: indexPath) as! CollectionViewEventsHomeCell
            
            let sliderImage_model = In_Store_Offers[indexPath.row]
            
            let name = sliderImage_model.title
            cell.lblTitleName.text = name

            let image_url = sliderImage_model.image
            let url = URL(string: image_url ?? "")
            cell.imageViewLinkSlider.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
            }
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewItemCell", for: indexPath) as! CollectionViewItemCell
            
            let categorieModel = categoriesData.categoriesDetails[indexPath.row]
            let image_url = categorieModel.catIcon

            let url = URL(string: image_url ?? "")
            print("image Url Fix Cell : .......... \(url) ")
//            cell.imgItem.kf.setImage(with: url)
//            cell.imgItem.kf.setimage
//            cell.imgItem.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil, completionHandler: { imageResult, error, type, cache in
//                cell.imgItem.image = Imagee
//            })
            
            cell.imgItem.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
            }
            
//            cell.imgItem.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)

//            if url == nil {
//                cell.imgItem.image = UIImage(named :"default_big")
//            }

            cell.lblItemName.text = categorieModel.categoryName
            
            if indexPath.row == 2 || indexPath.row == 5 {
                cell.viewRightLine.isHidden = true
            }
            if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 {
                cell.viewBottomLine.isHidden = true
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewServices {
            if categoriesData != nil {
                if categoriesData.categoriesDetails.count != nil {
                    if categoriesData.categoriesDetails.count >= 6 {
                        
                        viewServiceMianHightCon.constant = 245
                        return CGSize(width: (collectionView.frame.size.width) / 3, height: (collectionView.frame.size.height) / 2)
                        
                    } else {
                        
                        viewServiceMianHightCon.constant = 130
                        return CGSize(width: (collectionView.frame.size.width) / 3, height: 100 )
                    }
                    
                } else {
                    
                    viewServiceMianHightCon.constant = 0
                    return CGSize(width: (collectionView.frame.size.width) / 3, height: (collectionView.frame.size.height) / 2)
                    //
                }
                
            } else {
                
                viewServiceMianHightCon.constant = 0
                 return CGSize(width: (collectionView.frame.size.width) / 3, height: (collectionView.frame.size.height) / 2)
            }
            
        } else if collectionView == collectionViewPromotions {
            return CGSize(width: collectionView.frame.size.width / 1.4 , height: 176)
        } else if collectionView == collectionViewEvents {
            return CGSize(width: collectionView.frame.size.width / 1.4, height: 176)
        } else {
            // collection view slider top
            if homeAllData != nil {
                if homeAllData.sliderimages.count > 0 {
                    collectionViewSliderTop.reloadData()
                    return CGSize(width: collectionView.frame.size.width, height: 176)
                } else {
                    return CGSize.zero //CGSize(width: collectionView.frame.size.width, height: 0)
                }
            } else {
                return CGSize.zero //CGSize(width: collectionView.frame.size.width, height: 0)
            }
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        if user_is_Login == false {
//
//            helper.showAlertOKCancelAction(appName, "User is not Login", self, successClosure: { (login) in
//
//                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = testController
//
//            }) { (skip) in
//
//                mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//                mainTabbarObj.selectedIndex = 0
//
//            }
//
//            return
//        } else{
        
            if collectionView == self.collectionViewSliderTop {
                
                if homeAllData == nil {
                    return
                }
                let sliderImage_model = homeAllData.sliderimages[indexPath.row]
                let redirection_url = (sliderImage_model.url ?? "https://www.veenas.com/")
                //            let removeLastExtraPoint = redirection_url.removeLast()
                print("Select Image : \(redirection_url)")
                
                if let url_to_redirect = URL(string: redirection_url){
                    
                    let dic:NSDictionary = [ "title": "Yellow APP",
                                             "apiUrl" : "\(url_to_redirect)",
                                             "istype" : ""]

                        
                    performSegue(withIdentifier: "seguetoWeb", sender: dic)
                    
                    //                if UIApplication.shared.canOpenURL( url_to_redirect) {
                    //
                    //                    let safariViewController = SFSafariViewController(url: URL(string: redirection_url!)!)
                    //                    safariViewController.delegate = self
                    //                    self.navigationController?.present(safariViewController, animated: true, completion: nil)
                    //
                    //                }
                    //                else{
                    //                    AppManager.shared.showOkAlert(title: "Alert", message: "Unable to open the link. Please try again.", onCompletion: {(callBack: String) in })
                    //                }
                    
                }
                else{
                    AppManager.shared.showOkAlert(title: "Alert", message: "Unable to open the link. Please try again.", view: self, onCompletion: {(callBack: String) in })
                }
            }
                
            else if collectionView == self.collectionViewPromotions {
                
                if promotionsData == nil {
                    return
                }
                
                let sliderImage_model = In_Online_Offers[indexPath.row]
                
                print(sliderImage_model)
                
                selectedBusinessIDTodayOffers = sliderImage_model.proID
                selectedCategoryType = CategoryType.promotions
                
                performSegue(withIdentifier: "detailsToDescription", sender: nil)
                
            }
                
                
            else if collectionView == self.collectionViewEvents {
                
                if In_Store_Offers == nil {
                    return
                }
                
                let sliderImage_model = In_Store_Offers[indexPath.row]
                
                print(sliderImage_model)
                
                selectedBusinessIDTodayOffers = sliderImage_model.proID
                selectedCategoryType = CategoryType.promotions
                
                performSegue(withIdentifier: "detailsToDescription", sender: nil)
                
            }
                
            else {
                
                if categoriesData == nil {
                    return
                }
                
                let categorieModel = categoriesData.categoriesDetails[indexPath.row]
                print(categorieModel)
                
                // Commented by Ajay
//                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ServiceSubCategoryVC") as? ServiceSubCategoryVC {
//                    vc.catID = categorieModel.categoryID
//                    vc.titleHeder = categorieModel.categoryName
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
                
                self.performSegue(withIdentifier: "mainToSubCat", sender: categorieModel)
                
                
                
                
                //
                print("Redirect to module")
                
                //
                //
                
            }
//        }
        
    }
    
    /**
     Invokes Timer to start Automatic Animation with repeat enabled
     */
    func startTimer() {
        _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true);
    }
    
    @objc func scrollToNextCell() {
        
        if homeAllData != nil {
            if homeAllData.sliderimages.count > 0 {
                if let coll = collectionViewSliderTop {
                    for cell in coll.visibleCells {
                        let indexPath: IndexPath? = coll.indexPath(for: cell)
                        if ((indexPath?.row)! < homeAllData.sliderimages.count - 1){
                            let indexPath1: IndexPath?
                            indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                            
                            coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                        }
                        else{
                            let indexPath1: IndexPath?
                            indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                            coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if segue.identifier == "detailsToDescription" {
                let viewController:DetailDescriptionViewController = segue.destination as! DetailDescriptionViewController
                viewController.selectedServiceID = selectedBusinessIDTodayOffers
                viewController.categoryType = selectedCategoryType
            }
        
             if segue.identifier == "seguetoWeb" {
                let vc = segue.destination as! WebVC
                vc.dicdata = sender as? NSDictionary ?? [:]
            }
        
        if segue.identifier == "mainToDetail" {
            if let viewController:DetailListViewController = segue.destination as? DetailListViewController {
                 viewController.categoryType = selectedCategoryType
            } else {
                return
            }
            
//            viewController.categoryType = CategoryType.promotions
           

        }
        if segue.identifier == "mainToSubCat" {
            let viewController:ServiceSubCategoryVC = segue.destination as! ServiceSubCategoryVC
            viewController.catID = (sender as? CategoriesDetail)?.categoryID
            viewController.titleHeder = (sender as? CategoriesDetail)?.categoryName
            viewController.image = (sender as? CategoriesDetail)?.catIcon
        }
        
        if segue.identifier == "segueToSelectLocation" {
            let viewController:HomeLocationViewController = segue.destination as! HomeLocationViewController
            viewController.HomeViewController = self
        }
        
        if segue.identifier == "segueToFavouriteList" {
            let viewController:FavouriteViewController = segue.destination as! FavouriteViewController
//            viewController.HomeViewController = self
            
        }
        
        

        
//            let viewController:DetailListViewController = segue.destination as! DetailListViewController
//            viewController.categoryType = selectedCategoryType
        
//        }
    }
}

extension HomeVC: UIGestureRecognizerDelegate {
    
    func revealController(_ revealController: SWRevealViewController!, animateTo position: FrontViewPosition)
    {
        if position == FrontViewPosition.right {
            
            if self.view.viewWithTag(9966) == nil {
                let coverView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
                coverView.tag = 9966
                coverView.backgroundColor = UIColor.black
                coverView.alpha = 0.0;
                UIView.animate(withDuration: 0.3, animations: {
                    coverView.alpha = 0.7;
                })
                self.view.addSubview(coverView)
            }
        }
        else{
            
            let coverView = self.view.viewWithTag(9966)
            UIView.animate(withDuration: 0.3, animations: {
                coverView?.alpha = 0.0;
            }, completion: { (true) in
                coverView?.removeFromSuperview()
            })
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}


extension UIColor {
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
