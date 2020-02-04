//
//  DetailDescriptionViewController.swift
//  MCA
//
//  Created by Goutham Devaraju on 21/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
//import AARatingBar
//import Kingfisher

class DetailDescriptionViewController: UIViewController {
    
    @IBOutlet weak var imageQuickInfo: UIImageView!
    @IBOutlet weak var topViewGrabOffers: UIView!
    
    @IBOutlet weak var btnContect2: UIButton!
    @IBOutlet weak var btnGrabOffer: UIButton!
    
    @IBOutlet weak var viewContant: UIView!
    @IBOutlet weak var viewContactshight: NSLayoutConstraint!
    
    @IBOutlet weak var viewGrabOffers: UIView!
    @IBOutlet weak var viewGrabhight: NSLayoutConstraint!

    //MARK: - Properties
    
    var selectedServiceID: Int!
    var imageURL: String!
    
    var backData = NSDictionary()
    
    var eventID = 0
    var proID = 0
    
    var backDataBusiness = NSDictionary()
    var backDataPromotions = NSDictionary()
    var backDataEvents = NSDictionary()
    var backDataOrganisations = NSDictionary()

    var categoryType: CategoryType!
    
    @IBOutlet var imageViewTop: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDescription: UITextView!
    @IBOutlet var labelLocation: UILabel!
    @IBOutlet var labelDays: UILabel!
    @IBOutlet var labelView: UILabel!
    @IBOutlet var ratingView: AARatingBar!
    
    @IBOutlet var viewGradiant: DetailDescriptionGradiant!
    @IBOutlet var viewDescriptionBackground: UIView!
    @IBOutlet var buttonContact: UIButton!
    
    @IBOutlet var viewReport: UIView!
    @IBOutlet var buttonReport: UIButton!
    @IBOutlet var buttonCancel: UIButton!
    
    var viewOverlay: UIView!
    var activityIndicator: UIActivityIndicatorView!
    
    var presenterDetailDescription: DetailDescriptionPresenterImplementation!
    
    @IBOutlet weak var lblReportTitleHeder: UILabel!
    
    
    @IBOutlet weak var btnAddtoWalletOutlet: UIButton!
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topViewGrabOffers.isHidden = true
        
        if categoryType == CategoryType.promotions {

            viewContactshight.constant = 0
            viewGrabhight.constant = 64
            
            viewContant.isHidden = true
            viewGrabOffers.isHidden = false
            
            btnGrabOffer.setTitle("Grab Offer", for: .normal)
            imageQuickInfo.image = UIImage(named: "info_green")

        } else if categoryType == CategoryType.events {
            
            viewContactshight.constant = 0
            viewGrabhight.constant = 64

            viewContant.isHidden = true
            viewGrabOffers.isHidden = false
            
            btnGrabOffer.setTitle("Join the Event", for: .normal)
            imageQuickInfo.image = UIImage(named: "info_blue")

            
        } else {
            
            viewContactshight.constant = 64
            viewGrabhight.constant = 0

            viewContant.isHidden = false
            viewGrabOffers.isHidden = true
        }
        
        print("categoryType >>>>>>>>>>: \(categoryType)")
        print("selectedServiceID >>>>>>>>>>: \(selectedServiceID)")

        // Do any additional setup after loading the view.
        configureGradiantView()
        configureShadows()
        
