////
////  googlePhoneVerification.swift
////  YELLOW APP
////
////  Created by Apple on 18/10/19.
////  Copyright © 2019 Bananaapps. All rights reserved.
////
//
//import UIKit
//
//class googlePhoneVerification: UIViewController {
//
//    var SignupViewControllerObj : SignupViewController?
//
//    //MARK: - Property
//    var presenterPhoneVerification: GooglePhoneVerificationPresenterImplementation!
//
//    @IBOutlet var viewTextFieldBackground: UIView!
//
//    @IBOutlet var textFieldPhoneNumber: UITextField!
//
//    @IBOutlet var viewOTP: PinView!
//
//    @IBOutlet var viewOTPBackground: UIView!
//
//    @IBOutlet var buttonContinue: UIButton!
//
//    @IBOutlet var buttonSendOTP: UIButton!
//
//    @IBOutlet weak var lblPhoneCountyCode: UILabel!
//
//    // Loder View
//    var viewOverlay: UIView!
//
//    var activityIndicator: UIActivityIndicatorView!
//
//
//    //MARK: - ViewController Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        textFieldPhoneNumber.placeholder = SignupViewControllerObj?.textFieldPhone.text ?? ""
//
//        createPresenterInstance()
//        setupOTPView()
//
//        buttonSendOTP.setTitle("Send OTP", for: .normal)
//
//        hideOTPView()
//
//
//        //        initiateShowOTP()
//    }
//
//    //MARK: - Button Events
//
//    @IBAction func sendOTPEvent(_ sender: Any) {
//        presenterPhoneVerification.validatePhoneNumberAndProceed(stringPhoneNumber: textFieldPhoneNumber.text!, country_code: lblPhoneCountyCode.text ?? "+44")
//
//    }
//
//    @IBAction func backEvent(_ sender: Any) {
//
//        AppManager.shared.printLog(stringToPrint: "Back and cancel registration")
//
//        self.navigationController?.popViewController(animated: true)
//
//    }
//
//    @IBAction func continueButtonEvent(_ sender: Any) {
//
//        var otpCode:String = ""
//
//        for textField in viewOTP.textFields {
//            if textField.text == "" {
//
//                AppManager.shared.showOkAlert(title: "Incomplete", message: "Please enter a 6 digit OPT sent to your Phone Number.", onCompletion: { (callBack: String) in })
//
//                return
//            }
//            otpCode += textField.text!
//        }
//
//
//        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
//
//        DispatchQueue.main.async {
//            self.addActivityIndicatorView()
//        }
//
//        let credential = PhoneAuthProvider.provider().credential(
//            withVerificationID: verificationID ?? "",
//            verificationCode: otpCode)
//
//        AppManager.shared.printLog(stringToPrint: "OTP Entered is: \(otpCode)")
//
//        Auth.auth().signIn(with: credential) { (responce, error) in
//
//            DispatchQueue.main.async {
//                self.removeActivityIndicator()
//            }
//
//            AppManager.shared.printLog(stringToPrint: "Error is: \(error?.localizedDescription ?? "")")
//
//            if error != nil {
//                print(error as Any)
//
//                AppManager.shared.showOkAlert(title: "Incomplete", message: error?.localizedDescription ?? "The SMS code has expired. Please re-send the verification code to try again.", onCompletion: { (callBack: String) in })
//            } else {
//
//                // Got to Back VC
//
//                self.SignupViewControllerObj?.apiCallAfterGooglePhoneVerification()
//
//                self.navigationController?.popViewController(animated: true)
//                //                self.dismiss(animated: true, completion: nil)
//                self.SignupViewControllerObj?.googleSignUpMobileNumber = self.textFieldPhoneNumber.text ?? ""
//
//            }
//
//            //        presenterPhoneVerification.sendOTP_to_server(stringOTPNumber: otpCode)
//        }
//    }
//
//    // Send Otp Again
//
//
//    func VerificationSendOTP(Number : String) {
//
//        viewOTP.clearTextField()
//        textFieldPhoneNumber.text = ""
//
//        DispatchQueue.main.async {
//            self.addActivityIndicatorView()
//        }
//
//        PhoneAuthProvider.provider().verifyPhoneNumber("\(Number)", uiDelegate: nil) { (verificationID, error) in
//
//            DispatchQueue.main.async {
//                self.removeActivityIndicator()
//            }
//            print(verificationID as Any)
//            print(error as Any)
//            if let error = error {
//                print(error)
//
//                AppManager.shared.showOkAlert(title: "Alert", message: "\(error.localizedDescription)", onCompletion: { (string: String) -> () in })
//                return
//            }
//
//            self.showOTPView()
//
//            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
//        }
//    }
//
//    // Activity Loder view
//    func addActivityIndicatorView(){
//
//        viewOverlay = nil
//
//        viewOverlay = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//        viewOverlay.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
//        view.addSubview(viewOverlay)
//
//        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
//        activityIndicator.center = viewOverlay.center
//        viewOverlay.addSubview(activityIndicator)
//
//        activityIndicator.startAnimating()
//    }
//
//    func removeActivityIndicator() {
//        activityIndicator.stopAnimating()
//        viewOverlay.removeFromSuperview()
//    }
//}
//
//extension googlePhoneVerification: GooglePhoneVerificationViewProtocol{
//
//    //MARK: - Presenter Object
//    func createPresenterInstance(){
//        presenterPhoneVerification = GooglePhoneVerificationPresenterImplementation(viewController: self)
//    }
//
//    //MARK: - OTP
//    func setupOTPView(){
//
//        //        viewOTPBackground.isHidden = true
//        //        buttonContinue.isHidden = true
//
//        var config:PinConfig! = PinConfig()
//        config.numberOfFields     = 6
//        config.dotColor           = UIColor(named: "HeadingTextColor")
//        config.lineColor          = UIColor(named: "HeadingTextColor")
//        config.spacing            = 20
//
//        viewOTP.config = config
//
//        viewOTP.setUpView()
//        //        viewOTP.textFields[0].becomeFirstResponder()
//    }
//
//    func initiateShowOTP() {
//
//        textFieldPhoneNumber.resignFirstResponder()
//        buttonSendOTP.setTitle("Resend OTP", for: .normal)
//        showOTPView()
//    }
//
//    func showOTPView(){
//
//        viewOTPBackground.isHidden = false
//        buttonContinue.isHidden = false
//
//    }
//
//    func hideOTPView(){
//
//        viewOTPBackground.isHidden = true
//        buttonContinue.isHidden = true
//    }
//
//    //MARK: - Touches Method
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        for textField in viewOTP.textFields{
//            textField.resignFirstResponder()
//        }
//    }
//
//    func redirectToEmailVerification(){
//        self.performSegue(withIdentifier: "otpToEmailVerification", sender: nil)
//    }
//}
