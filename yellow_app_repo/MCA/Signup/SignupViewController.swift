//
//  SignupViewController.swift
//  MCA
//
//  Created by Goutham Devaraju on 20/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

import FirebaseAuth
import GoogleSignIn

class SignupViewController: BaseViewController, UITextFieldDelegate {
    
    // Google sign up get Data variable
    var firstName = ""
    var lastName = ""
    var email = ""
    let phoneNumber = ""
    var userID = ""
    var googleSignUpMobileNumber = ""
    var isFrome = ""

    @IBOutlet var viewFirstNameBackground: UIView!
    
    @IBOutlet var viewLastNameBackground: UIView!
    
    @IBOutlet var viewEmailBackground: UIView!
    
    @IBOutlet var viewPhoneBackground: UIView!
    
    @IBOutlet var viewPasswordBackground: UIView!
    
    @IBOutlet var viewConfirmBackground: UIView!
    
    @IBOutlet var buttonContinue: UIButton!
    
//    @IBOutlet var viewFacebookBackground: UIView!
    
    @IBOutlet var viewGoogleBackground: UIView!
    
//    @IBOutlet var textFieldFirstName: UITextField!
    
//    @IBOutlet var textFieldLastName: UITextField!
    
    @IBOutlet var textFieldEmail: UITextField!
    
    @IBOutlet var textFieldPhone: UITextField!
    
    @IBOutlet var textFieldPassword: UITextField!
    
    @IBOutlet var textFieldConfirmPassword: UITextField!
    
    
    var presenterSignup: SignupPresenterImplementation!
    
//    private var buttonFacebook: FBLoginButton!
    
    var viewOverlay: UIView!
    
    var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var btnChackBox1: UIButton!
    @IBOutlet weak var btnChackBox2: UIButton!

    @IBOutlet weak var lblMoCountryCode: UILabel!
    
    
    @IBOutlet weak var btnShowPassOutlet: UIButton!
    @IBOutlet weak var btnShowConPassOutlet: UIButton!
    
    
    
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
             GIDSignIn.sharedInstance().signOut()
        } catch {
            print("no GIDSignIn")
        }

        // Do any additional setup after loading the view.
        createPresenterObject()
        setShadowsForViews()
//        createFacebookButton()
        setupGoogleSignInDelegate()
        
        }
    
    //MARK: - Other Methods
    func createPresenterObject(){
        presenterSignup = SignupPresenterImplementation(viewController: self)
    }
    
    func setShadowsForViews(){
        
        viewFirstNameBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
        viewLastNameBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
        viewEmailBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
        viewPhoneBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
        viewPasswordBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
        viewConfirmBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
//        viewFacebookBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
        viewGoogleBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
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
    
    func removeActivityIndicator() {
        activityIndicator.stopAnimating()
        viewOverlay.removeFromSuperview()
    }
    
    //MARK: - Button Events
    @IBAction func backToLoginEvent(_ sender: Any) {
        
        self.view.endEditing(true)

//        navigationController?.popViewController(animated: true)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func continueRegistration(_ sender: Any) {
        
        self.view.endEditing(true)

        presenterSignup.performSignupValidationsAndProceed()
    }
    
    @IBAction func googleSignInEvent(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if btnChackBox1.isSelected == true {
            
            GIDSignIn.sharedInstance()?.signIn()
            
        } else {
            
            AppManager.shared.showOkAlert(title: "Alert", message: "By clicking on option below, I agree to the Terms and conditions and have read the Privacy Statement.", view: self, onCompletion: { (string: String) -> () in })
        }
    }
    
    //MARK: - TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 1:
//            textFieldLastName.becomeFirstResponder()
            break
        case 2:
            textFieldEmail.becomeFirstResponder()
            break
        case 3:
            textFieldPhone.becomeFirstResponder()
            break
        case 4:
            textFieldPassword.becomeFirstResponder()
        break
        case 5:
            textFieldConfirmPassword.becomeFirstResponder()
        break
        case 6:
            presenterSignup.performSignupValidationsAndProceed()
        break
        default:
            break
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == textFieldFirstName && textField == textFieldLastName {
//            let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
//            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
//            let typedCharacterSet = CharacterSet(charactersIn: string)
//            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
//            return alphabet
//
//        } else {
            return true
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presenterSignup.resignAllResponders()
    }
    
    @IBAction func btnChackBoxEvent(_ sender: UIButton) {
        
        if sender.isSelected == true {
            
            sender.isSelected = false
            btnChackBox1.isSelected = false
            
        } else {
            
            sender.isSelected = true
            btnChackBox1.isSelected = true
            
        }
    }
        
    @IBAction func btnChackBoxEvent2(_ sender: UIButton) {
        
        if sender.isSelected == true {
            sender.isSelected = false
            btnChackBox2.isSelected = false

        } else {
            sender.isSelected = true
            btnChackBox2.isSelected = true

        }
    }
    
    @IBAction func btnTermsConditionEvent(_ sender: UIButton) {
        
        let dic:NSDictionary = [ "title": "Terms & Conditions",
                                 "apiUrl" : Html.termsCondition(),
                                 "istype" : "html"]
        performSegue(withIdentifier: "seguetoWeb", sender: dic)
        
    }
    
    
    @IBAction func btnPrivacyEvent(_ sender: UIButton) {

        let dic:NSDictionary = [ "title": "Privacy Policy",
                                 "apiUrl" : Html.privacyPolicy(),
                                 "istype" : "html"]
        performSegue(withIdentifier: "seguetoWeb", sender: dic)
        
    }
    
    @IBAction func btnPasswordShowEvent(_ sender: UIButton) {
        if textFieldPassword.isSecureTextEntry == true {
            textFieldPassword.isSecureTextEntry = false
            btnShowPassOutlet.setTitle("Hide", for: .normal)

            btnShowPassOutlet.titleLabel?.font =  UIFont(name: "Poppins-SemiBold", size: 16)

        } else {
            textFieldPassword.isSecureTextEntry = true
            btnShowPassOutlet.setTitle("Show", for: .normal)
            btnShowPassOutlet.titleLabel?.font =  UIFont(name: "Poppins-SemiBold", size: 16)

        }
    }

    
    @IBAction func btnConPasswordShowEvent(_ sender: UIButton) {
        
        if textFieldConfirmPassword.isSecureTextEntry == true {
            
            btnShowConPassOutlet.setTitle("Hide", for: .normal)
            textFieldConfirmPassword.isSecureTextEntry = false
            btnShowConPassOutlet.titleLabel?.font =  UIFont(name: "Poppins-SemiBold", size: 16)

        } else{
            
            textFieldConfirmPassword.isSecureTextEntry = true
            btnShowConPassOutlet.setTitle("Show", for: .normal)

            btnShowConPassOutlet.titleLabel?.font =  UIFont(name: "Poppins-SemiBold", size: 16)

        }
    }


}


