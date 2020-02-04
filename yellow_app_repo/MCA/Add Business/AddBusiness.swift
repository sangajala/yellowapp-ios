//
//  AddBusiness.swift
//  MCA
//
//  Created by Apple on 30/09/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
//import GooglePlacePicker
import Photos
import BSImagePicker

class AddBusiness: UIViewController{
    
    var viewOverlay: UIView!
    var activityIndicator: UIActivityIndicatorView!
    
    var imageArray = NSMutableArray()
    private var bussinessCategoryModal: BussinessCategory1!
    private var bussinessSubCategoryModal: BussinessSubCategory!
    private var loginModal: LoginModel!
    var communitySelectModel: CommunitySelectModel!
    
    var addressLat : Double = 0.0
    var addressLong : Double = 0.0
    
    // All View Category
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var viewSubCategory: UIView!
    @IBOutlet weak var viewBusinessName: UIView!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var viewWebsite: UIView!
    @IBOutlet weak var viewPincode: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var viewphone: UIView!
    
    
    @IBOutlet weak var txtChooseCT: UITextField!
    @IBOutlet weak var lblCat: UILabel!
    
    @IBOutlet weak var txtChooseSBCT: UITextField!
    @IBOutlet weak var lblSubCat: UILabel!
    
    @IBOutlet weak var txtbusinessName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
//    @IBOutlet weak var lblAddress: UILabel!
    
    
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtWebsite: UITextField!

    @IBOutlet weak var txtPincode: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNo: UITextField!
    
    @IBOutlet weak var btnImage1: UIButton!
//    @IBOutlet weak var btnImage2: UIButton!
//    @IBOutlet weak var btnImage3: UIButton!
//    @IBOutlet weak var btnImage4: UIButton!
//    @IBOutlet weak var btnImage5: UIButton!
//    @IBOutlet weak var btnImage6: UIButton!

    var picker:UIImagePickerController? = UIImagePickerController()
    var autocompleteController = GMSAutocompleteViewController()

    
    var gradePicker: UIPickerView!
//    let gradePickerValues = ["5. Klasse", "6. Klasse", "7. Klasse"]
//    let gradePickerValues2 = ["5. 123", "6. 434", "7. 543"]
    var mainArray = NSArray()
    
    private var slectTextField = UITextField()
    private var selectButton = UIButton()
    private var user_ID : Int?
    private var community_id : Int?
    private var subcategory : Int?
    private var addressCity : String?
    
    private var CatID : Int?
    private var categoryName: String?
    private var SubcategoryName : String?
    
    var Allbuttonimage = NSMutableArray()
    
    @IBOutlet weak var btnChackBox1: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user_is_Login == false {
            
            helper.showAlertOKCancelAction(appName, "User is not Login", self, successClosure: { (login) in
                
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationLogin") as? UINavigationController {
                    UserDefaults.standard.set(true, forKey: key_is_present_to_login)
                    self.present(vc, animated: true, completion: nil)
                } else {
                    mainTabbarObj.selectedIndex = 0
                }
                
//                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = testController
                
            }) { (skip) in
                
                //                mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//                mainTabbarObj.selectedIndex = 0
                
            
                AppManager.shared.redirectToHomeScreen()
                
                
            }
            
        } else {
            
            firstTimeSetup()
            
//            let user_id = UserDefaults.standard.object(forKey: key_user_id)
//            print(user_id as Any)
//            user_ID = user_id as? Int ?? 0
//
//            let community_iduser_ID = UserDefaults.standard.object(forKey: key_location_id)
//            print(user_id as Any)
//            community_id = community_iduser_ID as? Int ?? 0
//
//            setupshadowColor()
//
//            apiGetCategory()
//
//            gradePicker = UIPickerView()
//
//            gradePicker.dataSource = self
//            gradePicker.delegate = self
//
//            txtChooseCT.inputView = gradePicker
//            txtChooseSBCT.inputView = gradePicker
//
//            txtDescription.text = "Description"
//            if txtDescription.text == "Description" {
//                txtDescription.textColor = UIColor.lightGray
//            } else {
//                txtDescription.textColor = UIColor.black
//            }
//
//            txtChooseCT.addTarget(self, action: #selector(category), for: .allEvents)
//            txtChooseSBCT.addTarget(self, action: #selector(subCategory), for: .allEvents)
//            toolBardSetup()
            
        }
        
