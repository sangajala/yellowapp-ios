//
//  HomeLocationViewController.swift
//  YELLOW APP
//
//  Created by Apple on 04/11/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class HomeLocationViewController : UIViewController, UITextFieldDelegate {
    
    var cv = SWRevealViewController()
    
    var HomeViewController: HomeVC!

    //    var mainArraycommunitySelect = NSArray()
    //    var mainArrayLocationSelect = NSArray()

    // Search text
//    @IBOutlet weak var txtSearch: UITextField!
    var SerachArray = NSArray()
    var mainArray : CommunitySelectModel!


    //MARK: - Properties
    var presenterLocationSelect: LocationSelectPresenterImplementation!
    var viewOverlay: UIView!
    var activityIndicator: UIActivityIndicatorView!

//    @IBOutlet var labelSelectTitle: UILabel!
    @IBOutlet var tableViewLocation: UITableView!
//    @IBOutlet var buttonSubmit: UIButton!

    lazy private var locationsData = [
        ["Title": "East London", "icon_name": "location_east_london", "isComingSoon": false],
        ["Title": "West London", "icon_name": "location_west_london", "isComingSoon": false],
        ["Title": "Birmingham", "icon_name": "location_birmingham", "isComingSoon": true]
    ]

    private var selectedIndex = 0

    private var locationSelectModel: LocationSelectModel!
    private var communitySelectModel: CommunitySelectModel!

//    var locationSelectModelMain : LocationSelectModel!
//    var communitySelectModelMain : CommunitySelectModel!

    let refreshControl = UIRefreshControl()

    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

        // Do any additional setup after loading the view.
//        setShadowsForViews()
//        createPresenterInstanceAndGetLocations()
        
        configureTitle()
//        txtSearch.returnKeyType = .done

//        txtSearch.addTarget(self, action: #selector(searchWorkersAsPerText), for: .allEvents)
//
//        if #available(iOS 10.0, *) {
//            tableViewLocation.refreshControl = refreshControl
//        } else {
//            tableViewLocation.addSubview(refreshControl)
//        }
//
//        refreshControl.addTarget(self, action: #selector(refresData(_:)), for: .allEvents)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        locationSelectModel = locationSelectModelMain
        communitySelectModel = communitySelectModelMain

        tableViewLocation.reloadData()

    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
       dismissVC()
    }
    
    func dismissVC(){
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
//    @objc func refresData(_ sender: Any) {
//        // Fetch Weather Data
//
//        refreshControl.endRefreshing()
//
//        createPresenterInstanceAndGetLocations()
//    }

    override func viewWillAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.2, animations: {
            mainTabbarObj?.tabBar.isHidden = true
            mainTabbarObj.tabBar.backgroundColor = UIColor.clear
        }) { (true) in

        }

        if mainTabbarObj?.view.viewWithTag(8888) != nil{
            let button = mainTabbarObj?.view.viewWithTag(8888)
            button?.isHidden = true
            button?.isUserInteractionEnabled = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.2, animations: {
            mainTabbarObj?.tabBar.isHidden = false
            mainTabbarObj.tabBar.backgroundColor = UIColor.white

        }) { (true) in

        }

        if mainTabbarObj?.view.viewWithTag(8888) != nil{
            let button = mainTabbarObj?.view.viewWithTag(8888)
            button?.isHidden = false
            button?.isUserInteractionEnabled = true
        }
    }



    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    // search text field

