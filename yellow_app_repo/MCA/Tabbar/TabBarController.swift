//
//  TabBarController.swift
//  MCA
//
//  Created by Goutham Devaraju on 20/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

var mainTabbarObj : TabBarController!

class TabBarController: UITabBarController,  UITabBarControllerDelegate, UIGestureRecognizerDelegate  {

    //MARK: - Properties
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    
    var cv = SWRevealViewController()
    
    let newBtn = UIButton()

    //MARK: - ViewController Life Cycle
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
//        SWRevealViewController()
        
        mainTabbarObj = self
        menusettup()
//        confiureTabbar()
        setupMiddleButton()
        mainTabbarObj.delegate = self
        
        setTabBarItems()
        
//        if UserDefaults.standard.value(forKey: key_select_last_tab) != nil {
//
//            if let selectTb = UserDefaults.standard.object(forKey: key_select_last_tab) {
//                print("selectTb old : \(selectTb)")
//                if mainTabbarObj != nil{
//                    mainTabbarObj.selectedIndex = selectTb as? Int ?? 0 //selectTb as? Int ?? 0
//                }
//            }
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().backgroundColor = .clear
        UITabBar.appearance().layer.backgroundColor = UIColor.clear.cgColor
        UITabBar.appearance().tintColor = UIColor.clear
        tabBarController?.delegate = self
        self.delegate = self
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        <#code#>
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
             self.newBtn.isHidden = false
        }) { (true) in
            
        }
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            self.newBtn.isHidden = true
        }) { (true) in
            
        }
    }
    //MARK: - Other Methods