//        txtAddress.addTarget(self, action: #selector(addrestextField), for: .allEvents)
        
        addDoneButtonOnKeyboard()
       
        
    }
    
    func firstTimeSetup(){
        let user_id = UserDefaults.standard.object(forKey: key_user_id)
        print(user_id as Any)
        user_ID = user_id as? Int ?? 0
        
        let community_iduser_ID = UserDefaults.standard.object(forKey: key_location_id)
        print(user_id as Any)
        community_id = community_iduser_ID as? Int ?? 0
        
        setupshadowColor()
        
        apiGetCategory()
        
        gradePicker = UIPickerView()
        
        gradePicker.dataSource = self
        gradePicker.delegate = self
        
        txtChooseCT.inputView = gradePicker
        txtChooseSBCT.inputView = gradePicker
        
        txtDescription.text = "Description"
        if txtDescription.text == "Description" {
            txtDescription.textColor = UIColor.lightGray
        } else {
            txtDescription.textColor = UIColor.black
        }
        
        txtChooseCT.addTarget(self, action: #selector(category), for: .allEvents)
        txtChooseSBCT.addTarget(self, action: #selector(subCategory), for: .allEvents)
        toolBardSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        firstTimeSetup()
    }
    
//
//    override func viewDidDisappear(_ animated: Bool) {
//         self.tabBarController?.tabBar.isHidden = false
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        self.tabBarController?.tabBar.isHidden = true
//    }
    
//    @objc func addrestextField(textField: UITextField) {
//
//        txtAddress.resignFirstResponder()
//        view.endEditing(true)
//        openPlacePiker()
//    }
    
    func setupshadowColor(){
  
        viewCategory.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewSubCategory.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewBusinessName.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewAddress.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewDescription.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewWebsite.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewPincode.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewEmail.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewImage.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewphone.layer.shadowColor = UIColor.backgroundShadowColor.cgColor

    }
    
    func toolBardSetup() {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black//UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelTapped))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txtChooseCT.inputAccessoryView = toolBar
        txtChooseSBCT.inputAccessoryView = toolBar

    }
    
    @objc func doneTapped() {
        
        self.view.endEditing(true)
        
        if slectTextField == txtChooseCT {
            
            if categoryName == nil || categoryName == "" {
                if bussinessCategoryModal != nil {
                    if bussinessCategoryModal.categoriesDetails[0] != nil {
                        lblCat.text = bussinessCategoryModal.categoriesDetails[0].categoryName
                        txtChooseCT.placeholder = ""
                        CatID = bussinessCategoryModal.categoriesDetails[0].categoryID
                    }
                }
               
                
            } else {
                
                lblCat.text = categoryName
                txtChooseCT.placeholder = ""

                lblSubCat.text = ""
                txtChooseSBCT.placeholder = ""

                SubcategoryName = ""
                apiSubGetCategory()
            }
        
        } else if slectTextField == txtChooseSBCT {
            
            if SubcategoryName == nil || SubcategoryName == "" {
                
                if bussinessSubCategoryModal == nil {
                    return
                } else if bussinessSubCategoryModal.subCategoriesDetails.count != 0 {
                    if bussinessSubCategoryModal.subCategoriesDetails[0] != nil {
                        
                        lblSubCat.text = bussinessSubCategoryModal.subCategoriesDetails[0].subcatName
                        txtChooseSBCT.placeholder = ""
                        subcategory = bussinessSubCategoryModal.subCategoriesDetails[0].subcategoryID
                    } else{
                        
                    }
                }
            } else {
            
                lblSubCat.text = SubcategoryName
                txtChooseSBCT.placeholder = ""


            }

//            print("ok")
//            apiSubGetCategory()
            
        }

//        self.toolbarDelegate?.didTapDone()
    }
    
    @objc func cancelTapped() {
        print("ok")
       
        self.view.endEditing(true)
//        self.toolbarDelegate?.didTapCancel()
    }

    
    @objc func category () {

        slectTextField = txtChooseCT
        txtChooseCT.inputView = gradePicker
        picker?.delegate = self
        picker?.reloadInputViews()

    }
    
    @objc func subCategory () {
        
        slectTextField = txtChooseSBCT
        txtChooseSBCT.inputView = gradePicker
        picker?.delegate = self
        picker?.reloadInputViews()
    }
    
    @IBAction func btnback(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
//        if !navigationController?.popViewController(animated: true){
//
//        }
        
//        self.navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnImage1Action(_ sender: UIButton) {
        
//        if sender.currentImage == nil {
//            OpenActionseet()
//        }
        
        self.view.endEditing(true)
        helper.showAlertOKCancelWithAction(appName, "Are you want to upload photo?", self, cancelClosure: { (cancel) in
           
            
        }) { (ok) in

            self.selectButton = sender
            self.OpenActionseet()
        }
        
    }
    
    @IBAction func btnImage2Action(_ sender: UIButton) {
//        if sender.currentImage == nil {
//            OpenActionseet()
//        }
         selectButton = sender
         OpenActionseet()
        
    }
    
    @IBAction func btnImage3Action(_ sender: UIButton) {
//        if sender.currentImage == nil {
//            OpenActionseet()
//        }
        selectButton = sender

        OpenActionseet()
    
    }
    
    @IBAction func btnImage4Action(_ sender: UIButton) {
        selectButton = sender

        OpenActionseet()
    }
    
    @IBAction func btnImage5Action(_ sender: UIButton) {
//        if sender.currentImage == nil {
//            OpenActionseet()
//        }
        selectButton = sender
         OpenActionseet()
    }
    
    @IBAction func btnImage6Action(_ sender: UIButton) {
//        if sender.currentImage == nil {
//            OpenActionseet()
//        }
         selectButton = sender
         OpenActionseet()
    }
    
    @IBAction func btnAddbusinessAction(_ sender: UIButton) {
        
//        @IBOutlet weak var txtbusinessName: UITextField!
//        @IBOutlet weak var txtAddress: UITextField!
//        @IBOutlet weak var lblAddress: UILabel!
//
//
//        @IBOutlet weak var txtDescription: UITextView!
//        @IBOutlet weak var txtWebsite: UITextField!
//
//        @IBOutlet weak var txtPincode: UITextField!
//        @IBOutlet weak var txtEmail: UITextField!
//        @IBOutlet weak var txtPhoneNo: UITextField!
//
//
        if lblCat.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            let msg = "Select Category"
            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })

        } else if lblSubCat.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            
            let msg = "Select Sub-Category"
            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })

        } else if txtbusinessName.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            
            let msg = "Please Enter Business Name"
            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })
            
        } else if txtAddress.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            
            let msg = "Please Enter Address"
            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })
            
        } else if txtDescription.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            
            let msg = "Please Enter Description"
            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })
            
        } else if txtWebsite.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            
            let msg = "Please Enter Website"
            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })
            
        } else if txtPincode.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            
            let msg = "Please Enter Postcode"
            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })
            
        } else if txtEmail.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            
            let msg = "Please Enter Email"
            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })
            
        }
        
        else if isValidEmail(emailString: txtEmail.text ?? "") == false {
            
            let msg = "Please Enter Valid Email"
            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })
            
        }
        
        else if txtPhoneNo.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            
            let msg = "Please Enter Phone Number"
            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })
            
        } else if btnImage1.image(for: .normal) == UIImage(named: "image_blank") {
            
            let msg = "Please Choose Image"
            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })
            
        }  else if btnChackBox1.isSelected == false {
            
            helper.showAlertOKAction("Alert", "By clicking on option below, I agree to the Terms and conditions and have read the Privacy Statement.", "OK", self) { (ok) in
            }
            
        }

        else {
            
            let image = btnImage1.image(for: .normal)
            let imageSend = resizeImage(image: image!, newWidth: 80)
//            let parm = ["Address" : txtAddress.text ?? "",
//                        "catid" : CatID!,
//                        "City" : "vishakapatnam",
//                        "Description" : txtDescription.text ?? "",
//                        "Email" : txtEmail.text ?? "",
//                        "Image" : imageSend?.toBase64() ?? "",
//                        "Latitude" : addressLat,
//                        "Longitude" : addressLong,
//                        "Phone" : txtPhoneNo.text ?? "",
//                        "Postcode" : txtPincode.text ?? "",
//                        "Communityid" : community_id,
//                        "Serviceid" : "0",
//                        "subcatid" : subcategory!,
//                        "Title" : txtbusinessName.text? ?? "",
//                        "Userid" : user_ID!,
//                        "Website" : txtWebsite.text ?? ""] as [String : Any]
            
            
            let parm = ["Address" : txtAddress.text ?? " ",
                        "catid" : CatID!,
                        "City" : "vishakapatnam",
                        "Description" : txtDescription.text ?? "",
                        "Email" : txtEmail.text ?? "",
                        "Image" : imageSend?.toBase64() ?? "",
                        "Latitude" : addressLat,
                        "Longitude" : addressLong,
                        "Phone" : txtPhoneNo.text ?? "",
                        "Postcode" : txtPincode.text ?? "",
                        "Communityid" : community_id!,
                        "Serviceid" : "0",
                        "subcatid" : subcategory!,
                        "Title" : txtbusinessName.text ?? "",
                        "Userid" : user_ID!,
                        "Website" : txtWebsite.text ?? ""] as [String : Any]
            
            print("Business : \(parm)")
            addBusinessApi(parm: parm)
            
        }
        
