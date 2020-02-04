////
////  PhoneVerificationPresenter.swift
////  MCA
////
////  Created by Goutham Devaraju on 28/07/19.
////  Copyright © 2019 Bananaapps. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class GooglePhoneVerificationPresenterImplementation: GooglePhoneVerificationPresenterProtocol {
//
//    var phoneVerificationViewController: GooglePhoneVerificationViewController
//    
//    required init(viewController: GooglePhoneVerificationViewController){
//        self.phoneVerificationViewController = viewController
//    }
//    
//    func validatePhoneNumberAndProceed(stringPhoneNumber: String, country_code: String){
//        
//        if isValidPhoneNumber(value: stringPhoneNumber) {
//            
//            //Show the OTP view
//            phoneVerificationViewController.initiateShowOTP()
//            
//            AppManager.shared.printLog(stringToPrint: "Make an API call to send an OTP")
//            
////            phoneVerificationViewController.s
//            
//            let realNumber = country_code + stringPhoneNumber
//            print("send Again Otp Number : \(realNumber)")
//            sendOTP_to_phoneNumber(stringPhoneNumber: realNumber)
//            
//        }
//        else {
//            AppManager.shared.showOkAlert(title: "Alert", message: "Please enter a valid Phone Number.", onCompletion: {(callBackString: String) in })
//        }
//    }
//    
//    func isValidPhoneNumber(value: String) -> Bool {
//        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: value))
//    }
//    
//    
//    func sendOTP_to_phoneNumber(stringPhoneNumber: String){
//        
//        //Make an API call to receive OTP
//        
//        phoneVerificationViewController.VerificationSendOTP(Number: stringPhoneNumber)
//        
//        
//    }
//    
//    func sendOTP_to_server(stringOTPNumber: String){
//        
//        //Send OTP to server
//        
//        //Currently skipping actual verification and redirecting to email verification screen
//        phoneVerificationViewController.redirectToEmailVerification()
//        
//    }
//    
//}
