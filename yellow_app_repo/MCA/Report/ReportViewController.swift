//
//  ReportViewController.swift
//  MCA
//
//  Created by Goutham Devaraju on 30/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
import AARatingBar
import Kingfisher

class ReportViewController: UIViewController {
    
    var businessIndividualModel: BusinessIndividualModel!
    var eventsIndividualModel: EventsIndividualModel!
    var promotionsIndividualModel: PromotionsIndividualModel!
    var organisationsIndividualModel: OrganisationIndividualModel!
    
    var selectedServiceID : Int?

    //MARK: - Properties
    
    @IBOutlet var viewDetails: UIView!
    
    @IBOutlet var imageMain: UIImageView!
    @IBOutlet var imageFeaturedIcon: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelLocation: UILabel!
    @IBOutlet var ratingView: AARatingBar!
    @IBOutlet var labelDays: UILabel!
    @IBOutlet var labelViews: UILabel!
    
    @IBOutlet var viewTextViewBackground: UIView!
    @IBOutlet var textViewReport: UITextView!
    
    var selectedService_ID: Int!
    var viewOverlay: UIView!
    var activityIndicator: UIActivityIndicatorView!
    
    var categoryType: CategoryType!
    
    var presenterReport: ReportPresenterImplementation!
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createPresenterInstance()
        configureReportingViewDetail()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        addDoneButtonOnKeyboard()
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Other Methods
    func createPresenterInstance(){
        let presenterObj = ReportPresenterImplementation(viewController: self)
        presenterReport = presenterObj
    }
    
    func configureShadows(){
        viewDetails.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
    }
    
