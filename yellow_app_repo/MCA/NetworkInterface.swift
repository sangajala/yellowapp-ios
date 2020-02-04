//
//  NetworkInterface.swift
//  MCA
//
//  Created by Goutham Devaraju on 21/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

let CONTENTTYPE = "Content-Type"
let APPLICATION_JSON = "application/json"
let FORM_URL_ENCODE =  "application/x-www-form-urlencoded"
let ACCEPT =  "Accept"
let XREQUESTID = "X-RequestId"

enum DataErrors : Error {
    case invalidJSONData
    case dataParseError
    case noData
}

enum NetworkError : Error {
    case httpStatus201
    case httpStatus204
    case httpStatus400
    case httpStatus404
    case httpStatus410
    case httpStatusUnknownError
}

enum POST_RequestType {
    
    //Authentication
    case register_user_post
    case login_user_post
    case forgot_password_post
    case report_post
    
    case add_wallet_business_post
    case add_wallet_events_post
    case add_wallet_promotions_post
    case add_wallet_organisations_post
    
    
    case remove_wallet_business_post
    case remove_wallet_events_post
    case remove_wallet_promotions_post
    case remove_wallet_organisations_post
//    Service/Removewallet
    
    case add_Service_Register_post
    case service_delete
    
    case Service_Multipal_Image_Uplode
    case Service_UpdateService
    case Service_Delete_image

}

enum GET_RequestType {
    
    //Community details
    case community_users_get
    
    //Locations
    case community_locations_get
    
    //Home screen details
    case home_get
    case home_get_promotions
    case home_organizations
    case home_categories
    case home_get_services

    
    //Category details
    case services_get
    case events_get
    case promotions_get
    case organisations_get
    
    //Individual details
    case services_individual_get
    case events_individual_get
    case promotions_individual_get
    case organisations_individual_get
    
    //Business contact details
    case services_contact_details_get
    case events_contact_details_get
    case promotions_contact_details_get
    case organisations_contact_details_get
    
    //Favourite Businesses
    case favourite_businesses_details_get
    case favourite_businesses_Event
    case favourite_businesses_Promotions
    case favourite_businesses_Organization
    
    
    case get_businesses_category
    case get_businesses_sub_category
    
    //About Us
    case get_organization
    case get_event
    case get_service_category_list
    case get_service_sub_category_list
    case get_Business_list
    case get_Profile_data
    
    case get_PromotionDiscount
    case get_EventDiscount

    

}

struct RequestConstants {
    //static let BaseURL = "http://mca.bananaapps.co.uk"
//    static let BaseURL =  isLocationBased == 0 ? "http://mcaindia.bananaapps.co.uk" : "http://mca.bananaapps.co.uk"
    static let BaseURL =  isLocationBased == 0 ? "https://yellowappcms.co.uk" : "https://yellowappcms.co.uk"
    // https://yellowappcms.co.uk/api/

}

class NetworkRequests {
    
    static func BaseURL() -> String {
        let baseURL = RequestConstants.BaseURL
        return baseURL
    }
    
