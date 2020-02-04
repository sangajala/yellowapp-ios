//
//  BarcodeImageDeatails.swift
//  YELLOW APP
//
//  Created by Apple on 22/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class BarcodeImageDeatails: UIViewController {

    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var imageBarcode: UIImageView!
    
    var dicdata = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblItemName.text? = dicdata.object(forKey: "title") as? String ?? ""
        imageBarcode.image = dicdata.object(forKey: "image") as? UIImage ?? UIImage()

    }
    
    @IBAction func btnBackEvent(_ sender: UIButton) {
       self.navigationController?.popViewController(animated: true)
    }

}
