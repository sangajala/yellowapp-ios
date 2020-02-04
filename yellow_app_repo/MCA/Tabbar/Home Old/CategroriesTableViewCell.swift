//
//  CategroriesTableViewCell.swift
//  MCA
//
//  Created by Goutham Devaraju on 05/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class CategroriesTableViewCell: UITableViewCell {

    //MARK: - Properties
    @IBOutlet private weak var categorySlidesCollectionView: UICollectionView!
    @IBOutlet var labelModuleDescription: UILabel!
    @IBOutlet var buttonSeeAll: UIButton!
    
    var viewControllerHome: HomeViewController!
    
    func setViewControllerObject(viewController: HomeViewController){
        viewControllerHome = viewController
    }
    
    //MARK: - Button Actions
    @IBAction func seeAllEvent(_ sender: UIButton) {
        print("see all action")
        viewControllerHome.seeAllAction(withButton: sender)
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        
        categorySlidesCollectionView.delegate = dataSourceDelegate
        categorySlidesCollectionView.dataSource = dataSourceDelegate
        categorySlidesCollectionView.tag = row
        categorySlidesCollectionView.reloadData()
        
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
