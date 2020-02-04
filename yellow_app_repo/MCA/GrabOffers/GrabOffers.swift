//
//  grabOffers.swift
//  YELLOW APP
//
//  Created by Apple on 22/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class GrabOffers: UIViewController {
    
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var lblTitleDiscountOffers: UILabel!
    @IBOutlet weak var lblDiscountCode: UILabel!
    
//    @IBOutlet weak var lblUserName: UILabel!
//    @IBOutlet weak var imageUserImage: UIImageView!
    @IBOutlet weak var imageBarcode: UIImageView!
    
    var categoryType: CategoryType!
    
    var promotionDiscountModal : PromotionDiscountModal!
    var eventDiscountModal : EventDiscountModal!

    var discountOfferID : Int = 0
    var DetailDescriptionViewControllerObj : DetailDescriptionViewController!
    
    @IBOutlet weak var viewNoOffersFound: UIView!
    @IBOutlet weak var btnClickHereOutlet: UIButton!
    @IBOutlet weak var viewDiscountHight: NSLayoutConstraint!
    @IBOutlet weak var btnClickHereHight: NSLayoutConstraint!
    
//    var disclaimer = "<h2>Disclaimer</h2><p> By downloading, accessing or using Yellow App/Website, you signify your assent to this disclaimer. The content of this app, including and not limited to all data, information, graphics, links, are provided as a convenience to our users and are meant to be used for informational purposes only. Yellow App is not liable whatsoever for any direct, indirect or consequential issues that may arise on the part of Vendor/Merchant/User/Visitor.</p>"
    
    var urlClickHere = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiForDiscountDetails()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.cellTappedMethod(_:)))
        
        imageBarcode.isUserInteractionEnabled = true
        imageBarcode.addGestureRecognizer(tapGestureRecognizer)
        
        viewNoOffersFound.isHidden = true

    }
    
    @objc func cellTappedMethod(_ sender:AnyObject){
        print("you tap image")
        
        if imageBarcode.image != nil {
            
            let dic = ["title" : lblTitleDiscountOffers.text ?? "",
                       "image" : imageBarcode.image as Any] as [String : Any]
            
            performSegue(withIdentifier: "segueToBarcodeImage", sender: dic)
        }
    }
 
    @IBAction func btnBackEvents(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDisclaimerEvent(_ sender: UIButton) {
        
//        if let url = Html.disclaimer() { //URL(string: "http://yellowapp.co.uk/disclaimer.html") {
        
            let dic:NSDictionary = [ "title": "Disclaimer",
                                     "apiUrl" : Html.disclaimer(),
                                     "istype" : "html"]
            performSegue(withIdentifier: "seguetoWeb", sender: dic)
            
//        }
    }
    
    
    @IBAction func btnTermsConditionsEvent(_ sender: UIButton) {
        
        let dic:NSDictionary = [ "title": "Terms & Conditions",
                                 "apiUrl" : Html.termsCondition(),
                                 "istype" : "html"]
        
        performSegue(withIdentifier: "seguetoWeb", sender: dic)
    }
    
    @IBAction func btnOfferNotWorking(_ sender: UIButton) {
        
        performSegue(withIdentifier: "detailsToReport", sender: nil)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "seguetoWeb" {
            if let vc = segue.destination as? WebVC {
                vc.dicdata = sender as? NSDictionary ?? [:]
            }
        }
        
        if segue.identifier == "segueToBarcodeImage" {
            if let viewController = segue.destination as? BarcodeImageDeatails {
                viewController.dicdata = sender as? NSDictionary ?? [:]
            }
        }
        
        if segue.identifier == "detailsToReport" {
            let viewController:ReportViewController = segue.destination as! ReportViewController
            
            viewController.selectedService_ID = discountOfferID
            viewController.categoryType = categoryType
            
            if DetailDescriptionViewControllerObj != nil {
                if categoryType == CategoryType.promotions {
                    viewController.promotionsIndividualModel = DetailDescriptionViewControllerObj.presenterDetailDescription.promotionsIndividualModel
                    
                    viewController.selectedService_ID = discountOfferID
                }
                else if categoryType == CategoryType.events {
                    viewController.eventsIndividualModel = DetailDescriptionViewControllerObj.presenterDetailDescription.eventsIndividualModel
                    viewController.selectedService_ID = discountOfferID
                } else{
                    
                }
            }
            
//            if categoryType == CategoryType.business{
//                viewController.businessIndividualModel =
//                    viewController.selectedService_ID = discountOfferID
//            }
//            else
            
//            else if categoryType == CategoryType.organisations{
//
//                viewController.organisationsIndividualModel = presenterDetailDescription.organisationsIndividualModel
//                viewController.selectedService_ID = discountOfferID
//
//
//            } else {
//                return
//            }
            
        }
    }
    
    func ApiForDiscountDetails() {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.view)
        
        var getRequestType = GET_RequestType.services_individual_get

        var payloadParams = [
            "ProID": discountOfferID] as [String : Any]
        
        if categoryType == CategoryType.promotions{
            payloadParams = [
                "ProID": discountOfferID] as [String : Any]
            getRequestType = GET_RequestType.get_PromotionDiscount
        } else if categoryType == CategoryType.events {
            payloadParams = [
                "EventID": discountOfferID] as [String : Any]
            getRequestType = GET_RequestType.get_EventDiscount

        } else {
            return //
        }
        
        print("parm : \(payloadParams)")
        print("url  : \(getRequestType)")
        
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        _ = NetworkInterface.getRequest(getRequestType, headers: headers as NSDictionary, params: payloadParams as NSDictionary, requestCompletionHander: { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
//            self.removeActivityIndicator()
            
            guard let _ = data else{
                
                if self.categoryType == CategoryType.promotions{
                    self.viewNoOffersFound.isHidden = false
                } else{
                    self.btnBackEvents(UIButton())
                }
 
                DispatchQueue.main.async {
 
                    //                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    print("json data discount Offers : \(json)")
                }
                
                let decoder = JSONDecoder()
                
                if self.categoryType == CategoryType.promotions{
                    let response = try decoder.decode(PromotionDiscountModal.self, from: data!)
                    self.promotionDiscountModal = response
                    self.grabOffersResponse()
                    
                } else if self.categoryType == CategoryType.events{
                    let response = try decoder.decode(EventDiscountModal.self, from: data!)
                    self.eventDiscountModal = response
                    self.EventOffersResponse()
                }
            }
            catch{
                
                if self.categoryType == CategoryType.promotions{
                    self.viewNoOffersFound.isHidden = false
                } else{
                    self.btnBackEvents(UIButton())
                }

                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                print(error)
            }
        })
    }
    
    func grabOffersResponse() {
    
        if let data = promotionDiscountModal {
            
//            lblUserName.text = "asd"
            lblTitleDiscountOffers.text = data.title
            lblDiscountCode.text = data.discCode
            if data.url != nil {
                urlClickHere = data.url ?? ""
                viewDiscountHight.constant = 85
                btnClickHereHight.constant = 25


            } else{
                btnClickHereOutlet.isHidden = true
                viewDiscountHight.constant = 75
                btnClickHereHight.constant = 0

            }
            
            if let barcode = UIImage(barcode: "\(data.discCode)") {
                imageBarcode.image = barcode
            }

            let url = URL(string: data.image)
            imageItem.kf.setImage(with: url, placeholder: UIImage(named :"default"), options: nil, progressBlock: nil) { (result) in
            }
            
//            if let profileData = AppManager.shared.profileDataModal {
//
//                if profileData.firstname != nil && profileData.firstname != "" {
//                    if profileData.lastname != nil {
//                        self.lblUserName.text? = (profileData.firstname) + " " +  (profileData.lastname)
//                    } else{
//                        lblUserName.text? = (profileData.firstname)
//                    }
//                } else{
//                    self.lblUserName.text? = ""
//                }
//
//                let imageurl = profileData.profilePic
//                if imageurl != nil && imageurl != "" {
//                    self.imageUserImage.kf.setImage(with: URL(string: imageurl), placeholder: UIImage(named :"man_placeholder"), options: nil, progressBlock: nil) { (result) in
//                    }}
//            }
        }
    }
    
    func EventOffersResponse() {
        
        if let data = eventDiscountModal {
            
//            lblUserName.text = "asd"
            lblTitleDiscountOffers.text = data.title
            lblDiscountCode.text = data.discCode
            if data.url != nil {
                urlClickHere = data.url ?? ""
                viewDiscountHight.constant = 85
                btnClickHereHight.constant = 25

            } else{
                btnClickHereOutlet.isHidden = true
                viewDiscountHight.constant = 75
                btnClickHereHight.constant = 0


            }

            if let barcode = UIImage(barcode: "\(data.discCode)"){
                imageBarcode.image = barcode
            }
            
            let url = URL(string: data.image ?? "")
            
            imageItem.kf.setImage(with: url, placeholder: UIImage(named :"default"), options: nil, progressBlock: nil) { (result) in
            }

//            if let profileData = AppManager.shared.profileDataModal {
//
//                if profileData.firstname != nil && profileData.firstname != "" {
//                    if profileData.lastname != nil {
//                         self.lblUserName.text? = (profileData.firstname) + " " +  (profileData.lastname)
//                    } else {
//                        lblUserName.text? = (profileData.firstname)
//                    }
//                } else{
//                    self.lblUserName.text? = ""
//                }
//
//                let imageurl = profileData.profilePic
//                if imageurl != nil && imageurl != "" {
//                    self.imageUserImage.kf.setImage(with: URL(string: imageurl), placeholder: UIImage(named :"man_placeholder"), options: nil, progressBlock: nil) { (result) in
//                    }}
//            }
        }
    }
    
    @IBAction func btnClickHereEvent(_ sender: UIButton) {
        if urlClickHere != nil {
            let url = URL(string: urlClickHere)!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                    print("success!")
                })
            }
        }
    }
}

extension UIImage {
    
    convenience init?(barcode: String) {
        let data = barcode.data(using: .ascii)
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        guard let ciImage = filter.outputImage else {
            return nil
        }
        self.init(ciImage: ciImage)
    }
}