    // GET Requests
    static func getRequestofType(_ requestType:GET_RequestType, headers:NSDictionary?,  urlParams:NSDictionary?) -> URLRequest {
    
        let request:URLRequest!

        switch requestType {

        case .community_users_get:
            let path = "/api/Common/CommunityUsers"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .community_locations_get:
            let path = "/api/Common/CommunityLocations"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .home_get:
            let path = "/api/Common/Home"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .services_get:
            let path = "/api/Services"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .services_individual_get:
            let path = "/api/Service/ServiceByID"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .events_individual_get:
            let path = "/api/Service/EventByID"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .promotions_individual_get:
            let path = "/api/Promotions/PromotionByID"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .organisations_individual_get:
            let path = "/api/Organization/OrganizationById"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .favourite_businesses_details_get:
            let path = "/api/Service/FavServices"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break

        case .events_get:
            let path = "/api/Events"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .promotions_get:
            let path = "/api/Promotions"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .organisations_get:
            let path = "/api/Organizations"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .services_contact_details_get:
            let path = "/api/Service/ServiceContact"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .events_contact_details_get:
            let path = "/api/Event/EventContact"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .promotions_contact_details_get:
            let path = "/api/Promotions/PromotionContact"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .organisations_contact_details_get:
            let path = "/api/Organization/OrganizationContact"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .home_get_promotions:
            let path = "/api/Promotions"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        
        case .home_organizations:
            let path = "/api/Organizations"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .home_categories:
            let path = "/api/Common/Categories"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .get_businesses_category:
            let path = "/api/Common/Categories"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .get_businesses_sub_category:
            let path = "/api/Common/SubCategories"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .get_organization:
            let path = "/api/Organization/OrganizationById"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .get_event:
            let path = "/api/Events"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .get_service_category_list:
            let path = "/api/Common/CategorySliderImages"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .get_service_sub_category_list:
            let path = "/api/Common/SubCategories"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .get_Business_list:
            let path = "/api/Service/ServiceByUser"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            
        case .home_get_services:
            let path = "/api/Services"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .get_Profile_data:
            let path = "/api/user/Profile"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .favourite_businesses_Event:
            let path = "/api/Event/FavEvents"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .favourite_businesses_Promotions:
            let path = "/api/Promotions/FavPromotions"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .favourite_businesses_Organization:
            let path = "/api/Organization/FavOrganisation"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .get_PromotionDiscount:
            let path = "/api/Promotions/PromotionDiscount"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        case .get_EventDiscount:
            let path = "/api/Event/EventDiscount"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
        }
    
        return request
    }
    
