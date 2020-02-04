//
//  DetailListViewController.swift
//  MCA
//
//  Created by Goutham Devaraju on 13/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import AARatingBar
import Kingfisher

class DetailListViewController: UIViewController {
    
    @IBOutlet weak var viewNodataFound: UIView!

    //MARK: - Properties
    var Req_cat_ID = 0
    var Req_title = ""
    var Req_sub_Cat_ID = 0
    var Req_sub_icon : String?

    var req_cat_icon : String?
    var req_cat_name : String?

    var selectedBusinessID: Int!
    
    var presenterDetailList: DetailListPresenterImplementation!
    
    var businessModelMain: BusinessModel!
    var eventsModelMain: EventsModel!
    var promotionsModelMain: PromotionsModel!
    var organisationsModelMain: OrganisationModel!
    
    var categoryType: CategoryType!
    
    @IBOutlet var viewMapBackground: UIView!
    @IBOutlet var textFieldSearch: UITextField!
    @IBOutlet var viewSegmentController: WMSegment!
    
    @IBOutlet var tableViewDetailList: UITableView!
    
//    @IBOutlet var viewForCategories: UIView!
//    @IBOutlet var viewCategory: UIView!
    
    // MAP VIEW
    @IBOutlet weak var viewMainMapView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    var locationArray = NSMutableArray()
    
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
    
    var selectedCategoryType: CategoryType!
    
    // scroll view titles
    
    @IBOutlet weak var viewTitleSlider: UIView!
    @IBOutlet weak var lblTitleSlider: UILabel!
    @IBOutlet weak var imageTitleSilder: UIImageView!
    
    @IBOutlet weak var viewCatSlider: UIView!
    @IBOutlet weak var lblCatSlider: UILabel!
    @IBOutlet weak var imageCatSilder: UIImageView!
    
