//
//  UpdateBusinessService.swift
//  YELLOW APP
//
//  Created by Apple on 13/11/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

//
//  AddBusiness.swift
//  MCA
//
//  Created by Apple on 30/09/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
import GooglePlacePicker
import Photos
import BSImagePicker
import Kingfisher

class UpdateBusinessService: UIViewController{

    // All View Category
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var viewSubCategory: UIView!
    @IBOutlet weak var viewBusinessName: UIView!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var viewWebsite: UIView!
    @IBOutlet weak var viewPincode: UIView!
    @IBOutlet weak var viewEmail: UIView!
//    @IBOutlet weak var viewImage: UIView!
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
    
//    @IBOutlet weak var btnImage1: UIButton!
    
    var gradePicker: UIPickerView!
    
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
    
    var isType = ""
    var isFrome = ""
    var recivedData : ServicesUserList!
    
    @IBOutlet weak var viewImages: UIView!
    @IBOutlet weak var viewImagesHight: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewImages: UICollectionView!
    @IBOutlet weak var btnAddbusinessOutlet: UIButton!
    
    
    var imageArray : [BussinessList_Image]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewImagesHight.constant = 0
        viewImages.isHidden = true
        
        imageArray = recivedData.images
        
        let user_id = UserDefaults.standard.object(forKey: key_user_id)
        user_ID = user_id as? Int ?? 0
        updateDataSetup()
        
        collectionViewImages.reloadData()
    }
        
    
    override func viewWillAppear(_ animated: Bool) {
        updateDataSetup()
    }
    
    func updateDataSetup (){
        
//        txtDescription.text = "Description"
//        if txtDescription.text == "Description" {
//            txtDescription.textColor = UIColor.lightGray
//        } else {
//            txtDescription.textColor = UIColor.black
//        }
        
        txtDescription.textColor = UIColor.black
        
        lblCat.text = recivedData.catname
        lblSubCat.text = recivedData.subcatname
        txtbusinessName.text = recivedData.title
        txtAddress.text = recivedData.address
        txtDescription.text = recivedData.servicesUserListDescription ?? "Description"
        txtWebsite.text = recivedData.website
        txtPincode.text = recivedData.postcode
        txtEmail.text = recivedData.email
        txtPhoneNo.text = recivedData.phone
        
        txtChooseCT.isEnabled = false
        txtChooseSBCT.isEnabled = false
        
        btnAddbusinessOutlet.setTitle("Continue", for: .normal)
        
    }
    
    func setupshadowColor(){
        
        viewCategory.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewSubCategory.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewBusinessName.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewAddress.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewDescription.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewWebsite.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewPincode.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewEmail.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
//        viewImage.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewphone.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
    }

    
    @IBAction func btnback(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
//        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func btnAddbusinessAction(_ sender: UIButton) {
    
//        if txtChooseCT.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//            let msg = "Select Category"
//            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })
//
//        } else if txtChooseSBCT.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//
//            let msg = "Select Sub-Category"
//            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })
//
//        }
        
         if txtbusinessName.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            
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
            
        }
