//
//  SignupPresenter.swift
//  MCA
//
//  Created by Goutham Devaraju on 21/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation
import FirebaseAuth

class SignupPresenterImplementation: SignupPresneterProtocol {
    
    var firstName = ""
    var lastName = ""
    var email = ""
    var phone = ""
    var password = ""
    var social_loginID = "0"
    var social_loginTYPE = ""
    var isSocial = Bool()
    
    //MARK: - Properties
    var signupViewController : SignupViewController?
    
    
    //MARK: - Initializers
    required init(viewController: SignupViewController){
        self.signupViewController = viewController
    }
    
    //MAKR: - Other Methods
    func performSignupValidationsAndProceed(){
        
//        if let firstName = signupViewController!.textFieldFirstName.text{
        
//            if firstName.count > 0{
//
//                if let lastName = signupViewController!.textFieldLastName.text{
//
//                    if lastName.count > 0 {
//
                        if let email = signupViewController!.textFieldEmail.text{
        
                            if isValidEmail(emailString: email){
                                
                                if let phoneNumber = signupViewController?.textFieldPhone.text{
                                    
                                    if phoneNumber.count > 0{
                                        
//                                        if isValidPhoneNumber(value: phoneNumber){
                                        
                                            if let password = signupViewController?.textFieldPassword.text{
                                                
                                                if password.count >= 5{
                                                    
                                                    if let confirmedPassword = signupViewController?.textFieldConfirmPassword.text{
                                                        
                                                        if confirmedPassword.count > 0{
                                                            
                                                            if confirmedPassword == password{
                                                                
                                                                if signupViewController?.btnChackBox1.isSelected == true {
                                                                    
//                                                                    if signupViewController?.btnChackBox2.isSelected == true {
                                                                    
                                                                        resignAllResponders()
//                                                                        self.firstName = firstName
//                                                                        self.lastName = lastName
                                                                        self.email = email
                                                                        self.phone = phoneNumber
                                                                        self.password = password
                                                                        self.social_loginID = "0"
                                                                        self.social_loginTYPE = "G"
                                                                        self.isSocial = false
                                                                    signupViewController?.validatePhoneNumberAndProceed(stringPhoneNumber: phoneNumber, country_code: (signupViewController?.lblMoCountryCode.text!)!)
                                                                        //                                                                signupViewController?.VerificationSendOTP()
                                                                    
//                                                                    } else{
//
//                                                                        AppManager.shared.showOkAlert(title: "Alert", message: "click on the option I agree to receive any news, offers and marketing emails", onCompletion: { (string: String) -> () in })
//
//                                                                    }
                                                                    
                                                                } else{
                                                                    AppManager.shared.showOkAlert(title: "Alert", message: "By clicking on option below, I agree to the Terms and conditions and have read the Privacy Statement.", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
                                                                }
                                                                
                                                            AppManager.shared.printLog(stringToPrint: "Registering user")
                                                                
                                                                
                                                            }
                                                            else{
                                                                AppManager.shared.showOkAlert(title: "Alert", message: "Entered passwords do not match", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
                                                            }
                                                        }
                                                        else{
                                                            AppManager.shared.showOkAlert(title: "Alert", message: "Please confirm your password", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
                                                        }
                                                    }
                                                    else{
                                                        AppManager.shared.showOkAlert(title: "Alert", message: "Please confirm your password", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
                                                    }
                                                }
                                                else{
                                                    AppManager.shared.showOkAlert(title: "Alert", message: "Password should be greater than 5 charaters", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
                                                }
                                            }
                                            else{
                                                AppManager.shared.showOkAlert(title: "Alert", message: "Please enter a password", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
                                            }
//                                        }
//                                        else{
//                                            AppManager.shared.showOkAlert(title: "Alert", message: "Please enter a valid phone number", onCompletion: { (string: String) -> () in })
//                                        }
                                    }
                                    else{
                                        AppManager.shared.showOkAlert(title: "Alert", message: "Please enter a phone number", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
                                    }
                                }
                                else{
                                    AppManager.shared.showOkAlert(title: "Alert", message: "Please enter a phone number", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
                                }
                            }
                            else{
                                AppManager.shared.showOkAlert(title: "Alert", message: "Please enter a vaild email address", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
                            }
                        }
                        else{
                            AppManager.shared.showOkAlert(title: "Alert", message: "Please enter a email address", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
                        }
//                    }
//                    else{
//                        AppManager.shared.showOkAlert(title: "Alert", message: "Please enter your Last Name", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
//                    }
//                }
//                else{
//                    AppManager.shared.showOkAlert(title: "Alert", message: "Please enter your Last Name", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
//                }
//            }
//            else{
//                AppManager.shared.showOkAlert(title: "Alert", message: "Please enter your First Name", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
//            }
//        }
//        else{
//            AppManager.shared.showOkAlert(title: "Alert", message: "Please enter your First Name", view: self.signupViewController!, onCompletion: { (string: String) -> () in })
//        }
    }
    
    func isValidPassword(password: String) -> Bool {
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: password) else { return false }
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        guard texttest1.evaluate(with: password) else { return false }
        
        let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        guard texttest2.evaluate(with: password) else { return false }
        
        return true
    }
    
//    func isValidPhoneNumber(value: String) -> Bool {
//        //        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
//        //        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        //        let result =  phoneTest.evaluate(with: value)
//        //        return result
//        
//        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: value))
//        
//    }
    
    func isValidEmail(emailString: String) -> Bool{
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailString)
        
    }
    
    func resignAllResponders(){
//        signupViewController!.textFieldFirstName.resignFirstResponder()
//        signupViewController!.textFieldLastName.resignFirstResponder()
        signupViewController!.textFieldEmail.resignFirstResponder()
        signupViewController!.textFieldPhone.resignFirstResponder()
        signupViewController!.textFieldPassword.resignFirstResponder()
        signupViewController!.textFieldConfirmPassword.resignFirstResponder()
    }
    
    func ApiCallRagister() {
        
        registerUser(firstName: firstName, lastName: lastName, email: email, phone: self.signupViewController?.lblMoCountryCode.text ?? "+44" + phone, password: password, social_loginID: social_loginID, social_loginTYPE: social_loginTYPE, isSocial: false)
    }
    
    //MARK: - API Calls
    
    func registerUser(firstName: String, lastName: String, email: String, phone: String, password: String, social_loginID: String, social_loginTYPE: String, isSocial: Bool) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.signupViewController!, onCompletion: { (string: String) -> () in })
            return
        }
        
        DispatchQueue.main.async {
            self.signupViewController?.addActivityIndicatorView()
        }
        
        let payloadParams = [
            "Firstname": " ",//firstName,
            "Lastname": " ",//lastName,
            "Email": email,
            "Password": password,
            "Social_LoginId": social_loginID,
            "Social_LoginType": social_loginTYPE,
            "IsSocial": isSocial,
            "Phone": phone,
            ] as [String : Any?]
        
        print(payloadParams)
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        _ = NetworkInterface.postRequest(.register_user_post, headers: headers as NSDictionary, params: nil, payload: payloadParams as [String : Any]){ (success, data, response, error, header) -> (Void) in
            
            DispatchQueue.main.async {
                self.signupViewController?.removeActivityIndicator()
            }
            
            guard let _ = data else{
                DispatchQueue.main.async {
                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", view: self.signupViewController!, onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(SignupModel.self, from: data!)
                
                //Passing back values to ViewController to make use of the data
                self.signupViewController?.registerResponse(signupModel: response)
                
            }
                
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
}