        createPresenterInstance()
        fetchBusinessIndividualDetails()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailDescriptionViewController.viewHideOnTap))
        
        topViewGrabOffers.addGestureRecognizer(tap)
        
        setReportTitleHeder()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchBusinessIndividualDetails()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchBusinessIndividualDetails()
    }
    
    func setReportTitleHeder() {
        
        if categoryType == CategoryType.business {
            
            lblReportTitleHeder.text = "Do you want to report this Business listing?"
            
        } else if categoryType == CategoryType.events {
            
            lblReportTitleHeder.text = "Do you want to report this Event listing?"
            
        } else if categoryType == CategoryType.promotions {
            
            lblReportTitleHeder.text = "Do you want to report this Offer listing?"

            
        } else if categoryType == CategoryType.organisations {
            
            lblReportTitleHeder.text = "Do you want to report this Organisations listing?"

        } else {
            lblReportTitleHeder.text = "Do you want to report this Business listing?"
        }
    }
    
    @objc func viewHideOnTap() {
        topViewGrabOffers.isHidden = true
    }
        
    //MARK: - Other Methods
    
    func createPresenterInstance() {
        let presenterObj = DetailDescriptionPresenterImplementation(viewController: self)
        presenterDetailDescription = presenterObj
    }
    
    func configureShadows(){
        buttonContact.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewDescriptionBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
    }
    
    func configureGradiantView()  {
        viewGradiant.colors = [UIColor.black.withAlphaComponent(1.0), UIColor.clear]
    }
    
    func configureRatingView(ratingValue: Float){
        DispatchQueue.main.async {
            self.ratingView.value = CGFloat(ratingValue)
        }
    }
    
    func animateViewReport(){
        
        viewOverlay = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        viewOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.addSubview(viewOverlay)
        
        let initialYaxis = view.frame.height+30
        let height = view.frame.height/2+200, width = view.frame.width, xAxis = 0
        viewReport.frame = CGRect(x: CGFloat(xAxis), y: initialYaxis, width: width, height: height)
        viewOverlay.addSubview(viewReport)
        
        UIView.animate(withDuration:1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5,
                       options: .transitionCurlUp,
                       animations: {
                        
                        //Do all animations here
                        let height = self.view.frame.height/2+200, width = self.view.frame.width, xAxis = 0, yAxis = height/1.3
                        self.viewReport.frame = CGRect(x: CGFloat(xAxis), y: yAxis, width: width, height: height)
                        
        }, completion: { (value: Bool) in })
    }
    
    func fetchBusinessIndividualDetails(){
        
        presenterDetailDescription.fetchBusinessIndividualDetails(serviceid: selectedServiceID, categoryType: categoryType)
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
        if segue.identifier == "detailsToContact" {
            let viewController:ContactUsViewController = segue.destination as! ContactUsViewController
            viewController.selectedServiceID = selectedServiceID
            viewController.imageURL = imageURL
            viewController.categoryType = categoryType
        }
        
        if segue.identifier == "detailsToReport" {
            let viewController:ReportViewController = segue.destination as! ReportViewController
            viewController.selectedService_ID = selectedServiceID
            viewController.categoryType = categoryType
            
            if categoryType == CategoryType.business{
               viewController.businessIndividualModel = presenterDetailDescription.businessIndividualModel
                viewController.selectedService_ID = selectedServiceID
            } else if categoryType == CategoryType.events{
                viewController.eventsIndividualModel = presenterDetailDescription.eventsIndividualModel
                viewController.selectedService_ID = selectedServiceID

                
            } else if categoryType == CategoryType.promotions{
                viewController.promotionsIndividualModel = presenterDetailDescription.promotionsIndividualModel
                viewController.selectedService_ID = selectedServiceID

                
            } else if categoryType == CategoryType.organisations{
                
                viewController.organisationsIndividualModel = presenterDetailDescription.organisationsIndividualModel
                viewController.selectedService_ID = selectedServiceID


            } else {
                return
            }
            
        }
        
        if segue.identifier == "seguetoWeb" {
            if let vc = segue.destination as? WebVC {
                vc.dicdata = sender as? NSDictionary ?? [:]
            }
        }
        
        if segue.identifier == "segueToGrabOffers" {
            if let vc = segue.destination as? GrabOffers {
                vc.discountOfferID = selectedServiceID
                vc.categoryType = categoryType
                vc.DetailDescriptionViewControllerObj = self
            }
        }
        
    }
    
    //MARK: - Button Events
    @IBAction func contactEvent(_ sender: Any) {
        
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
        } else {
            
            performSegue(withIdentifier: "detailsToContact", sender: self)

        }
        