    func configureReportingViewDetail(){
    
        if categoryType == CategoryType.business {
            
            if businessIndividualModel == nil {
                return
            } else {
                
                if businessIndividualModel! == nil  {
                    return
                }
                
                let service = businessIndividualModel!
                
                var isFeatured = false
                
                if let featured = service.IsFeature{
                    isFeatured  = featured == "true"
                }
                
                imageFeaturedIcon.isHidden = isFeatured
                
                
                if let title = service.Title{
                    labelTitle.text = title
                }
                
                
                if let image_url = service.Image{
                    if let url_image = URL(string: image_url){
                        //                    imageMain.kf.setImage(with: url_image)
                        imageMain.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                        }
                    }
                }
                
                if let location = service.Location{
                    labelLocation.text = location
                }
                
                if let views = service.Views{
                    labelViews.text = views == 1 ? "\(views) view" : "\(views) views"
                }
                
                if let rating = service.rating{
                    ratingView.value = CGFloat(rating)
                }
                
                if let createdDate = service.Created_Datetime {
                    
                    if createdDate == nil || createdDate.count == 0 || createdDate == "" {
                        //                labelDays.text = "\(0) day"
                        return
                    }
                    
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
                        labelDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
                    }
                }
                if let Description = service.Description {
                    textViewReport.text = Description
                }
            }
        }
            
        else if categoryType == CategoryType.events{
            
            if eventsIndividualModel == nil {
                return
            } else{
                
                if eventsIndividualModel == nil {
                    return
                }
                
                
                let service = eventsIndividualModel!
                
                var isFeatured = false
                
                if let featured = service.IsFeature{
                    isFeatured  = featured == "true"
                }
                
                imageFeaturedIcon.isHidden = isFeatured
                
                
                if let title = service.Title{
                    labelTitle.text = title
                }
                
                
                if let image_url = service.Image{
                    if let url_image = URL(string: image_url){
                        //                    imageMain.kf.setImage(with: url_image)
                        imageMain.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                        }
                    }
                }
                
                if let location = service.Location{
                    labelLocation.text = location
                }
                
                if let views = service.Views{
                    labelViews.text = views == 1 ? "\(views) view" : "\(views) views"
                }
                
                if let rating = service.Rating{
                    ratingView.value = CGFloat(rating)
                }
                
                if let createdDate = service.Created_Datetime{
                    
                    if createdDate == nil || createdDate.count == 0 || createdDate == "" {
                        //                labelDays.text = "\(0) day"
                        return
                    }
                    
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
                        labelDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
                    }
                }
                
                if let Description = service.Description {
                    textViewReport.text = Description
                }
            }
            
        }
            else if categoryType == CategoryType.promotions {
            
            if promotionsIndividualModel == nil {
                return
            } else{
                
//                if AppManager.shared.promotionsModel == nil || AppManager.shared.promotionsModel.PromotionsList.count == 0 {
//                    return
//                }
                
                let service = promotionsIndividualModel!
                
                var isFeatured = false
                
                if let featured = service.IsFeature{
                    isFeatured  = featured == "true"
                }
                
                imageFeaturedIcon.isHidden = isFeatured
                
                
                if let title = service.Title{
                    labelTitle.text = title
                }
                
                
                if let image_url = service.Image{
                    if let url_image = URL(string: image_url){
                        //                    imageMain.kf.setImage(with: url_image)
                        imageMain.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                        }
                    }
                }
                
                if let location = service.Location{
                    labelLocation.text = location
                }
                
                if let views = service.Views{
                    labelViews.text = views == 1 ? "\(views) view" : "\(views) views"
                }
                
                if let rating = service.Rating{
                    ratingView.value = CGFloat(rating)
                }
                
                if let createdDate = service.Created_Datetime{
                    
                    if createdDate == nil || createdDate.count == 0 || createdDate == "" {
                        //                labelDays.text = "\(0) day"
                        return
                    }
                    
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
                    
                    if let days = components.day {
                        labelDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
                    }
                }
                
                if let Description = service.Description {
                    textViewReport.text = Description
                }
            }
        }
        else {
            
            if organisationsIndividualModel == nil {
                return
            } else{
            
            
//            if AppManager.shared.organisationsModel == nil || AppManager.shared.organisationsModel.OrganisationsList.count == 0 {
//                return
//            }
            
            let service = organisationsIndividualModel!
            
            var isFeatured = false
            
            if let featured = service.IsFeature{
                isFeatured  = featured == "true"
            }
            
            imageFeaturedIcon.isHidden = isFeatured
            
            
            if let title = service.Title{
                labelTitle.text = title
            }
            
            
            if let image_url = service.Image{
                if let url_image = URL(string: image_url){
//                    imageMain.kf.setImage(with: url_image)
                    imageMain.kf.setImage(with: url_image, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                    }
                }
            }
            
            if let location = service.Location{
                labelLocation.text = location
            }
            
            if let views = service.Views{
                labelViews.text = views == 1 ? "\(views) view" : "\(views) views"
            }
            
            if let rating = service.Rating {
                ratingView.value = CGFloat(rating)
            }
            
            if let createdDate = service.Created_Datetime{
                
                if createdDate == nil || createdDate.count == 0 || createdDate == "" {
                    //                labelDays.text = "\(0) day"
                    return
                }
                
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
                    labelDays.text = days == 1 || days == 0 ? "\(days) day ago" : "\(days) days ago"
                }
              }
                
                if let Description = service.Description {
                    textViewReport.text = Description
                }
            }
        }
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
    
    //MARK: - Button Events
    
    @IBAction func backButtonEvent(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reportButtonEvent(_ sender: Any) {
        
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
            
            let user_id_cached = UserDefaults.standard.value(forKey: key_user_id) as! Int

            if textViewReport.text.trimmingCharacters(in: .whitespaces).count == 0 {
                
                AppManager.shared.showOkAlert(title: "Alart", message: "Please enter text", view: self, onCompletion: { (callBack: String) in })
            } else {
                presenterReport.sendReportDetails(comments: textViewReport.text.trimmingCharacters(in: .whitespaces), user_id: user_id_cached, categoryType: categoryType)
            }
            
        }
        else{
            
            
            
//            AppManager.shared.showOkAlert(title: "Message", message: "Unable to fetch data. Please try again later.", onCompletion: { (callBack: String) in })
            
            print("Unable to report")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToReportThanksyou" {
            if let viewController:ReportThanksVC = segue.destination as? ReportThanksVC{
                viewController.backVC = self
            }
        }
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
 extension ReportViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        if textView.text.count + (text.count - range.length) <= 250 {
            
            if(text == "\n") {
                
                return textView.text.count + (text.count - range.length) <= 250
            }
                
            else {
                return textView.text.count + (text.count - range.length) <= 250
            }
            
            
            
        } else {
            
            return false
        }

    }
}


