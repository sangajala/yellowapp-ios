//
//  DetailDescriptionGradiant.swift
//  MCA
//
//  Created by Goutham Devaraju on 21/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import UIKit

class DetailDescriptionGradiant: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    // Default Colors
    var colors:[UIColor] = [UIColor.red, UIColor.blue]
    
    override func draw(_ rect: CGRect) {
        
        // Must be set when the rect is drawn
        setGradient(color1: colors[0], color2: colors[1])
    }
    
    func setGradient(color1: UIColor, color2: UIColor) {
        
        let context = UIGraphicsGetCurrentContext()
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [color1.cgColor, color2.cgColor] as CFArray, locations: [0, 1])!
        
        // Draw Path
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        context!.saveGState()
        path.addClip()
        context!.drawLinearGradient(gradient, start: CGPoint(x: frame.width / 2, y: 0), end: CGPoint(x: frame.width / 2, y: frame.height), options: CGGradientDrawingOptions())
        context!.restoreGState()
    }
    
    override func layoutSubviews() {
        
        // Ensure view has a transparent background color (not required)
        backgroundColor = UIColor.clear
    }

}
