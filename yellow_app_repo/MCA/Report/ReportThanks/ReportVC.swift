//
//  ReportVC.swift
//  asf
//
//  Created by Arthonsys Ben on 24/10/19.
//  Copyright © 2019 Arthonsys Ben. All rights reserved.
//

import UIKit

class ReportThanksVC: UIViewController {

    @IBOutlet weak var ViewBig: UIView!
    
    var backVC : ReportViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ViewBig.layer.masksToBounds = false
        ViewBig.layer.shadowOffset = CGSize(width:0, height: 0)
        ViewBig.layer.shadowRadius = 1
        ViewBig.layer.shadowOpacity = 1
        ViewBig.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
    }
   
    @IBAction func btnBackAction(_ sender: UIButton) {
      
        self.navigationController?.popViewController(animated: true)
        if backVC != nil {
            backVC.backButtonEvent(UIButton())
        }
    }
}