//        print("Contact Event")
        
    }
    
    @IBAction func backButtonEvent(_ sender: Any) {
        print("Back event")
        
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reportButtonEvent(_ sender: Any) {
        print("Report button event")
        
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
        } else {
            
          animateViewReport()
            
        }
    }
    
    @IBAction func btnDisclaimerEvent(_ sender: UIButton) {
        
//        if _ = Html.disclaimer() {
        
            let dic:NSDictionary = [ "title": "Disclaimer",
                                     "apiUrl" : Html.disclaimer(),
                                     "istype" : "html"]
            performSegue(withIdentifier: "seguetoWeb", sender: dic)
            
//            UIApplication.shared.open(url)
//            print(url)
//        }
        
//   let url2 = URL(string: "http://yellowapp.co.uk/disclaimer.html")
//        print(url2)
//
        
    }
    
    @IBAction func addToWalletEvent(_ sender: Any) {
        print("Add to wallet function")
        
//        if sender.isselect
        
        if (UserDefaults.standard.value(forKey: key_user_id) != nil) {
            
            let user_id_cached = UserDefaults.standard.value(forKey: key_user_id) as! Int
            print(user_id_cached,categoryType)

            if categoryType == CategoryType.business{
                
                if let serviceDtaa = presenterDetailDescription.businessIndividualModel {
                   
                    if btnAddtoWalletOutlet.isSelected == true {
//                    if serviceDtaa.IsWallet?.uppercased() == "TRUE" {

                        if let service_id = selectedServiceID {
                            self.presenterDetailDescription.removeToToWallet(categoryType: .business, service_id: service_id, user_id: user_id_cached)
                        } else {

                        }
                        
                    } else if btnAddtoWalletOutlet.isSelected == false {

//                    } else if serviceDtaa.IsWallet?.uppercased() == "FALSE"{

                        if let service_id = selectedServiceID {
                            self.presenterDetailDescription.addBusinessToWallet(service_id: service_id, user_id: user_id_cached, eventID: eventID, proID: proID, categoryType: categoryType)
                        } else{

                        }

                    }
                }
                
            } else if categoryType == CategoryType.events{
                
                if let serviceDtaa = presenterDetailDescription.eventsIndividualModel {
                    
                    if serviceDtaa.IsWallet?.uppercased() == "TRUE" {
                        
                        if let service_id = selectedServiceID {
                            self.presenterDetailDescription.removeToToWallet(categoryType: .events, service_id: service_id, user_id: user_id_cached)
                        } else {
                            
                        }
                        
                    } else if serviceDtaa.IsWallet?.uppercased() == "FALSE"{
                        
                        if let service_id = selectedServiceID{
                            self.presenterDetailDescription.addBusinessToWallet(service_id: service_id, user_id: user_id_cached, eventID: eventID, proID: proID, categoryType: categoryType)
                        } else{
                            
                        }
                        
                    }
                }
            } else if categoryType == CategoryType.organisations{
                
                
                if let serviceDtaa = presenterDetailDescription.organisationsIndividualModel {
                    
                    if serviceDtaa.IsWallet?.uppercased() == "TRUE" {
                        
                        if let service_id = selectedServiceID {
                            self.presenterDetailDescription.removeToToWallet(categoryType: .organisations, service_id: service_id, user_id: user_id_cached)
                        } else {
                            
                        }
                        
                    } else if serviceDtaa.IsWallet?.uppercased() == "FALSE"{
                        
                        if let service_id = selectedServiceID{
                            self.presenterDetailDescription.addBusinessToWallet(service_id: service_id, user_id: user_id_cached, eventID: eventID, proID: proID, categoryType: categoryType)
                        } else{
                            
                        }
                        
                    }
                }
            } else if categoryType == CategoryType.promotions{
              
                if let serviceDtaa = presenterDetailDescription.promotionsIndividualModel {
                    
                    if serviceDtaa.IsWallet?.uppercased() == "TRUE" {
                        
                        if let service_id = selectedServiceID {
                            self.presenterDetailDescription.removeToToWallet(categoryType: .promotions, service_id: service_id, user_id: user_id_cached)
                        } else {
                            
                        }
                        
                    } else if serviceDtaa.IsWallet?.uppercased() == "FALSE"{
                        
                        if let service_id = selectedServiceID{
                            self.presenterDetailDescription.addBusinessToWallet(service_id: service_id, user_id: user_id_cached, eventID: eventID, proID: proID, categoryType: categoryType)
                        } else{
                            
                        }
                        
                    }
                }
            } else {
                
                
                
            }
            
//            if presenterDetailDescr
            

//            if let service_id = selectedServiceID{
//                presenterDetailDescription.addBusinessToWallet(service_id: service_id, user_id: user_id_cached, eventID: eventID, proID: proID, categoryType: categoryType)
//            }
//            else{
//                print("Unable to add to wallet")
//            }
        }
        
        else if user_is_Login == false {
            
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
        } else {
            
        }
    }
    
    @IBAction func reportEvent(_ sender: Any) {
        
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
        } else {
            
            print("Button report event")
            
            UIView.animate(withDuration: 0.2, animations: {
                //Do all animations here
                let height = self.view.frame.height/2+200, width = self.view.frame.width, xAxis = 0, yAxis = self.view.frame.height
                self.viewReport.frame = CGRect(x: CGFloat(xAxis), y: yAxis, width: width, height: height)
            }, completion: { _ in
                self.viewReport.removeFromSuperview()
            })
            
            
            //(isCompleted: Bool)
            UIView.animate(withDuration: 0.2, animations: {
                self.viewOverlay.alpha = 0
            }, completion: { _ in
                self.viewOverlay.removeFromSuperview()
            })
            
            
            performSegue(withIdentifier: "detailsToReport", sender: nil)
        }
        
        
       
    }
    
    @IBAction func cancelReportingEvent(_ sender: Any) {
        print("Button cancel event")
        
        UIView.animate(withDuration: 0.2, animations: {
            //Do all animations here
            let height = self.view.frame.height/2+200, width = self.view.frame.width, xAxis = 0, yAxis = self.view.frame.height
            self.viewReport.frame = CGRect(x: CGFloat(xAxis), y: yAxis, width: width, height: height)
        }, completion: { _ in
            self.viewReport.removeFromSuperview()
        })
        
        //(isCompleted: Bool)
        UIView.animate(withDuration: 0.2, animations: {
            self.viewOverlay.alpha = 0
        }, completion: { _ in
            self.viewOverlay.removeFromSuperview()
        })
    }
    
    @IBAction func btnGrabOffersEvent(_ sender: UIButton) {
        
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
        } else {
        
            topViewGrabOffers.isHidden = false
            
        }
        
    }
    
    @IBAction func btnGrabOffersContinueEvent(_ sender: UIButton) {
        
        performSegue(withIdentifier: "segueToGrabOffers", sender: self)
        topViewGrabOffers.isHidden = true

        
    }
}

