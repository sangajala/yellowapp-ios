//
//  ServiceSubCategoryVC.swift
//  MCA
//
//  Created by Arthonsys Ben on 04/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class ServiceSubCategoryVC: UIViewController {

    @IBOutlet weak var viewNoDataFound: UIView!
    
    @IBOutlet weak var collectionViewSliderConstant: NSLayoutConstraint!
    @IBOutlet weak var collectionViewSlider: UICollectionView!
    @IBOutlet weak var tableViewServiceList: UITableView!
    
    var serviceCategoryListModel: ServiceCategoryListModel!
    var serviceSubCategoryModel: ServiceSubCategoryModel!
    
    var catID: Int?
    var community_Id : Int?
    var titleHeder : String?
    var image : String?
    
    var selectSubCat = 0
    var selectSubCatTitle = ""
    

    
    @IBOutlet weak var lblTitleHeder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewNoDataFound.isHidden = true
        
        let community_iduser_ID = UserDefaults.standard.object(forKey: key_location_id) as? Int ?? 0
        community_Id = community_iduser_ID

        startTimer()
        getServiceCategories(cat_ID: catID ?? 0, community_Id: community_Id ?? 0)
        getCategoriesSliderImages(community_Id: community_Id ?? 0)
        lblTitleHeder.text = titleHeder
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
                
                self.collectionViewSlider.reloadData()
                
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
            catch {
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
    
    func getServiceCategories(cat_ID: Int, community_Id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        let payloadParams = ["CatID": cat_ID,
                             "CommunityId": community_Id] as [String : Any]
        
        helper.startLoader(view: self.view)
        
        
        
        _ = NetworkInterface.getRequest(.get_service_sub_category_list, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                
                self.viewNoDataFound.isHidden = false

                
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(ServiceSubCategoryModel.self, from: data!)
                print(response)
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(jsonData)
                } catch let myJSONError {
                    print(myJSONError)
                }
                self.serviceSubCategoryModel = response
                self.tableViewServiceList.reloadData()
                
                //Passing back values to ViewController to make use of the data
                //                self.homeViewController?.homeDataResponse(homeModel: response)
            }
            catch{
                
                self.viewNoDataFound.isHidden = false
                
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

class CollectionViewCellSlider2: UICollectionViewCell {
    @IBOutlet weak var imageViewLinkSlider: UIImageView!
}

extension ServiceSubCategoryVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if serviceCategoryListModel == nil {
            collectionViewSliderConstant.constant = 0
            return 0
        } else if serviceCategoryListModel.categoryimagesDetails.count == 0{
            collectionViewSliderConstant.constant = 0
            return 0
        }
        else {
            collectionViewSliderConstant.constant = 180
            return serviceCategoryListModel.categoryimagesDetails.count > 0 ? serviceCategoryListModel.categoryimagesDetails.count : 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellSlider2", for: indexPath) as! CollectionViewCellSlider2
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

class TableViewSubServiceCell: UITableViewCell {
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
}

extension ServiceSubCategoryVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if serviceSubCategoryModel == nil {
//            viewNoDataFound.isHidden = false

            return 0
        } else if serviceSubCategoryModel.subCategoriesDetails.count  == 0 {
            viewNoDataFound.isHidden = false
            
            return 0
        }
        else{
            
            viewNoDataFound.isHidden = true

            return serviceSubCategoryModel.subCategoriesDetails.count > 0 ? serviceSubCategoryModel.subCategoriesDetails.count : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewSubServiceCell", for: indexPath) as! TableViewSubServiceCell
        
        let categorieModel = serviceSubCategoryModel.subCategoriesDetails[indexPath.row]
        let image_url = categorieModel.subcatIcon

        let url = URL(string: image_url)
//        cell.imgItem.kf.setImage(with: url)
        cell.imgItem.kf.setImage(with: url, placeholder: UIImage(named :"default"), options: nil, progressBlock: nil) { (result) in
        }

        cell.lblItemName.text = categorieModel.subcatName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if serviceSubCategoryModel != nil {
            
            let categorieModel = serviceSubCategoryModel.subCategoriesDetails[indexPath.row]

            selectSubCat = categorieModel.subcategoryID
            selectSubCatTitle = categorieModel.subcatName
            
//            performSegue(withIdentifier: "mainToDetail", sender: nil)
            
            if let viewController = ((self.tabBarController?.viewControllers?[1] as! UINavigationController).viewControllers[0]) as? DetailListViewController {
            
                print(viewController)
                
                viewController.categoryType = CategoryType.business
                viewController.Req_cat_ID = catID ?? 0
                
                viewController.Req_sub_Cat_ID = selectSubCat
                viewController.Req_title = selectSubCatTitle
                
                viewController.Req_sub_icon = categorieModel.subcatIcon
                
                viewController.req_cat_icon = image
                viewController.req_cat_name = titleHeder
                
                tabBarController?.selectedIndex = 1
                
            }


        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToDetail" {
            let viewController:DetailListViewController = segue.destination as! DetailListViewController
            viewController.categoryType = CategoryType.business
            viewController.Req_cat_ID = catID ?? 0
            viewController.Req_sub_Cat_ID = selectSubCat
            viewController.Req_title = selectSubCatTitle
        }
    }
}