    @IBOutlet weak var viewSUbCatSlider: UIView!
    @IBOutlet weak var lblSubCatSlider: UILabel!
    @IBOutlet weak var imageSubCatSilder: UIImageView!
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Req_cat_ID)
        print(Req_sub_Cat_ID)
        print(Req_title)
        
        //default
        viewMainMapView.isHidden = true
        self.viewLocationSelect.isHidden = true
        self.textFieldSearch.isEnabled = true
        
        textFieldSearch.addTarget(self, action: #selector(searchFilter), for: .allEvents)
        configureSegmentController()

//        DispatchQueue.main.async {
//            self.updateData()
//            self.titleSliderSetup()
//        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewNodataFound.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            self.updateData()
//            self.titleSliderSetup()
        }
    }
    
    func updateData() {
        
        DispatchQueue.main.async {
            
            if self.categoryType == nil {
                self.categoryType = CategoryType.promotions
            }
            
            self.getDataFromServer()
            self.titleSliderSetup()
            self.createPresenterInstance()

        }
        
        
//        if categoryType == nil {
//            categoryType = CategoryType.promotions
//        }
        
    }
    
    func titleSliderSetup() {
        
        if categoryType == CategoryType.business {
            
            lblTitleSlider.text = "Services"
            imageTitleSilder.image = UIImage(named: "home_business_icon")
            
            lblCatSlider.text = req_cat_name
            imageCatSilder.kf.setImage(with: URL(string: req_cat_icon ?? ""), placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
            }
//            imageCatSilder.backgroundColor = UIColor.init(named: <#T##String#>)
            
            lblSubCatSlider.text = Req_title
            imageSubCatSilder.kf.setImage(with: URL(string: Req_sub_icon ?? ""), placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
            }
            
            viewCatSlider.isHidden = false
            viewSUbCatSlider.isHidden = false
            
             self.addGradientForbusiness()
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            }
            
        } else if categoryType == CategoryType.promotions {
            
            lblTitleSlider.text = "Offers"
            imageTitleSilder.image = UIImage(named: "home_promotions_icon")
            viewCatSlider.isHidden = true
            viewSUbCatSlider.isHidden = true
            
             self.addGradientForPromotion()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                self.addGradientForPromotion()
//            }
            
        } else if categoryType == CategoryType.events {
            
            lblTitleSlider.text = "Events"
            imageTitleSilder.image = UIImage(named: "home_events_icon")
            viewCatSlider.isHidden = true
            viewSUbCatSlider.isHidden = true
            
            
               self.addGradientForEvent()
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            }
            
        } else if categoryType == CategoryType.organisations {
            
            lblTitleSlider.text = "Organisations"
            imageTitleSilder.image = UIImage(named: "home_events_icon")
            viewCatSlider.isHidden = true
            viewSUbCatSlider.isHidden = true
            
            
               self.addGradientForbusiness()
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            }
            
            
        } else {
            
            lblTitleSlider.text = "Promotions"
            imageTitleSilder.image = UIImage(named: "home_promotions_icon")
            viewCatSlider.isHidden = true
            viewSUbCatSlider.isHidden = true
            
            self.addGradientForPromotion()
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            }
            
        }
    }
    
    
    func addGradientForbusiness() {
        
//        let gradient1 = CAGradientLayer()
//        gradient1.frame = viewTitleSlider.bounds
//        gradient1.colors = [hexStringToUIColor(hex: "E6E3F6").cgColor,  hexStringToUIColor(hex: "E6E3F6").cgColor]
//        viewTitleSlider.layer.insertSublayer(gradient1, at: 0)
        
        viewTitleSlider.backgroundColor = hexStringToUIColor(hex: "E5E2F5")
        
//        let gradient2 = CAGradientLayer()
//        gradient2.frame = viewCatSlider.bounds
//        gradient2.colors = [hexStringToUIColor(hex: "E6E3F6").cgColor, hexStringToUIColor(hex: "E6E3F6").cgColor]
//        viewCatSlider.layer.insertSublayer(gradient2, at: 0)
        
        viewCatSlider.backgroundColor = hexStringToUIColor(hex: "E5E2F5")

        
//        let gradient3 = CAGradientLayer()
//        gradient3.frame = viewSUbCatSlider.bounds
//        gradient3.colors = [hexStringToUIColor(hex: "E6E3F6").cgColor, hexStringToUIColor(hex: "E6E3F6").cgColor]
//        viewSUbCatSlider.layer.insertSublayer(gradient3, at: 0)
        
        viewSUbCatSlider.backgroundColor = hexStringToUIColor(hex: "E5E2F5")
        
    }
    
    func addGradientForPromotion() {
        
        viewTitleSlider.backgroundColor = hexStringToUIColor(hex: "DCF0E7")

//        DispatchQueue.main.async{
//            let gradient1 = CAGradientLayer()
//            gradient1.frame = self.viewTitleSlider.bounds
//            gradient1.colors = [self.hexStringToUIColor(hex: "E5F9EE").cgColor,  self.hexStringToUIColor(hex: "E5F9EE").cgColor]
//            self.viewTitleSlider.layer.insertSublayer(gradient1, at: 0)
//        }
    }
    
    func addGradientForEvent() {
        
        viewTitleSlider.backgroundColor = hexStringToUIColor(hex: "EBEFFB")

//        DispatchQueue.main.async {
//
//
////            let gradient1 = CAGradientLayer()
////            gradient1.frame = self.viewTitleSlider.bounds
////            gradient1.colors = [self.hexStringToUIColor(hex: "E5self.F9EE").cgColor,  self.hexStringToUIColor(hex: "E5F9EE").cgColor]
////            self.viewTitleSlider.layer.insertSublayer(gradient1, at: 0)
//        }
    }
    
    
    
    @objc func searchFilter() {
        
        if (textFieldSearch.text?.count)! > 0 {
            
            let searchText = textFieldSearch.text ?? ""
            
            print("searchText : \(searchText)")
            
            if categoryType == CategoryType.business {
                
                if businessModelMain == nil {
                    return
                }
                
                if textFieldSearch.text?.count ?? 0 > 0 {
                    let Names = businessModelMain.ServicesList.filter({$0.Title!.uppercased().contains((textFieldSearch.text ?? "").uppercased())})
                    print("serach Array : \(Names)")
                    presenterDetailList.businessModel.ServicesList = Names
                    tableViewDetailList.reloadData()
                } else {
                    
                    presenterDetailList.businessModel = businessModelMain
                    tableViewDetailList.reloadData()
                }
                
            } else if categoryType == CategoryType.events {
                
                if eventsModelMain == nil {
                    return
                }
                
                if textFieldSearch.text?.count ?? 0 > 0 {
                    
                    let Names = eventsModelMain.EventsList.filter({$0.Title!.uppercased().contains((textFieldSearch.text ?? "").uppercased())})
                    print("serach Array : \(Names)")
                    presenterDetailList.eventsModel.EventsList = Names
                    tableViewDetailList.reloadData()
                } else {
                    
                    presenterDetailList.eventsModel = eventsModelMain
                    tableViewDetailList.reloadData()
                }
                
            } else if categoryType == CategoryType.promotions {
                
                if promotionsModelMain == nil {
                    return
                }
                
                if textFieldSearch.text?.count ?? 0 > 0 {
                    
                    let Names = promotionsModelMain.PromotionsList.filter({$0.Title!.uppercased().contains((textFieldSearch.text ?? "").uppercased())})
                    print("serach Array : \(Names)")
                    presenterDetailList.promotionsModel.PromotionsList = Names
                    tableViewDetailList.reloadData()
                } else {
                    
                    presenterDetailList.promotionsModel = promotionsModelMain
                    tableViewDetailList.reloadData()
                }
                
            } else if categoryType == CategoryType.organisations {
                
                
                if organisationsModelMain == nil {
                    return
                }
                
                if textFieldSearch.text?.count ?? 0 > 0 {
                    
                    let Names = organisationsModelMain.OrganisationsList.filter({$0.Title!.uppercased().contains((textFieldSearch.text ?? "").uppercased())})
                    print("serach Array : \(Names)")
                    presenterDetailList.organisationsModel.OrganisationsList = Names
                    tableViewDetailList.reloadData()
                } else {
                    
                    presenterDetailList.organisationsModel = organisationsModelMain
                    tableViewDetailList.reloadData()
                }
                
            }
        } else {
            
            if categoryType == CategoryType.business {
                
                if businessModelMain == nil {
                    return
                }
                
                presenterDetailList.businessModel = businessModelMain
                tableViewDetailList.reloadData()
                
                
            } else if categoryType == CategoryType.events {
                
                
                if eventsModelMain == nil {
                    return
                }
                presenterDetailList.eventsModel = eventsModelMain
                tableViewDetailList.reloadData()
                
                
            } else if categoryType == CategoryType.promotions {
                
                if promotionsModelMain == nil {
                    return
                }
                
                presenterDetailList.promotionsModel = promotionsModelMain
                tableViewDetailList.reloadData()
                
            } else if categoryType == CategoryType.organisations {
                
                if organisationsModelMain == nil {
                    return
                }
                presenterDetailList.organisationsModel = organisationsModelMain
                tableViewDetailList.reloadData()
            }
        }
}
    
    //MARK: - Button Actions
    @IBAction func segmentValueChange(_ sender: WMSegment) {
        
        switch sender.selectedSegmentIndex {
        case 0: break
//            presenterDetailList.sortByLocation()
        case 1: break
              print("Pending work")
//            presenterDetailList.sortByLocation()
//            presenterDetailList.sortByRatings()
//        case 2:

////            presenterDetailList.sortByDate()
//        case 3:
//            presenterDetailList.sortByViews()
        default:
            print("Default value selected")
        }
        
//        reloadDetailedTableView()
        
    }
    
    @IBAction func backToMainButtonEvent(_ sender: Any) {
        print("Back event")
        
        mainTabbarObj.selectedIndex = 0
        
        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func mapButtonEvent(_ sender: UIButton) {
        print("Map button event")
        
        if presenterDetailList.businessModel != nil || presenterDetailList.eventsModel != nil || presenterDetailList.promotionsModel != nil || presenterDetailList.organisationsModel != nil {
            
            viewLocationSelect.isHidden = true
            
            if sender.isSelected == true {
                sender.isSelected = false
                viewMainMapView.isHidden = true
                self.textFieldSearch.isEnabled = true
                
                
            } else {
                
                self.textFieldSearch.isEnabled = false
                
                sender.isSelected = true
                viewMainMapView.isHidden = false
                
                setupLatLong()
            }
            
        }
        

        
       
    }
    
    @IBAction func searchEvent(_ sender: Any) {
        print("Search event")
    }
    
    //MARK: - Other Methods
    
    func createPresenterInstance() {
        let presenterObj = DetailListPresenterImplementation(viewController: self)
        presenterDetailList = presenterObj
    }
    
    func configureSegmentController() {
        
        viewSegmentController.selectorType = .bottomBar
        viewSegmentController.selectorColor = UIColor.init(named: "ButtonColor") ?? UIColor.red
        
        //Set segment color accordingly
        if categoryType == CategoryType.business{
//            viewSegmentController.selectorColor = .red
        }
        else if categoryType == CategoryType.events{
//           viewSegmentController.selectorColor = .green
        }
        else if categoryType == CategoryType.promotions{
//           viewSegmentController.selectorColor = .red
        }
        else if categoryType == CategoryType.organisations{
//            viewSegmentController.selectorColor = .blue
        }
        
//        viewSegmentController.selectorColor = .red
        viewSegmentController.updateConstraints()
    }
    
    func reloadDetailedTableView(){
        DispatchQueue.main.async {
            self.tableViewDetailList.reloadData()
        }
    }
    
    //MARK: - Fetch data from the server
    func getDataFromServer() {
        // (UserDefaults.standard.value(forKey: key_user_id) != nil) &&
        if ((UserDefaults.standard.value(forKey: key_location_id) != nil)){
            let user_id_cached = UserDefaults.standard.value(forKey: key_user_id) as? Int ?? 0
            let location_id_cached = UserDefaults.standard.value(forKey: key_location_id) as! Int
            
            let req_cat_ID = Req_cat_ID
            let req_title = Req_title
            let req_sub_Cat_ID = Req_sub_Cat_ID

            if categoryType == CategoryType.business{
                print("Fetch business")
                
                DispatchQueue.main.async {
                     self.presenterDetailList.fetchBusinessDetails(location_id: location_id_cached, user_id: user_id_cached, Req_cat_ID: req_cat_ID, Req_title: req_title, Req_sub_Cat_ID: req_sub_Cat_ID)
                }
            }
                
            else if categoryType == CategoryType.events{
                print("Fetch events")
                
                DispatchQueue.main.async {
                    self.presenterDetailList.fetchEventsDetails(location_id: location_id_cached, user_id: user_id_cached)
                }
                
                
            }
                
            else if categoryType == CategoryType.promotions {
                print("Fetch promotions")
                
                DispatchQueue.main.async {
                     self.presenterDetailList.fetchPromotionsDetails(location_id: location_id_cached, user_id: user_id_cached)
                }
               
            }
            else if categoryType == CategoryType.organisations{
                print("Fetch organisations")
                
                DispatchQueue.main.async {
                    self.presenterDetailList.fetchOrganisationDetails(location_id: location_id_cached, user_id: user_id_cached)
                    
                }
               
            } else{
                
                // promotions
                print("default Fetch promotions")
                
                DispatchQueue.main.async {
                    self.presenterDetailList.fetchPromotionsDetails(location_id: location_id_cached, user_id: user_id_cached)
                }

            }
        }
        else{
//            AppManager.shared.showOkAlert(title: "Message", message: "Unable to fetch data. Please try again later.", onCompletion: { (callBack: String) in })
        }
    }
    
    @IBAction func btnFilterEvent(_ sender: UIButton) {
        openShortList()
    }
    
    func openShortList() {
        
        let optionMenu = UIAlertController(title: nil, message: "Sort by", preferredStyle: .actionSheet)
        
        let NearbyAction = UIAlertAction(title: "Near by", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Near by")
            self.presenterDetailList.sortByLocation()
            
//            DispatchQueue.main.async {
//                self.reloadDetailedTableView()
//            }
        })
        
        let LatestAction = UIAlertAction(title: "Latest", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Latest")
//            self.presenterDetailList.
//            self.reloadDetailedTableView()
            self.presenterDetailList.sortByDate()
            
//            DispatchQueue.main.async {
//                self.reloadDetailedTableView()
//            }
            
            
        })
        
        let byrating = UIAlertAction(title: "By rating", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            print("By rating")

            self.presenterDetailList.sortByRatings()
            
//            DispatchQueue.main.async {
//                self.reloadDetailedTableView()
//            }
            
        })
        
        let ByView = UIAlertAction(title: "By Views", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("By Views")
            self.presenterDetailList.sortByViews()
            
//            DispatchQueue.main.async {
//                self.reloadDetailedTableView()
//            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(NearbyAction)
        optionMenu.addAction(LatestAction)
        optionMenu.addAction(byrating)
        optionMenu.addAction(ByView)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func btnCloseMapEvent(_ sender: UIButton) {
        self.viewLocationSelect.isHidden = true
        viewMainMapView.isHidden = true
    }
    
    @IBAction func btnCloseLocationDetalsView(_ sender: UIButton) {
        self.viewLocationSelect.isHidden = true
    }
    
    @IBAction func btnSelectLocationView(_ sender: UIButton) {
        
        self.viewLocationSelect.isHidden = true
        performSegue(withIdentifier: "detailsToDescription", sender: nil)
        
    }
    
}

