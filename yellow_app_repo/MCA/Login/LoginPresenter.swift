//
//  LoginPresenter.swift
//  MCA
//
//  Created by Goutham Devaraju on 21/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

class LoginPresenterImplementation: LoginPresenterProtocol {
    
    var loginViewController : LoginViewController!
    
    required init(viewController: LoginViewController){
        self.loginViewController = viewController
    }
    
    func performLoginValidationsAndProceed() {
        
        if let email = loginViewController!.textFieldEmail.text{
            
            if isValidEmail(emailString: email){
                
                if let password = loginViewController?.textFieldPassword.text{
                    
                    if password.count > 1 {
                        
                        if loginViewController?.btnChackBox1.isSelected == true {
                            
                            resignAllResponders()
                            
                            AppManager.shared.printLog(stringToPrint: "Login user")
                            loginUser(email: email, password: password, social_loginID: "0", social_loginTYPE: "G", isSocial: false)
                            
//                            if loginViewController?.btnChackBox2.isSelected == true {
//
//
//                            } else {
//
//                                AppManager.shared.showOkAlert(title: "Alert", message: "click on the option I agree to receive any news, offers and marketing emails", onCompletion: { (string: String) -> () in })
//                            }
                            
                        } else {
                            
                            helper.showAlertOKAction("Alert", "By clicking on option below, I agree to the Terms and conditions and have read the Privacy Statement.", "OK", self.loginViewController) { (ok) in
                            }
                            
//                            AppManager.shared.showOkAlert(title: "Alert", message: "click on option below, I agree to the Terms of Use and have read the Privacy Statement.", onCompletion: { (string: String) -> () in })
                        }
                        
                    }
                    else{
                        
                        helper.showAlertOKAction("Alert", "Please enter a valid password", "OK", self.loginViewController) { (ok) in
                        }
                        
//                        AppManager.shared.showOkAlert(title: "Ok", message: "Please enter a valid password", onCompletion: { (callBack: String) in })
                    }
                }
                else{
                    
                    helper.showAlertOKAction("Alert", "Please enter a password", "OK", self.loginViewController) { (ok) in
                    }

                    
//                    AppManager.shared.showOkAlert(title: "Ok", message: "Please enter a password", onCompletion: { (callBack: String) in })
                }
            }
            else{
                
                helper.showAlertOKAction("Alert", "Please enter a vaild email address", "OK", self.loginViewController) { (ok) in
                }

//                AppManager.shared.showOkAlert(title: "Ok", message: "Please enter a vaild email address", onCompletion: { (callBack: String) in })
            }
        }
        
    }
    
    func isValidPassword(password: String) -> Bool {
        
        return false
    }
    
    func isValidEmail(emailString: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        "^[\\w-\\+]+(\\.[\\w]+)*@[\\w-]+(\\.[\\w]+)*(\\.[a-z]{2,})$"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailString)
    }
    
    func resignAllResponders() {
        
        loginViewController.textFieldEmail.resignFirstResponder()
        loginViewController.textFieldPassword.resignFirstResponder()
    }
    
    
    //MARK: - API Call
    
    func loginUser(email: String, password: String, social_loginID: String, social_loginTYPE: String, isSocial: Bool) {
        
        if !Reachability.isConnectedToNetwork(){
            
            helper.showAlertOKAction(internetErrorTitle, internetError, "OK", self.loginViewController) { (ok) in
            }
            
//            AppManager.shared.showOkAlert(title: internetErrorTitle, message: internetError, onCompletion: { (string: String) -> () in })
            return
        }
        
//        self.loginViewController.addActivityIndicatorView()
        
//        DispatchQueue.main.async {
//            self.loginViewController.addActivityIndicatorView()
//        }
        
        helper.startLoader(view: self.loginViewController.view)

        let payloadParams = [
            "Email": email,
            "Password": password,
            "Social_LoginId": social_loginID,
            "IsSocial": isSocial,
            "Social_LoginType": social_loginTYPE
            ] as [String : Any]
        
        AppManager.shared.printLog(stringToPrint: "Login post parameters: \(payloadParams)")
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        helper.stopLoader()
        
        _ = NetworkInterface.postRequest(.login_user_post, headers: headers as NSDictionary, params: nil, payload: payloadParams){ (success, data, response, error, header) -> (Void) in
            
//            self.loginViewController.removeActivityIndicator()
            
//            DispatchQueue.main.async {
//                self.loginViewController.removeActivityIndicator()
//            }
            
            guard let data_ = data else {
                DispatchQueue.main.async {
                    
                    helper.showAlertOKAction("Alert", "Failed to login. Please try again later.", "OK", self.loginViewController) { (ok) in
                    }
                    
//                    AppManager.shared.showOkAlert(title: internetErrorTitle, message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(LoginModel.self, from: data_)

                //Passing back values to ViewController to make use of the data
                self.loginViewController?.loginResponse(loginModel: response)
            }
            catch{
                if response != nil{
                    
                    helper.showAlertOKAction(internetErrorTitle, "API Error. Status Code: \(String(describing: response?.statusCode)).", "OK", self.loginViewController) { (ok) in
                    }
                    
//                    AppManager.shared.showOkAlert(title: "Error", message: "API Error. Status Code: \(String(describing: response?.statusCode)).", onCompletion: { (callBack: String) in })
                    
                    AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                }
                else {
                    
                    helper.showAlertOKAction(internetErrorTitle, "No response from the server please try again later.", "OK", self.loginViewController) { (ok) in
                }
                    
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                    
                    AppManager.shared.printLog(stringToPrint: "No response from the server please try again later. ")
                }
            }
            
            
        }
        
    }
    
    
}