//    func confiureTabbar() {
//
//        view.backgroundColor = .clear
//
//        let newTabBarHeight = defaultTabBarHeight + 20
//
//        var newFrame = tabBar.frame
//        newFrame.size.height = newTabBarHeight
//        newFrame.origin.y = view.frame.size.height - newTabBarHeight
//
//        tabBar.frame = newFrame
//
//        let backgroundImage = UIImageView(image: UIImage(named: "tabBGHome"))
//        backgroundImage.frame = newFrame
//        backgroundImage.contentMode = .scaleAspectFit
//        backgroundImage.backgroundColor = .clear
//        backgroundImage.tag = 99999
//        self.view.addSubview(backgroundImage)
//
//        UITabBar.appearance().layer.borderWidth = 0.0
//        UITabBar.appearance().clipsToBounds = true
//        UITabBar.appearance().backgroundColor = .clear
//        UITabBar.appearance().layer.backgroundColor = UIColor.white.cgColor
//        UITabBar.appearance().tintColor = UIColor.clear
//
//        navigationController?.isNavigationBarHidden = true
//
//    }
    func setTabBarItems(){
        
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "home_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.selectedImage = UIImage(named: "home_Tab_select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.title = ""
        myTabBarItem1.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let myTabBarItem3 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem3.image = UIImage(named: "discount_grey")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.selectedImage = UIImage(named: "discount_yellow")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.title = ""
        myTabBarItem3.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let myTabBarItem2 = (self.tabBar.items?[3])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "my_business_gray")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "my_business_tab_select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.title = ""
        myTabBarItem2.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let myTabBarItem4 = (self.tabBar.items?[4])! as UITabBarItem
        myTabBarItem4.image = UIImage(named: "menu_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem4.selectedImage = UIImage(named: "more_s")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem4.title = ""
        myTabBarItem4.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func setupMiddleButton() {
        
//        let menuButton = UIButton(frame: CGRect(x: self.tabBar.center.x - 31, y: self.view.bounds.height - 74, width: 64, height: 64))
//        let paddingBottom : CGFloat = 20.0
//
//        var menuButtonFrame = menuButton.frame
//        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height
//        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
//        menuButton.frame = menuButtonFrame
//
//        // menuButton.backgroundColor = #colorLiteral(red: 0.7711942792, green: 0.08465609699, blue: 0.2401509583, alpha: 1)
//
//        menuButton.layer.cornerRadius = menuButtonFrame.height/2
//        view.addSubview(menuButton)
//
//        let rectBoundTabbar = self.tabBar.bounds
//        let xx = rectBoundTabbar.midX
//        let yy = rectBoundTabbar.midY - paddingBottom
//        menuButton.center = CGPoint(x: xx, y: yy)
//
//        self.tabBar.addSubview(menuButton)
//        self.tabBar.bringSubviewToFront(menuButton)
//
//        menuButton.setImage(UIImage(named: "explore"), for: .normal)
//        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
//        menuButton.isUserInteractionEnabled = false
        
        newBtn.tag = 8888
        newBtn.backgroundColor = UIColor.clear
        newBtn.frame = CGRect(x: self.tabBar.center.x - 31, y: self.view.bounds.height - 74, width: 64, height: 64)
        newBtn.frame.size.height = 20
        newBtn.setImage(UIImage(named: "explore_main"), for: .normal)
        newBtn.contentMode = .scaleToFill
        newBtn.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        newBtn.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        
//        self.view.addSubview(newBtn)
        self.view.insertSubview(newBtn, aboveSubview: self.tabBar)
//        view.layoutIfNeeded()
        
        newBtn.frame = CGRect(x: self.tabBar.center.x - 31, y: self.view.bounds.height - 74, width: 64, height: 64)
        newBtn.layer.cornerRadius = 32
        
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 2
        print("Success tab 2")
        
        let vc = self.viewControllers![selectedIndex] as! UINavigationController
        vc.popToRootViewController(animated: false)
        
//        tabBarController?.selectedViewController = ServiceCatVC
        
//        getKoachezFromApi()
        
        
    }
    
    func getKoachezFromApi() {
        
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        <#code#>
//    }
    
//    viewdidl
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if mainTabbarObj.selectedIndex != nil  {
            UserDefaults.standard.set(mainTabbarObj.selectedIndex, forKey: key_select_last_tab)
        }
    
            print(tabBarController.selectedViewController?.restorationIdentifier)
        print(tabBarController.selectedViewController?.restorationIdentifier)
        

        
        if viewController.title == "menuvc" as String || tabBarController.selectedViewController?.restorationIdentifier == "SettingsVC" {
        
            mainTabbarObj.selectedIndex = 0
            cv.revealToggle(animated: true)
            
            return false
        }
        
        if viewController.title == "tabBar2" as String || tabBarController.selectedViewController?.restorationIdentifier == "DetailListViewController" {
            print(getSecondTbVC())
            if let secondTab = getSecondTbVC() as? DetailListViewController {
                secondTab.categoryType = CategoryType.promotions
                secondTab.updateData()
            }
        }
        
        return true
    }
    
    func getSecondTbVC() -> UIViewController {
        
        let tabBarController = revealViewController().frontViewController as? UITabBarController
        return (tabBarController?.children[1] as! UINavigationController).viewControllers[0] as! DetailListViewController
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
//      let tabBarSelectIndex = mainTabbarObj.selectedIndex
        
        print(mainTabbarObj.selectedIndex)
        
        if mainTabbarObj.selectedIndex != nil  {
            UserDefaults.standard.set(mainTabbarObj.selectedIndex, forKey: key_select_last_tab)
        }
        
       
//
//        if tabBarSelectIndex == 4 {
//
//            if user_is_Login == false {
//
//                helper.showAlertOKCancelAction(appName, "User is not Login", self, successClosure: { (login) in
//
//                    let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDelegate.window?.rootViewController = testController
//
//                }) { (skip) in
//
//                    mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//                    mainTabbarObj.selectedIndex = 0
//                }
//
//                return
//            } else {
//
//                cv.revealToggle(animated: true)
//
//                mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//                mainTabbarObj.selectedIndex = 0
//            }
//        }
        
//
//        print(tabBar.selectedItem)
//        print(tabBar.index(ofAccessibilityElement: item))
//        print((tabBar.items?[4]) as Any)
////        print(tabBar.items?[4] as Any)
//        if ((tabBar.items?[4]) != nil) {
//
//        }
//
//        if tabBarController?.selectedIndex == 3 || tabBarController?.selectedIndex == 4 {
//            if user_is_Login == false {
//
//                helper.showAlertOKCancelAction(appName, "User is not Login", self, successClosure: { (login) in
//
//                    let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDelegate.window?.rootViewController = testController
//
//                }) { (skip) in
//
//                    mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//                    mainTabbarObj.selectedIndex = 0
//                }
//
//                return
//            }
//        }
        
//        let vc = tabBarController?.selectedViewController
//        print(vc as Any)
//        var electedIndex = 1
//        if selectedIndex == nil {
//            return
//        }
        
       
//
//        if selectedIndex == 0 {
//            
////            AppManager.shared.showUserNoLoginAlert(title: appName, message: "User not Login") { (login) in
////
//
//            
//        } else if selectedIndex == 1 {
//            
//            AppManager.shared.showUserNoLoginAlert(title: appName, message: "User not Login") { (login) in
//                
//                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = testController
//                
//            }
//            
//            } else if selectedIndex == 2 {
//            
//            AppManager.shared.showUserNoLoginAlert(title: appName, message: "User not Login") { (login) in
//                
//                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = testController
//            }
//            
//        } else if selectedIndex == 3 {
//            
//            AppManager.shared.showUserNoLoginAlert(title: appName, message: "User not Login") { (login) in
//                
//                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = testController
//            }
//            
//        } else if selectedIndex == 4 {
//            
//            AppManager.shared.showUserNoLoginAlert(title: appName, message: "User not Login") { (login) in
//                
//                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = testController
//            }
//            
//        } else {
//            
//            AppManager.shared.showUserNoLoginAlert(title: appName, message: "User not Login") { (login) in
//                
//                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = testController
//                
//            }
//        }
//        
////        if tabBar.selectedItem == HomeVC {
////
////        } else if item == HomeVC{
////
////        }
        
    }
    
//    func tabBarController(_ tabBarController: UITabBarController,
//                          shouldSelect viewController: UIViewController) -> Bool{
//        let index = tabBarController.viewControllers?.index(of: viewController)
//        return true// you decide
    
//}
    
    
    

    
    

}