extension ReportViewController: ReportViewProtocol{
    
    func responseReportData(reportModel: ReportModel) {
  

        
//        DispatchQueue.main.async {
//
//            AppManager.shared.showOkAlert(title: "Alert", message: "click on option below, I agree to the Terms of Use and have read the Privacy Statement.", onCompletion: { (string: String) -> () in })
//        }
        
        let message = reportModel.Message

        if reportModel.isSuccess == true {
            
             self.performSegue(withIdentifier: "segueToReportThanksyou", sender: self)
            
//            let alert = UIAlertController(title: "Alert", message: message ?? "", preferredStyle: UIAlertController.Style.alert)
//            
//            // add an action (button)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
//                
//                // do something like...
////                self.navigationController?.popViewController(animated: true)
//                
//                self.performSegue(withIdentifier: "segueToReportThanksyou", sender: self)
//
//                
//            }))
//            // show the alert
//            self.present(alert, animated: true, completion: nil)
            
            
            
            
//            DispatchQueue.main.async {
//
//                AppManager.shared.showOkAlert(title: "Alert", message: message ?? "Success", onCompletion: { (callBackString: String) in
//                    self.navigationController?.popViewController(animated: true)
//                })
//
////                AppManager.shared.showOkAlert(title: "Alert", message: message ?? "") { (ok) in
////                    self.navigationController?.popViewController(animated: true)
////                }
//            }
            
            
//            AppManager.shared.showOkAlert(title: "Alert", message: message ?? "Success", onCompletion: { (callBackString: String) in
//                self.navigationController?.popViewController(animated: true)
//            })
        } else{
            
            let alert = UIAlertController(title: "Alert", message: message ?? "", preferredStyle: UIAlertController.Style.alert)

            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
                
                
            }))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
 
        }
        
    }
}

extension ReportViewController {
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textViewReport.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        textViewReport.resignFirstResponder()
    }
}


import UIKit
@IBDesignable class TextViewWithPlaceholder: UITextView {
    
    override var text: String! { // Ensures that the placeholder text is never returned as the field's text
        get {
            if showingPlaceholder {
                return "" // When showing the placeholder, there's no real text to return
            } else { return super.text }
        }
        set { super.text = newValue }
    }
    @IBInspectable var placeholderText: String = ""
    @IBInspectable var placeholderTextColor: UIColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0) // Standard iOS placeholder color (#C7C7CD). See https://stackoverflow.com/questions/31057746/whats-the-default-color-for-placeholder-text-in-uitextfield
    private var showingPlaceholder: Bool = true // Keeps track of whether the field is currently showing a placeholder
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if text.isEmpty {
            showPlaceholderText() // Load up the placeholder text when first appearing, but not if coming back to a view where text was already entered
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        // If the current text is the placeholder, remove it
        if showingPlaceholder {
            text = nil
            textColor = nil // Put the text back to the default, unmodified color
            showingPlaceholder = false
        }
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        // If there's no text, put the placeholder back
        if text.isEmpty {
            showPlaceholderText()
        }
        return super.resignFirstResponder()
    }
    
    private func showPlaceholderText() {
        showingPlaceholder = true
        textColor = placeholderTextColor
        text = placeholderText
    }
}
