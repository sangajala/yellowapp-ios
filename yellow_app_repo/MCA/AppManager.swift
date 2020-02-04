//
//  AppManager.swift
//  MCA
//
//  Created by Goutham Devaraju on 20/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation
import UIKit
//import Google
import GoogleSignIn
import Firebase

class AppManager {
    
    static let shared: AppManager = AppManager()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var locationSelectedModel_shared: Locations!
    var communitySelectedModel_shared: CommunityUsers!
    
    var businessModel: BusinessModel!
    var eventsModel: EventsModel!
    var promotionsModel: PromotionsModel!
    var organisationsModel: OrganisationModel!
    
    var profileDataModal: ProfileData!

    var index_for_report: Int!
    
    var user_details: LoginModel!
    
    
    //MARK: - Initialise keys and secrets
    func initialiseKeysAndSecrets(){
        
        //        GIDSignIn.sharedInstance().clientID = "386989684194-pomeu01pdrceose9kkhcifv77au4olua.apps.googleusercontent.com"
        //
        //        FirebaseApp.configure()
        
        //        Fabric.with([Crashlytics.self])
        //
        //        FIRApp.configure()
        
        
    }
    
    //MARK: - Redirections
    func redirectToInitialPage(){
        
        if (UserDefaults.standard.value(forKey: key_user_id) != nil) && (UserDefaults.standard.value(forKey: key_location_id) != nil) {
            let user_id = UserDefaults.standard.value(forKey: key_user_id) as! Int
            let location_id = UserDefaults.standard.value(forKey: key_location_id) as! Int
            
            if user_id > 0 && location_id > 0{
                
                //Redirecting to home screen as login values are already cached.
                redirectToHomeScreen()
            }
            else{
                if !isWelcomeScreenDisplayedAlready(){
                    redirectToSplashScreen()
                }
                else{
                    //Write logic to get check for existing session and redirect accordingly
                    redirectToLoginScreen()
                }
            }
        }
        else{
            AppManager.shared.printLog(stringToPrint: "User_ID or Location_ID not available.")
            
            if !isWelcomeScreenDisplayedAlready(){
                redirectToSplashScreen()
            }
            else{
                //Write logic to get check for existing session and redirect accordingly
                redirectToLoginScreen()
            }
            
        }
    }
    
    func redirectToSplashScreen() {
        
        UserDefaults.standard.set(true, forKey: isWelcomeScreenDispalayed)
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let  splashVC = storyboard.instantiateViewController(withIdentifier:"SplashViewController") as! SplashViewController
        let navController = UINavigationController.init(rootViewController: splashVC)
        appDelegate?.window?.rootViewController = navController
    }
    
    func redirectToLoginScreen() {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let  loginVC = storyboard.instantiateViewController(withIdentifier:"LoginViewController") as! LoginViewController
        let navController = UINavigationController.init(rootViewController: loginVC)
        appDelegate?.window?.rootViewController = navController
    }
    
    func redirectToHomeScreen() {

        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let NavigationHome = mainStoryboard.instantiateViewController(withIdentifier: "NavigationHome") as! UINavigationController
        appDelegate?.window?.rootViewController = NavigationHome

    }
    
    //MARK: - Other Methods
    func isWelcomeScreenDisplayedAlready() -> Bool{
        return UserDefaults.standard.bool(forKey: isWelcomeScreenDispalayed)
    }
    
    func printLog(stringToPrint: String) {
        print("---------------------$-$--$--$--$--$--$-$----------------------------------")
        print(stringToPrint)
        print("---------------------$-$--$--$--$--$--$-$----------------------------------")
    }
    
    //MARK: - AlertController with parameters
    func showOkAlert(title: String, message: String, view: UIViewController, onCompletion: @escaping (_ alertType: String) -> ()) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let ok_action = UIAlertAction(title: "Okay",
                                      style: .default,
                                      handler: {(alert: UIAlertAction!) in
                                        onCompletion(AlertControlOptions.ok)
        })