extension SignupViewController : SignupViewProtocol{
    
    func registerResponse(signupModel: SignupModel) {
        
        guard let isSuccess = signupModel.isSuccess, let message = signupModel.Message else {
            AppManager.shared.showOkAlert(title: "Alert", message: "Failed to login. Please try again later.", view: self, onCompletion: { (callBack: String) in })
            return
        }
        
        if isSuccess {
            
            self.performSegue(withIdentifier: "otpToEmailVerification", sender: nil)

        }
        else{
            AppManager.shared.showOkAlert(title: "Alert", message: message, view: self, onCompletion: { (callBack: String) in })
        }
    }
}


//extension SignupViewController: LoginButtonDelegate{
//
//    @IBAction func facebookLoginEvent(_ sender: Any) {
//
//        if AccessToken.current != nil{
//            fetchFacebookUserInfo()
//        }
//        else{
//            buttonFacebook.sendActions(for: .touchUpInside)
//        }
//    }
//
//    func createFacebookButton(){
//        buttonFacebook = FBLoginButton.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        buttonFacebook.permissions = ["public_profile", "email"]
//        buttonFacebook.delegate = self
//    }
//
//    func reinitiateFacebookLogin(){
//
//        LoginManager().logIn(permissions: ["email"], from : self) { (loginResult, error) in
//            self.fetchFacebookUserInfo()
//        }
//    }
//
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//
//        if error != nil{
//            AppManager.shared.printLog(stringToPrint: "Handle facebook login error")
//        }
//
//        if let result_ = result{
//            if result_.isCancelled{
//                AppManager.shared.printLog(stringToPrint: "Do nothing on cancel")
//            }
//            else{
//
//                if (result?.grantedPermissions.contains("email"))!{
//                    AppManager.shared.printLog(stringToPrint: "Fetch user information as we got Facebook session.")
//                    fetchFacebookUserInfo()
//                }
//                else{
//
//                    AppManager.shared.showFacebookNoEmailFoundAlert(title: "Unable to login", message: "Email not found. Please provide email permissions inorder to login.", onCompletion: {(callBackString: String) in
//
//                        if AlertControlOptions.retry == callBackString{
//                            self.reinitiateFacebookLogin()
//                        }
//                        else{
//                            AppManager.shared.printLog(stringToPrint: "Setting current accesstoken to nil on Cancel")
//                            AccessToken.current = nil
//                        }
//                    })
//                }
//            }
//        }
//        else{
//            AppManager.shared.printLog(stringToPrint: "Handle error case")
//        }
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//
//    }
//
//    func fetchFacebookUserInfo(){
//
//        if AccessToken.current != nil{
//
//            let graphRequest:GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"first_name,email, picture.type(large)"])
//
//            graphRequest.start(completionHandler: { (connection, result, error) -> Void in
//
//                if ((error) != nil)
//                {
//                    AppManager.shared.printLog(stringToPrint: "Error: \(String(describing: error))")
//                }
//                else
//                {
//                    let fbResult = result as! NSDictionary
//                    AppManager.shared.printLog(stringToPrint: "FBResult: \(fbResult)")
//
//                    if fbResult.value(forKey: "email") != nil{
//
//                        self.presenterSignup.registerUser(firstName: fbResult.value(forKey: "first_name") as! String, lastName: "", email: fbResult.value(forKey: "email") as! String, phone: "", password: "", social_loginID: fbResult.value(forKey: "id") as! String, social_loginTYPE: "F", isSocial: true)
//
//                    }
//                    else{
//
//                        AccessToken.current = nil
//
//                        self.reinitiateFacebookLogin()
//                    }
//                }
//            })
//        }
//        else{
//
//        }
//    }
//
//
//}


