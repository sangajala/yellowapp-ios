//
//  HomeViewController.swift
//  MCA
//
//  Created by Goutham Devaraju on 02/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
import SafariServices
import Kingfisher


class HomeViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet var viewExtraBounds: UIView!
    @IBOutlet var labelLocationTop: UILabel!
    @IBOutlet var buttonProfile: UIButton!
    @IBOutlet var viewSearchBar: UIView!
    @IBOutlet var viewMapBackground: UIView!
    @IBOutlet var viewProfileBackground: UIView!
    @IBOutlet var tableViewHome: UITableView!
    @IBOutlet var textFieldSearchHome: UITextField!
    
    var viewOverlay: UIView!
    var activityIndicator: UIActivityIndicatorView!
    var presenterHome: HomePresenterImplementation!
    
    var selectedCategoryType: CategoryType!
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        setShadowProperties()
        createPresenterObjectAndFetchHomeData()
        getHomeDataFromServer()
    }
    
    //MARK: - Button Events
    @IBAction func profileImageTapEvent(_ sender: Any) {
        AppManager.shared.printLog(stringToPrint: "Profile")
    }
    
    @IBAction func mapViewTapEvent(_ sender: Any) {
        AppManager.shared.printLog(stringToPrint: "Map tap event")
    }
    
    @IBAction func locationTapEvent(_ sender: Any) {
        AppManager.shared.printLog(stringToPrint: "Location tap event")
    }
    
    func seeAllAction(withButton button: UIButton){

        if button.title(for: .selected) == "Services"{
            selectedCategoryType = CategoryType.business
        }
        else if button.title(for: .selected) == "Events"{
            selectedCategoryType = CategoryType.events
        }
        else if button.title(for: .selected) == "Discounts and Offers"{
            selectedCategoryType = CategoryType.promotions
        }
        else
        {
            selectedCategoryType = CategoryType.organisations
        }
        
        if let viewController = ((self.tabBarController?.viewControllers?[1] as! UINavigationController).viewControllers[0]) as? DetailListViewController {
            
            print(viewController)
            viewController.categoryType = selectedCategoryType
//            viewController.Req_cat_ID = catID ?? 0
//            viewController.Req_sub_Cat_ID = selectSubCat
//            viewController.Req_title = selectSubCatTitle
            
            tabBarController?.selectedIndex = 1
            
        }
//        performSegue(withIdentifier: "mainToDetail", sender: nil)
    }
    
    //MARK: - Other Methods
    func setShadowProperties() {
        viewMapBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewProfileBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
    }
    
    func createPresenterObjectAndFetchHomeData(){
        presenterHome = HomePresenterImplementation(viewController: self)
    }
    
    func addActivityIndicatorView(){
        
        viewOverlay = nil
        
        viewOverlay = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        viewOverlay.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.addSubview(viewOverlay)
        
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = viewOverlay.center
        viewOverlay.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
    }
    
    func removeActivityIndicator(){
        activityIndicator.stopAnimating()
        viewOverlay.removeFromSuperview()
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToDetail" {
            let viewController:DetailListViewController = segue.destination as! DetailListViewController
            viewController.categoryType = selectedCategoryType
        }
    }
    
    //MARK: - Server related
    func getHomeDataFromServer(){
        
        if (UserDefaults.standard.value(forKey: key_user_id) != nil) && ((UserDefaults.standard.value(forKey: key_location_id) != nil)){
            let user_id_cached = UserDefaults.standard.value(forKey: key_user_id) as! Int
            let location_id_cached = UserDefaults.standard.value(forKey: key_location_id) as! Int
            
            presenterHome.getHomeData(location_id: location_id_cached, user_id: user_id_cached)
        }
        else{
//            AppManager.shared.showOkAlert(title: "Message", message: "Unable to fetch location data. Please try again later.", onCompletion: { (callBack: String) in })
        }
        
        //        if let location_id = AppManager.shared.locationSelectedModel_shared.Location_ID, let user_id = AppManager.shared.user_details.UserID{
        //            let user_id_cached = UserDefaults.standard.value(forUndefinedKey: key_user_id) as! Int
        //            presenterHome.getHomeData(location_id: location_id, user_id: user_id_cached)
        //        }
        //        else{
        //            print("Unable to fetch Home data.")
        //        }
    }
}