//        else if btnImage1.image(for: .normal) == UIImage(named: "image_blank") {
//
//            let msg = "Please Choose Image"
//            AppManager.shared.showOkAlert(title: appName, message: msg, view: self, onCompletion: { (callBack: String) in })
//
//        }
        else if btnChackBox1.isSelected == false {
            
            helper.showAlertOKAction("Alert", "By clicking on option below, I agree to the Terms and conditions and have read the Privacy Statement.", "OK", self) { (ok) in
            }
        }
            
        else {
            
            helper.showAlertOKCancelActionNew(alertTitle: appName, alertMsg: "Are you want to uplode more multipal images?", self, successClosure: { (ok) in
                
                self.openmultepalImagePiker(serviceId: self.recivedData.serviceID)
                
            }, cancelClosure: { (cancel) in
                
                self.updateApi(multepalImage: [])
                
            })

            
            
            
            
//            if isType == "Edit" {
//
//
//
//            }
//            else {
//
//                let image = btnImage1.image(for: .normal)
//                let imageSend = resizeImage(image: image!, newWidth: 80)
//                let parm = ["Address" : txtAddress.text ?? " ",
//                            "catid" : CatID!,
//                            "City" : "vishakapatnam",
//                            "Description" : txtDescription.text ?? "",
//                            "Email" : txtEmail.text ?? "",
//                            "Image" : imageSend?.toBase64() ?? "",
//                            "Latitude" : addressLat,
//                            "Longitude" : addressLong,
//                            "Phone" : txtPhoneNo.text ?? "",
//                            "Postcode" : txtPincode.text ?? "",
//                            "Communityid" : community_id!,
//                            "Serviceid" : "0",
//                            "subcatid" : subcategory!,
//                            "Title" : txtbusinessName.text ?? "",
//                            "Userid" : user_ID!,
//                            "Website" : txtWebsite.text ?? ""] as [String : Any]
//
//                print("Business : \(parm)")
//                addBusinessApi(parm: parm)
//
//            }
            
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
            
        }, finish: { (assets: [PHAsset]) -> Void in
            print("Finish: \(assets)")
            
            let multepalImagesArray = NSMutableArray()
            multepalImagesArray.removeAllObjects()
            for i in assets {
                let imageSend = self.resizeImage(image: i.image, newWidth: 80)?.toBase64()
                //                print(imageSend as Any)
                multepalImagesArray.add(imageSend as Any)
            }
            
            self.updateApi(multepalImage: multepalImagesArray)

//            self.addmultepalImageApi(multepalImage: multepalImagesArray, serviceId : serviceId)
            
        }, completion: nil)
        
    }
    
    
    @IBAction func btnDeleteServiceImageOnCellEvent(_ sender: UIButton) {
        
        helper.showAlertOKCancelWithAction(appName, "Do you want to delete this Image?", self, cancelClosure: { (cance) in
            
            
        }) { (ok) in
            
            let indexPath = self.buttonToIndexPathCollctionView(sender: sender)
            print(":tap button \(indexPath.row)")
            if let index = self.recivedData.images?[indexPath.row] {
                let Image_Id = index.imageID
                self.apiDeleteImages(Image_Id: Image_Id ?? 0)
            }
            
        }
        
       
        
    }
    
    func buttonToIndexPathCollctionView(sender : UIButton) -> IndexPath {
        let point = sender.convert(CGPoint.zero, to: collectionViewImages as UIView)
        
        let indexPath: IndexPath! = collectionViewImages.indexPathForItem(at: point)
        
        print("row is = \(indexPath.row) && section is = \(indexPath.section)")
        
        return indexPath
        
    }
    
    func afterDeletRelodeData(image_id : Int) {
        
        let mainArray = imageArray
        let removeDeletAray = mainArray?.filter{$0.imageID != image_id}
        print(removeDeletAray as Any)
        print(removeDeletAray?.count as Any)
        imageArray = removeDeletAray
        collectionViewImages.reloadData()
        
    }
    
}


extension UpdateBusinessService : UITextViewDelegate {
    
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

extension UpdateBusinessService  {
    
     // All APi get data and Set
    func updateApi(multepalImage : NSMutableArray) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }

        let imageStringArray = NSMutableArray()
        imageStringArray.removeAllObjects()
        for i in multepalImage {
            let dic = ["Images" : i as? String ?? ""]
            imageStringArray.add(dic)
        }
        
        var community_id = 1
        
        if ((UserDefaults.standard.value(forKey: key_location_id) != nil)){
            community_id = UserDefaults.standard.value(forKey: key_location_id) as! Int
        }
    
        let url = URL(string: recivedData.image)
        let data = try? Data(contentsOf: url!)
        let imageSingal = UIImage(data: data!)
        let imageSend = resizeImage(image: imageSingal!, newWidth: 80)
        
        let parm = ["Serviceid" : recivedData.serviceID,
                   "Userid" : user_ID!,
                   "Title" : txtbusinessName.text ?? "",
                   "Location" : recivedData.location,
                   "Rating" : recivedData.rating,
                   "IsFeature" : recivedData.isFeature as Any,
                   "Image" : imageSend?.toBase64() as Any,
                   "Views" : recivedData.views,
                   "Latitude" : recivedData.latitude as Any,
                   "Longitude" : recivedData.longitude as Any,
                   "Address" : txtAddress.text as Any,
                   "Description" : txtDescription.text ?? "",
                   "catid" : recivedData.catid,
                   "City" : "vishakapatnam",
                   "Phone" : txtPhoneNo.text ?? "",
                   "Postcode" : txtPincode.text ?? "",
                   "Catname" : recivedData.catname,
                   "Subcatname" : recivedData.subcatname,
                   "Email" : txtEmail.text ?? "",
                   "Website" : txtWebsite.text ?? "",
                   "Communityid" : community_id,
                   "Created_Datetime" : recivedData.createdDatetime,
                   "Updated_Datetime" : recivedData.updatedDatetime,
                   "Images" : imageStringArray] as [String : Any]
        
