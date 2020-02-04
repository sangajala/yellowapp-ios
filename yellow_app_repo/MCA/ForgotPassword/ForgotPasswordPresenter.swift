//
//  ForgotPasswordPresenter.swift
//  MCA
//
//  Created by Goutham Devaraju on 22/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

class ForgotPasswordPresenterImplementation: ForgotPasswordPresenterProtocol {
    
    var forgotPasswordViewController : ForgotPasswordViewController!
    
    required init(viewController: ForgotPasswordViewController){
        forgotPasswordViewController = viewController
    }
    
    func isValidEmail(emailString: String) -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailString)
    }
    
    func performForgotPasswordEmailValidationsAndProceed() {
        
        if let email = forgotPasswordViewController!.textFieldEmail.text{
            
            if isValidEmail(emailString: email){
                
                AppManager.shared.printLog(stringToPrint: "Send forgot password request")
                forgotPassword(forEmail: email)
            }
            else{
                AppManager.shared.showOkAlert(title: "Ok", message: "Please enter a vaild email address", view: self.forgotPasswordViewController, onCompletion: { (callBack: String) in })
            }
        }
        
    }
    
    func resignAllResponders() {
        forgotPasswordViewController.textFieldEmail.resignFirstResponder()
    }
    
    
    //MARK: - API Call
    func forgotPassword(forEmail email: String){
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self.forgotPasswordViewController, onCompletion: { (string: String) -> () in })
            return
        }
        
        let payloadParams = [
            "User_Email": email
            ] as [String : Any]
        
        let headers: [String: String] = [CONTENTTYPE: APPLICATION_JSON, ACCEPT: APPLICATION_JSON]
        
        _ = NetworkInterface.postRequest(.forgot_password_post, headers: headers as NSDictionary, params: nil, payload: payloadParams){ (success, data, response, error, header) -> (Void) in
            
            guard let _ = data else{
                DispatchQueue.main.async {
                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", view: self.forgotPasswordViewController, onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(ForgotpasswordModel.self, from: data!)
                
                //Passing back values to ViewController to make use of the data
                self.forgotPasswordViewController.forgotPasswordResponse(forgotPasswordModel: response)
                
            }
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
            
        }
        
    }
    
}
