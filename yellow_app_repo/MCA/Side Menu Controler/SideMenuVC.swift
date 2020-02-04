//
//  SideMenuVC.swift
//  YELLOW App
//
//  Created by Apple on 07/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
import GoogleSignIn

class SideMenuVC: UIViewController {
    
    var profileData : ProfileData!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let titleArray = ["MY Community", "My services","Favorites", "Categories", "Offers", "Events", "Feedback","Disclaimer","Terms and conditions","Privacy policy","FAQ's","About Us", "Contact Us","Our website","Complaint","Logout"]

    var isMenuOpen = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
    func Api_Profile_Data (user_Id : Int){
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
//        helper.startLoader(view: self.view)
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        let payloadParams = ["userid": user_Id] as [String : Any]
        
        print(payloadParams)
        
        _ = NetworkInterface.getRequest(.get_Profile_data, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
//            helper.stopLoader()
            
            guard let _ = data else {
                //                DispatchQueue.main.async {
                //                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                //                }
                return
            }
            
            do {
                
//                print(data)
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                
                print(jsonData)
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(ProfileData.self, from: data!)
                AppManager.shared.profileDataModal = response

                self.profileData = response
                print(response)
                
                let imageurl = response.profilePic
                if imageurl != nil && imageurl != "" {
                    self.profileImage.kf.setImage(with: URL(string: imageurl), placeholder: UIImage(named :"man_placeholder"), options: nil, progressBlock: nil) { (result) in
                }}
                
                if response.firstname != nil && response.firstname != "" {
                    if response.lastname != nil {
                        self.lblUserName.text? = (response.firstname) + " " +  (response.lastname)
                    } else{
                        self.lblUserName.text? = (response.firstname)
                    }
                } else{
                    self.lblUserName.text? = ""
                }
               
            }
            catch {
                
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        isMenuOpen = true
        self.revealViewController().frontViewController.view.isUserInteractionEnabled = true
        self.revealViewController().view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.endEditing(true)
        
        (UIApplication.shared.delegate as! AppDelegate).window?.endEditing(true)
        
        if (UserDefaults.standard.object(forKey: key_user_id) != nil){
            let user_id = UserDefaults.standard.value(forKey: key_user_id) as! Int
            Api_Profile_Data(user_Id: user_id)
        }
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isMenuOpen = false
        self.revealViewController().frontViewController.view.isUserInteractionEnabled = true

    }
    
    func getHomeVC() -> UIViewController {
        
        let tabBarController = revealViewController().frontViewController as? UITabBarController
        
        return (tabBarController?.children[0] as! UINavigationController).viewControllers[0] as! HomeVC
        
    }
    
    @IBAction func btnImageEvent(_ sender: UIButton) {
        
        if user_is_Login == false {
            
            helper.showAlertOKCancelAction(appName, "User is not Login", self, successClosure: { (login) in
                
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationLogin") as? UINavigationController {
                    UserDefaults.standard.set(true, forKey: key_is_present_to_login)
                    self.present(vc, animated: true, completion: nil)
                } else{
                    mainTabbarObj.selectedIndex = 0
                }
                
            }) { (skip) in
                
                //              mainTabbarObj.delegate = self as? UITabBarControllerDelegate
                mainTabbarObj.selectedIndex = 0
                
            }
            
            return
        } else {
            
            let homeVC : HomeVC = getHomeVC() as! HomeVC
            homeVC.performSegue(withIdentifier: "seguetoProfile", sender: nil)
            self.revealViewController().revealToggle(animated: true)

        }
    }
}

extension SideMenuVC : SWRevealViewControllerDelegate, UIGestureRecognizerDelegate {
    
}

extension SideMenuVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! menuCell
        if indexPath.row == (titleArray.count - 1) {
            if user_is_Login == true {
                cell.lblTitle.text = "Logout"
            } else{
                cell.lblTitle.text = "Login"
            }
        } else{
            cell.lblTitle?.text = titleArray[indexPath.row] as? String ?? ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.reloadData()
        
        let homeVC : HomeVC = getHomeVC() as! HomeVC
        
        self.revealViewController().revealToggle(animated: true)
        
        // Dismiss All Puse ViewControler
        homeVC.navigationController?.popViewController(animated: false)
        
        if indexPath.row == 0 {
            
             homeVC.btnAboutUsPage()
            
        } else if indexPath.row == 1 {
            
            mainTabbarObj.selectedIndex = 3
            
        } else if indexPath.row == 2 {
            
            mainTabbarObj.selectedIndex = 0
            homeVC.openFavouriteList()
            
//            mainTabbarObj.selectedIndex = 1
            
        } else if indexPath.row == 3 {
            
            mainTabbarObj.selectedIndex = 2
            
        } else if indexPath.row == 4  {
            
             mainTabbarObj.selectedIndex = 0
             homeVC.openDiscount()
            
        } else if indexPath.row == 5 {
            
            mainTabbarObj.selectedIndex = 0
            homeVC.openEvents()

            
//            let dic:NSDictionary = [ "title": "Yellow APP",
//                                     "apiUrl" : "http://yellowapp.co.uk/privacy.html",
//                                     "istype" : ""]
//
//            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)

        } else if indexPath.row == 6 {
            
            let dic:NSDictionary = [ "title": "Feedback",
                                     "apiUrl" : "https://docs.google.com/forms/d/e/1FAIpQLSeEMaOjvenPGt-49ujvvLQmiSJ3ZyB6qud1UHaf9dVNu0x9RQ/viewform",
                                     "istype" : ""]

            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)
            
        } else if indexPath.row == 7 {
            
            
            let dic:NSDictionary = [ "title": "Disclaimer",
                                     "apiUrl" : Html.disclaimer(),
                                     "istype" : "html"]

            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)
            
        } else if indexPath.row == 8 {
            
            let dic:NSDictionary = [ "title": "Terms & Conditions",
                                     "apiUrl" : Html.termsCondition(),
                                     "istype" : "html"]

            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)
            
        }  else if indexPath.row == 9 {
            
            let dic:NSDictionary = [ "title": "Privacy Policy",
                                     "apiUrl" : Html.privacyPolicy(),
                                     "istype" : "html"]

            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)
            
        } else if indexPath.row == 10 {
            
            let dic:NSDictionary = [ "title": "FAQ's",
                                     "apiUrl" : Html.faqS(),
                                     "istype" : "html"]

            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)
            
        } else if indexPath.row == 11 {
            
            let dic:NSDictionary = [ "title": "Yellow APP",
                                     "apiUrl" : "http://yellowapp.co.uk",
                                     "istype" : ""]

            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)
            
        } else if indexPath.row == 12 {
            
            let dic:NSDictionary = [ "title": "Contact Us",
                                     "apiUrl" : "http://yellowapp.co.uk/index.html#contact",
                                     "istype" : ""]

            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)
            
        } else if indexPath.row == 13 {
            
            let dic:NSDictionary = [ "title": "Yellow APP",
                                     "apiUrl" : "http://yellowapp.co.uk/index.html",
                                     "istype" : ""]

            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)
            
        } else if indexPath.row == 14 {
            
            let dic:NSDictionary = [ "title": "Complaint",
                                     "apiUrl" : "https://docs.google.com/forms/d/e/1FAIpQLSeEMaOjvenPGt-49ujvvLQmiSJ3ZyB6qud1UHaf9dVNu0x9RQ/viewform",
                                     "istype" : ""]

            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)
            
        }
        
        else if indexPath.row == titleArray.count - 1  {
            
            if user_is_Login == false {
                
                UserDefaults.standard.removeObject(forKey: key_user_id)
                user_is_Login = false
                
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationLogin") as? UINavigationController {
                    UserDefaults.standard.set(true, forKey: key_is_present_to_login)
                    self.present(vc, animated: true, completion: nil)
                } else{
                    mainTabbarObj.selectedIndex = 0
                }
                
            } else {
                
                helper.showAlertLogout(appName, "Are you sure want to Logout?", self, successClosure: { (cancel) in
                    
                }, cancelClosure: { (ok) in
                    
                    UserDefaults.standard.removeObject(forKey: key_user_id)
                    user_is_Login = false
                    
                    let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = testController
                    
                    let userdefault = UserDefaults.standard
                    
                    userdefault.removeObject(forKey: key_location_id)
                    userdefault.removeObject(forKey: key_location_name)
                    userdefault.removeObject(forKey: key_city_name)
                    userdefault.removeObject(forKey: key_select_last_tab)
                    userdefault.removeObject(forKey: key_is_present_to_login)
                    
                    do {
                        try GIDSignIn.sharedInstance().signOut()
                    } catch {
                        print("no GIDSignIn")
                    }
                    
                    self.showToast(message: "logout successful", font: UIFont.systemFont(ofSize: 16.0))
                })
            }
            
        } else {
             mainTabbarObj.selectedIndex = 0
        }
    }
    
    
    
    
}


class menuCell : UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
}


