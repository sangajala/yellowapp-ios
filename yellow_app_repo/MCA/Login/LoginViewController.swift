//
//  LoginViewController.swift
//  MCA
//
//  Created by Goutham Devaraju on 20/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
//import FBSDKLoginKit
import GoogleSignIn
import CoreLocation

import Firebase

class LoginViewController: BaseViewController, UITextFieldDelegate {
    
    var gpsAllow = false
    var isLogin = false

    @IBOutlet var buttonLogin: UIButton!
    
    @IBOutlet var viewEmailBackground: UIView!
    
    @IBOutlet var viewPasswordBackground: UIView!
    
//    @IBOutlet var viewFacebookBackground: UIView!
    
    @IBOutlet var viewGoogleBackground: UIView!
    
    @IBOutlet var textFieldEmail: UITextField!
    
    @IBOutlet var textFieldPassword: UITextField!
    
    var presenterLogin : LoginPresenterImplementation!
    
//    private var buttonFacebook: FBLoginButton!
    
    var viewOverlay: UIView!
    
    var activityIndicator: UIActivityIndicatorView!
    
    // GPS permission View
    @IBOutlet weak var viewGpsPermission: UIView!
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var btnChackBox1: UIButton!
    @IBOutlet weak var btnChackBox2: UIButton!
    
    @IBOutlet weak var btnShowPassOutlet: UIButton!

    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createPresenterObject()
        setShadowsForViews()
//        createFacebookButton()
        setupGoogleSignInDelegate()

        gpsLocationSetup()
        viewGpsPermission.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        createPresenterObject()
        setupGoogleSignInDelegate()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        buttonFacebook.delegate = nil
    }
    
    //MARK: - Other Methods
    
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
    
    func createPresenterObject(){
        presenterLogin = LoginPresenterImplementation(viewController: self)
    }
    
    func setShadowsForViews(){
        
        viewEmailBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
        viewPasswordBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
//        viewFacebookBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
        viewGoogleBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
    }
    
//    func createFacebookButton(){
//        buttonFacebook = FBLoginButton.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        buttonFacebook.permissions = ["public_profile", "email"]
//        buttonFacebook.delegate = nil
//    }
    
    func gpsLocationSetup(){
        
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                gpsAllow = false
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                gpsAllow = true
            }
        } else {
            print("Location services are not enabled")
            gpsAllow = false
        }
    }
    
    //MARK: - Button Events
    @IBAction func loginEvent(_ sender: Any) {
        
        self.view.endEditing(true)
         presenterLogin.performLoginValidationsAndProceed()
    
    }
    
    @IBAction func btnSkipEvent(_ sender: UIButton) {
        
        goToLocationSelectPage()
       
    }
    
    
//    @IBAction func facebookLoginEvent(_ sender: Any) {
//
//        buttonFacebook.delegate = self
//
//        if AccessToken.current != nil{
//            fetchFacebookUserInfo()
//        }
//        else{
//            buttonFacebook.sendActions(for: .touchUpInside)
//        }
//
//    }
    
    @IBAction func googleLoginEvent(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if btnChackBox1.isSelected == true {
            
            GIDSignIn.sharedInstance()?.signIn()
            
        } else {
            
            helper.showAlertOKAction("Alert", "By clicking on option below, I agree to the Terms and conditions and have read the Privacy Statement.", "OK", self) { (ok) in
            }
//            AppManager.shared.showOkAlert(title: "Alert", message: "click on option below, I agree to the Terms of Use and have read the Privacy Statement.", onCompletion: { (string: String) -> () in })
        }
    }
    
    @IBAction func btnAllowGPSEvent(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        viewGpsPermission.isHidden = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
//        if gpsAllow != false {
//
//        } else {
//            viewGpsPermission.isHidden = false
//        }
        
    }
    
    @IBAction func btnDenyGPSEvent(_ sender: UIButton) {
        
        viewGpsPermission.isHidden = true
        
        performSegue(withIdentifier: "logintoSelectCity", sender: self)
        
    }
    
    
    //MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 1{
            textFieldPassword.becomeFirstResponder()
        }
        else if textField.tag == 2{
            
            textFieldEmail.resignFirstResponder()
            textFieldPassword.resignFirstResponder()
            
            presenterLogin.performLoginValidationsAndProceed()
        }
        
        return true
    }
    
    //MARK: - Touches Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        presenterLogin.resignAllResponders()
    }
    
