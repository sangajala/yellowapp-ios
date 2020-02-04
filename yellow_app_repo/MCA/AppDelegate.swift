//
//  AppDelegate.swift
//  MCA
//
//  Created by Goutham Devaraju on 20/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import GooglePlaces
import GoogleMaps

var appName = "YELLOW APP"
var user_is_Login = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print(error)
    }
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //AppManager takes care of setting initials
        //        AppManager.shared.initialiseKeysAndSecrets()
        
        //Redirecting to module based on auth values
        
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        GIDSignIn.sharedInstance().delegate = self
        
        AppManager.shared.redirectToInitialPage()
        
        GMSServices.provideAPIKey("AIzaSyD_qyUJHzGb_1M_2M1pj5ayupbmGXY-Mb4")
        
        GMSPlacesClient.provideAPIKey("AIzaSyD_qyUJHzGb_1M_2M1pj5ayupbmGXY-Mb4")
        
        // Driver App
        //        GMSServices.provideAPIKey("AIzaSyAtcm7ClwzkrMgvd6ybeiG34NfQNyTvzTs")
        //        GMSPlacesClient.provideAPIKey("AIzaSyAtcm7ClwzkrMgvd6ybeiG34NfQNyTvzTs")
        
        // Horizon
        //        GMSServices.provideAPIKey("AIzaSyCtOIM6KHgwdFjLE-WxYXn9eT0NIfl7j-Q")
        //        GMSPlacesClient.provideAPIKey("AIzaSyCtOIM6KHgwdFjLE-WxYXn9eT0NIfl7j-Q")
        
        return true
        
    }
    
    
    //func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    //
    //
    //    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return true
        //        return ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataManager.shared.saveContext()
    }
}


private var maxLengths = [UITextField: Int]()

// 2
extension UITextField {
    
    // 3
    @IBInspectable var maxLength: Int {
        get {
            // 4
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            // 5
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControl.Event.editingChanged
            )
        }
    }
    
    @objc func limitLength(textField: UITextField) {
        // 6
        guard let prospectiveText = textField.text, prospectiveText.count > maxLength else {
            return
        }
        
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = prospectiveText.substring(to: maxCharIndex)
        selectedTextRange = selection
        
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
}
