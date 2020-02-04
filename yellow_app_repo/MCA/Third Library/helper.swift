//
//  helper.swift
//  YELLOW
//
//  Created by Apple on 04/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

let screenRect = UIScreen.main.bounds
let screenWidth = screenRect.size.width
let screenHeight = screenRect.size.height

var LOCAL_TIME_ZONE: Int { return TimeZone.current.secondsFromGMT() }

import UIKit
import NVActivityIndicatorView
import SystemConfiguration

var internetError = "Can't connect. Please check your internet Connection"
var internetErrorTitle = "Error"

class helper: NSObject {
    
        //MARK:- Functions for alert
        
        class func showAlert(alertTitle : String, alertMsg : String, view: UIViewController) {
            
            let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
            
            let actionOK : UIAlertAction = UIAlertAction(title: "OK", style: .default) { (alt) in
                print("This is ok action");
            }
            alert.addAction(actionOK)
            
            view.present(alert, animated: true, completion: nil)
            
        }
        
        class func showAlertOKAction(_ alertTitle : String, _ alertMsg : String, _ okTitle : String, _ view: UIViewController, successClosure: @escaping (String?) -> () ) {
            
            let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
            
            let actionOK : UIAlertAction = UIAlertAction(title: okTitle, style: .default) { (alt) in
                print("This is ok action");
                successClosure("OK")
            }
            alert.addAction(actionOK)
            
            view.present(alert, animated: true, completion: nil)
            
        }
    
        class func showAlertOKCancelWithAction(_ alertTitle : String, _ alertMsg : String, _ view: UIViewController, cancelClosure: @escaping (String?) -> (), successClosure: @escaping (String?) -> () ) {

            let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertController.Style.alert)

            let actionOK : UIAlertAction = UIAlertAction(title: "OK", style: .default) { (alt) in

                print("This is ok action");
                successClosure("OK")
            }
            
            let actionCancel : UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { (alt) in

                print("This is cancel action");
                cancelClosure("Cancel")
            }
            
            alert.addAction(actionCancel)
            alert.addAction(actionOK)


            view.present(alert, animated: true, completion: nil)
    }

    class func startLoader(view: UIView) {
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        actInd.center = view.center
        actInd.hidesWhenStopped = true
        actInd.style =
            UIActivityIndicatorView.Style.whiteLarge
        view.addSubview(actInd)
        
        let loader = ActivityData(type: .circleStrokeSpin, color: UIColor.init(named: "ButtonColor"), backgroundColor: .clear)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(loader, nil)
        
    }
    
    class func stopLoader() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
//    func showActivityIndicatory(uiView: UIView) {
//
//        var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
//        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
//        actInd.center = uiView.center
//        actInd.hidesWhenStopped = true
//        actInd.style =
//            UIActivityIndicatorView.Style.whiteLarge
//        uiView.addSubview(actInd)
//        activityIndicator.startAnimating()
//
//    }
//
//    func hideshowActivityIndicatory() {
//
//        activityIndicator.stopAnimating()
//
////        activityIndicator.stopAnimating()
//
//
//
//    }
    
    //
    class func showAlertOKCancelAction(_ alertTitle : String, _ alertMsg : String, _ view: UIViewController, successClosure: @escaping (String?) -> (), cancelClosure: @escaping (String?) -> () ) {
        let hardMsg = "Please Login to Continue"
        
        let alert = UIAlertController(title: alertTitle, message: hardMsg, preferredStyle: UIAlertController.Style.alert)
        
        let actionOK : UIAlertAction = UIAlertAction(title: "Skip", style: .default) { (alt) in
            
            cancelClosure("Skip")
            
        }
        let actionCancel : UIAlertAction = UIAlertAction(title: "Login", style: .default) { (alt) in
            
            successClosure("Login")
            
        }
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        view.present(alert, animated: true, completion: nil)
    }
    
    class func showAlertLogout(_ alertTitle : String, _ alertMsg : String, _ view: UIViewController, successClosure: @escaping (String?) -> (), cancelClosure: @escaping (String?) -> () ) {
//        let hardMsg = "Please Login to Continue"
        
        let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
        
        let actionOK : UIAlertAction = UIAlertAction(title: "NO", style: .default) { (alt) in
            
            successClosure("Login")
            
        }
        
        let actionCancel : UIAlertAction = UIAlertAction(title: "YES", style: .default) { (alt) in
            
            cancelClosure("Skip")
            
        }
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        view.present(alert, animated: true, completion: nil)
    }
    
    class func showAlertOKCancelActionNew( alertTitle : String,  alertMsg : String, _ view: UIViewController, successClosure: @escaping (String?) -> (), cancelClosure: @escaping (String?) -> () ) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
        
        let actionOK : UIAlertAction = UIAlertAction(title: "Yes", style: .default) { (alt) in
            
            successClosure("ok")
        }
        let actionCancel : UIAlertAction = UIAlertAction(title: "No", style: .cancel) { (alt) in
            
            cancelClosure("Cancel")
        }
        
//        alert.view.tintColor = #colorLiteral(red: 0, green: 0.1294117647, blue: 0.168627451, alpha: 1)
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        view.present(alert, animated: true, completion: nil)
    }
    
    class func StringDateToDate(dateString : String, dateFormatte : String) -> Date {
        
        //let dateString = "Thu, 22 Oct 2015 07:45:17 +0000"
        //        let dateFormatte = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatte
        var dateObj = dateFormatter.date(from: dateString)
        
        dateObj = dateObj! + TimeInterval(LOCAL_TIME_ZONE)
        if dateObj == nil {
            return Date()
        } else{
            return dateObj!
        }
    }
    
    class func DateToString(date : Date, dateFormatte : String) -> String {
        
        //        let date = NSDate()
        //        let dateFormatte = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatte
        print("Dateobj: (dateFormatter.string(from: dateObj!))")
        return (dateFormatter.string(from: date))
        
    }

}


public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
//    class func isConnectedToNetwork() -> Bool {
//        return NetworkReachabilityManager()!.isReachable
//    }
}

extension UIViewController {
//
    func showToast(message : String, withDuration : Float) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-100, width: 250, height: 35))
        toastLabel.numberOfLines = 0
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.sizeToFit()
        toastLabel.frame = CGRect( x: toastLabel.frame.minX, y: toastLabel.frame.minY,width:   toastLabel.frame.width + 20, height: toastLabel.frame.height + 8)

        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: TimeInterval(withDuration), delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }


}

