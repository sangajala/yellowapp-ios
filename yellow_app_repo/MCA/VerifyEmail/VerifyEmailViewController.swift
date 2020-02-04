//
//  VerifyEmailViewController.swift
//  MCA
//
//  Created by Goutham Devaraju on 29/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class VerifyEmailViewController: BaseViewController {

    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func gotoLoginEvent(_ sender: Any) {
        
//        self.view.window!.rootViewController?.dismissViewControllerAnimated(false, completion: nil)
        
        self.navigationController?.backToViewController(viewController: LoginViewController.self)
        
    }
    
    
    @IBAction func skipAndExploreEvent(_ sender: Any) {
        
        
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    


}


