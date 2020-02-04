//
//  LinkSlidesTableViewCell.swift
//  MCA
//
//  Created by Goutham Devaraju on 05/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class LinkSlidesTableViewCell: UITableViewCell {

    @IBOutlet private weak var linkSlidesCollectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        
        linkSlidesCollectionView.delegate = dataSourceDelegate
        linkSlidesCollectionView.dataSource = dataSourceDelegate
        linkSlidesCollectionView.tag = row
        linkSlidesCollectionView.reloadData()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