extension SignupViewController: GIDSignInDelegate, GIDSignInUIDelegate {

    func setupGoogleSignInDelegate(){

        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self

    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        AppManager.shared.printLog(stringToPrint: "Google sign In didSignInForUser : Sign")

        if let error = error {
            print(error.localizedDescription)
            return
        }

        if let fName = user.profile.givenName, let lName = user.profile.familyName, let emailID = user.profile.email, let user_id = user.userID{
            firstName = lName
            lastName = fName
            email = emailID
            userID = user_id
        }
        
        DispatchQueue.main.async {
            
            if user.profile.email.count != 0 {
                self.isFrome = "Google"
                self.performSegue(withIdentifier: "signupToPhoneVerification", sender: nil)
            } else {
                AppManager.shared.showOkAlert(title: "Alert", message: "User data not Found", view: self, onCompletion: { (string: String) -> () in })
            }
            
        }

        
        
        
        
        
    }

    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(self, animated: true, completion: nil)
    }

    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }

}




extension SignupViewController {
    
    func validatePhoneNumberAndProceed(stringPhoneNumber: String, country_code : String){
        
        if isValidPhoneNumber(value: stringPhoneNumber){
        
//            Show the OTP view
            
//            PhoneVerificationViewController.initiateShowOTP()
            
            AppManager.shared.printLog(stringToPrint: "Make an API call to send an OTP")
            
            let subNumbner = (country_code + stringPhoneNumber).trimmingCharacters(in: .whitespaces)
            print("OTP Send Number IS : \(subNumbner)")
            VerificationSendOTP(Number: subNumbner)
            
        }
        else {
            AppManager.shared.showOkAlert(title: "Alert", message: "Please enter a valid Phone Number.", view: self, onCompletion: {(callBackString: String) in })
        }
    }
    
    func isValidPhoneNumber(value: String) -> Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: value))
    }
    
    
    func VerificationSendOTP(Number : String) {
        
        DispatchQueue.main.async {
            self.addActivityIndicatorView()
        }
        
        PhoneAuthProvider.provider().verifyPhoneNumber("\(Number)", uiDelegate: nil) { (verificationID, error) in
            
            DispatchQueue.main.async {
                self.removeActivityIndicator()
            }
            
            print(verificationID as Any)
            print(error as Any)
            
            if let error = error {
                print(error)
                AppManager.shared.showOkAlert(title: "Alert", message: "\(error.localizedDescription)", view: self, onCompletion: { (string: String) -> () in })
                return
            }
            
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            self.isFrome = "normal"
            self.performSegue(withIdentifier: "signupToPhoneVerification", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signupToPhoneVerification" {
            
             if let vc = segue.destination as? PhoneVerificationViewController {
                vc.SignupViewControllerObj = self
                vc.isFrome = isFrome
            }
        }
        
//        if segue.identifier == "signupToGooglePhoneVerification" {
//
////            if let vc = segue.destination as? GooglePhoneVerificationViewController {
////                vc.SignupViewControllerObj = self
////
////            }
//        }
        
        
        
        
        if segue.identifier == "seguetoWeb" {
            
            let vc = segue.destination as! WebVC
            vc.dicdata = sender as? NSDictionary ?? [:]
            
        }
    }
 
    func ApiCallRagisterToEmail() {
        presenterSignup.ApiCallRagister()
    }
    
    func apiCallAfterGooglePhoneVerification (){
        self.presenterSignup.registerUser(firstName: firstName, lastName: lastName, email: email, phone: googleSignUpMobileNumber, password: "", social_loginID: userID, social_loginTYPE: "G", isSocial: true)
    }
    
   
}

