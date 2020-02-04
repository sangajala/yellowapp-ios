//
//  Menu_VC.swift
//  Elite USA
//
//  Created by Aadmin on 21/06/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit


class tableviewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_selected_red: UILabel!
    @IBOutlet weak var view_background_outlet: UIView!
}
var selectrow = 0

class Menu_VC: UIViewController,UITableViewDataSource, UITableViewDelegate,SWRevealViewControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var table_Outlet: UITableView!
    
    var selectrow = 0
    
    var isMenuOpen = false
            //remove item ("Checkout" >> planFly)
    var c_array = ["Home","About Us","Services","Live Chat","Requests","Orders","Contact Us","Privacy Policy","Terms & Conditions","Profile"]
    // Wishlist remove
    var c_arrayImg = ["home","about-us","privacy policy","chat","paper_airplane","orders2","contact-us","Service","terms-&-condition","profile",]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        table_Outlet.tableFooterView = UIView()
        let indexPath = NSIndexPath.init(row: 0, section: 0)
        table_Outlet.selectRow(at: indexPath as IndexPath, animated: true, scrollPosition: .top)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       self.table_Outlet.reloadData()
        isMenuOpen = true
        self.revealViewController().frontViewController.view.isUserInteractionEnabled = true
        self.revealViewController().view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        self.view.endEditing(true)
        (UIApplication.shared.delegate as! AppDelegate).window?.endEditing(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        isMenuOpen = false
        self.revealViewController().frontViewController.view.isUserInteractionEnabled = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return c_array.count
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        table_Outlet.reloadData()
        
        let tabBarController = revealViewController().frontViewController as? UITabBarController
        self.revealViewController().revealToggle(animated: true)

        
        switch indexPath.row {
        case 0:
            let homeVC = getHomeVC()
            for controller in homeVC.navigationController!.viewControllers as Array {
                print(controller)
                if let vc = controller as? Home_VC  {
                    homeVC.navigationController!.popToViewController(controller, animated: false)
//                    vc.tableView.scrollToTOP()
                }
            }
            selectrow = indexPath.row
            tabBarController?.selectedIndex = 0

        case 1:
            let dic:NSDictionary = [ "title": "eliteUSA",
                                     "apiUrl" : "http://35.168.99.29/eliteusa/about-us-app/"]

            tabBarController?.selectedIndex = 0
            
            let homeVC = getHomeVC()
            
            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)
            
        case 2:
            
            let dic:NSDictionary = [ "title": "eliteUSA",
                                     "apiUrl" : "http://35.168.99.29/eliteusa/services-app/"]
            
            tabBarController?.selectedIndex = 0
            
            let homeVC = getHomeVC()
            
            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)
            
//        case 3 :
//
//            let homeVC = getHomeVC()
//            for controller in homeVC.navigationController!.viewControllers as Array {
//                print(controller)
//                if let vcHome = controller as? Home_VC  {
//                    homeVC.navigationController!.popToViewController(controller, animated: false)
//                    vcHome.tableView.scrollToBottom(animated: false)
//                }
//            }
//
//            tabBarController?.selectedIndex = 0
            
        case 3:
            tabBarController?.selectedIndex = 1

        case 4:
            tabBarController?.selectedIndex = 2
            
//        case 5:
//
//            tabBarController?.selectedIndex = 0
//            let homeVC = getHomeVC()
//            homeVC.performSegue(withIdentifier: "SegueToChackOutVC", sender: self)

            
        case 5:

            if let Vc = ((tabBarController?.childViewControllers[3] as! UINavigationController).viewControllers[0]) as? Order_VC {
            Vc.dataFilterVC = [:]
            Vc.vcType = " "
                
            }
            tabBarController?.selectedIndex = 3

            