        alertController.addAction(ok_action)

        view.present(alertController, animated: true, completion: nil)

//        appDelegate?.window?.rootViewController?.present(alertController, animated: true, completion: nil)

    }
    
//    class func showOkAlert(_ alertTitle : String, _ alertMsg : String, _ okTitle : String, _ view: UIViewController, successClosure: @escaping (String?) -> () ) {
//
//        let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
//
//        let actionOK : UIAlertAction = UIAlertAction(title: okTitle, style: .default) { (alt) in
//            print("This is ok action");
//            successClosure("OK")
//        }
//        alert.addAction(actionOK)
//
//        view.present(alert, animated: true, completion: nil)
//
//    }
    
    //MARK: - AlertController for Location Permission
    func showLocationNotFoundAlert(title: String, message: String, onCompletion: @escaping (_ alertType: String) -> ()) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok_action = UIAlertAction(title: "Cancel",
                                      style: .default,
                                      handler: {(alert: UIAlertAction!) in
                                        onCompletion(AlertControlOptions.ok)
        })
        
        let retry_action = UIAlertAction(title: "Settings",
                                         style: .default,
                                         handler: {(alert: UIAlertAction!) in
                                            onCompletion(AlertControlOptions.retry)
        })
        
        alertController.addAction(retry_action)
        alertController.addAction(ok_action)
        
        appDelegate?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: - AlertController with parameters
    func showFacebookNoEmailFoundAlert(title: String, message: String, onCompletion: @escaping (_ alertType: String) -> ()) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok_action = UIAlertAction(title: "Cancel",
                                      style: .default,
                                      handler: {(alert: UIAlertAction!) in
                                        onCompletion(AlertControlOptions.ok)
        })
        
        let retry_action = UIAlertAction(title: "Retry",
                                         style: .default,
                                         handler: {(alert: UIAlertAction!) in
                                            onCompletion(AlertControlOptions.retry)
        })
        
        alertController.addAction(retry_action)
        alertController.addAction(ok_action)
        
        appDelegate?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    // show alart ok with action
    func showAlartWithOkAction(title: String, message: String, onCompletion: @escaping (_ alertType: String) -> ()) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok_action = UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: {(alert: UIAlertAction!) in
                                        onCompletion(AlertControlOptions.ok)
        })
        
        //        let retry_action = UIAlertAction(title: "Retry",
        //                                         style: .default,
        //                                         handler: {(alert: UIAlertAction!) in
        //                                            onCompletion(AlertControlOptions.retry)
        //        })
        //
        //        alertController.addAction(retry_action)
        alertController.addAction(ok_action)
        appDelegate?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func showUserNoLoginAlert(title: String, message: String, onCompletion: @escaping (_ alertType: String) -> ()) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok_action = UIAlertAction(title: "Login",
                                      style: .default,
                                      handler: {(alert: UIAlertAction!) in
                                        onCompletion(AlertControlOptions.login)
        })
        
        let retry_action = UIAlertAction(title: "Skip",
                                         style: .default,
                                         handler: {(alert: UIAlertAction!) in
                                            onCompletion(AlertControlOptions.skip)
        })
        
        alertController.addAction(retry_action)
        alertController.addAction(ok_action)
        
        appDelegate?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    
//    func showOK(title: String, message: String, onCompletion: @escaping (_ alertType: String) -> ()) {
//
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//
//        let ok_action = UIAlertAction(title: "Login",
//                                      style: .default,
//                                      handler: {(alert: UIAlertAction!) in
//                                        onCompletion(AlertControlOptions.ok)
//        })
//
////        let retry_action = UIAlertAction(title: "Skip",
////                                         style: .default,
////                                         handler: {(alert: UIAlertAction!) in
////                                            onCompletion(AlertControlOptions.skip)
////        })
//
//        alertController.addAction(retry_action)
//        alertController.addAction(ok_action)
//
//        appDelegate?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
//
//    }
//
    
    
}
