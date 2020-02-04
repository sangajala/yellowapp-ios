//
//  ContactUsViewController.swift
//  MCA
//
//  Created by Goutham Devaraju on 27/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices
import Kingfisher
import MapKit

class ContactUsViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    //MARK: - Properties
    
    var selectedServiceID: Int!
    var imageURL : String!
    
    var categoryType: CategoryType!
    
    var presenterContactUs: ContactUsPresenterImplementation!
    
    @IBOutlet var viewNavigation: UIView!
    
    var lat = String()
    var long = String()

    @IBOutlet var viewCall: UIView!
    @IBOutlet var viewMail: UIView!
    @IBOutlet var viewMessgae: UIView!
    @IBOutlet var viewWeb: UIView!
    @IBOutlet var viewWhatsapp: UIView!
    @IBOutlet var viewShare: UIView!
    
    @IBOutlet weak var lblAddressTitle: UILabel!
    @IBOutlet var labelAddress: UILabel!
    
    var hasTopNotch: Bool {
        if #available(iOS 11.0,  *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        
        return false
    }
    
    @IBOutlet weak var viewNolocationFound: UIView!
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureShadows()
        createPresenterInstance()
        fetchContactUsDetails()
        
        viewNolocationFound.isHidden = true
        
    }
    
    //MARK: - Other Methods
    
    func createPresenterInstance(){
        let presenterObj = ContactUsPresenterImplementation(viewController: self)
        presenterContactUs = presenterObj
    }
    
    func configureShadows(){
        
        if !hasTopNotch{
            viewNavigation.translatesAutoresizingMaskIntoConstraints = true
            viewNavigation.frame = CGRect(x: viewNavigation.frame.origin.x, y: -215, width: view.frame.width, height: viewNavigation.frame.height)
        }
        
        viewCall.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewMail.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewMessgae.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewWeb.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewWhatsapp.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewShare.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
    }
    
    func fetchContactUsDetails() {
        
        if (UserDefaults.standard.value(forKey: key_user_id) != nil){
            
            let user_id_cached = UserDefaults.standard.value(forKey: key_user_id) as! Int
            
            if let service_id = selectedServiceID {
                presenterContactUs.fetchContactDetails(forService_id: service_id, user_id: user_id_cached)
            }
            else {
                print("Unable to fetch ContactUs details")
            }
        }
    }
    
    //MARK: - Button Events
    
    @IBAction func btnOpenMapAddress(_ sender: UIButton) {
        if lat != "0.0" && long != "0.0" && lat != "0.00" && long != "0.00" {
            if let url = "http://maps.apple.com/maps?saddr=\(lat),\(long)" as? String {
                print("open url : \(url)")
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
            }
        } else {
            
        }
    }
    
    @IBAction func backButtonEvent(_ sender: Any) {
        navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func callButtonEvent(_ sender: Any) {
        
        if categoryType == CategoryType.business{
            if let phoneNumber = presenterContactUs.contactUsModel.Phone{
                phoneNumber.makeAColl()
            }
        }
        else if categoryType == CategoryType.events{
            if let phoneNumber = presenterContactUs.contactUsEventsModel.Phone{
                phoneNumber.makeAColl()
            }
        }
        else if categoryType == CategoryType.promotions{
            if let phoneNumber = presenterContactUs.contactUsPromotionsModel.Phone{
                phoneNumber.makeAColl()
            }
        }
        else{
            if let phoneNumber = presenterContactUs.contactUsOrganisationsModel.Phone{
                phoneNumber.makeAColl()
            }
        }
        
    }
    
    @IBAction func mailButtonEvent(_ sender: Any) {
        
        if categoryType == CategoryType.business{
            if let email = presenterContactUs.contactUsModel.Email{
                
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients([email])
                    mail.setMessageBody("", isHTML: true)
                    
                    present(mail, animated: true)
                } else {
                    // show failure alert
                    AppManager.shared.showOkAlert(title: "Mail configuration not found", message: "Please configure an email and try again.", view: self, onCompletion: { (callBackString: String) in })
                }
            }
            else{
                AppManager.shared.showOkAlert(title: "Email Not Found", message: "", view: self, onCompletion: { (callBackString: String) in })
            }
        }
        else if categoryType == CategoryType.events{
            if let email = presenterContactUs.contactUsEventsModel.Email{
                
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients([email])
                    mail.setMessageBody("", isHTML: true)
                    
                    present(mail, animated: true)
                } else {
                    // show failure alert
                    AppManager.shared.showOkAlert(title: "Mail configuration not found", message: "Please configure an email and try again.", view: self, onCompletion: { (callBackString: String) in })
                }
            }
            else{
                AppManager.shared.showOkAlert(title: "Email Not Found", message: "", view: self, onCompletion: { (callBackString: String) in })
            }
        }
        else if categoryType == CategoryType.promotions{
            if let email = presenterContactUs.contactUsPromotionsModel.Email{
                
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients([email])
                    mail.setMessageBody("", isHTML: true)
                    
                    present(mail, animated: true)
                } else {
                    // show failure alert
                    AppManager.shared.showOkAlert(title: "Mail configuration not found", message: "Please configure an email and try again.", view: self, onCompletion: { (callBackString: String) in })
                }
            }
            else{
                AppManager.shared.showOkAlert(title: "Email Not Found", message: "", view: self, onCompletion: { (callBackString: String) in })
            }
        }
        else{
            if let email = presenterContactUs.contactUsOrganisationsModel.Email{
                
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients([email])
                    mail.setMessageBody("", isHTML: true)
                    
                    present(mail, animated: true)
                } else {
                    // show failure alert
                    AppManager.shared.showOkAlert(title: "Mail configuration not found", message: "Please configure an email and try again.", view: self, onCompletion: { (callBackString: String) in })
                }
            }
            else{
                AppManager.shared.showOkAlert(title: "Email Not Found", message: "", view: self, onCompletion: { (callBackString: String) in })
            }
        }
        
        
       
    }
    
    @IBAction func messageButtonEvent(_ sender: Any) {
        
        if categoryType == CategoryType.business{
            if let phoneNumber = presenterContactUs.contactUsModel.Phone{
                
                let composeVC = MFMessageComposeViewController()
                composeVC.messageComposeDelegate = self
                
                // Configure the fields of the interface.
                composeVC.recipients = [phoneNumber]
                composeVC.body = ""
                
                // Present the view controller modally.
                if MFMessageComposeViewController.canSendText() {
                    self.present(composeVC, animated: true, completion: nil)
                } else {
                    AppManager.shared.showOkAlert(title: "Sending message is not supported", message: "", view: self, onCompletion: { (callBackString: String) in })
                }
                
            }
            else
            {
                AppManager.shared.showOkAlert(title: "Phone Number Not Found", message: "", view: self, onCompletion: { (callBackString: String) in })
            }
        }
        else if categoryType == CategoryType.events{
            if let phoneNumber = presenterContactUs.contactUsEventsModel.Phone{
                
                let composeVC = MFMessageComposeViewController()
                composeVC.messageComposeDelegate = self
                
                // Configure the fields of the interface.
                composeVC.recipients = [phoneNumber]
                composeVC.body = ""
                
                // Present the view controller modally.
                if MFMessageComposeViewController.canSendText() {
                    self.present(composeVC, animated: true, completion: nil)
                } else {
                    AppManager.shared.showOkAlert(title: "Sending message is not supported", message: "", view: self, onCompletion: { (callBackString: String) in })
                }
                
            }
            else
            {
                AppManager.shared.showOkAlert(title: "Phone Number Not Found", message: "", view: self, onCompletion: { (callBackString: String) in })
            }
        }
        else if categoryType == CategoryType.promotions{
            if let phoneNumber = presenterContactUs.contactUsPromotionsModel.Phone{
                
                let composeVC = MFMessageComposeViewController()
                composeVC.messageComposeDelegate = self
                
                // Configure the fields of the interface.
                composeVC.recipients = [phoneNumber]
                composeVC.body = ""
                
                // Present the view controller modally.
                if MFMessageComposeViewController.canSendText() {
                    self.present(composeVC, animated: true, completion: nil)
                } else {
                    AppManager.shared.showOkAlert(title: "Sending message is not supported", message: "", view: self, onCompletion: { (callBackString: String) in })
                }
                
            }
            else
            {
                AppManager.shared.showOkAlert(title: "Phone Number Not Found", message: "", view: self, onCompletion: { (callBackString: String) in })
            }
        }
        else{
            if let phoneNumber = presenterContactUs.contactUsOrganisationsModel.Phone{
                
                let composeVC = MFMessageComposeViewController()
                composeVC.messageComposeDelegate = self
                
                // Configure the fields of the interface.
                composeVC.recipients = [phoneNumber]
                composeVC.body = ""
                
                // Present the view controller modally.
                if MFMessageComposeViewController.canSendText() {
                    self.present(composeVC, animated: true, completion: nil)
                } else {
                    AppManager.shared.showOkAlert(title: "Sending message is not supported", message: "", view: self, onCompletion: { (callBackString: String) in })
                }
                
            }
            else
            {
                AppManager.shared.showOkAlert(title: "Phone Number Not Found", message: "", view: self, onCompletion: { (callBackString: String) in })
            }
        }
        
    }
    
    @IBAction func webButtonEvent(_ sender: Any) {
        
        if categoryType == CategoryType.business{
            if let url_to_redirect = presenterContactUs.contactUsModel.Website{
                
                if let url_to_redirect = URL(string: url_to_redirect){
                    
                    if UIApplication.shared.canOpenURL( url_to_redirect) {
                        
                        let safariViewController = SFSafariViewController(url: url_to_redirect)
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
                AppManager.shared.showOkAlert(title: "Alert", message: "Unable to open the link. Please try again.", view: self, onCompletion: {(callBack: String) in })
            }
        }
        else if categoryType == CategoryType.events{
            if let url_to_redirect = presenterContactUs.contactUsEventsModel.Website{
                
                if let url_to_redirect = URL(string: url_to_redirect){
                    
                    if UIApplication.shared.canOpenURL( url_to_redirect) {
                        
                        let safariViewController = SFSafariViewController(url: url_to_redirect)
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
                AppManager.shared.showOkAlert(title: "Alert", message: "Unable to open the link. Please try again.", view: self, onCompletion: {(callBack: String) in })
            }
        }
        else if categoryType == CategoryType.promotions{
            if let url_to_redirect = presenterContactUs.contactUsPromotionsModel.Website{
                
                if let url_to_redirect = URL(string: url_to_redirect){
                    
                    if UIApplication.shared.canOpenURL( url_to_redirect) {
                        
                        let safariViewController = SFSafariViewController(url: url_to_redirect)
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
                AppManager.shared.showOkAlert(title: "Alert", message: "Unable to open the link. Please try again.", view: self, onCompletion: {(callBack: String) in })
            }
        }
        else {
            if let url_to_redirect = presenterContactUs.contactUsOrganisationsModel.Website{
                
                if let url_to_redirect = URL(string: url_to_redirect){
                    
                    if UIApplication.shared.canOpenURL( url_to_redirect) {
                        
                        let safariViewController = SFSafariViewController(url: url_to_redirect)
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
                AppManager.shared.showOkAlert(title: "Alert", message: "Unable to open the link. Please try again.", view: self, onCompletion: {(callBack: String) in })
            }
        }
        
    }
    
    @IBAction func whatsappButtonEvent(_ sender: Any) {
        
        if presenterContactUs.contactUsModel == nil {
            return
        } else{
            
            if categoryType == CategoryType.business{
                if let phoneNumber = presenterContactUs.contactUsModel.Phone{
                    
                    let appURL = NSURL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
                    if UIApplication.shared.canOpenURL(appURL as URL) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
                        }
                        else {
                            UIApplication.shared.openURL(appURL as URL)
                        }
                    }
                    else {
                        AppManager.shared.showOkAlert(title: "Whatsapp not found", message: "", view: self, onCompletion: { (callBackString: String) in })
                    }
                }
                else{
                    AppManager.shared.showOkAlert(title: "Phone Number Not Found", message: "", view: self, onCompletion: { (callBackString: String) in })
                }
            }
            else if categoryType == CategoryType.events{
                
                if presenterContactUs.contactUsEventsModel.Phone == nil {
                    return
                } else{
                    
                    if let phoneNumber = presenterContactUs.contactUsEventsModel.Phone{
                        
                        let appURL = NSURL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
                        if UIApplication.shared.canOpenURL(appURL as URL) {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
                            }
                            else {
                                UIApplication.shared.openURL(appURL as URL)
                            }
                        }
                        else {
                            AppManager.shared.showOkAlert(title: "Whatsapp not found", message: "", view: self, onCompletion: { (callBackString: String) in })
                        }
                    }
                    else{
                        AppManager.shared.showOkAlert(title: "Phone Number Not Found", message: "", view: self, onCompletion: { (callBackString: String) in })
                    }
                }
                
                
            }
            else if categoryType == CategoryType.promotions {
                
                if presenterContactUs.contactUsPromotionsModel.Phone == nil {
                    return
                } else{
                    
                    if let phoneNumber = presenterContactUs.contactUsPromotionsModel.Phone {
                        
                        let appURL = NSURL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
                        if UIApplication.shared.canOpenURL(appURL as URL) {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
                            }
                            else {
                                UIApplication.shared.openURL(appURL as URL)
                            }
                        }
                        else {
                            AppManager.shared.showOkAlert(title: "Whatsapp not found", message: "", view: self, onCompletion: { (callBackString: String) in })
                        }
                    }
                    else{
                        AppManager.shared.showOkAlert(title: "Phone Number Not Found", message: "", view: self, onCompletion: { (callBackString: String) in })
                    }
                    
                }
                
                
            }
            else{
                if let phoneNumber = presenterContactUs.contactUsOrganisationsModel.Phone{
                    
                    let appURL = NSURL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
                    if UIApplication.shared.canOpenURL(appURL as URL) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
                        }
                        else {
                            UIApplication.shared.openURL(appURL as URL)
                        }
                    }
                    else {
                        AppManager.shared.showOkAlert(title: "Whatsapp not found", message: "", view: self, onCompletion: { (callBackString: String) in })
                    }
                }
                else{
                    AppManager.shared.showOkAlert(title: "Phone Number Not Found", message: "", view: self, onCompletion: { (callBackString: String) in })
                }
            }
            
        }
        
    }
    
    @IBAction func shareButtonEvent(_ sender: Any) {
        
        if categoryType == CategoryType.business{
            if let description = presenterContactUs.contactUsModel.Description, let title_ = presenterContactUs.contactUsModel.Title, let webSite = presenterContactUs.contactUsModel.Website{
                
                let shareText = " \(title_) \n\n\(description) \n\n \(webSite) "
                
                let url = URL(string: imageURL)
                
                UIImageView().kf.setImage(with: url) { result in
                    // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
                    switch result {
                    case .success(let value):
                        
                        let vc = UIActivityViewController(activityItems: [shareText, value.image], applicationActivities: [])
                        self.present(vc, animated: true)
                        
                    case .failure(let error):
                        print(error) // The error happens
                    }
                }
            }
        }
        else if categoryType == CategoryType.events{
            
//            let description = presenterContactUs.contactUsEventsModel.Description,
            
            if let title_ = presenterContactUs.contactUsEventsModel.Title, let webSite = presenterContactUs.contactUsEventsModel.Website{
                
//                let shareText = " \(title_) \n\n\(description) \n\n \(webSite) "
                let shareText = " \(title_) \n\n \(webSite) "
                
                let url = URL(string: imageURL)
                
                UIImageView().kf.setImage(with: url) { result in
                    // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
                    switch result {
                    case .success(let value):
                        
                        let vc = UIActivityViewController(activityItems: [shareText, value.image], applicationActivities: [])
                        self.present(vc, animated: true)
                        
                    case .failure(let error):
                        print(error) // The error happens
                    }
                }
            }
        }
        else if categoryType == CategoryType.promotions{
            
            if let title_ = presenterContactUs.contactUsPromotionsModel.Title, let webSite = presenterContactUs.contactUsPromotionsModel.Website{
                
                //                let shareText = " \(title_) \n\n\(description) \n\n \(webSite) "
                let shareText = " \(title_) \n\n \(webSite) "
                
                let url = URL(string: imageURL)
                
                UIImageView().kf.setImage(with: url) { result in
                    // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
                    switch result {
                    case .success(let value):
                        
                        let vc = UIActivityViewController(activityItems: [shareText, value.image], applicationActivities: [])
                        self.present(vc, animated: true)
                        
                    case .failure(let error):
                        print(error) // The error happens
                    }
                }
            }
        }
        else{
            if let description = presenterContactUs.contactUsOrganisationsModel.Description, let title_ = presenterContactUs.contactUsOrganisationsModel.Title, let webSite = presenterContactUs.contactUsOrganisationsModel.Website{
                
                let shareText = " \(title_) \n\n\(description) \n\n \(webSite) "
                
                let url = URL(string: imageURL)
                
                UIImageView().kf.setImage(with: url) { result in
                    // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
                    switch result {
                    case .success(let value):
                        
                        let vc = UIActivityViewController(activityItems: [shareText, value.image], applicationActivities: [])
                        self.present(vc, animated: true)
                        
                    case .failure(let error):
                        print(error) // The error happens
                    }
                }
            }
        }
    }
}

extension ContactUsViewController: ContactUsViewProtocol{
    
    func responseContactDetailsData(contactUsModel: ContactUsModel) {
        
        //Plot the values from contact model
        if let address = contactUsModel.Address1{
//            labelAddress.text = address
            labelAddress.attributedText = NSAttributedString(string: address, attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
        }
        
        lblAddressTitle.text = contactUsModel.Title
        
        let annotation = CustomPointAnnotation()
        
        if contactUsModel != nil {
            
            annotation.title = contactUsModel.Title ?? ""
           
            lat = contactUsModel.Latitude ?? ""
            long = contactUsModel.Longitude ?? ""
            
            if lat == "" {
                viewNolocationFound.isHidden = false
                return
            }
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: ((contactUsModel.Latitude! as NSString).doubleValue), longitude: ((contactUsModel.Longitude! as NSString).doubleValue))
            
            annotation.imageName = "business_map"
            mapView.addAnnotation(annotation)
            
            
            let viewRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: true)
            
            
            
            if lat != "" || lat != nil || lat != "<null>" || lat.count != 0 || long != "" || long != nil || long != "<null>" || long.count != 0{
                viewNolocationFound.isHidden = true
                
            } else{
                viewNolocationFound.isHidden = false
            }
            
            
            
        }
    }
    
    func responseEventsContactDetailsData(contactUsModel: ContactUsEventsModel){
        //Plot the values from contact model
        if let address = contactUsModel.Address1{
//            labelAddress.text = address
            labelAddress.attributedText = NSAttributedString(string: address, attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
        }
        
        lblAddressTitle.text = contactUsModel.Title

        
        let annotation = CustomPointAnnotation()
        
        if contactUsModel != nil {
            
            annotation.title = contactUsModel.Title ?? ""
            // 51.5074  0.1278
            // ((contactUsModel.Latitude! as NSString).doubleValue)
            // (contactUsModel.Longitude! as NSString).doubleValue)
            
            if (contactUsModel.Latitude! as NSString) != nil || (contactUsModel.Latitude! as NSString) != "<null>" || (contactUsModel.Longitude! as NSString) != nil || (contactUsModel.Longitude! as NSString) != "<null>"  {
                
                lat = contactUsModel.Latitude ?? ""
                long = contactUsModel.Longitude ?? ""
                
                if lat == "" {
                    viewNolocationFound.isHidden = false
                    return
                }

                
                annotation.coordinate = CLLocationCoordinate2D(latitude: ((contactUsModel.Latitude! as NSString).doubleValue), longitude: ((contactUsModel.Longitude! as NSString).doubleValue))
                
                annotation.imageName = "promo_map"
                mapView.addAnnotation(annotation)
                
                let viewRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
                mapView.setRegion(viewRegion, animated: true)
                
                
                if lat != "" || lat != nil || lat != "<null>" || lat.count != 0 || long != "" || long != nil || long != "<null>" || long.count != 0{
                    viewNolocationFound.isHidden = true
                    
                } else{
                    viewNolocationFound.isHidden = false
                }
                
                
            }
            

            
        }
    }
    
    func responsePromotionsContactDetailsData(contactUsModel: ContactUsPromotionsModel){
        //Plot the values from contact model
        if let address = contactUsModel.Address1{
//            labelAddress.text = address
            labelAddress.attributedText = NSAttributedString(string: address, attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
        }
        
        lblAddressTitle.text = contactUsModel.Title

        let annotation = CustomPointAnnotation()

        if contactUsModel != nil {
            
            annotation.title = contactUsModel.Title ?? ""
            
            lat = contactUsModel.Latitude ?? ""
            long = contactUsModel.Longitude ?? ""
            
            if lat == "" {
                viewNolocationFound.isHidden = false
                return
            }
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: ((contactUsModel.Latitude! as NSString).doubleValue), longitude: ((contactUsModel.Longitude! as NSString).doubleValue))
            annotation.imageName = "promo_map"
            mapView.addAnnotation(annotation)
            
            let viewRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: true)
            
            lat = contactUsModel.Latitude ?? ""
            long = contactUsModel.Longitude ?? ""
            
            if lat != "" || lat != nil || lat != "<null>" || lat.count != 0 || long != "" || long != nil || long != "<null>" || long.count != 0{
                viewNolocationFound.isHidden = true
                
            } else{
                viewNolocationFound.isHidden = false
            }
            
        }
        
    }
    
    func responseOrganisationsContactDetailsData(contactUsModel: ContactUsOrganisationsModel){
        //Plot the values from contact model
        if let address = contactUsModel.Address1{
//            labelAddress.text = address
            labelAddress.attributedText = NSAttributedString(string: address, attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
        }
        
        lblAddressTitle.text = contactUsModel.Title

        let annotation = CustomPointAnnotation()
        
        if contactUsModel != nil {
            
            annotation.title = contactUsModel.Title ?? ""
            
            lat = contactUsModel.Latitude ?? ""
            long = contactUsModel.Longitude ?? ""
            
            if lat == "" {
                viewNolocationFound.isHidden = false
                return
            }
            
            print(contactUsModel)
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: ((contactUsModel.Latitude! as NSString).doubleValue), longitude: ((contactUsModel.Longitude! as NSString).doubleValue))
            
            annotation.imageName = "promo_map"
            mapView.addAnnotation(annotation)
            
            let viewRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: true)
            
            lat = contactUsModel.Latitude ?? ""
            long = contactUsModel.Longitude ?? ""
            
            if lat != "" || lat != nil || lat != "<null>" || lat.count != 0 || long != "" || long != nil || long != "<null>" || long.count != 0{
                viewNolocationFound.isHidden = true
                
            } else{
                viewNolocationFound.isHidden = false
            }
        }
        
    }
}