//    func reinitiateFacebookLogin(){
//
//        LoginManager().logIn(permissions: ["email"], from : self) { (loginResult, error) in
//            self.fetchFacebookUserInfo()
//        }
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "seguetoWeb" {
            
            let vc = segue.destination as! WebVC
            vc.dicdata = sender as? NSDictionary ?? [:]
            
        }
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

    
    
}

extension LoginViewController: LoginViewProtocol{
    
    func loginResponse(loginModel: LoginModel) {
        
        guard let isSuccess = loginModel.Message.isSuccess, let message = loginModel.Message.Message else {
            
            helper.showAlertOKAction("Alert", "Failed to login. Please try again later.", "OK", self) { (ok) in
            }
            
//            AppManager.shared.showOkAlert(title: "Alert", message: "Failed to login. Please try again later.", onCompletion: { (callBack: String) in })
            return
        }
        
        if isSuccess{
            
            self.showToast(message: message ?? "", font: UIFont.systemFont(ofSize: 16.0))
            
            //Storing login model detilas for further user. Cache this user data to use every time app launches.
            
            if let user_id = loginModel.UserID {
                UserDefaults.standard.setValue(user_id, forKey: key_user_id)
                UserDefaults.standard.synchronize()
            }
            
            
            
            
            
            AppManager.shared.user_details = loginModel
            
            isLogin = true
            
            if gpsAllow == false {
                viewGpsPermission.isHidden = false
                return
            }
            
            goToLocationSelectPage()
        }
        else {
            print(message)
            helper.showAlertOKAction("Alert", message, "OK", self) { (ok) in
            }
//            AppManager.shared.showOkAlert(title: "Alert", message: message, onCompletion: { (callBack: String) in })
        }
    }
}

//extension LoginViewController: LoginButtonDelegate{
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
//                        self.presenterLogin.loginUser(email: fbResult.value(forKey: "email") as! String, password: "", social_loginID: fbResult.value(forKey: "id") as! String, social_loginTYPE: "F", isSocial: true)
//                    }
//                    else{
//
//                        AccessToken.current = nil
//
////                        self.reinitiateFacebookLogin()
//                    }
//                }
//            })
//        }
//        else{
//
//        }
//    }
//}

extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate{
    
    func setupGoogleSignInDelegate(){
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
    }

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        AppManager.shared.printLog(stringToPrint: "Google Sign In didSignInForUser Login")

        if let error = error {
            print(error.localizedDescription)
            return
        }

        var firstName = ""
        var lastName = ""
        var email = ""
//        let phoneNumber = ""
        var userID = ""
        print(user.profile)

        if let fName = user.profile.givenName, let lName = user.profile.familyName, let emailID = user.profile.email, let user_id = user.userID{
            firstName = lName
            lastName = fName
            email = emailID
            userID = user_id
        }


        DispatchQueue.main.async {

           self.presenterLogin.loginUser(email: email, password: "", social_loginID: userID, social_loginTYPE: "G", isSocial: true)

        }


    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(self, animated: true, completion: nil)
    }
    
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LoginViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            gpsAllow = true
            GotoLoginSelect()
        } else{
            gpsAllow = false
        }
    }
    
    func GotoLoginSelect() {
        if gpsAllow == true && isLogin == true {
            goToLocationSelectPage()
        } else {
            
        }
    }
    
    func goToLocationSelectPage() {
        
        if ((UserDefaults.standard.value(forKey: key_location_id) != nil)){
            if let location_id_cached = UserDefaults.standard.value(forKey: key_location_id) as? Int {
                
                if (UserDefaults.standard.object(forKey: key_user_id) != nil){
                    let user_id = UserDefaults.standard.value(forKey: key_user_id) as! Int
                    print(user_id)
                    if user_id != 0 {
                        user_is_Login = true
                    } else{
                        user_is_Login = false
                    }
                }
                
                self.dismiss(animated: true, completion: nil)
                
//                AppManager.shared.redirectToHomeScreen()
                
            } else {
                self.performSegue(withIdentifier: "loginToLocationSelect", sender: nil)
            }

            
        } else{
            self.performSegue(withIdentifier: "loginToLocationSelect", sender: nil)
        }
        
        
    }
}