    // POST Requests
    static func postRequestofType(_ requestType:POST_RequestType,headers:NSDictionary?, urlParams:NSDictionary?, payload :[String:Any]? ) -> URLRequest {
        var request:URLRequest!
        
        switch requestType {
            
        case .register_user_post:
            let authPath = "/api/user/Register"
            let endpoint = RequestConstants.BaseURL + authPath
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
            
        case .login_user_post:
            let authPath = "/api/user/Login"
            let endpoint = RequestConstants.BaseURL + authPath
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
            
        case .forgot_password_post:
            let authPath = "/api/user/ForgotPassword"
            let endpoint = RequestConstants.BaseURL + authPath
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
            
        case .report_post:
            let authPath = "/api/Common/Report"
            let endpoint = RequestConstants.BaseURL + authPath
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
            
        case .add_wallet_business_post:
            let authPath = "/api/Service/Addwallet"
            let parmUrl = payload?["parmurl"] as? String ?? ""
            let endpoint = RequestConstants.BaseURL + authPath + parmUrl
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
            
        case .add_wallet_events_post:
            let authPath = "/api/Event/Addwallet"
            let parmUrl = payload?["parmurl"] as? String ?? ""
            let endpoint = RequestConstants.BaseURL + authPath + parmUrl
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
            
        case .add_wallet_promotions_post:
            let authPath = "/api/Promotions/Addwallet"
            let parmUrl = payload?["parmurl"] as? String ?? ""
            let endpoint = RequestConstants.BaseURL + authPath + parmUrl
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
            
        case .add_wallet_organisations_post:
            let authPath = "/api/Organization/Addwallet"
            let parmUrl = payload?["parmurl"] as? String ?? ""
            let endpoint = RequestConstants.BaseURL + authPath + parmUrl
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
            
        case .add_Service_Register_post:
            let authPath = "/api/Service/Register"
            let endpoint = RequestConstants.BaseURL + authPath
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
        case .service_delete:
            let authPath = "/api/Service/DeleteService"
            let parmUrl = payload?["Serviceid"] as? Int ?? 0
            let endpoint = RequestConstants.BaseURL + authPath + "?Serviceid=\(parmUrl)"
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
            
        case .remove_wallet_business_post:
            let authPath = "/api/Service/Removewallet"
            let parmUrl = payload?["parmurl"] as? String ?? ""
            let endpoint = RequestConstants.BaseURL + authPath + parmUrl
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
        case .remove_wallet_promotions_post:
            let authPath = "/api/Promotions/Removewallet"
            let parmUrl = payload?["parmurl"] as? String ?? ""
            let endpoint = RequestConstants.BaseURL + authPath + parmUrl
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
        case .remove_wallet_events_post:
            let authPath = "/api/Event/Removewallet"
            let parmUrl = payload?["parmurl"] as? String ?? ""
            let endpoint = RequestConstants.BaseURL + authPath + parmUrl
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
        case .remove_wallet_organisations_post:
            let authPath = "/api/Organization/Addwallet"
            let parmUrl = payload?["parmurl"] as? String ?? ""
            let endpoint = RequestConstants.BaseURL + authPath + parmUrl
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
        case .Service_Multipal_Image_Uplode:
            
            let authPath = "/api/Service/Images"
            let endpoint = RequestConstants.BaseURL + authPath
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
        case .Service_UpdateService:
            
            let authPath = "/api/Service/UpdateService"
            let endpoint = RequestConstants.BaseURL + authPath
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
            
        case .Service_Delete_image:
            
            let authPath = "/api/Service/DeleteServiceImage"
            let parmUrl = payload?["parmurl"] as? String ?? ""
            let endpoint = RequestConstants.BaseURL + authPath + parmUrl
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
        }
        
        return request
    }
    
    
    static func createGETRequest(_ baseURL:String , headers:NSDictionary?, urlParams:NSDictionary?) -> URLRequest {
        
        var headerAsString:String = ""
        
        if (urlParams != nil && urlParams!.count > 0) {
            
            headerAsString = "?"
            
            for (key, value) in urlParams! {
                headerAsString += "\(key)=\(value)&"
            }
            
            //This removes the extra last "&" appended at the end
            headerAsString.removeLast()
        }
        
        let fullUrlString = baseURL + headerAsString;
        let urlPath = NSString(format: fullUrlString as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue)!
        let url = URL(string: urlPath)
        let request = NSMutableURLRequest(url: url!)
        print(fullUrlString)
        print(headers!)
        
        if headers != nil {
            for (key,value) in headers! {
                request.addValue(value as! String, forHTTPHeaderField: key as! String)
            }
        }
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
    
    static func createPOSTRequest(_ baseURL:String ,headers:NSDictionary?,urlParams: NSDictionary?, payload:[String:Any]) -> URLRequest {
        
        var headerAsString:String = ""
        
        if (urlParams != nil && urlParams!.count > 0) {
            
            for (key,_) in urlParams! {
                // headerAsString += separator
                headerAsString += key as! String
                // headerAsString += "="
                // headerAsString += value as! String
                // separator = "&"
            }
        }
        
        let fullUrlString = baseURL + headerAsString;
        print(fullUrlString)
        
        let url = URL(string: fullUrlString)
        let request = NSMutableURLRequest(url: url!)
        if headers != nil {
            for (key,value) in headers! {
                request.addValue(value as! String, forHTTPHeaderField: key as! String)
            }
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: payload, options: [])
            let post = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
            request.httpBody = post.data(using: String.Encoding.utf8);
        }catch {
            AppManager.shared.printLog(stringToPrint: "json error: \(error)")
        }
        request.httpMethod = "POST"
        request.timeoutInterval = 80
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
    
}


typealias RequestCompletionType = (Bool, Data?, HTTPURLResponse?, Error?, [AnyHashable:Any]?) -> (Void)

class NetworkInterface: NSObject {
    