        //                    "Image" : imageSend?.toBase64() ?? "",

        helper.startLoader(view: self.view)
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        _ = NetworkInterface.postRequest(.Service_UpdateService, headers: headers as NSDictionary, params: nil, payload: parm ){ (success, data, response, error, header) -> (Void) in
            
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
                    
                    self.showToast(message: msg, font: UIFont.systemFont(ofSize: 16.0))
                    
                    self.btnback(UIButton())
                    

//                    helper.showAlertOKCancelActionNew(alertTitle: appName, alertMsg: "Are you want to uplode more multipal images?", self, successClosure: { (ok) in
//
//                        self.openmultepalImagePiker(serviceId: ServiceId as Any)
//
//                    }, cancelClosure: { (cancel) in
//                        self.performSegue(withIdentifier: "seguetoAddBusinessThanksYou", sender: self)
//                    })
                    
                    
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

    func isValidEmail(emailString: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailString)
    }
    
    
    
    func apiDeleteImages(Image_Id : Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        let imageStringArray = NSMutableArray()
        imageStringArray.removeAllObjects()

        let parmUrl = "?Serviceid=\(recivedData.serviceID)&Imageid=\(Image_Id)"
        let parm = ["Serviceid" : recivedData.serviceID,
                    "Imageid" : Image_Id,
                    "parmurl" : parmUrl] as [String : Any]
        
        let Service_Delete_image = POST_RequestType.Service_Delete_image

        helper.startLoader(view: self.view)
        
        print(parm)
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        _ = NetworkInterface.postRequest(Service_Delete_image, headers: headers as NSDictionary, params: nil, payload: parm ){ (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let data_ = data else {
                DispatchQueue.main.async {
                    //                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do {
                // make sure this JSON is in the format we expect
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("JSON: \(json)")
                print(success)
                let msg = ((json as? NSDictionary)?.object(forKey: "Message") as? String ?? "")
                let ServiceId = ((json as? NSDictionary)?.object(forKey: "Value"))
                
                if success == true {
                    
                    self.showToast(message: msg, font: UIFont.systemFont(ofSize: 16.0))
                    self.afterDeletRelodeData(image_id: Image_Id)
                    
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
    
    
    
}


extension UpdateBusinessService : UITextFieldDelegate {
    
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


extension UpdateBusinessService : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width) / 1.3, height: 200 )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("recivedData image count : \(imageArray.count ?? 0)")
        if imageArray.count > 0 {
            viewImages.isHidden = false
            viewImagesHight.constant = 200
            return imageArray.count
        } else {
            viewImages.isHidden = true
            viewImagesHight.constant = 0
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessServiceImageCell", for: indexPath) as? BusinessServiceImageCell {
            let index = imageArray[indexPath.row]
            let url = URL(string: index.imageURL ?? "")
            cell.imageService.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = recivedData.images?[indexPath.row] {
            
        }
        
    }
    
   
    
    
    
    
    
    
    
}


class BusinessServiceImageCell : UICollectionViewCell {
    
    @IBOutlet weak var imageService: UIImageView!
    
    @IBOutlet weak var btnServiceDelete: UIButton!
    
}



//public extension UICollectionView {
//    func indexPathForView(_ view: UIView) -> IndexPath? {
//        let center = view.center
//        let viewCenter = self.convert(center, from: view.superview)
//        let indexPath = self.indexPathForView(viewCenter)
//        return indexPath
//    }
//}


extension UIView {
    
    func findCollectionView() -> UICollectionView? {
        if let collectionView = self as? UICollectionView {
            return collectionView
        } else {
            return superview?.findCollectionView()
        }
    }
    
    func findCollectionViewCell() -> UICollectionViewCell? {
        if let cell = self as? UICollectionViewCell {
            return cell
        } else {
            return superview?.findCollectionViewCell()
        }
    }
    
    func findCollectionViewIndexPath() -> IndexPath? {
        guard let cell = findCollectionViewCell(), let collectionView = cell.findCollectionView() else { return nil }
        
        return collectionView.indexPath(for: cell)
    }
    
   
}


