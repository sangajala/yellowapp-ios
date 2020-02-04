//
//  ForgotPasswordViewController.swift
//  MCA
//
//  Created by Goutham Devaraju on 20/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet var viewEmailBackground: UIView!
    
    @IBOutlet var textFieldEmail: UITextField!
    
    var presenterForgotPassword : ForgotPasswordPresenterImplementation!
    
    //MAKR: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createPresenterObject()
        setShadowsForViews()
    }
    
    //MARK: - Other Methods
    
    func createPresenterObject(){
        presenterForgotPassword = ForgotPasswordPresenterImplementation(viewController: self)
    }
    
    func setShadowsForViews(){
        viewEmailBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
    }
    

    //MARK: - Button Actions
    @IBAction func backToLoginEvent(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func forgotPasswordEvent(_ sender: Any) {
        presenterForgotPassword.performForgotPasswordEmailValidationsAndProceed()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        presenterForgotPassword.performForgotPasswordEmailValidationsAndProceed()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presenterForgotPassword.resignAllResponders()
    }
    

}

extension ForgotPasswordViewController: ForgotPasswordViewProtocol{
    
    func forgotPasswordResponse(forgotPasswordModel: ForgotpasswordModel) {
        
        guard let _ = forgotPasswordModel.isSuccess, let message = forgotPasswordModel.Message else {
            AppManager.shared.showOkAlert(title: "Alert", message: "Failed to forgot password. Please try again later.", view: self, onCompletion: { (callBack: String) in
//                self.navigationController?.popViewController(animated: true)
            })
            return
        }
                
        AppManager.shared.showOkAlert(title: "Alert", message: message, view: self, onCompletion: { (callBack: String) in
            self.navigationController?.popViewController(animated: true)
        })
    }
}
