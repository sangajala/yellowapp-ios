//
//  FavouriteViewController.swift
//  MCA
//
//  Created by Goutham Devaraju on 03/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FavouriteViewController: ButtonBarPagerTabStripViewController {

//    MARK: - Properties
    
//    @IBOutlet var tableviewFavBusinesses: UITableView!
//    @IBOutlet var viewSegmentController: WMSegment!
    
    var selectedBusinessID: Int!
    var presenterFavourites: FavouritesPresenterImplementation!
    
    //MARK: - ViewController Life Cycle
    
    let arrayCategoury = NSMutableArray()
    let arrayCategoryIdentifires = ["services", "events", "discounts", "intrest"]
    var currentChildViewController = UIViewController()
    
    let childVCArray = NSMutableArray()

    override func viewDidLoad() {
        
        arrayCategoury.removeAllObjects()
        print(arrayCategoury)
        
        arrayCategoury.add("SERVICES")
        arrayCategoury.add("EVENTS")
        arrayCategoury.add("OFFERS") // DISCOUNTS AND
        arrayCategoury.add("PLACES OF INTEREST")
        print(arrayCategoury)
        
//        CategoryVC_obj = self
//         change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = UIColor.init(named: "ButtonColor")!
         //COLOR_PRIMARY_TEXT_COLOR
//        settings.style.buttonBarItemFont = UIFont.init(name: "Montserrat-Light", size: 15)!//UIFont.init(name: "Montserrat-Light", size: 15)!
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
//            oldCell?.label.textColor = .black
//            oldCell?.label.font = UIFont.init(name: "Montserrat-Light", size: 15)!
            oldCell?.label.textColor = UIColor.init(named: "HeadingTextColor") //COLOR_ACCENT_TEXT_COLOR
            newCell?.label.textColor = UIColor.black //COLOR_PRIMARY_TEXT_COLOR
//            newCell?.label.font = UIFont.init(name: "Montserrat-Regular", size: 15)!

            // Ben10 print("newCell?.label.text)
            if newCell != nil {
                
                // let index = self!.arrayCategoury.index(of: newCell?.label.text ?? "")

                let index = self?.index(of: (newCell?.label.text ?? ""), array: self!.arrayCategoury)
                
                if index != 9999 {
                    
                    if let vc = self!.childVCArray[index!] as? PagesVC {
                        vc.ReloadFunction(index: index!)
                        vc.favouritesVC = self
                        self!.currentChildViewController  = vc
                    }
                }

            }
        
              // Ben10 print(""index = \(index)")
            
            
//            if newCell?.label.text != "DELI MEATS" {
//                self!.btnListgrid.isHidden = true
//            }
//            else {
//                self!.btnListgrid.isHidden = false
//            }
        }
        
        super.viewDidLoad()
        
        dataSetup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dataSetup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        dataSetup()
        
    }
    
    func dataSetup(){
        
        self.containerView.isScrollEnabled = false
        
        AppManager.shared.printLog(stringToPrint: "FavouriteViewController")
        
        if user_is_Login == false {
            
            helper.showAlertOKCancelAction(appName, "User is not Login", self, successClosure: { (login) in
                
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationLogin") as? UINavigationController {
                    UserDefaults.standard.set(true, forKey: key_is_present_to_login)
                    self.present(vc, animated: true, completion: nil)
                } else{
                    mainTabbarObj.selectedIndex = 0
                }
                
            }) { (skip) in
                mainTabbarObj.selectedIndex = 0
            }
            return
        } else {
            
            createPresenterInstanceAndFetchFavouritesBusiness()
            
        }
    }
    
    func relodePagesVC() {
        if let pagesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PagesVC") as? PagesVC {
            pagesVC.favouritesVC = self
            pagesVC.ReloadFunction(index: 0)
        }
    }
    
    func index(of : String, array : NSArray) -> Int {
        var index = 9999
        for i in 0 ..< array.count {
            if array[i] as! String == of {
                index = i
                break
            }
        }
        
        return index
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
//        if childVCArray.count == 0 {
//            let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PagesVC")
//            childVCArray.add(child_1)
//        } else{
        
        print(arrayCategoury)
        
        childVCArray.removeAllObjects()
        
        for i in 0 ..< 4 {
            print(arrayCategoury[i] as! String)
            let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PagesVC") as! PagesVC
            child_1.titleString = arrayCategoury[i] as! String
            child_1.restorationIdentifier = arrayCategoryIdentifires[i]
            childVCArray.add(child_1)
        }

        return childVCArray as! [UIViewController]
    }
    
    

        