//        else if btnImage1.image == uiimage(name : "image_blank") {
//
//            let msg = "Please Choose Image"
//            AppManager.shared.showOkAlert(title: "Error", message: msg, onCompletion: { (callBack: String) in })
//
//        }
//        } else if lbladdress.count == 0 {
//
//        }  else if lbladdress.count == 0 {
//
//        } else if lbladdress.count == 0 {
//
//        }else if {
//
//        }  else if lbladdress.count == 0 {
//
//        }  else if lbladdress.count == 0 {
//
//        }
//        Subcategory_Id
//        Category_Id
        
//        print(parm)

//        if let theJSONData = try? JSONSerialization.data(
//            withJSONObject: parm,
//            options: []) {
//            let theJSONText = String(data: theJSONData,
//                                     encoding: .ascii)
//            print("JSON string = \(theJSONText!)")
//
//
//
//        }
        
        
//        if getOnlySelectImage().count == 0 {
//            print("Please select image")
//        }

    }
    
//    func getOnlySelectImage() -> NSMutableArray {
//        let sendImages = NSMutableArray()
//        for i in Allbuttonimage {
//            let button = i as! UIButton
//            if button.image(for: .normal) != UIImage(named: "image_blank") {
//                sendImages.add(button.image(for: .normal) as Any)
//            }
//        }
//        print(sendImages)
//        return sendImages
//    }
    
    
    func addActivityIndicatorView() {
        
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
    
    @IBAction func btnChackBoxEvent1(_ sender: UIButton) {
        
        if sender.isSelected == true {
            sender.isSelected = false
            btnChackBox1.isSelected = false
        } else {
            sender.isSelected = true
            btnChackBox1.isSelected = true

        }
    }
    
    
    func openmultepalImagePiker(serviceId : Any) {
        
        
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 6
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            print("Selected: \(asset)")
        }, deselect: { (asset: PHAsset) -> Void in
            print("Deselected: \(asset)")
        }, cancel: { (assets: [PHAsset]) -> Void in
            print("Cancel: \(assets)")
            self.btnback(UIButton())
            
        }, finish: { (assets: [PHAsset]) -> Void in
            print("Finish: \(assets)")
            
            var multepalImagesArray = NSMutableArray()
            multepalImagesArray.removeAllObjects()
            for i in assets {
                let imageSend = self.resizeImage(image: i.image, newWidth: 80)?.toBase64()
//                print(imageSend as Any)
                multepalImagesArray.add(imageSend as Any)
            }
            
            self.addmultepalImageApi(multepalImage: multepalImagesArray, serviceId : serviceId)
            
        }, completion: nil)
        
    
            
    }
}