    static func getRequest(_ requestType:GET_RequestType , headers:NSDictionary? = [:], params:NSDictionary? = [:], requestCompletionHander:@escaping RequestCompletionType) -> URLSessionDataTask {
        
        return self.sendAsyncRequest(NetworkRequests.getRequestofType(requestType, headers: headers, urlParams: params)) { (success, data, response, error, headers) -> (Void) in
            
            if (success == true && response != nil) {
                
                let httpResponse: HTTPURLResponse = response!
                let httpStatusCode = httpResponse.statusCode
                
                AppManager.shared.printLog(stringToPrint: "Response Code:\(httpStatusCode)")
                
                switch httpStatusCode {
                
                case 200:
                    let succcess = (data != nil)
                    if (succcess) {
                        requestCompletionHander(succcess, data, response, nil, httpResponse.allHeaderFields)
                    } else {
                        requestCompletionHander(false, nil, response , DataErrors.invalidJSONData, httpResponse.allHeaderFields)
                    }
                    break
                case 204:
                    requestCompletionHander(false, nil, response, NetworkError.httpStatus204, httpResponse.allHeaderFields)
                    break
                case 404:
                    requestCompletionHander(false,nil,response, NetworkError.httpStatus404, httpResponse.allHeaderFields)
                    break
                case 410:
                    requestCompletionHander(false, nil, response, NetworkError.httpStatus410, httpResponse.allHeaderFields)
                    break
                default:
                    requestCompletionHander(false,nil,response,NetworkError.httpStatusUnknownError, httpResponse.allHeaderFields)
                    break
                }
            }
            else {
                requestCompletionHander(false,nil,response,error, nil)
            }
        }
    }
    
    
    static func postRequest(_ requestType: POST_RequestType, headers: NSDictionary? = [:], params: NSDictionary? = [:], payload: [String: Any], requestCompletionHander: @escaping RequestCompletionType) -> URLSessionDataTask{
        
        let networkRequest = NetworkRequests.postRequestofType(requestType, headers: headers, urlParams: params, payload: payload)
        
        return self.sendAsyncRequest(networkRequest){ (success, data, response, error, headers)  -> (Void) in
            
            if (success == true && response != nil) {
                
                let httpResponse: HTTPURLResponse = response!
                let httpStatusCode = httpResponse.statusCode
                
                AppManager.shared.printLog(stringToPrint: "-----------------------------------------> Response Code:\(httpStatusCode)")
                
                switch httpStatusCode {
                    
                case 200:
                    let succcess = (data != nil)
                    if (succcess) {
                        requestCompletionHander(succcess, data, response, nil, httpResponse.allHeaderFields)
                    } else {
                        requestCompletionHander(false, data, response , DataErrors.invalidJSONData, httpResponse.allHeaderFields)
                    }
                    break
                case 204:
                    requestCompletionHander(false, data, response, NetworkError.httpStatus204, httpResponse.allHeaderFields)
                    break
                case 404:
                    requestCompletionHander(false,data,response, NetworkError.httpStatus404, httpResponse.allHeaderFields)
                    break
                case 410:
                    requestCompletionHander(false, data, response, NetworkError.httpStatus410, httpResponse.allHeaderFields)
                    break
                default:
                    if data != nil{
                        requestCompletionHander(false,data,response,NetworkError.httpStatusUnknownError, httpResponse.allHeaderFields)
                    }
                    else{
                        requestCompletionHander(false,data,response,NetworkError.httpStatusUnknownError, httpResponse.allHeaderFields)
                    }
                    break
                }
            }
            else {
                
                if response != nil{
                    let httpResponse: HTTPURLResponse = response!
                    let httpStatusCode = httpResponse.statusCode
                    
                    AppManager.shared.printLog(stringToPrint: "Response Code:\(httpStatusCode)")
                    
                    requestCompletionHander(false,nil,response,error, nil)
                }
                else{
                    
                    AppManager.shared.printLog(stringToPrint: "Response Code: 0")
                    
                    requestCompletionHander(false,nil,nil,error, nil)
                }
            }
        }
    }
    
    
    
    static fileprivate func sendAsyncRequest(_ request:URLRequest, completionHandler:@escaping RequestCompletionType) -> URLSessionDataTask{
        
        let task = URLSession.shared.dataTask(with: request) { ( data_,response, error) in
            
            DispatchQueue.main.async {
                
                guard let data = data_, let httpUrlResponse = response as? HTTPURLResponse else {
                    completionHandler(false, nil, nil, DataErrors.invalidJSONData, nil)
                    return
                }
                
                completionHandler(true, data, httpUrlResponse, nil, httpUrlResponse.allHeaderFields)
            }
        }
        
        task.resume()
        return task
    }
    
}
