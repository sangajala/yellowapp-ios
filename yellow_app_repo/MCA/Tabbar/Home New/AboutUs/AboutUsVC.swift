//
//  AboutUsVC.swift
//  MCA
//
//  Created by Arthonsys Ben on 03/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
import Kingfisher

class AboutUsVC: UIViewController {

    @IBOutlet weak var collectionViewEvent: UICollectionView!
    @IBOutlet weak var imgViewTop: UIImageView!
    @IBOutlet weak var lblItemTitle: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var aboutUsModel : AboutUsModel!
    var eventListModel : EventListModel!
    var organizID : Int?
    
    var selectedCategoryType: CategoryType!

    var selectedEventID : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let community_iduser_ID = UserDefaults.standard.object(forKey: key_location_id) as? Int ?? 0
        print(community_iduser_ID)
//        community_id = community_iduser_ID as? Int ?? 0
        
        getDataOrganizations(org_Id: organizID ?? 0)
        getDataEvent(Community_Id: community_iduser_ID)
        // Do any additional setup after loading the view.
    }
    
    func getDataOrganizations(org_Id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        let payloadParams = ["Organisationid": org_Id] as [String : Any]
        
        helper.startLoader(view: self.view)
        
        _ = NetworkInterface.getRequest(.get_organization, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(AboutUsModel.self, from: data!)
                print(response)
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(jsonData)
                } catch let myJSONError {
                    print(myJSONError)
                }
                self.aboutUsModel = response
                
                let image_url = self.aboutUsModel.image

                let url = URL(string: image_url)
//                self.imgViewTop.kf.setImage(with: url)
                self.imgViewTop.kf.setImage(with: url, placeholder: UIImage(named :"default_big"), options: nil, progressBlock: nil) { (result) in
                }
                self.lblItemTitle.text = self.aboutUsModel.title
                self.lblLocation.text = self.aboutUsModel.location
                self.lblDescription.text = self.aboutUsModel.aboutUsModelDescription
                
                //Passing back values to ViewController to make use of the data
                //                self.homeViewController?.homeDataResponse(homeModel: response)
            }
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
    
    func getDataEvent(Community_Id: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        let payloadParams = ["Communityid": Community_Id] as [String : Any]
        
        _ = NetworkInterface.getRequest(.get_event, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            guard let _ = data else {
                DispatchQueue.main.async {
//                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(EventListModel.self, from: data!)
                print(response)
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(jsonData)
                } catch let myJSONError {
                    print(myJSONError)
                }
                self.eventListModel = response
                self.collectionViewEvent.reloadData()
                
                //Passing back values to ViewController to make use of the data
                //                self.homeViewController?.homeDataResponse(homeModel: response)
            }
            catch{
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSeeAllEventAction(_ sender: UIButton) {
        
        
        if let viewController = ((self.tabBarController?.viewControllers?[1] as! UINavigationController).viewControllers[0]) as? DetailListViewController {
            
            print(viewController)
            viewController.categoryType = CategoryType.events
            //            viewController.Req_cat_ID = catID ?? 0
            //            viewController.Req_sub_Cat_ID = selectSubCat
            //            viewController.Req_title = selectSubCatTitle
            
            tabBarController?.selectedIndex = 1
            
        }
        
        
//        performSegue(withIdentifier: "mainToDetail", sender: nil)
        
    }
    
}

class CollectionViewEventCell: UICollectionViewCell {
    
    @IBOutlet weak var viewShdow: UIView!
    @IBOutlet weak var viewShdow2: UIView!
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
}


extension AboutUsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if eventListModel == nil {
            return 0
        }
        else{
            return eventListModel.eventsList.count > 0 ? eventListModel.eventsList.count : 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewEventCell", for: indexPath) as! CollectionViewEventCell
        
        let event_model = eventListModel.eventsList[indexPath.row]
        let image_url = event_model.image
        let url = URL(string: image_url)
        cell.imgEvent.kf.setImage(with: url)
        cell.lblTitle.text = event_model.title
        cell.lblLocation.text = event_model.location
        
        let date = event_model.createdDatetime
        print(date)
        
        cell.viewShdow.layer.shadowColor = UIColor.gray.cgColor
        cell.viewShdow.layer.shadowOpacity = 0.5
        cell.viewShdow.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.viewShdow.layer.shadowRadius = 2
        
        cell.viewShdow2.layer.cornerRadius = 2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         let event_model = eventListModel.eventsList[indexPath.row]
            
            selectedEventID = event_model.eventID
           selectedCategoryType = CategoryType.events
//            let type : CategoryType!
//            selectedCategoryType = type.events
//                CategoryType.events
            performSegue(withIdentifier: "detailsToDescription", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailsToDescription" {
            let viewController = segue.destination as! DetailDescriptionViewController
            viewController.selectedServiceID = selectedEventID
            viewController.categoryType = selectedCategoryType
        }
        
        if segue.identifier == "mainToDetail" {
            let viewController:DetailListViewController = segue.destination as! DetailListViewController
            viewController.categoryType = CategoryType.events
        }
    }
}
