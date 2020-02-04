//
//  SplashViewController.swift
//  MCA
//
//  Created by Goutham Devaraju on 20/07/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController, UIScrollViewDelegate {

    @IBOutlet var viewIntroOne: UIView!
    @IBOutlet var viewIntroOne_Subview: UIView!
    
    @IBOutlet var viewIntroTwo: UIView!
    @IBOutlet var viewIntroThree: UIView!
    
    @IBOutlet var scrollViewWelcome: UIScrollView!
    
    @IBOutlet var buttonTapToStart: UIButton!
    
    private var scrollViewWidth: CGFloat = 0.0
    private var widthIntroView: CGFloat = 0.0
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureWelcomeScreensLayout()
    }
    
    override func viewDidLayoutSubviews() {
        
        viewIntroOne_Subview.layer.cornerRadius = viewIntroOne_Subview.frame.height/2
        
        scrollViewWidth = scrollViewWelcome.frame.width
        
        widthIntroView = view.frame.width/1.171875
        buttonTapToStart.frame = CGRect(x: view.frame.midX - widthIntroView/2, y: buttonTapToStart.frame.origin.y, width: widthIntroView, height: 44)
    }
    
    func configureWelcomeScreensLayout(){
        
        //Setting scrollView content
        scrollViewWelcome.contentSize = CGSize(width: view.frame.width*3, height: 0)
        
        let width_view = view.frame.width/1.171875
        let height_view = width_view/0.8510638298
        let yAxis = (view.frame.midY - height_view/2) - height_view/5
        
        var xAxis = view.frame.midX - width_view/2
        viewIntroOne.frame = CGRect(x: xAxis, y: yAxis, width: width_view, height: height_view)
        scrollViewWelcome.addSubview(viewIntroOne)
        
        xAxis = (viewIntroOne.frame.origin.x*3)+width_view
        viewIntroTwo.frame = CGRect(x: xAxis, y: yAxis, width: width_view, height: height_view)
        scrollViewWelcome.addSubview(viewIntroTwo)
        
        xAxis = (viewIntroOne.frame.origin.x*5)+(width_view*2);
        viewIntroThree.frame = CGRect(x: xAxis, y: yAxis, width: width_view, height: height_view)
        scrollViewWelcome.addSubview(viewIntroThree)
        
        buttonTapToStart.isHidden = true
    }
    
    //MARK: - Button Events
    @IBAction func tapToStartEvent(_ sender: Any) {
        
        AppManager.shared.printLog(stringToPrint: "Tap to start")
        AppManager.shared.redirectToLoginScreen()
        
    }
    
    //MARK: - ScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x/scrollViewWidth == 2{
            buttonTapToStart.isHidden = false
        }
        else{
            buttonTapToStart.isHidden = true
        }
        
        //        buttonTapToStart.isHidden = 3 == scrollView.contentOffset.x/scrollViewWidth
    }

}