//    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
//
//        if communitySelectModelMain == nil || communitySelectModelMain.CommUsers.count == 0 {
//            return
//        }
//
//        //        print(SerachArray)
//
//        if txtSearch.text?.count ?? 0 > 0 {
//            if isLocationBased == 0 {
//
//                //                print(communitySelectModel.CommUsers)
//
//                if txtSearch.text?.count ?? 0 > 0 {
//
//                    let CommunityNames = communitySelectModelMain.CommUsers.filter({$0.CommunityName!.uppercased().contains((txtSearch.text ?? "").uppercased())})
//                    print("serach Array : \(CommunityNames)")
//                    self.communitySelectModel.CommUsers = CommunityNames
//                    tableViewLocation.reloadData()
//
//                } else {
//
//                    communitySelectModel.CommUsers = communitySelectModelMain.CommUsers
//                    tableViewLocation.reloadData()
//
//                    //                    let CommunityNames = communitySelectModelMain.CommUsers.filter({$0.CommunityName!.uppercased().contains((txtSearch.text ?? "").uppercased())})
//                    //                    print("serach Array : \(CommunityNames)")
//                    //                    self.communitySelectModel.CommUsers = CommunityNames
//                    //                    tableViewLocation.reloadData()
//
//                }
//
//            } else {
//
//                if txtSearch.text?.count ?? 0 > 0 {
//
//                    let LocationName = locationSelectModelMain.Locations.filter({$0.Location!.uppercased().contains((txtSearch.text ?? "").uppercased())})
//                    print("serach Array : \(LocationName)")
//                    self.locationSelectModel.Locations = LocationName
//                    tableViewLocation.reloadData()
//
//                } else {
//
//                    locationSelectModel.Locations = locationSelectModelMain.Locations
//                    tableViewLocation.reloadData()
//                }
//
//
//            }
//
//        } else {
//
//            communitySelectModel.CommUsers = communitySelectModelMain.CommUsers
//            tableViewLocation.reloadData()
//
//            //            createPresenterInstanceAndGetLocations()
//        }
//    }

    //MARK: - Button Events
//    @IBAction func submitEvent(_ sender: Any) {
//
//        AppManager.shared.printLog(stringToPrint: "Submit event")
//
//        if isLocationBased == 0{
//
//            let user_selected_values = communitySelectModel.CommUsers[selectedIndex]
//
//            //Storing the current selected location for further use in home screen. Need to cache this selected location to user it every time the application launches.
//            if let community_id = user_selected_values.Id{
//
//                UserDefaults.standard.setValue(community_id, forKey: key_location_id)
//                UserDefaults.standard.synchronize()
//
//                UserDefaults.standard.setValue(user_selected_values.CommunityName, forKey: key_location_name)
//                UserDefaults.standard.synchronize()
//
//                AppManager.shared.communitySelectedModel_shared = CommunityUsers()
//                AppManager.shared.communitySelectedModel_shared.Heroimage = user_selected_values.Heroimage
//                AppManager.shared.communitySelectedModel_shared.Id = user_selected_values.Id
//                AppManager.shared.communitySelectedModel_shared.Logo = user_selected_values.Logo
//                AppManager.shared.communitySelectedModel_shared.CommunityName = user_selected_values.CommunityName
//
//            }
//        }
//        else{
//
//            let user_selected_values = locationSelectModel.Locations[selectedIndex]
//
//            //Storing the current selected location for further use in home screen. Need to cache this selected location to user it every time the application launches.
//            if let location_id = user_selected_values.Location_ID{
//
//                UserDefaults.standard.setValue(location_id, forKey: key_location_id)
//                UserDefaults.standard.synchronize()
//
//                UserDefaults.standard.setValue(user_selected_values.Location, forKey: key_location_name)
//                UserDefaults.standard.synchronize()
//
//                AppManager.shared.locationSelectedModel_shared = Locations()
//                AppManager.shared.locationSelectedModel_shared.Image = user_selected_values.Image
//                AppManager.shared.locationSelectedModel_shared.Location_ID = user_selected_values.Location_ID
//                AppManager.shared.locationSelectedModel_shared.Location = user_selected_values.Location
//                AppManager.shared.locationSelectedModel_shared.Latitude = user_selected_values.Latitude
//                AppManager.shared.locationSelectedModel_shared.Longitude = user_selected_values.Longitude
//
//            }
//        }
//
//        AppManager.shared.redirectToHomeScreen()
//    }

    //MARK: - Other Methods
    func setShadowsForViews() {
//        buttonSubmit.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
    }

    func createPresenterInstanceAndGetLocations(){
        
//        presenterLocationSelect = HomeLocationSelectPresenterImplementation(viewController: HomeLocationViewController)

//        presenterLocationSelect = HomeLocationSelectPresenterImplementation(viewController: self)

        //Fetching locations based on App Version
        if isLocationBased == 0 {
            presenterLocationSelect.getCommunityUsers()
        }
        else {
            presenterLocationSelect.getLocationsFromServer()
        }

        //        isLocationBased == 0 ? presenterLocationSelect.getCommunityUsers() : presenterLocationSelect.getLocationsFromServer()

    }

    func configureTitle(){
       // labelSelectTitle.text = isLocationBased == 0 ? "Select your location" : "Select your location"
    }

    //MARK: - ViewController