//        AppManager.shared.printLog(stringToPrint: "FavouriteViewController")

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
////                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
////                let appDelegate = UIApplication.shared.delegate as! AppDelegate
////                appDelegate.window?.rootViewController = testController
//
//            }) { (skip) in
//
////                mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//                mainTabbarObj.selectedIndex = 0
//
//                //                let application = UIApplication.shared.delegate as! AppDelegate
//                //                let tabbarController =
//                //                //application.tabBarController as UITabBarController
//                //                let selectedIndex = tabBarController.selectedIndex
//
//
//            }
//
//            return
//        } else {
        
//             createPresenterInstanceAndFetchFavouritesBusiness()
        
//            fetchFavourites()
//        }
    
//    }
    
    //MARK: - Other Methods
    
    func fetchFavourites(){
        
        if user_is_Login == false {
            return
        }
        
        if (UserDefaults.standard.value(forKey: key_user_id) != nil){
            
            let user_id_cached = UserDefaults.standard.value(forKey: key_user_id) as! Int
            presenterFavourites.fetchBusinessFavourites(user_id: user_id_cached)
            presenterFavourites.fetchBusinessFavourites_Event(user_id: user_id_cached)
            presenterFavourites.fetchBusinessFavourites_Promotions(user_id: user_id_cached)
            presenterFavourites.fetchBusinessFavourites_Organization(user_id: user_id_cached)
        }
        else{
            
            print("Unable to fetch favourite business")
        }
    }
    
    @IBAction func btnBackEvent(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
//        mainTabbarObj.selectedIndex = 0

    }
}

extension FavouriteViewController: FavouriteViewProtocol {
    
    func createPresenterInstanceAndFetchFavouritesBusiness() {
        
        let presenterObj = FavouritesPresenterImplementation(viewController: self)
        presenterFavourites = presenterObj
        fetchFavourites()
        
    }
    
    func responseFavouriteBusiness(businessModel: BusinessModel) {
        
//        print(AppManager.shared.businessModel)
//        print(businessModel)

        AppManager.shared.businessModel = businessModel
        
        if let vc = self.viewControllers[0] as? PagesVC {
            vc.businessModel = businessModel.ServicesList
            vc.favouritesVC = self
            DispatchQueue.main.async {
                vc.tableview?.reloadData()
            }
        }
       
    }
    
    func responseFavouriteBusiness_Event(eventsModel: EventsModel) {
        
        AppManager.shared.eventsModel = eventsModel
        
        if let vc = self.viewControllers[1] as? PagesVC {
        vc.eventsModel = eventsModel.EventsList
        vc.favouritesVC = self

        DispatchQueue.main.async {
            vc.tableview?.reloadData()
          }
        }
    }
    
    func responseFavouriteBusiness_Promotions(promotionsModel: PromotionsModel) {
        
        AppManager.shared.promotionsModel = promotionsModel
        
        if let vc = self.viewControllers[2] as? PagesVC {
        vc.promotionsModel = promotionsModel.PromotionsList
        vc.favouritesVC = self

        DispatchQueue.main.async {
            vc.tableview?.reloadData()
         }
        }
    }
    
    func responseFavouriteBusiness_Origanisation(organisationsModel: OrganisationModel) {
        
//        print(AppManager.shared.organisationsModel)
        AppManager.shared.organisationsModel = organisationsModel
//        print(AppManager.shared.organisationsModel)

        if let vc = self.viewControllers[3] as? PagesVC {
        vc.organisationsModel = organisationsModel.OrganisationsList
        vc.favouritesVC = self

        DispatchQueue.main.async {
            vc.tableview?.reloadData()
          }
        }
    }
    
}

