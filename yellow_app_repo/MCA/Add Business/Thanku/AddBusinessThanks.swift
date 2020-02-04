//
//  AddBusinessThanks.swift
//  YELLOW APP
//
//  Created by Apple on 25/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class AddBusinessThanks: UIViewController {
    
    var backVC : AddBusiness!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func btnDoneEvent(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        if backVC != nil {
            backVC.btnback(UIButton())
        }

        
    }
    

}