extension DetailListViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        presenterDetailList.resignAllResponders()
    }
}

extension DetailListViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenterDetailList.resignAllResponders()
        
        return true
    }
}

extension DetailListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.row == 0 {
            return 140
        }
            
        else if indexPath.row != 0 {
            
            if presenterDetailList.businessModel == nil && presenterDetailList.eventsModel == nil && presenterDetailList.organisationsModel == nil && presenterDetailList.promotionsModel == nil {
                return 0.0
            }
            
            if categoryType == CategoryType.business{
                return presenterDetailList.businessModel.ServicesList.count-1 == indexPath.row ? 120 : 115
            }
            else if categoryType == CategoryType.events{
                return presenterDetailList.eventsModel.EventsList.count-1 == indexPath.row ? 120 : 115
            }
            else if categoryType == CategoryType.promotions{
                if presenterDetailList.promotionsModel != nil {
                    return presenterDetailList.promotionsModel.PromotionsList.count-1 == indexPath.row ? 120 : 115
                } else {
                    return 0
                }
            }
            else if categoryType == CategoryType.organisations {
                return presenterDetailList.organisationsModel.OrganisationsList.count-1 == indexPath.row ? 120 : 115
            } else {
                //default
                  return presenterDetailList.promotionsModel.PromotionsList.count-1 == indexPath.row ? 120 : 115
            }
        }
        else{
            return 115
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewNodataFound.isHidden = true
        
        if ((presenterDetailList?.businessModel) != nil) {

            if presenterDetailList.businessModel.ServicesList.count == 0{
                viewNodataFound.isHidden = false
                return 0
            } else {
                viewNodataFound.isHidden = true
                return presenterDetailList.businessModel.ServicesList.count
            }

        } else if ((presenterDetailList?.eventsModel) != nil) {

            if presenterDetailList.eventsModel.EventsList.count == 0 {
                viewNodataFound.isHidden = false
                return 0
            } else {
                viewNodataFound.isHidden = true
                return presenterDetailList.eventsModel.EventsList.count
            }

        } else if ((presenterDetailList?.promotionsModel) != nil) {

            if presenterDetailList.promotionsModel.PromotionsList.count == 0{
                viewNodataFound.isHidden = false
                return 0
            } else {
                viewNodataFound.isHidden = true
                return presenterDetailList.promotionsModel.PromotionsList.count
            }

        } else if ((presenterDetailList?.organisationsModel) != nil){

            if presenterDetailList.organisationsModel.OrganisationsList.count == 0{
                viewNodataFound.isHidden = false
                return 0
            } else {
                viewNodataFound.isHidden = true
                return presenterDetailList.organisationsModel.OrganisationsList.count
            }

        } else {
            viewNodataFound.isHidden = true
            return 0
        }
        
//        if presenterDetailList.businessModel != nil || presenterDetailList.eventsModel != nil || presenterDetailList.promotionsModel != nil || presenterDetailList.organisationsModel != nil {
//
//            if categoryType == CategoryType.business{
//                if presenterDetailList.businessModel.ServicesList.count == 0{
//                    viewNodataFound.isHidden = false
//                } else {
//                     viewNodataFound.isHidden = true
//                }
//                return presenterDetailList.businessModel.ServicesList.count > 0 ? presenterDetailList.businessModel.ServicesList.count : 0
//            }
//            else if categoryType == CategoryType.events{
//                if presenterDetailList.eventsModel.EventsList.count == 0{
//                    viewNodataFound.isHidden = false
//                } else {
//                    viewNodataFound.isHidden = true
//                }
//                return presenterDetailList.eventsModel.EventsList.count > 0 ? presenterDetailList.eventsModel.EventsList.count : 0
//            }
//            else if categoryType == CategoryType.promotions{
//                if presenterDetailList.promotionsModel.PromotionsList.count == 0{
//                    viewNodataFound.isHidden = false
//                } else {
//                    viewNodataFound.isHidden = true
//                }
//                return presenterDetailList.promotionsModel.PromotionsList.count > 0 ? presenterDetailList.promotionsModel.PromotionsList.count : 0
//            }
//            else if categoryType == CategoryType.organisations {
//                if presenterDetailList.organisationsModel.OrganisationsList.count == 0{
//                    viewNodataFound.isHidden = false
//                } else {
//                    viewNodataFounnmapd.isHidden = true
//                }
//                return presenterDetailList.organisationsModel.OrganisationsList.count > 0 ? presenterDetailList.organisationsModel.OrganisationsList.count : 0
//            } else{
//                viewNodataFound.isHidden = true
//                return 0
//            }
//        }
//        else{
//
//            viewNodataFound.isHidden = true
//            return 0
//        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell_indentifier = ""
        
        if categoryType == CategoryType.business {
            
            if presenterDetailList.businessModel == nil {
                return UITableViewCell()
            } else  if presenterDetailList.businessModel.ServicesList.count == 0 {
                return UITableViewCell()
            }
            
            let service = presenterDetailList.businessModel.ServicesList[indexPath.row]
            
//            print(service.Latitude)
//            print(service.Longitude)

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
            
            let category_detailed_cell = tableView.dequeueReusableCell(withIdentifier: cell_indentifier) as! DetailListTableViewCell
            
            if let rating = service.Rating{
                print("rating : \(rating)")
                //                category_detailed_cell.viewRatingBar.value = CGFloat(service.Rating)
            }
//            DispatchQueue.main.async {
                category_detailed_cell.viewRatingBar.value = CGFloat(service.Rating ?? 0.0)
//            }
//            category_detailed_cell.viewRatingBar.value = CGFloat(3)

            if let title = service.Title{
                category_detailed_cell.labelTitleDetailedList.text = title
            }
            
            
            
            if let image_url = service.Image{
                if let url_image = URL(string: image_url){
                    
                    category_detailed_cell.imageViewDetailList.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                    }
//                    category_detailed_cell.imageViewDetailList.kf.setImage(with: url_image)
                }
            }
            
            if let location = service.Location{
                category_detailed_cell.labelLocation.text = location
            }
            
            if let views = service.Views{
                category_detailed_cell.labelViews.text = views == 1 || views == 0 ? "\(views) view" : "\(views) views"
            }

            if let createdDate = service.Created_Datetime {
                
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
                    presenterDetailList.businessModel.ServicesList[indexPath.row].createdDate = days
                }
            }
            
            return category_detailed_cell
            
        }
            
        else if categoryType == CategoryType.promotions {
            
            if presenterDetailList.promotionsModel == nil {
                return UITableViewCell()
            } else  if presenterDetailList.promotionsModel.PromotionsList.count == 0 {
                return UITableViewCell()
            }
            
            let service = presenterDetailList.promotionsModel.PromotionsList[indexPath.row]
            
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
            
          
            
            let category_detailed_cell = tableView.dequeueReusableCell(withIdentifier: cell_indentifier) as! DetailListTableViewCell
            
            if let rating = service.Rating{
                print("rating : \(rating)")
                //                category_detailed_cell.viewRatingBar.value = CGFloat(service.Rating)
            }
            
            category_detailed_cell.viewRatingBar.value = CGFloat(service.Rating ?? 0.0)
            
            if let title = service.Title{
                category_detailed_cell.labelTitleDetailedList.text = title
            }
            
            
            if let image_url = service.Image{
                if let url_image = URL(string: image_url){
                    category_detailed_cell.imageViewDetailList.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                    }
                }
            }
            
            if let location = service.Location{
                category_detailed_cell.labelLocation.text = location
            }
            
            if let views = service.Views{
                category_detailed_cell.labelViews.text = views == 1 || views == 0 ? "\(views) view" : "\(views) views"
            }
            
            category_detailed_cell.viewRatingBar.value = CGFloat(service.Rating ?? 0.0)
            
            
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
                    presenterDetailList.promotionsModel.PromotionsList[indexPath.row].createdDate = days
                }
            }
            
            return category_detailed_cell
            
        }
            
        else if categoryType == CategoryType.events {
            //
            if presenterDetailList.eventsModel == nil {
                return UITableViewCell()
            } else  if presenterDetailList.eventsModel.EventsList.count == 0 {
                return UITableViewCell()
            }
            //
            let service = presenterDetailList.eventsModel.EventsList[indexPath.row]
            
            var isFeatured = false
            
            if let featured = service.IsFeature {
                isFeatured  = featured == "true"
            }
            
            if isFeatured{
                cell_indentifier = indexPath.row == 0 ? "DetailListTableViewCellID_first_featured" : "DetailListTableViewCellID_featured"
            }
            else{
                cell_indentifier = indexPath.row == 0 ? "DetailListTableViewCellID_first" : "DetailListTableViewCellID"
            }
            
            let category_detailed_cell = tableView.dequeueReusableCell(withIdentifier: cell_indentifier) as! DetailListTableViewCell
            
            
            if let rating = service.Rating{
                print("rating : \(rating)")
                //                category_detailed_cell.viewRatingBar.value = CGFloat(service.Rating)
            }
            
            category_detailed_cell.viewRatingBar.value = CGFloat(service.Rating ?? 0.0)
            
            if let title = service.Title{
                category_detailed_cell.labelTitleDetailedList.text = title
            }
            
            if let image_url = service.Image{
                if let url_image = URL(string: image_url){
                    
                    category_detailed_cell.imageViewDetailList.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                    }
                    //                    category_detailed_cell.imageViewDetailList.kf.setImage(with: url_image)
                }
            }
            
            if let location = service.Location{
                category_detailed_cell.labelLocation.text = location
            }
            
            if let views = service.Views{
                category_detailed_cell.labelViews.text = views == 1 || views == 0 ? "\(views) view" : "\(views) views"
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
                    presenterDetailList.eventsModel.EventsList[indexPath.row].createdDate = days
                }
            }
            
            return category_detailed_cell
            
        }
        else if categoryType == CategoryType.organisations {
            
            let service = presenterDetailList.organisationsModel.OrganisationsList[indexPath.row]
            
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
            
            let category_detailed_cell = tableView.dequeueReusableCell(withIdentifier: cell_indentifier) as! DetailListTableViewCell
            
            if let rating = service.Rating{
                print("rating : \(rating)")
                //                category_detailed_cell.viewRatingBar.value = CGFloat(service.Rating)
            }
            
            category_detailed_cell.viewRatingBar.value = CGFloat(service.Rating ?? 0.0)
            
            if let title = service.Title{
                category_detailed_cell.labelTitleDetailedList.text = title
            }
            
            
            if let image_url = service.Image{
                if let url_image = URL(string: image_url){
                    
                    category_detailed_cell.imageViewDetailList.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                    }
                    //                    category_detailed_cell.imageViewDetailList.kf.setImage(with: url_image)
                }
            }
            
            if let location = service.Location{
                category_detailed_cell.labelLocation.text = location
            }
            
            if let views = service.Views{
                category_detailed_cell.labelViews.text = views == 1 || views == 0 ? "\(views) view" : "\(views) views"
            }
            
            //            if let rating = service.Rating {
            //                category_detailed_cell.viewRatingBar.value = CGFloat(rating)
            //            }
            
            //            category_detailed_cell.viewRatingBar.value = CGFloat(service.Rating ?? 0.0)
            
            
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
                    presenterDetailList.organisationsModel.OrganisationsList[indexPath.row].createdDate = days
                }
            }
            
            return category_detailed_cell
            
        }
        else {
            // default promotionsModel
            let service = presenterDetailList.promotionsModel.PromotionsList[indexPath.row]
            
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
            
            
            
            let category_detailed_cell = tableView.dequeueReusableCell(withIdentifier: cell_indentifier) as! DetailListTableViewCell
            
            if let rating = service.Rating{
                print("rating : \(rating)")
                //                category_detailed_cell.viewRatingBar.value = CGFloat(service.Rating)
            }
            
            category_detailed_cell.viewRatingBar.value = CGFloat(service.Rating ?? 0.0)
            
            if let title = service.Title{
                category_detailed_cell.labelTitleDetailedList.text = title
            }
            
            
            if let image_url = service.Image{
                if let url_image = URL(string: image_url){
                    category_detailed_cell.imageViewDetailList.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                    }
                    //                    category_detailed_cell.imageViewDetailList.kf.setImage(with: url_image)
                }
            }
            
            if let location = service.Location{
                category_detailed_cell.labelLocation.text = location
            }
            
            if let views = service.Views{
                category_detailed_cell.labelViews.text = views == 1 || views == 0 ? "\(views) view" : "\(views) views"
            }
            
            
            category_detailed_cell.viewRatingBar.value = CGFloat(service.Rating ?? 0.0)
            
            
            
            
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
                    presenterDetailList.promotionsModel.PromotionsList[indexPath.row].createdDate = days
                }
            }
            
            return category_detailed_cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if categoryType == CategoryType.business{
            let service = presenterDetailList.businessModel.ServicesList[indexPath.row]
            selectedBusinessID = service.Service_Id
            AppManager.shared.businessModel = presenterDetailList.businessModel
        }
        else if categoryType == CategoryType.events{
            let service = presenterDetailList.eventsModel.EventsList[indexPath.row]
            selectedBusinessID = service.Event_Id
            AppManager.shared.eventsModel = presenterDetailList.eventsModel
        }
        else if categoryType == CategoryType.promotions{
            let service = presenterDetailList.promotionsModel.PromotionsList[indexPath.row]
            selectedBusinessID = service.Pro_Id
            AppManager.shared.promotionsModel = presenterDetailList.promotionsModel
        }
        else if categoryType == CategoryType.organisations{
            let service = presenterDetailList.organisationsModel.OrganisationsList[indexPath.row]
            selectedBusinessID = service.Organisation_Id
            AppManager.shared.organisationsModel = presenterDetailList.organisationsModel
        } else{
            
            let service = presenterDetailList.promotionsModel.PromotionsList[indexPath.row]
            selectedBusinessID = service.Pro_Id
            AppManager.shared.promotionsModel = presenterDetailList.promotionsModel
        }
        
        AppManager.shared.index_for_report = indexPath.row
        performSegue(withIdentifier: "detailsToDescription", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsToDescription" {
            let viewController = segue.destination as! DetailDescriptionViewController
            viewController.selectedServiceID = selectedBusinessID
            viewController.categoryType = categoryType
        }

    }
}