extension HomeViewController: HomeViewProtocol{
    
    func homeDataResponse(homeModel: HomeModel) {
        
        print("Message: \(String(describing: homeModel.message.message))")
        
        //Updating location name on top
        if UserDefaults.standard.value(forKey: key_location_name) != nil{
            labelLocationTop.text = UserDefaults.standard.value(forKey: key_location_name) as? String
        }
        
        DispatchQueue.main.async {
            self.tableViewHome.reloadData()
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if presenterHome.homeModel != nil{
            return presenterHome.homeModel.homeData.count > 0 ? presenterHome.homeModel.homeData.count + 2 : 0
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            
            let linkSlideCell = tableView.dequeueReusableCell(withIdentifier: "LinkSlidesTableViewCellID") as! LinkSlidesTableViewCell
            linkSlideCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            return linkSlideCell
        }
        else if indexPath.row == presenterHome.homeModel.homeData.count + 1{
            
            let moduleCount = presenterHome.homeModel.moduleCount
            
            let optionsCell = tableView.dequeueReusableCell(withIdentifier: "OptionsTableViewCellID") as! OptionsTableViewCell
            
            optionsCell.setHomeViewControllerObject(viewController: self)
            
            if let business_count = moduleCount.business{
                optionsCell.labelNumberOfBusinesses.text = "\(business_count)"
            }
            
            if let promotions_count = moduleCount.promotions {
                optionsCell.labelNumberOfPromotions.text = "\(promotions_count)"
            }
            
            if let events_count = moduleCount.events{
                optionsCell.labelNumberOfEvents.text = "\(events_count)"
            }
            
            if let posts_count = moduleCount.organizations {
                optionsCell.labelNumberOfPosts.text = "\(posts_count)"
            }
            
            return optionsCell
        }
        else{
            
            let categorySlideCell = tableView.dequeueReusableCell(withIdentifier: "CategroriesTableViewCellID") as! CategroriesTableViewCell
            
            categorySlideCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
            if presenterHome.homeModel != nil{
                
                let data_module = presenterHome.homeModel.homeData[indexPath.row - 1]
                categorySlideCell.labelModuleDescription.text = data_module.homeDatumDescription
                
                categorySlideCell.setViewControllerObject(viewController: self)
                
                if data_module.moduleName == "Services"{
                    categorySlideCell.buttonSeeAll.setTitleColor(UIColor(named: "Business_category"), for: .normal)
                    categorySlideCell.buttonSeeAll.setTitle("Services", for: .selected)
                }
                else if data_module.moduleName == "Events"{
//                    categorySlideCell.buttonSeeAll.setTitleColor(UIColor(named: "Events_category"), for: .normal)
                    categorySlideCell.buttonSeeAll.setTitleColor(UIColor.yellow, for: .normal)
                    categorySlideCell.buttonSeeAll.setTitle("Events", for: .selected)
                }
                else if data_module.moduleName == "Organizations"{
                    categorySlideCell.buttonSeeAll.setTitleColor(UIColor(named: "Posts_category"), for: .normal)
                    categorySlideCell.buttonSeeAll.setTitle("Organizations", for: .selected)
                }
                else{
//                    categorySlideCell.buttonSeeAll.setTitleColor(UIColor(named: "Promotions_category"), for: .normal)
                    categorySlideCell.buttonSeeAll.setTitleColor(UIColor.red, for: .normal)
                    categorySlideCell.buttonSeeAll.setTitle("Discounts and Offers", for: .selected)
                }
            }
            else{
                categorySlideCell.labelModuleDescription.text = ""
            }
            
            categorySlideCell.buttonSeeAll.tag = indexPath.row - 1
            
            return categorySlideCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 176
        }
        else{
            return 200
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textFieldSearchHome.resignFirstResponder()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, SFSafariViewControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //Get the sliders links data and pass it
//        return 5//presenterHome.homeModel.HomeData
        
        if collectionView.tag == 0{
            if presenterHome.homeModel == nil{
                return 0
            }
            else{
                return presenterHome.homeModel.sliderimages.count > 0 ? presenterHome.homeModel.sliderimages.count : 0
            }
        }
        else{
            if presenterHome.homeModel == nil{
                return 0
            }
            else{
                
                let data_module = presenterHome.homeModel.homeData[collectionView.tag - 1]
                let dataCount = data_module.data.count//data_module.data.count
                return dataCount > 0 ? dataCount : 0
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Return collectionView cell accordingly
        if collectionView.tag == 0{
            
            let sliderImage_model = presenterHome.homeModel.sliderimages[indexPath.row]
            let image_url = sliderImage_model.image
            
            let linkSlideCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LinkSlideCollectionViewCellID",
                                                                             for: indexPath) as! LinkSlideCollectionViewCell
            
            if  image_url != "" {
                let url = URL(string: image_url)
                
                linkSlideCollectionCell.imageViewLinkSlider.kf.setImage(with: url)
            }
            
            return linkSlideCollectionCell
        }
        else
        {
            
            let data_module = presenterHome.homeModel.homeData[collectionView.tag - 1]
            let dataObject = data_module.data[indexPath.row]
            let image_url = dataObject.image
            
            let categorySlideCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCellID",
                                                                             for: indexPath) as! CategoriesCollectionViewCell
            
            categorySlideCollectionCell.labelTitle.text = dataObject.title
            categorySlideCollectionCell.location.text = dataObject.location
            
//            categorySlideCollectionCell.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
            
            categorySlideCollectionCell.viewBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
            
            if image_url != "" {
                let url = URL(string: image_url)
                categorySlideCollectionCell.imageCategory.kf.setImage(with: url)
            }
            
            return categorySlideCollectionCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("IndexPathRow: \(indexPath.row), section: \(indexPath.section)")
        
        if collectionView.tag == 0 {
            let sliderImage_model = presenterHome.homeModel.sliderimages[indexPath.row]
            let redirection_url = sliderImage_model.url
            
            if let url_to_redirect = URL(string: redirection_url){
                
                if UIApplication.shared.canOpenURL( url_to_redirect) {
                    
                    let safariViewController = SFSafariViewController(url: URL(string: redirection_url)!)
                    safariViewController.delegate = self
                    self.navigationController?.present(safariViewController, animated: true, completion: nil)
                    
                }
                else{
                    AppManager.shared.showOkAlert(title: "Alert", message: "Unable to open the link. Please try again.", view: self, onCompletion: {(callBack: String) in })
                }
                
            }
            else{
                AppManager.shared.showOkAlert(title: "Alert", message: "Unable to open the link. Please try again.", view: self, onCompletion: {(callBack: String) in })
            }
        }
        else{
            print("Redirect to module")
        }
    }
    
}

//extension HomeViewController {
//
//    func revealController(_ revealController: SWRevealViewController!, animateTo position: FrontViewPosition)
//    {
//        if position == FrontViewPosition.right{
//
//            if self.view.viewWithTag(9966) == nil {
//                let coverView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
//                coverView.tag = 9966
//                coverView.backgroundColor = UIColor.black
//                coverView.alpha = 0.0;
//                UIView.animate(withDuration: 0.3, animations: {
//                    coverView.alpha = 0.7;
//                })
//                self.view.addSubview(coverView)
//            }
//        }
//        else{
//
//            let coverView = self.view.viewWithTag(9966)
//            UIView.animate(withDuration: 0.3, animations: {
//                coverView?.alpha = 0.0;
//            }, completion: { (true) in
//                coverView?.removeFromSuperview()
//            })
//        }
//    }
//}