extension ContactUsViewController: MFMailComposeViewControllerDelegate{
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}

extension ContactUsViewController: MFMessageComposeViewControllerDelegate{
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
     
        dismiss(animated: true, completion: nil)
    }
}

//extension ContactUsViewController: SFSafariViewControllerDelegate{
//
//}


extension ContactUsViewController : MKMapViewDelegate {
    
        func setupLatLong() {
            
          

    }
    
//        print(allLocationArray)
//        if allLocationArray.count != 0 {
//
//            for location in allLocationArray {
//
//                let locationDic = location as? NSDictionary ?? [:]
//                let title = locationDic["title"] as? String ?? ""
//                let latitude = locationDic["latitude"] as? String ?? ""
//                let longitude = locationDic["longitude"] as? String ?? ""
//
//                let serviceType = locationDic["locationType"] as? String ?? ""
//
//                let annotation = CustomPointAnnotation()
//
//                print("latitude : \(latitude)")
//                print("longitude : \(longitude)")
//
//                if serviceType == "Services" {
//
//                    annotation.title = title
//                    annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 51.5074, longitude: Double(longitude) ?? 0.1278)
//                    annotation.imageName = "business_map"
//
//
//                }else if serviceType == "promotions" {
//
//                    annotation.title = title
//                    annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 51.5074, longitude: Double(longitude) ?? 0.1278)
//                    annotation.imageName = "promo_map"
//
//                }
//
//                if allLocationArray[0] as? NSDictionary ?? [:] == locationDic {
//                    let coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 51.5074, longitude: Double(longitude) ?? 0.1278)
//                    let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
//                    mapView.setRegion(viewRegion, animated: true)
//                }
//
//                mapView.addAnnotation(annotation)
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
    }
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//
//        print(view.annotation?.debugDescription as Any)
//
//        // refress to center position map
//        mapView.setCenter(CLLocationCoordinate2D(latitude: view.annotation?.coordinate.latitude ?? 0.0, longitude: view.annotation?.coordinate.longitude ?? 0.0), animated: true)
//
//        // get select let long
//        let latitude = view.annotation?.coordinate.latitude ?? 0.0
//        let longitude = view.annotation?.coordinate.longitude ?? 0.0
//
//        print("Select coordinate : \(latitude, longitude)")
//
//        var isTypeLocationArray = allLocationArray.filter {((($0 as! NSDictionary)["latitude"] as! String) == "\(latitude)") && (($0 as! NSDictionary)["longitude"] as! String) == "\(longitude)"}
//
//        print(isTypeLocationArray)
//
//        if isTypeLocationArray[0] != nil {
//            let locationType = (isTypeLocationArray[0] as! NSDictionary)["locationType"] as? String ?? ""
//
//            if locationType == "Services" {
//
//                if servicesListData != nil || self.servicesListData.servicesList.count != 0 {
//
//                    let promotionsListAll = servicesListData.servicesList
//
//                    let filteredLocation = promotionsListAll.filter { promotionsListAll in
//                        return ((promotionsListAll.latitude! as NSString).doubleValue == latitude && (promotionsListAll.longitude! as NSString).doubleValue == longitude)
//                    }
//
//                    //                    if filteredLocation[]
//                    //
//                    print("Search Found Data All: \(filteredLocation)")
//                    print("Search Found Data First Array : \(filteredLocation)")
//
//                    if filteredLocation[0] != nil && filteredLocation.count != 0 {
//
//                        self.viewLocationSelect.isHidden = false
//
//                        let url = URL(string: filteredLocation[0].image)
//                        imageLocation.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
//                        }
//
//                        lbltitleName.text = filteredLocation[0].title
//                        lblLocationName.text = filteredLocation[0].location
//                        //                lblitemStatusDays.text = selectData["title"] as? String ?? ""
//                        lblreviews.text = "\(filteredLocation[0].views)"
//                        viewRating.value = CGFloat(filteredLocation[0].rating)
//
//                        if (filteredLocation[0].createdDatetime).count != 0  {
//
//                            //2019-08-13T05:50:14.937
//                            let createdDate = filteredLocation[0].createdDatetime
//                            let isoDate = helper.StringDateToDate(dateString: createdDate, dateFormatte: "yyyy-MM-dd'T'HH:mm:ss.SSS")
//                            //                    let isoDate = he//"2016-04-14T10:44:00"
//                            print(isoDate)
//
//                            let dateFormatter = DateFormatter()
//                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
//                            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//                            let date = dateFormatter.date(from:createdDate)!
//                            //                    let a = dateFormatter.date(from: createdDate)
//
//                            let calendar = Calendar.current
//
//                            // Replace the hour (time) of both dates with 00:00
//                            let date1 = calendar.startOfDay(for: date)
//                            let date2 = calendar.startOfDay(for: Date())
//
//                            let components = calendar.dateComponents([.day], from: date1, to: date2)
//
//                            if let days = components.day{
//
//                                lblitemStatusDays.text = days == 1 ? "\(days) day" : "\(days) days"
//
//                                //Setting date in integer format
//                                //                        presenterDetailList.eventsModel.EventsList[indexPath.row].createdDate = days
//                            }
//                        }
//
//                        selectedBusinessIDTodayOffers = filteredLocation[0].serviceID
//                        selectedCategoryType = CategoryType.business
//
//                    }
//                }
//
//
//
//            } else if locationType == "promotions" {
//
//
//                if promotionsData != nil || promotionsData.promotionsList.count != 0 {
//
//                    let promotionsListAll = promotionsData.promotionsList
//
//                    let filteredLocation = promotionsListAll.filter { promotionsListAll in
//                        return ((promotionsListAll.latitude! as NSString).doubleValue == latitude && (promotionsListAll.longitude! as NSString).doubleValue == longitude)
//                    }
//                    //
//                    print("Search Found Data All: \(filteredLocation)")
//                    print("Search Found Data First Array : \(filteredLocation[0])")
//
//                    if filteredLocation[0] != nil && filteredLocation.count != 0 {
//
//                        self.viewLocationSelect.isHidden = false
//
//                        let url = URL(string: filteredLocation[0].image ?? "")
//                        imageLocation.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
//                        }
//
//                        lbltitleName.text = filteredLocation[0].title
//                        lblLocationName.text = filteredLocation[0].location ?? "Visakhapatnam"
//                        //                lblitemStatusDays.text = selectData["title"] as? String ?? ""
//                        lblreviews.text = "\(filteredLocation[0].views ?? 0)"
//                        viewRating.value = CGFloat(filteredLocation[0].rating ?? 0.0)
//
//
//                        if (filteredLocation[0].createdDatetime)?.count != 0  {
//
//                            //2019-08-13T05:50:14.937
//                            let createdDate = filteredLocation[0].createdDatetime
//                            let isoDate = helper.StringDateToDate(dateString: createdDate ?? "\(Date())", dateFormatte: "yyyy-MM-dd'T'HH:mm:ss.SSS")
//                            //                    let isoDate = he//"2016-04-14T10:44:00"
//                            print(isoDate)
//
//                            let dateFormatter = DateFormatter()
//                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
//                            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//                            let date = dateFormatter.date(from:createdDate ?? "\(Date())")!
//                            //                    let a = dateFormatter.date(from: createdDate)
//
//                            let calendar = Calendar.current
//
//                            // Replace the hour (time) of both dates with 00:00
//                            let date1 = calendar.startOfDay(for: date)
//                            let date2 = calendar.startOfDay(for: Date())
//
//                            let components = calendar.dateComponents([.day], from: date1, to: date2)
//
//                            if let days = components.day{
//
//                                lblitemStatusDays.text = days == 1 ? "\(days) day" : "\(days) days"
//
//                                //Setting date in integer format
//                                //                        presenterDetailList.eventsModel.EventsList[indexPath.row].createdDate = days
//                            }
//                        }
//
//                        selectedBusinessIDTodayOffers = filteredLocation[0].proID
//                        selectedCategoryType = CategoryType.promotions
//
//                    }
//                }
//
//
//            }
//
//
//        }
//
//
//    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
    }
    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//