extension DetailListViewController: DetailListViewProtocol{
    
    func responseEventsData(businessModel: EventsModel) {
        presenterDetailList.InitialiseAndFetchLocation()
        
        DispatchQueue.main.async {
            self.tableViewDetailList.reloadData()
        }
    }
    
    func responsePromotionsData(businessModel: PromotionsModel) {
        
        presenterDetailList.InitialiseAndFetchLocation()
        
        print("PromotionsList :- \(businessModel.PromotionsList.count)")
        DispatchQueue.main.async {
            self.tableViewDetailList.reloadData()
        }
    }
    
    func responseOrganisationsData(businessModel: OrganisationModel) {
        
        presenterDetailList.InitialiseAndFetchLocation()
        
        DispatchQueue.main.async {
            self.tableViewDetailList.reloadData()
        }
    }
    
    func responseBusinessData(businessModel: BusinessModel) {
        
        presenterDetailList.InitialiseAndFetchLocation()
        
        DispatchQueue.main.async {
            self.tableViewDetailList.reloadData()
        }
    }
}

extension DetailListViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //Stoping updating locations as current location is received once
        presenterDetailList.locationManager.stopUpdatingLocation()
        
        print(locations)
        
        
        
        presenterDetailList.processDistanceAndStore(currentLocation: locations[0])
        
    }
}