//    func addActivityIndicatorView(){
//
//        viewOverlay = nil
//
//        viewOverlay = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//        viewOverlay.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
//        view.addSubview(viewOverlay)
//
//        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
//        activityIndicator.center = viewOverlay.center
//        viewOverlay.addSubview(activityIndicator)
//
//        activityIndicator.startAnimating()
//    }
//
//    func removeActivityIndicator(){
//        activityIndicator.stopAnimating()
//        viewOverlay.removeFromSuperview()
//    }

//    @IBAction func btnCurrentLocationEvent(_ sender: UIButton) {
//
//        selectedIndex = 0
//        GotoHomePage()
//        tableViewLocation.reloadData()
//
//    }


//    @IBAction func btnDontBelong(_ sender: UIButton) {
//
//        selectedIndex = 0
//        GotoHomePage()
//
//    }

//    @IBAction func btnBack(_ sender: UIButton) {
//
//        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
//
//    }
}

extension HomeLocationViewController : SWRevealViewControllerDelegate, UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

}

extension HomeLocationViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if isLocationBased == 0{
            if communitySelectModel == nil{
                return 0
            }
            else{
                return communitySelectModel.CommUsers.count > 0 ? communitySelectModel.CommUsers.count : 0
            }
        }
        else
        {
            if locationSelectModel == nil{
                return 0
            }
            else{
                return locationSelectModel.Locations.count > 0 ? locationSelectModel.Locations.count : 0
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLocationBased == 0 {

            let community = communitySelectModel.CommUsers[indexPath.row]
            let community_name = community.CommunityName

            let locationCell = tableView.dequeueReusableCell(withIdentifier: "LocationSelectTableViewCellID") as! HomeLocationSelectTableViewCell
            locationCell.labelTitle.text = community_name

            if UserDefaults.standard.value(forKey: key_location_name) != nil{
                if let CommunityName = UserDefaults.standard.object(forKey: key_location_name) as? String {
                    if CommunityName.uppercased() == community_name?.uppercased() {
                        locationCell.labelTitle.textColor = UIColor.init(named: "ButtonColor")
                    }
                }
            }
            return locationCell
        }
            
        else {
            
            let locations = locationSelectModel.Locations[indexPath.row]
            let location_name = locations.Location
            let locationCell = tableView.dequeueReusableCell(withIdentifier: "LocationSelectTableViewCellID") as! HomeLocationSelectTableViewCell
            locationCell.labelTitle.text = location_name
            return locationCell
            
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        view.endEditing(true)
//        txtSearch.resignFirstResponder()
        selectedIndex = indexPath.row
        GotoHomePage()
        tableView.reloadData()

    }

    func GotoHomePage() {

        AppManager.shared.printLog(stringToPrint: "Submit event")

        if isLocationBased == 0{

            if communitySelectModel == nil {
                return
            }

            if communitySelectModel.CommUsers.count == 0 {
                return
            }

            let user_selected_values = communitySelectModel.CommUsers[selectedIndex]

            if let community_id = user_selected_values.Id {

                UserDefaults.standard.setValue(community_id, forKey: key_location_id)
                UserDefaults.standard.synchronize()
                UserDefaults.standard.setValue(user_selected_values.CommunityName, forKey: key_location_name)
                UserDefaults.standard.synchronize()

                AppManager.shared.communitySelectedModel_shared = CommunityUsers()
                AppManager.shared.communitySelectedModel_shared.Heroimage = user_selected_values.Heroimage
                AppManager.shared.communitySelectedModel_shared.Id = user_selected_values.Id
                AppManager.shared.communitySelectedModel_shared.Logo = user_selected_values.Logo
                AppManager.shared.communitySelectedModel_shared.CommunityName = user_selected_values.CommunityName

            }
        }
        else{

            if locationSelectModel.Locations.count == 0 {
                return
            }

            let user_selected_values = locationSelectModel.Locations[selectedIndex]

            //Storing the current selected location for further use in home screen. Need to cache this selected location to user it every time the application launches.
            
            if let location_id = user_selected_values.Location_ID{

                UserDefaults.standard.setValue(location_id, forKey: key_location_id)
                UserDefaults.standard.synchronize()

                UserDefaults.standard.setValue(user_selected_values.Location, forKey: key_location_name)
                UserDefaults.standard.synchronize()

                AppManager.shared.locationSelectedModel_shared = Locations()
                AppManager.shared.locationSelectedModel_shared.Image = user_selected_values.Image
                AppManager.shared.locationSelectedModel_shared.Location_ID = user_selected_values.Location_ID
                AppManager.shared.locationSelectedModel_shared.Location = user_selected_values.Location
                AppManager.shared.locationSelectedModel_shared.Latitude = user_selected_values.Latitude
                AppManager.shared.locationSelectedModel_shared.Longitude = user_selected_values.Longitude
            }
        }

//        if (UserDefaults.standard.object(forKey: key_user_id) != nil){
//            let user_id = UserDefaults.standard.value(forKey: key_user_id) as! Int
//            print(user_id)
//            if user_id != 0 {
//                user_is_Login = true
//            } else{
//                user_is_Login = false
//            }
//        }
        
        dismissVC()
        HomeViewController?.viewDataSetup()
        

//        if UserDefaults.standard.value(forKey: key_is_present_to_login) != nil {
//            if let islogin = UserDefaults.standard.value(forKey: key_is_present_to_login) as? Bool {
//                if islogin == true {
//
//                    UserDefaults.standard.set(false, forKey: key_is_present_to_login)
//                    self.dismiss(animated: true, completion: nil)
//
//                } else{
//
//                    UserDefaults.standard.set(false, forKey: key_is_present_to_login)
//                    AppManager.shared.redirectToHomeScreen()
//                }
//            }
//
//        } else {
//
//            AppManager.shared.redirectToHomeScreen()
//        }

    }
}

//extension HomeLocationViewController : LocationSelectViewProtocol{
//
//    func communitySelectResponse(communitySelectModel: CommunitySelectModel) {
//
//        guard let isSuccess = communitySelectModel.Message.isSuccess, let _ = communitySelectModel.Message.Message else {
//            AppManager.shared.showOkAlert(title: "Alert", message: "Failed to fetch available locations.", view: self, onCompletion: { (callBack: String) in })
//            return
//        }
//
//        if isSuccess{
//
//            self.communitySelectModel = communitySelectModel
//            self.communitySelectModelMain = communitySelectModel
//
//            //  SerachArray = communitySelectModel
//            //            mainArray = (communitySelectModel)
//
//            //            print(SerachArray)
//            //            print(mainArray)
//            //
//            DispatchQueue.main.async {
//                self.tableViewLocation.reloadData()
//            }
//        }
//    }
//
//    func locationSelectResponse(locationSelectModel: LocationSelectModel) {
//
//        guard let isSuccess = locationSelectModel.Message.isSuccess, let _ = locationSelectModel.Message.Message else {
//            AppManager.shared.showOkAlert(title: "Alert", message: "Failed to fetch available locations.", view: self, onCompletion: { (callBack: String) in })
//            return
//        }
//
//        if isSuccess{
//
//            self.locationSelectModel = locationSelectModel
//            self.locationSelectModelMain = locationSelectModel
//
//            //            SerachArray = locationSelectModel.Locations as NSArray
//            //            mainArray = locationSelectModel.Locations as NSArray
//
//            //            print(SerachArray)
//            //            print(mainArray)
//
//
//            //            SerachArray = communitySelectModel
//
//
//            DispatchQueue.main.async {
//                self.tableViewLocation.reloadData()
//            }
//        }
//    }
//
//}