extension TabBarController : SWRevealViewControllerDelegate {
    
    func menusettup() {
        
        //    btnMenu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        //        menubutton.target = self.revealViewController()
        //        menubutton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        cv = self.revealViewController()
        cv.delegate = self as SWRevealViewControllerDelegate
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
    // MARK: - swrevealviewcontroller delegate -
    
    func revealController(_ revealController: SWRevealViewController!, animateTo position: FrontViewPosition)
    {
        if position == FrontViewPosition.right{
            
            if self.view.viewWithTag(9966) == nil {
                let coverView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
                coverView.tag = 9966
                coverView.backgroundColor = UIColor.black
                coverView.alpha = 0.0;
                UIView.animate(withDuration: 0.3, animations: {
                    coverView.alpha = 0.7;
                })
                self.view.addSubview(coverView)
            }
        }
        else{
            
            let coverView = self.view.viewWithTag(9966)
            UIView.animate(withDuration: 0.3, animations: {
                coverView?.alpha = 0.0;
            }, completion: { (true) in
                coverView?.removeFromSuperview()
            })
        }
    }
}

extension UITabBarController {
    func setTabBarVisible(visible:Bool, duration: TimeInterval, animated:Bool) {
        if (tabBarIsVisible() == visible) { return }
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        
        // animation
        UIViewPropertyAnimator(duration: duration, curve: .linear) {
            self.tabBar.frame.offsetBy(dx:0, dy:offsetY)
            self.view.frame = CGRect(x:0,y:0,width: self.view.frame.width, height: self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
            }.startAnimation()
    }
    
    func tabBarIsVisible() ->Bool {
        return self.tabBar.frame.origin.y < UIScreen.main.bounds.height
    }
}
