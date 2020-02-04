//
//  LocationSelectTableViewCell.swift
//  MCA
//
//  Created by Goutham Devaraju on 02/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class LocationSelectTableViewCell: UITableViewCell {

//    @IBOutlet var viewBackground: UIView!
//    @IBOutlet var imageLocationIcon: UIImageView!
//    @IBOutlet var imageSelectionIcon: UIImageView!
    
    @IBOutlet var labelTitle: UILabel!
//    @IBOutlet var labelComingSoon: UILabel!
    @IBOutlet weak var imageRightMark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
//        viewBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class HomeLocationSelectTableViewCell: UITableViewCell {
    
    //    @IBOutlet var viewBackground: UIView!
    //    @IBOutlet var imageLocationIcon: UIImageView!
    //    @IBOutlet var imageSelectionIcon: UIImageView!
    
    @IBOutlet var labelTitle: UILabel!
    //    @IBOutlet var labelComingSoon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        //        viewBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
