//
//  SettingVC.swift
//  YELLOW
//
//  Created by Apple on 04/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

var settingTabSelect = true

class SettingVC: UIViewController, SWRevealViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppManager.shared.printLog(stringToPrint: "Setting VC")
        SWRevealViewController().revealToggle(animated: true)

//        mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//        mainTabbarObj.selectedIndex = 0
        
//        SWRevealViewController().revealToggle(animated: true)
//
//        mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//        mainTabbarObj.selectedIndex = 0
//
//        AppManager.shared.printLog(stringToPrint: "Setting VC")
//
//        if user_is_Login == false {
//
//            helper.showAlertOKCancelAction(appName, "User is not Login", self, successClosure: { (login) in
//
//                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = testController
//
//            }) { (skip) in
//
//                mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//                mainTabbarObj.selectedIndex = 0
//            }
//
//            return
//
//        } else {
//
//            SWRevealViewController().revealToggle(animated: true)
//
//            mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//            mainTabbarObj.selectedIndex = 0
//
////            if settingTabSelect == true {
////
////                SWRevealViewController().revealToggle(animated: true)
////
////                mainTabbarObj.delegate = self as? UITabBarControllerDelegate
////                mainTabbarObj.selectedIndex = 0
////
////            } else {
////
////                settingTabSelect = true
////
////            }
////            settingTabSelect = true
////            if settingTabSelect == true {
////
////                SWRevealViewController().revealToggle(animated: true)
////
////            } else {
////
////                settingTabSelect = true
////
////
////            }
//
////            let tryButton = UIButton()
////
////            tryButton.addTarget(mainTabbarObj.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .allEvents)
//
////            SWRevealViewController.rightRevealToggle(UIButton())
//
//
//
////            rightRevealToggle
//
////            self.SWRevealViewController
//
//
////            self.SWRevealViewController.revealToggle()
//
//
////            menubutton.addTarget(TabBarController_VC_Obj.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
//
//        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        AppManager.shared.printLog(stringToPrint: "Setting VC")
        
        SWRevealViewController().revealToggle(animated: true)

        
//        SWRevealViewController().revealToggle(animated: true)
        
//        mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//        mainTabbarObj.selectedIndex = 0
        
//        if user_is_Login == false {
//
//            helper.showAlertOKCancelAction(appName, "User is not Login", self, successClosure: { (login) in
//
//                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = testController
//
//            }) { (skip) in
//
//                mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//                mainTabbarObj.selectedIndex = 0
//
//                //                let application = UIApplication.shared.delegate as! AppDelegate
//                //                let tabbarController =
//                //                //application.tabBarController as UITabBarController
//                //                let selectedIndex = tabBarController.selectedIndex
//
//            }
//
//            return
//        } else {
//
//            SWRevealViewController().revealToggle(animated: true)
//            mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//            mainTabbarObj.selectedIndex = 0
//
////            if settingTabSelect == true {
////
////                SWRevealViewController().revealToggle(animated: true)
////
////            } else {
////
////                settingTabSelect = true
////
////            }
//        }
    }
    
    @IBAction func btnLogOutEvent(_ sender: UIButton) {
        
        UserDefaults.standard.removeObject(forKey: key_user_id)
        user_is_Login = false
        
        let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = testController
        
    }
    
}
