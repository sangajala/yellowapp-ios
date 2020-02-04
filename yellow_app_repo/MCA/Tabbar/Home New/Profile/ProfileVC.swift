//
//  ProfileVC.swift
//  YELLOW APP
//
//  Created by Apple on 10/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileVC: UIViewController {
    
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblLastName: UILabel!
    
    @IBOutlet weak var lblMonumber: UILabel!
    
    @IBOutlet weak var lblGmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UserDefaults.standard.object(forKey: key_user_id) != nil){
            let user_id = UserDefaults.standard.value(forKey: key_user_id) as! Int
            Api_Profile_Data(user_Id: user_id)
        }


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (UserDefaults.standard.object(forKey: key_user_id) != nil){
            let user_id = UserDefaults.standard.value(forKey: key_user_id) as! Int
            Api_Profile_Data(user_Id: user_id)
        }

    }
    
    
    func Api_Profile_Data (user_Id : Int){
        
        if !Reachability.isConnectedToNetwork(){
            AppManager.shared.showOkAlert(title: "Error", message: internetError, view: self, onCompletion: { (string: String) -> () in })
            return
        }
        
        helper.startLoader(view: self.view)
        
        let headers = [ ACCEPT : APPLICATION_JSON]
        
        let payloadParams = ["userid": user_Id] as [String : Any]
        
        print(payloadParams)
        
        _ = NetworkInterface.getRequest(.get_Profile_data, headers: headers as NSDictionary , params: payloadParams as NSDictionary) { (success, data, response, error, header) -> (Void) in
            
            helper.stopLoader()
            
            guard let _ = data else {
                //                DispatchQueue.main.async {
                //                    AppManager.shared.showOkAlert(title: "Error", message: "No response from the server please try again later.", onCompletion: { (callBack: String) in })
                //                }
                return
            }
            
            do {
                
                print(data)
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                
                print(jsonData)
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(ProfileData.self, from: data!)
                AppManager.shared.profileDataModal = response

                print(response)
                
                // user Data set
                self.lblName.text? = (response.firstname)
                self.lblLastName.text? = (response.lastname)
                self.lblMonumber.text? = (response.phone)
                self.lblGmail.text? = (response.email)
                let imageurl = response.profilePic
                if imageurl != nil && imageurl != "" {
                    self.imageProfile.kf.setImage(with: URL(string: imageurl), placeholder: UIImage(named :"man_placeholder"), options: nil, progressBlock: nil) { (result) in
                }}
//
//                self.bussinessListModal = response
//                self.tableViewBusnessList.reloadData()
                
            }
            catch {
                
                AppManager.shared.printLog(stringToPrint: "API Error. Status Code: \(String(describing: response?.statusCode)).")
            }
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