extension DetailDescriptionViewController: DetailDescriptionViewProtocol{
    
    func responseEventsIndividualData(businessModel: EventsIndividualModel) {
        //Plot values here from model
        if let title = businessModel.Title{
            labelTitle.text = title
        }
        
        if let description = businessModel.Description {
            labelDescription.text = description
        }
        
        if let views = businessModel.Views {
            labelView.text = views == 1 || views == 0 ? "\(views) view" : "\(views) views"
        }
        
        if let location_string = businessModel.Location{
            labelLocation.text = location_string
        }
        
        if let isAddtocard = businessModel.IsWallet {
            if isAddtocard == "True" || isAddtocard == "true" {
                btnAddtoWalletOutlet.isSelected = true
            } else{
                btnAddtoWalletOutlet.isSelected = false
            }
        }
        
        if let image = businessModel.Image{
            let url = URL(string: image)
            imageViewTop.kf.setImage(with: url)
            
            imageURL = image
        }
        
        if let created_Date = businessModel.Created_Datetime{
            
            if created_Date == nil || created_Date.count == 0 || created_Date == "" {
                //                labelDays.text = "\(0) day"
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            let date = dateFormatter.date(from:created_Date)!
            
            if let days = Calendar.current.dateComponents([.day], from: date, to: Date()).day {
                labelDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
            }
            else{
                labelDays.text = "- - days"
            }
        }
        
        ratingView.value = CGFloat(businessModel.Rating ?? Int(0.0))

       
    }
    
    func responsePromotionsIndividualData(businessModel: PromotionsIndividualModel) {
        //Plot values here from model
        if let title = businessModel.Title{
            labelTitle.text = title
        }
        
        if let description = businessModel.Description{
            labelDescription.text = description
        }
        
        if let views = businessModel.Views{
            labelView.text = views == 1 || views == 0 ? "\(views) view" : "\(views) views"

        }
        
        if let location_string = businessModel.Location{
            labelLocation.text = location_string
        }
        
        
        if let image = businessModel.Image{
            let url = URL(string: image)
            imageViewTop.kf.setImage(with: url)
            
            //Storing for sending to next viewController
            imageURL = image
        }
        
        if let isAddtocard = businessModel.IsWallet {
            if isAddtocard.uppercased() == "TRUE" {
                btnAddtoWalletOutlet.isSelected = true
            } else{
                btnAddtoWalletOutlet.isSelected = false
            }
        }
        
        if let created_Date = businessModel.Created_Datetime{
            
//            print(created_Date)
            
            if created_Date == nil || created_Date.count == 0 || created_Date == "" {
//                labelDays.text = "\(0) day"
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            let date = dateFormatter.date(from:created_Date)!
            
            if let days = Calendar.current.dateComponents([.day], from: date, to: Date()).day {
                labelDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
            }
            else {
                labelDays.text = "- - days"
            }
        }
        
        ratingView.value = CGFloat(businessModel.Rating ?? Int(0.0))

        

    }
    
    func responseOrganisationsIndividualData(businessModel: OrganisationIndividualModel) {
        //Plot values here from model
        if let title = businessModel.Title{
            labelTitle.text = title
        }
        
        if let description = businessModel.Description{
            labelDescription.text = description
        }
        
        if let views = businessModel.Views{
            labelView.text = views == 1 || views == 0 ? "\(views) view" : "\(views) views"
        }
        
        if let location_string = businessModel.Location{
            labelLocation.text = location_string
        }
        
        if let ratings = businessModel.Rating{
            configureRatingView(ratingValue: ("\(ratings)" as NSString).floatValue)
        }
        
        if let image = businessModel.Image{
            let url = URL(string: image)
            imageViewTop.kf.setImage(with: url)
            
            //Storing for sending to next viewController
            imageURL = image
        }
        
        
        if let isAddtocard = businessModel.IsWallet {
            if isAddtocard.uppercased() == "TRUE" {
                btnAddtoWalletOutlet.isSelected = true
            } else{
                btnAddtoWalletOutlet.isSelected = false
            }
        }
        
        if let created_Date = businessModel.Created_Datetime{
            
            if created_Date == nil || created_Date.count == 0 || created_Date == "" {
                //                labelDays.text = "\(0) day"
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            let date = dateFormatter.date(from:created_Date)!
            
            if let days = Calendar.current.dateComponents([.day], from: date, to: Date()).day {
                labelDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
            }
            else{
                labelDays.text = "- - days"
            }
        }
        
        ratingView.value = CGFloat(businessModel.Rating ?? Int(0.0))

    }
    
    func responseBusinessIndividualData(businessModel: BusinessIndividualModel) {
        
        
        
        //Plot values here from model
        
//        if businessModel.IsWallet == true {
//            self.btnAddtoWalletOutlet.isSelected = true
//        } else{
////            btnAddtoWalletOutlet.isSelected == false
//        }
        
        if let title = businessModel.Title {
            labelTitle.text = title
        }
        
        if let description = businessModel.Description {
            labelDescription.text = description
        }
        
        if let views = businessModel.Views{
            labelView.text = views == 1 || views == 0 ? "\(views) view" : "\(views) views"
        }
        
        if let location_string = businessModel.Location{
            labelLocation.text = location_string
        }
        
        if let ratings = businessModel.rating{
            configureRatingView(ratingValue: ("\(ratings)" as NSString).floatValue)
        }
        
        if let image = businessModel.Image{
            let url = URL(string: image)
            imageViewTop.kf.setImage(with: url)
            
            //Storing for sending to next viewController
            imageURL = image
        }
        
        if let isAddtocard = businessModel.IsWallet {
            if isAddtocard.uppercased() == "TRUE" {
                btnAddtoWalletOutlet.isSelected = true
            } else{
                btnAddtoWalletOutlet.isSelected = false
            }
        }
        
        if let created_Date = businessModel.Created_Datetime{
            
            if created_Date == nil || created_Date.count == 0 || created_Date == "" {
                //                labelDays.text = "\(0) day"
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            let date = dateFormatter.date(from:created_Date)!
            
            if let days = Calendar.current.dateComponents([.day], from: date, to: Date()).day {
                labelDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
            }
            else {
                labelDays.text = "- - days"
            }
        }
        
        ratingView.value = CGFloat(businessModel.rating ?? Int(0.0))
        
    }
    
    
    
    
    func responseAddWallet(addWalletModel: AddWalletModel) {
        
        //Do something with the reponse
        
        print(addWalletModel)
        
        let messgae = addWalletModel.Message
        if addWalletModel.isSuccess == true {
            
            self.btnAddtoWalletOutlet.isSelected = true

            self.showToast(message: messgae ?? "", font: UIFont.systemFont(ofSize: 16.0))

            self.fetchBusinessIndividualDetails()

//
//            let alert = UIAlertController(title: "Alert", message: messgae ?? "", preferredStyle: UIAlertController.Style.alert)
//            // add an action (button)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
//
//                self.fetchBusinessIndividualDetails()
//            }))
            // show the alert
//            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            self.showToast(message: messgae ?? "", font: UIFont.systemFont(ofSize: 16.0))
            
//            let alert = UIAlertController(title: "Alert", message: messgae ?? "", preferredStyle: UIAlertController.Style.alert)
//
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
//            }))
//            // show the alert
//            self.present(alert, animated: true, completion: nil)
            
        }
            
//        if  {
//            AppManager.shared.showOkAlert(title: "Alert", message: messgae, onCompletion: { (callBackString: String) in })
//        }
//
        
//        if addWalletModel.isSuccess! {
//            print(addWalletModel)
//            btnAddtoWalletOutlet.isSelected = true
//        }
    }
    
    
    func responseRemoveWallet(addWalletModel: RemoveWalletModel) {
        
        //Do something with the reponse
        
        print(addWalletModel)
        
        let messgae = addWalletModel.Message
        if addWalletModel.isSuccess == true {
            
            self.btnAddtoWalletOutlet.isSelected = false
            self.showToast(message: messgae ?? "", font: UIFont.systemFont(ofSize: 16.0))
            self.fetchBusinessIndividualDetails()
            

//            let alert = UIAlertController(title: "Alert", message: messgae ?? "", preferredStyle: UIAlertController.Style.alert)
//            // add an action (button)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
//
//                self.fetchBusinessIndividualDetails()
//
//                // do something like...
//                //                self.navigationController?.popViewController(animated: true)
//            }))
//            // show the alert
//            self.present(alert, animated: true, completion: nil)
        } else {
            
            self.showToast(message: messgae ?? "", font: UIFont.systemFont(ofSize: 16.0))

//            let alert = UIAlertController(title: "Alert", message: messgae ?? "", preferredStyle: UIAlertController.Style.alert)
//
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
//            }))
//            // show the alert
//            self.present(alert, animated: true, completion: nil)
            
        }
        
        //        if  {
        //            AppManager.shared.showOkAlert(title: "Alert", message: messgae, onCompletion: { (callBackString: String) in })
        //        }
        //
        
        //        if addWalletModel.isSuccess! {
        //            print(addWalletModel)
        //            btnAddtoWalletOutlet.isSelected = true
        //        }
    }
    
    
}

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}
