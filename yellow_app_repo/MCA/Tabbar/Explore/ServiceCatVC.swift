//
//  ServiceCatVC.swift
//  MCA
//
//  Created by Arthonsys Ben on 04/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class ServiceCatVC: UIViewController {
    
    @IBOutlet weak var viewNoDataFound: UIView!
    
    @IBOutlet weak var collectionViewHightConstant: NSLayoutConstraint!
    @IBOutlet weak var collectionViewSlider: UICollectionView!
    @IBOutlet weak var tableViewServiceList: UITableView!
    
    var community_Id : Int?
    
    var categoriesData: CategoriesHomeModel3!
    var serviceCategoryListModel: ServiceCategoryListModel!
    var titleHeder: String?
    
    var isFrome = ""
    
    @IBOutlet weak var lblTitleHeder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewNoDataFound.isHidden = true
        startTimer()
        let community_iduser_ID = UserDefaults.standard.object(forKey: key_location_id) as? Int ?? 0
        community_Id = community_iduser_ID
        getServiceCategories(community_Id: community_Id ?? 0)
        getCategoriesSliderImages(community_Id: community_Id ?? 0)
//        lblTitleHeder.text = titleHeder
        // Do any additional setup after loading the view.
        
    }
    
    func getCategoriesSliderImages(community_Id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        let payloadParams = ["CommunityId": community_Id] as [String : Any]
        
//        helper.startLoader(view: self.view)
        
        _ = NetworkInterface.getRequest(.get_service_category_list, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
//            helper.stopLoader()
            
            guard let _ = data else {
                
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(ServiceCategoryListModel.self, from: data!)
                print(response)
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(jsonData)
                } catch let myJSONError {
                    print(myJSONError)
                }
                self.serviceCategoryListModel = response
                self.collectionViewSlider.reloadData()
                
                //Passing back values to ViewController to make use of the data
                //                self.homeViewController?.homeDataResponse(homeModel: response)
            }
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                self.collectionViewSlider.reloadData()
            }
        }
    }
    
    func getServiceCategories(community_Id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        let payloadParams = ["CommunityId": community_Id] as [String : Any]
        
        helper.startLoader(view: self.view)
        
        _ = NetworkInterface.getRequest(.home_categories, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                
                self.tableViewServiceList.reloadData()
                
                
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(CategoriesHomeModel3.self, from: data!)
                print(response)
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(jsonData)
                } catch let myJSONError {
                    print(myJSONError)
                }
                
                self.categoriesData = response
                self.tableViewServiceList.reloadData()
                
                //Passing back values to ViewController to make use of the data
                //                self.homeViewController?.homeDataResponse(homeModel: response)
            }
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
                self.tableViewServiceList.reloadData()
            }
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        
//        tabBarController?.selectedIndex = 0
        mainTabbarObj.selectedIndex = 0
        
//        if isFrome == "ExploreViewController" {
//
////            mainTabbarObj.delegate = self as? UITabBarControllerDelegate
//            mainTabbarObj.selectedIndex = 0
//            self.navigationController?.popViewController(animated: true)
//
//        } else {
//
//            self.navigationController?.popViewController(animated: true)
//
//        }
    }
}

class CollectionViewCellSlider: UICollectionViewCell {
    @IBOutlet weak var imageViewLinkSlider: UIImageView!
}

extension ServiceCatVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if serviceCategoryListModel == nil {
            collectionViewHightConstant.constant = 0
            return 0
        } else if serviceCategoryListModel.categoryimagesDetails.count == 0{
            collectionViewHightConstant.constant = 0
            return 0
        }
        else{
            collectionViewHightConstant.constant = 180
            return serviceCategoryListModel.categoryimagesDetails.count > 0 ? serviceCategoryListModel.categoryimagesDetails.count : 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellSlider", for: indexPath) as! CollectionViewCellSlider
        let categorieModel = serviceCategoryListModel.categoryimagesDetails[indexPath.row]
        let image_url = categorieModel.image
        
        let url = URL(string: image_url)
//        cell.imageViewLinkSlider.kf.setImage(with: url)
        cell.imageViewLinkSlider.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (collectionView.frame.size.width), height: 180)
    }
    
    func startTimer() {
        _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollAutomatically(_:)), userInfo: nil, repeats: true);
    }
    
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        if let coll  = collectionViewSlider {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < serviceCategoryListModel.categoryimagesDetails.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
                
            }
        }
    }
    
}

class TableViewServiceCell: UITableViewCell {
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
}

extension ServiceCatVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categoriesData == nil {
//            viewNoDataFound.isHidden = false
            return 0
        } else  if categoriesData.categoriesDetails.count == 0 {
            viewNoDataFound.isHidden = false
            return 0
        }
        else {
            viewNoDataFound.isHidden = true
            return categoriesData.categoriesDetails.count > 0 ? categoriesData.categoriesDetails.count : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewServiceCell", for: indexPath) as! TableViewServiceCell
        
        let categorieModel = categoriesData.categoriesDetails[indexPath.row]
        let image_url = categorieModel.catIcon
        
        let url = URL(string: image_url ?? "")
//        cell.imgItem.kf.setImage(with: url)
        cell.imgItem.kf.setImage(with: url, placeholder: UIImage(named :"default"), options: nil, progressBlock: nil) { (result) in
        }
        
        cell.lblItemName.text = categorieModel.categoryName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ServiceSubCategoryVC") as! ServiceSubCategoryVC
        let categorieModel = categoriesData.categoriesDetails[indexPath.row]
        vc.catID = categorieModel.categoryID
        vc.titleHeder = categorieModel.categoryName
        vc.image = categorieModel.catIcon
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
