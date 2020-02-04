//
//  DetailListTableViewCell.swift
//  MCA
//
//  Created by Goutham Devaraju on 14/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
import AARatingBar

class DetailListTableViewCell: UITableViewCell {

    @IBOutlet var viewBackground: UIView!
    @IBOutlet var viewRatingBar: AARatingBar!
    @IBOutlet var imageViewDetailList: UIImageView!
    @IBOutlet var labelDays: UILabel!
    @IBOutlet var labelViews: UILabel!
    @IBOutlet var labelLocation: UILabel!
    @IBOutlet var imageIconDetailList: UIImageView!
    @IBOutlet var labelTitleDetailedList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBackground.layer.shadowColor = UIColor.backgroundShadowColor.cgColor
//        viewRatingBar.isEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
