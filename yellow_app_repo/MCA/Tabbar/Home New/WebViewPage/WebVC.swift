//
//  WebVC.swift
//  YELLOW App
//
//  Created by Apple on 08/10/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class WebVC: UIViewController,UIWebViewDelegate, UIGestureRecognizerDelegate {
    
//    @IBOutlet weak var menubutton: UIButton!
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var titleHeder: UILabel!
    
    var dicdata = NSDictionary()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dicdata)
        
        if let istype = dicdata.object(forKey: "istype") as? String {
            
            if istype == "html" {
                
                titleHeder.text = dicdata.object(forKey: "title") as? String ?? "Yellow App"
                let apiURL = dicdata.object(forKey: "apiUrl") as? String ?? ""
                
                if let url = Bundle.main.url(forResource: "\(apiURL)", withExtension: "html") {
                    webview.loadRequest(URLRequest(url: url))
                }
                
//                self.webview.loadHTMLString(apiURL, baseURL: nil)
//                self.webview.scalesPageToFit = true
//                self.webview.loadRequest(URLRequest(url: URL(string: apiURL)!))
                
            } else {
                
                titleHeder.text = dicdata.object(forKey: "title") as? String ?? "Yellow App"
                let apiURL = dicdata.object(forKey: "apiUrl") as? String ?? ""
                self.webview.loadRequest(URLRequest(url: URL(string: apiURL)!))
            }
            
        } else {
            
            // default
            titleHeder.text = dicdata.object(forKey: "title") as? String ?? "Yellow App"
            let apiURL = dicdata.object(forKey: "apiUrl") as? String ?? ""
            self.webview.loadRequest(URLRequest(url: URL(string: apiURL)!))
            
        }

    }
    
    @IBAction func btnback(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        helper.startLoader(view: view)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        helper.stopLoader()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        helper.stopLoader()
        print(error)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        return true
    }
    
}