//        case 7 :
//
////          tabBarController?.selectedIndex = 2

        case 6:
            
            tabBarController?.selectedIndex = 0
            let homeVC = getHomeVC()
            homeVC.performSegue(withIdentifier: "seguetoContact", sender: self)

        case 7:
            let dic:NSDictionary = [ "title": "eliteUSA",
                                     "apiUrl" :"http://35.168.99.29/eliteusa/privacy-policy-app/"]
            tabBarController?.selectedIndex = 0
            let homeVC = getHomeVC()
            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)
            

        case 8:
            
            let dic:NSDictionary = [ "title": "eliteUSA",
                                     "apiUrl" :"http://35.168.99.29/eliteusa/terms-and-conditions-app/"]
            tabBarController?.selectedIndex = 0
            
            let homeVC = getHomeVC()
            
            homeVC.performSegue(withIdentifier: "seguetoWeb", sender: dic)

        case 9:
            tabBarController?.selectedIndex = 4
            
        default:
            
            print("defoult")
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as! tableviewCell
        cell.lbl_Title.text = c_array[indexPath.row]
        cell.img.image = UIImage(named: c_arrayImg[indexPath.row])
        
        cell.img.setImageColor(color: UIColor.white)
        
        if selectrow == indexPath.row {
            cell.lbl_selected_red.isHidden = false
            cell.view_background_outlet.backgroundColor = UIColor(hex : "0B0B0B")
        }
        else{
            cell.lbl_selected_red.isHidden = true
            cell.view_background_outlet.backgroundColor = UIColor.black

        }

        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "go_to_webview" {
            let vc = segue.destination as! Webview_VC
            vc.dicdata = sender as! NSDictionary
        }
        
        if segue.identifier == "tab_segue" {
            
        }
    }
    
    @IBAction func btn_SignOut(_ sender: UIButton) {
        
      showAlert()
        
    }
    let usedata = Global_Class.getUserDefaultDICT()
    
    func apiCall() {
        SVProgressHUD.show()
        let parm = ["appsecret": "b5cf452aa001f9b334ae5591b46a8ab2",
                    "appkey": "89b147026838f1c8a9c0a40bead6667c",
                    "customer_id": usedata.object(forKey: "entity_id") as! String,
                    "device_token": DeviceToken,
                    "device_type": "ios"]
          print(parm)
        Global_Class.API_PostData("customer/logout", parameter: parm as NSDictionary, successWithStatus1Closure: { (responce) in
            print(responce as Any)
            self.logOut()
        }, successWithStatus0Closure: { (responce) in
            
            print("responce = \(responce as! NSDictionary)")
            let msg = (responce as! NSDictionary).object(forKey: "responsemsg") as! String
            Global_Class.showAlert(alertTitle: "eliteUSA", alertMsg: msg, view: self)
            SVProgressHUD.dismiss()
            
        }) { (responce) in
            
            Global_Class.showAlert(alertTitle: "eliteUSA", alertMsg: responce!, view: self);
            SVProgressHUD.dismiss()
        }
    }

    
    func getHomeVC() -> UIViewController{
        let tabBarController = revealViewController().frontViewController as? UITabBarController
        
       return (tabBarController?.childViewControllers[0] as! UINavigationController).viewControllers[0] as! Home_VC
        
    }
    
    func getOrderVC() -> UIViewController{
        let tabBarController = revealViewController().frontViewController as? UITabBarController
        
        return (tabBarController?.childViewControllers[0] as! UINavigationController).viewControllers[3] as! Home_VC
        
    }
    
    func logOut(){
        
        Global_Class.setUserDefault(value: "NO", for: "isLogin")
        if let root = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
            print(root.childViewControllers)
            if let tabBarController = (root.childViewControllers[0] as? SWRevealViewController)?.frontViewController as? TabBarController_VC {
               
                print(tabBarController.childViewControllers)
                if  let chatVC = (tabBarController.childViewControllers[1] as? UINavigationController)?.childViewControllers[0] as? ChattingVC{
                    chatVC.timerr?.invalidate()
                }
            }
        }
        let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = testController
        SVProgressHUD.dismiss()

    }
    
    func showAlert () {
        let refreshAlert = UIAlertController(title: "eliteUSA", message: "Are you sure you want to Sign Out ?", preferredStyle: UIAlertControllerStyle.alert)
        let tabBarController = revealViewController().frontViewController as? UITabBarController
        refreshAlert.addAction(UIAlertAction(title: "Sign Out", style: .default, handler: { (action: UIAlertAction!) in
            self.apiCall()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancel")
        }))
        
        tabBarController?.present(refreshAlert, animated: true, completion: nil)
    
    }
}

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        
        if ((cString.count) != 6) {
            self.init(hex: "ff0000") // return red color for wrong hex input
            return
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
}

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: size.height - lineWidth, width: size.width, height: lineWidth))
       // UIRectFill(CGRect(0, size.height - lineWidth, size.width, lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}