extension DetailListViewController : MKMapViewDelegate {
    
    func setupLatLong() {
        print(" locationArray :  \(locationArray)")
        if locationArray.count != 0 {
            
            for location in locationArray {
                
                let locationDic = location as? NSDictionary ?? [:]
                
                let title = locationDic["title"] as? String ?? ""
                let latitude = locationDic["Latitude"] as? String ?? ""
                let longitude = locationDic["Longitude"] as? String ?? ""
                
                let serviceType = locationDic["locationType"] as? String ?? ""
                
                let annotation = CustomPointAnnotation()
                if serviceType == "business" {
                    
                    annotation.title = title
                    annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0)
                    annotation.imageName = "business_map"
                    
                    
                } else if serviceType == "events" {
                    
                    annotation.title = title
                    annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0)
                    annotation.imageName = "promo_map"
                    
                }  else if serviceType == "promotions" {
                    
                    annotation.title = title
                    annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0)
                    annotation.imageName = "promo_map"
                    
                }  else if serviceType == "organisations" {
                    
                    annotation.title = title
                    annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0)
                    annotation.imageName = "promo_map"
                    
                }
                
                if locationArray[0] as? NSDictionary ?? [:] == locationDic {
                    let coordinate = CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
                    let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
                    mapView.setRegion(viewRegion, animated: true)
                }
                
                mapView.addAnnotation(annotation)
                
            }
        }
    }
    
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
    
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        print(view.annotation?.debugDescription as Any)

        // refress to center position map
        mapView.setCenter(CLLocationCoordinate2D(latitude: view.annotation?.coordinate.latitude ?? 0.0, longitude: view.annotation?.coordinate.longitude ?? 0.0), animated: true)

        // get select let long
        let latitude = view.annotation?.coordinate.latitude ?? 0.0
        let longitude = view.annotation?.coordinate.longitude ?? 0.0

        print("Select coordinate : \(latitude, longitude)")

        var isTypelocationArray = locationArray.filter {((($0 as! NSDictionary)["Latitude"] as! String) == "\(latitude)") && (($0 as! NSDictionary)["Longitude"] as! String) == "\(longitude)"}

        print(isTypelocationArray)

        if isTypelocationArray[0] != nil {
            let locationType = (isTypelocationArray[0] as! NSDictionary)["locationType"] as? String ?? ""

            if locationType == "business" {

                if presenterDetailList.businessModel != nil || presenterDetailList.businessModel.ServicesList.count != 0 {

                    let ServicesList = presenterDetailList.businessModel.ServicesList

//                    let lat = (latitude as NSString).doubleValue

                    let filteredLocation = ServicesList.filter { ServicesList in
                        return ((ServicesList.Latitude! as NSString).doubleValue == latitude && (ServicesList.Longitude! as NSString).doubleValue == longitude)
                    }

                    //                    if filteredLocation[]
                    //
                    
                    print("Search Found Data All: \(filteredLocation)")
//                    print("Search Found Data First Array : \(filteredLocation)")

                    if filteredLocation[0] != nil && filteredLocation.count != 0 {

                        self.viewLocationSelect.isHidden = false

                        let url = URL(string: filteredLocation[0].Image ?? "")
                        imageLocation.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                        }

                        lbltitleName.text = filteredLocation[0].Title
                        lblLocationName.text = filteredLocation[0].Location
                        //                lblitemStatusDays.text = selectData["title"] as? String ?? ""
                        lblreviews.text = "\(filteredLocation[0].Views ?? 0)"
                        viewRating.value = CGFloat(filteredLocation[0].Rating ?? 0.0)

                        if (filteredLocation[0].Created_Datetime)?.count != 0  {

                            //2019-08-13T05:50:14.937
                            let createdDate = filteredLocation[0].Created_Datetime
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

                        selectedBusinessID = filteredLocation[0].Service_Id
                        selectedCategoryType = CategoryType.business

                    }
                }



            }
            else if locationType == "events" {
                
                if presenterDetailList.eventsModel != nil || presenterDetailList.eventsModel.EventsList.count != 0 {
                    
                    let EventsList = presenterDetailList.eventsModel.EventsList
                    
                    //                    let lat = (latitude as NSString).doubleValue
                    
                    let filteredLocation = EventsList.filter { EventsList in
                        return ((EventsList.Latitude! as NSString).doubleValue == latitude && (EventsList.Longitude! as NSString).doubleValue == longitude)
                    }
                    
                    //                    if filteredLocation[]
                    //
                    print("Search Found Data All: \(filteredLocation)")
                    //                    print("Search Found Data First Array : \(filteredLocation)")
                    
                    if filteredLocation[0] != nil && filteredLocation.count != 0 {
                        
                        self.viewLocationSelect.isHidden = false
                        
                        let url = URL(string: filteredLocation[0].Image ?? "")
                        imageLocation.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                        }
                        
                        lbltitleName.text = filteredLocation[0].Title
                        lblLocationName.text = filteredLocation[0].Location
                        //                lblitemStatusDays.text = selectData["title"] as? String ?? ""
                        lblreviews.text = "\(filteredLocation[0].Views ?? 0)"
                        viewRating.value = CGFloat(filteredLocation[0].Rating ?? 0.0)
                        
                        if (filteredLocation[0].Created_Datetime)?.count != 0  {
                            
                            //2019-08-13T05:50:14.937
                            let createdDate = filteredLocation[0].Created_Datetime
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
                        
                        selectedBusinessID = filteredLocation[0].Event_Id
                        selectedCategoryType = CategoryType.events
                        
                    }
                }
                
                
                
            } else if locationType == "promotions" {
                
                if presenterDetailList.promotionsModel != nil || presenterDetailList.promotionsModel.PromotionsList.count != 0 {
                    
                    let PromotionsList = presenterDetailList.promotionsModel.PromotionsList
                    
                    //                    let lat = (latitude as NSString).doubleValue
                    
                    let filteredLocation = PromotionsList.filter { PromotionsList in
                        return ((PromotionsList.Latitude! as NSString).doubleValue == latitude && (PromotionsList.Longitude! as NSString).doubleValue == longitude)
                    }
                    
                    //                    if filteredLocation[]
                    //
                    print("Search Found Data All: \(filteredLocation)")
                    //                    print("Search Found Data First Array : \(filteredLocation)")
                    
                    if filteredLocation[0] != nil && filteredLocation.count != 0 {
                        
                        self.viewLocationSelect.isHidden = false
                        
                        let url = URL(string: filteredLocation[0].Image ?? "")
                        imageLocation.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                        }
                        
                        lbltitleName.text = filteredLocation[0].Title
                        lblLocationName.text = filteredLocation[0].Location
                        //                lblitemStatusDays.text = selectData["title"] as? String ?? ""
                        lblreviews.text = "\(filteredLocation[0].Views ?? 0)"
                        viewRating.value = CGFloat(filteredLocation[0].Rating ?? 0.0)
                        
                        if (filteredLocation[0].Created_Datetime)?.count != 0  {
                            
                            //2019-08-13T05:50:14.937
                            let createdDate = filteredLocation[0].Created_Datetime
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
                        
                        selectedBusinessID = filteredLocation[0].Pro_Id
                        selectedCategoryType = CategoryType.promotions
                        
                    }
                }
                
                

            } else if locationType == "organisations" {
                
                if presenterDetailList.organisationsModel != nil || presenterDetailList.organisationsModel.OrganisationsList.count != 0 {
                    
                    let OrganisationsList = presenterDetailList.organisationsModel.OrganisationsList
                    
                    //                    let lat = (latitude as NSString).doubleValue
                    
                    let filteredLocation = OrganisationsList.filter { OrganisationsList in
                        return ((OrganisationsList.Latitude! as NSString).doubleValue == latitude && (OrganisationsList.Longitude! as NSString).doubleValue == longitude)
                    }
                    
                    //                    if filteredLocation[]
                    //
                    print("Search Found Data All: \(filteredLocation)")
                    //                    print("Search Found Data First Array : \(filteredLocation)")
                    
                    if filteredLocation[0] != nil && filteredLocation.count != 0 {
                        
                        self.viewLocationSelect.isHidden = false
                        
                        let url = URL(string: filteredLocation[0].Image ?? "")
                        imageLocation.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                        }
                        
                        lbltitleName.text = filteredLocation[0].Title
                        lblLocationName.text = filteredLocation[0].Location
                        //                lblitemStatusDays.text = selectData["title"] as? String ?? ""
                        lblreviews.text = "\(filteredLocation[0].Views ?? 0)"
                        viewRating.value = CGFloat(filteredLocation[0].Rating ?? 0.0)
                        
                        if (filteredLocation[0].Created_Datetime)?.count != 0  {
                            
                            //2019-08-13T05:50:14.937
                            let createdDate = filteredLocation[0].Created_Datetime
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
                        
                        selectedBusinessID = filteredLocation[0].Organisation_Id
                        selectedCategoryType = CategoryType.organisations
                        
                    }
                }
                
                
                
            }
            


        }
    }
        //        if

        //            return (Double((alllocationArray as! NSMutableArray)["latitude"] as? String ?? "0.0") == latitude && Double(alllocationArray["longitude"] as? String ?? "0.0") == longitude)
        //        }
//
//    }
    
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
        //                        lblitemStatusDays.text = days == 1 || days == 0 ? "\(days) day" : "\(days) days"
        //
        //                        //Setting date in integer format
        //                        //                        presenterDetailList.eventsModel.EventsList[indexPath.row].createdDate = days
        //                    }
        //                }
        //
        //                selectedBusinessID = filteredLocation[0].proID
        //                selectedCategoryType = CategoryType.promotions
        //
        //            }
        //        }
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