extension AddBusiness {
    
    func apiGetCategory() {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.view)
        
//        addActivityIndicatorView()
        
//        var community_id = community_id
//
        if ((UserDefaults.standard.value(forKey: key_location_id) != nil)){
            community_id = UserDefaults.standard.value(forKey: key_location_id) as? Int
        }
        
        print(community_id as Any)
        let payloadParams = [
            "communityid": community_id as Any] as [String : Any]
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        _ = NetworkInterface.getRequest(.get_businesses_category, headers: headers as NSDictionary, params: payloadParams as NSDictionary, requestCompletionHander: { (success, data, response, error, header) -> (Void) in
            
//            self.removeActivityIndicator()
            
            helper.stopLoader()
            
            guard let _ = data else{
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do {
                
//                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                    print(json)
//                }
//
                let json = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:AnyObject]
//
                print(data!)
                print(json)

                let decoder = JSONDecoder()
                
                let response = try decoder.decode(BussinessCategory1.self, from: data!)
                
//                print(response.categoriesDetails)
                
                self.registerResponse(bussinessCategory: response)
                
//                registerResponse
                
                //Passing back values to ViewController to make use of the data
//                self.signupViewController?.registerResponse(signupModel: response)

            }
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                print(error)
            }
        })
    }
    
    func registerResponse(bussinessCategory: BussinessCategory1) {
        
        guard let isSuccess = bussinessCategory.message.isSuccess, let _ = bussinessCategory.message.message else {
            AppManager.shared.showOkAlert(title: "Alert", message: "Failed to fetch available locations.", view: self, onCompletion: { (callBack: String) in })
            return
        }

        if isSuccess {

            bussinessCategoryModal = bussinessCategory
            
            print(bussinessCategoryModal.categoriesDetails)

            DispatchQueue.main.async {
                self.picker?.reloadInputViews()
                self.picker?.delegate = self
                
//                self.tableViewLocation.reloadData()
            }
        }
    }
    
    func apiSubGetCategory() {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        if CatID == nil {
            return
        }
        
//        addActivityIndicatorView()
        
        helper.startLoader(view: self.view)
        
        var community_id = 1
        
        if ((UserDefaults.standard.value(forKey: key_location_id) != nil)){
            community_id = UserDefaults.standard.value(forKey: key_location_id) as! Int
        }
        
        let payloadParams = [
            "communityid": community_id,
            "CatID" : CatID as Any] as [String : Any]
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        _ = NetworkInterface.getRequest(.get_businesses_sub_category, headers: headers as NSDictionary, params: payloadParams as NSDictionary, requestCompletionHander: { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            //            self.removeActivityIndicator()
            
            guard let _ = data else{
                self.bussinessSubCategoryModal = nil
                DispatchQueue.main.async {
                    self.picker?.reloadInputViews()
                    self.picker?.delegate = self
                }
//                DispatchQueue.main.async {
////                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
//                }
                return
            }
            
            do {
                
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                print(json as Any)
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(BussinessSubCategory.self, from: data!)
                self.registerResponse(bussinessSubCategory: response)
                
            }
                
            catch {
                self.bussinessSubCategoryModal = nil
                DispatchQueue.main.async {
                    self.picker?.reloadInputViews()
                    self.picker?.delegate = self
                }
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        })
    }
    
    func registerResponse(bussinessSubCategory: BussinessSubCategory) {

        guard let isSuccess = bussinessSubCategory.message.isSuccess, let _ = bussinessSubCategory.message.message else {
            AppManager.shared.showOkAlert(title: "Alert", message: "Failed to fetch available locations.", view: self, onCompletion: { (callBack: String) in })
            return
        }

        if isSuccess {

            bussinessSubCategoryModal = bussinessSubCategory

//            print(bussinessSubCategoryModal.subCategoriesDetails)

            DispatchQueue.main.async {
                self.picker?.reloadInputViews()
                self.picker?.delegate = self

            }
        }

    }
    
    
    func addDoneButtonOnKeyboard() {
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default
            
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
            
            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()
            
            txtDescription.inputAccessoryView = doneToolbar
        }
        
        @objc func doneButtonAction(){
            txtDescription.resignFirstResponder()
        }
    
    
    func addmultepalImageApi(multepalImage : NSMutableArray, serviceId : Any){
        
        if !Reachability.isConnectedToNetwork() {
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        let imageStringArray = NSMutableArray()
        imageStringArray.removeAllObjects()
        for i in multepalImage {
            let dic = ["Images" : i as? String ?? ""]
            imageStringArray.add(dic)
        }
        
        print("Images : \(imageStringArray)")
        
        let payloadParams = [
            "ServideId": serviceId,
            "Images" : imageStringArray] as [String : Any]
        
        print("payloadParams : \(payloadParams)")
        
        
        helper.startLoader(view: self.view)
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        _ = NetworkInterface.postRequest(.Service_Multipal_Image_Uplode, headers: headers as NSDictionary, params: nil, payload: payloadParams){ (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                DispatchQueue.main.async {
                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", view: self, onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do {
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
//                print(jsonData)
                
                let massage = jsonData?.object(forKey: "Message") as? String ?? ""
                
                if success == true {
                    
                    AppManager.shared.showAlartWithOkAction(title: appName, message: massage, onCompletion: { (ok) in
                        
                        self.performSegue(withIdentifier: "seguetoAddBusinessThanksYou", sender: self)
                        
                    })
                    
                } else{
                    
                    AppManager.shared.showOkAlert(title: "Error", message: massage, view: self, onCompletion: { (callBack: String) in })
                    
                }
                
                
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(ForgotpasswordModel.self, from: data!)
//
//                //Passing back values to ViewController to make use of the data
//                self.forgotPasswordViewController.forgotPasswordResponse(forgotPasswordModel: response)
                
            }
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
}

extension AddBusiness : UITextViewDelegate {
    
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

       
        //        return true
        
      
        
//        let currentText:String = textView.text
//        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
//
//        // If updated text view will be empty, add the placeholder
//        // and set the cursor to the beginning of the text view
//        if updatedText.isEmpty {
//
//            textView.text = "Description"
//            textView.textColor = UIColor.lightGray
//
//            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//        }
//
//            // Else if the text view's placeholder is showing and the
//            // length of the replacement string is greater than 0, set
//            // the text color to black then set its text to the
//            // replacement string
//        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
//            textView.textColor = UIColor.black
//            textView.text = text
//        }
//
//            // For every other case, the text should change with the usual
//            // behavior...
//        else {
//            return true
//        }
//
//        if textView.text.trimmingCharacters(in: .whitespaces).count > 10 {
//            return false
//        } else{
//            return true
//        }
//
//        // ...otherwise return false since the updates have already
//        // been made
//        return false
        
//        return textView.text.count + (text.count - range.length) <= 250
    }
}


extension AddBusiness : UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func OpenActionseet() {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
//        if let popoverController = optionMenu.popoverPresentationController {
//            popoverController.sourceView = btnSetImage
//            popoverController.sourceRect = CGRect(x: 0, y: 0, width: btnSetImage.frame.width, height: btnSetImage.frame.height)
//        }
        
        let saveAction = UIAlertAction(title: "Camera", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            self.openCamera()
            print("Camera")
        })
        
        let deleteAction = UIAlertAction(title: "Gallary", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.openGallary()
            print("openGallary")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    func openGallary() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            picker!.allowsEditing = false
            picker!.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
            present(picker!, animated: true, completion: nil)
            
        }
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            picker!.allowsEditing = false
            picker!.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker!.sourceType = UIImagePickerController.SourceType.camera
            picker!.cameraCaptureMode = .photo
            present(picker!, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.picker?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if ((info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil) {
            
            let selctImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)
            let cropImage = cropToBounds(image: selctImage ?? UIImage(), width: 10, height: 10)
            
            btnImage1.setImage(cropImage, for: .normal)
            
             self.picker?.dismiss(animated: true, completion: nil)
        }
        
        self.picker?.dismiss(animated: true, completion: nil)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        print(info)
//
//        if ((info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil) {
//
//            let selctImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)
////            imageArray.add(selctImage as Any)
//            btnImage1.setImage(selctImage, for: .normal)
//
//            dismiss(animated: true, completion: nil)
//
//
////            if selectButton == btnImage1 {
////
////                btnImage1.setImage(selctImage, for: .normal)
////
////            } else if selectButton == btnImage2 {
////
////                btnImage2.setImage(selctImage, for: .normal)
////
////
////            } else if selectButton == btnImage3 {
////
////                btnImage3.setImage(selctImage, for: .normal)
////
////
////            } else if selectButton == btnImage4{
////
////                btnImage4.setImage(selctImage, for: .normal)
////
////
////            } else if selectButton == btnImage5 {
////
////                btnImage5.setImage(selctImage, for: .normal)
////
////
////            } else if selectButton == btnImage6 {
////
////                btnImage6.setImage(selctImage, for: .normal)
////
////
////            }
////
////            imageProfile.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
////
////            imagePic = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
////            imagePic = GlobalClass.resizeImage(image: imagePic, newWidth: 300)
//
//            //            imageString = GlobalClass.imageToStrinig(info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
//            //            let imgpath = info[UIImagePickerController.InfoKey.imageURL]
//            //            selectImagPath = imgpath as! String
//
//        } else{
//            print("No Image Found")
//        }
//
//        dismiss(animated: true, completion: nil)
//
//    }
    
    func isValidEmail(emailString: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailString)
    }
   
    func addBusinessApi(parm : Any) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.view)
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        _ = NetworkInterface.postRequest(.add_Service_Register_post, headers: headers as NSDictionary, params: nil, payload: parm as! [String : Any]){ (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()

            guard let data_ = data else {
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
//            do{
            
                do {
                    // make sure this JSON is in the format we expect
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print("JSON: \(json)")
                    print(success)
                    let msg = ((json as? NSDictionary)?.object(forKey: "Message") as? String ?? "")
                    let ServiceId = ((json as? NSDictionary)?.object(forKey: "Value"))

                    if success == true {
                        
                        helper.showAlertOKCancelActionNew(alertTitle: appName, alertMsg: "Are you want to uplode more multipal images?", self, successClosure: { (ok) in
                            
                            self.openmultepalImagePiker(serviceId: ServiceId as Any)

                        }, cancelClosure: { (cancel) in
                             self.performSegue(withIdentifier: "seguetoAddBusinessThanksYou", sender: self)
                        })
                    
        
                    } else {
                        
                        AppManager.shared.showOkAlert(title: "Error", message: msg, view: self, onCompletion: { (callBack: String) in })

                    }
                }

            catch {
                if response != nil{
                    
                    AppManager.shared.showOkAlert(title: "Error", message: "API Error. Status Code: \(String(describing: response?.statusCode)).", view: self, onCompletion: { (callBack: String) in })
                    
                    AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                }
                else{

                    
                    AppManager.shared.printLog(stringToPrint: "No response from the server please try again later. ")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "seguetoAddBusinessThanksYou" {
            if let viewController:AddBusinessThanks = segue.destination as? AddBusinessThanks{
                viewController.backVC = self
            }
        }
    }
}

extension AddBusiness : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if slectTextField == txtChooseCT {
            
            if bussinessCategoryModal == nil{
                return 0
            }
            else {
                return bussinessCategoryModal.categoriesDetails.count //0//bussinessCategoryModal.categoriesDetails.count : 0 bussinessCategoryModal.categoriesDetails.count :
            }
            
        } else if slectTextField == txtChooseSBCT {
            
            if bussinessSubCategoryModal == nil{
                return 0
            } else {
                return bussinessSubCategoryModal.subCategoriesDetails.count
            }
            
        } else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if slectTextField == txtChooseCT {
            
            if bussinessCategoryModal != nil {
                if bussinessCategoryModal.categoriesDetails.count > 0 {
                    return bussinessCategoryModal.categoriesDetails[row].categoryName ?? ""
                } else {
                    return ""
                }
            }  else{
                return ""
            }
            
//            return bussinessCategoryModal.categoriesDetails[row].categoryName
            
        } else if slectTextField == txtChooseSBCT {
            
            if bussinessSubCategoryModal != nil{
                if bussinessSubCategoryModal.subCategoriesDetails.count > 0{
                    return bussinessSubCategoryModal.subCategoriesDetails[row].subcatName
                } else{
                    return ""
                }
            } else{
                return ""
            }
            
            
        } else {
            return "0"
        }

//        return mainArray[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if slectTextField == txtChooseCT {
            
            if bussinessCategoryModal == nil {
                return
            }
            
            categoryName = bussinessCategoryModal.categoriesDetails[row].categoryName
            self.CatID = bussinessCategoryModal.categoriesDetails[row].categoryID
            print(CatID)
            
        } else if slectTextField == txtChooseSBCT {
            
            if bussinessSubCategoryModal == nil {
                return
            }
            
            //txtChooseSBCT.text
            SubcategoryName = bussinessSubCategoryModal.subCategoriesDetails[row].subcatName
            subcategory = bussinessSubCategoryModal.subCategoriesDetails[row].subcategoryID
        }
       
    }
    
   

}


extension AddBusiness : GMSAutocompleteViewControllerDelegate  {
    
    func openPlacePiker() {
        
//        txtAddress.resignFirstResponder()
//        self.view.endEditing(true)

//        let config = GMSPlacePickerConfig(viewport: nil)
//        let placePicker = GMSPlacePickerViewController(config: config)
//        placePicker.delegate = self as GMSPlacePickerViewControllerDelegate
//        present(placePicker, animated: true, completion: nil)
    
        
        autocompleteController.delegate = self
        let filter = GMSAutocompleteFilter()
//        filter.country = "IND" //US"  //appropriate country code
        autocompleteController.autocompleteFilter = filter
        present(autocompleteController, animated: true, completion: nil)
        
    }
    
    // Handle the user's selection.

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        addressLat = place.coordinate.latitude
        addressLong = place.coordinate.longitude
        addressCity = place.name
        
        //             Ben10 print(""Place name: \(place.name)")
        //             Ben10 print(""Place address: \(place.formattedAddress)")
        //             Ben10 print(""Place attributions: \(place.attributions)")
        //             Ben10 print(""Place latitude: \(place.coordinate.latitude)")
        //             Ben10 print(""Place longitude: \(place.coordinate.longitude)")
        //                    self.lat = "\(place.coordinate.latitude)"
        //                    self.long = "\(place.coordinate.longitude)"
        
        if let address = place.formattedAddress {
            
            txtAddress.placeholder = ""
//            lblAddress.text = address
            
            
        } else {
            
            txtAddress.placeholder = "Address"
//            lblAddress.text = ""
            
        }
        
        self.autocompleteController.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.autocompleteController.dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    
//        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//            // TODO: handle the error.
//            // Ben10
////            print("Error: ", \(error.localizedDescription)")
//        }
//
//        // User canceled the operation.
//        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//            dismiss(animated: true, completion: nil)
//        }
//
//        // Turn the network activity indicator on and off again.
//        func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//            UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        }
//
//        func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//        }
    

    
//    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
//        // Dismiss the place picker, as it cannot dismiss itself.
//        viewController.dismiss(animated: true, completion: nil)
//
//        txtAddress.placeholder = ""
//        lblAddress.text = place.formattedAddress ?? ""
//
//        addressLat = place.coordinate.latitude
//        addressLong = place.coordinate.longitude
//        addressCity = place.name
//
////        print("Place name \(place.name)")
////        print("Place address \(place.formattedAddress ?? "no found")")
//        print("Place attributions \(String(describing: place.attributions))")
////
////        if let address = place.formattedAddress {
////            lblAddress.text = address
////            //            if let number = place.phoneNumber {
////            //                txtAlterphno.text = number
////            //            } else{
////            //                txtAlterphno.text = ""
////            //            }
////        } else {
////            lblAddress.text = ""
////        }
//
//    }
    
//    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
//        // Dismiss the place picker, as it cannot dismiss itself.
//        viewController.dismiss(animated: true, completion: nil)
//        print("No place selected")
//    }
    
//    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
//        // Dismiss the place picker, as it cannot dismiss itself.
//        viewController.dismiss(animated: true, completion: nil)
//
//        print("Place name \(place.name)")
//        print("Place address \(place.formattedAddress ?? "no found")")
//        print("Place attributions \(String(describing: place.attributions))")
//
//        if let address = place.formattedAddress {
//            lblAddress.text = address
//            //            if let number = place.phoneNumber {
//            //                txtAlterphno.text = number
//            //            } else{
//            //                txtAlterphno.text = ""
//            //            }
//        } else {
//            lblAddress.text = ""
//        }
//    }

}

extension AddBusiness : UITextFieldDelegate {
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
//        if textField == txtAddress {
//            openPlacePiker()
//            self.view.endEditing(true)
//            return false
//        } else{
//            return true
//        }
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
    //MARK:- Functions for Image
    
     func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}


extension PHAsset {
    
    var image : UIImage {
        var thumbnail = UIImage()
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: self, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil, resultHandler: { image, _ in
            thumbnail = image!
        })
        return thumbnail
    }
}


extension Bool{
    func isValidEmail(emailString: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailString)
    }
}
