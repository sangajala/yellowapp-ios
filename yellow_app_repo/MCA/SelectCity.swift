//
//  SelectCity.swift
//  MCA
//
//  Created by Apple on 27/09/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class SelectCity: UIViewController {
    
    @IBOutlet weak var tableViewCities: UITableView!
    
    let cityArray = ["Vishakapatnam City"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

class CityTableView : UITableViewCell {
    
    @IBOutlet weak var lblCityName: UILabel!
}

extension SelectCity : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableView
        let index = cityArray[indexPath.row] as? String ?? ""
        cell.lblCityName.text = index
        
        if UserDefaults.standard.value(forKey: key_city_name) != nil{
            if let CommunityName = UserDefaults.standard.object(forKey: key_city_name) as? String {
                if index.uppercased() == CommunityName.uppercased() {
                    cell.lblCityName.textColor = UIColor.init(named: "ButtonColor")
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = cityArray[indexPath.row] as? String ?? ""
        print(index)
        UserDefaults.standard.setValue(index, forKey: key_city_name)

        GotoLocationSelect()
                
    }
    
    func GotoLocationSelect() {
        performSegue(withIdentifier: "SelctCityToLocationSelect", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}