//        mapView.setCenter(CLLocationCoordinate2D(latitude: view.annotation?.coordinate.latitude ?? 0.0, longitude: view.annotation?.coordinate.longitude ?? 0.0), animated: true)
//
//        // get select let long
//        let latitude = view.annotation?.coordinate.latitude ?? 0.0
//        let longitude = view.annotation?.coordinate.latitude ?? 0.0
//
//        print("Select coordinate : \(latitude, longitude)")
//
//        //        if promotionsData != nil || promotionsData.promotionsList.count != 0 {
//        //
//        //            let promotionsListAll = promotionsData.promotionsList
//        //
//        //            let filteredLocation = promotionsListAll.filter { promotionsListAll in
//        //                return (Double(promotionsListAll.latitude) == latitude && Double(promotionsListAll.latitude) == longitude)
//        //            }
//        //
//        //            print("Search Found Data All: \(filteredLocation)")
//        //            print("Search Found Data First Array : \(filteredLocation[0])")
//        //
//        //            if filteredLocation[0] != nil && filteredLocation.count != 0 {
//        //
//        //                self.viewLocationSelect.isHidden = false
//        //
//        //                let url = URL(string: filteredLocation[0].image)
//        //                imageLocation.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
//        //                }
//        //
//        //                lbltitleName.text = filteredLocation[0].title
//        //                lblLocationName.text = filteredLocation[0].location.rawValue
//        //                //                lblitemStatusDays.text = selectData["title"] as? String ?? ""
//        //                lblreviews.text = "\(filteredLocation[0].views)"
//        //                viewRating.value = CGFloat(filteredLocation[0].rating)
//        //
//        //
//        //                if (filteredLocation[0].createdDatetime).count != 0  {
//        //
//        //                    //2019-08-13T05:50:14.937
//        //                    let createdDate = filteredLocation[0].createdDatetime
//        //                    let isoDate = helper.StringDateToDate(dateString: createdDate, dateFormatte: "yyyy-MM-dd'T'HH:mm:ss.SSS")
//        //                    //                    let isoDate = he//"2016-04-14T10:44:00"
//        //                    print(isoDate)
//        //
//        //                    let dateFormatter = DateFormatter()
//        //                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
//        //                    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//        //                    let date = dateFormatter.date(from:createdDate)!
//        //                    //                    let a = dateFormatter.date(from: createdDate)
//        //
//        //                    let calendar = Calendar.current
//        //
//        //                    // Replace the hour (time) of both dates with 00:00
//        //                    let date1 = calendar.startOfDay(for: date)
//        //                    let date2 = calendar.startOfDay(for: Date())
//        //
//        //                    let components = calendar.dateComponents([.day], from: date1, to: date2)
//        //
//        //                    if let days = components.day{
//        //
//        //                        lblitemStatusDays.text = days == 1 ? "\(days) day" : "\(days) days"
//        //
//        //                        //Setting date in integer format
//        //                        //                        presenterDetailList.eventsModel.EventsList[indexPath.row].createdDate = days
//        //                    }
//        //                }
//        //
//        //                selectedBusinessIDTodayOffers = filteredLocation[0].proID
//        //                selectedCategoryType = CategoryType.promotions
//        //
//        //            }
//        //        }
//    }
    
    
}


