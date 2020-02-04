//
//  OptionsTableViewCell.swift
//  MCA
//
//  Created by Goutham Devaraju on 06/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {

    @IBOutlet var viewBusiness: UIView!
    @IBOutlet var labelNumberOfBusinesses: UILabel!
    
    @IBOutlet var viewPromotions: UIView!
    @IBOutlet var labelNumberOfPromotions: UILabel!
    
    @IBOutlet var viewEvents: UIView!
    @IBOutlet var labelNumberOfEvents: UILabel!
    
    @IBOutlet var viewPosts: UIView!
    @IBOutlet var labelNumberOfPosts: UILabel!
    
    var viewControllerHome: HomeViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        viewBusiness.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewPromotions.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewEvents.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        viewPosts.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
    }
    
    func setHomeViewControllerObject(viewController: HomeViewController){
        viewControllerHome = viewController
    }
    
    @IBAction func businessButtonAction(_ sender: Any) {
        print("Business button event")
        viewControllerHome.selectedCategoryType = CategoryType.business
        viewControllerHome.performSegue(withIdentifier: "mainToDetail", sender: nil)
    }
    
    @IBAction func promotionsButtonEvent(_ sender: Any) {
        print("Promotions button event")
        viewControllerHome.selectedCategoryType = CategoryType.promotions
        viewControllerHome.performSegue(withIdentifier: "mainToDetail", sender: nil)
    }
    
    @IBAction func eventButtonEvent(_ sender: Any) {
        print("Events button event")
        viewControllerHome.selectedCategoryType = CategoryType.events
        viewControllerHome.performSegue(withIdentifier: "mainToDetail", sender: nil)
    }
    
    @IBAction func postsButtonEvent(_ sender: Any) {
        print("Posts button event")
//        viewControllerHome.selectedCategoryType = CategoryType.promotions
//        viewControllerHome.performSegue(withIdentifier: "mainToDetail", sender: nil)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
