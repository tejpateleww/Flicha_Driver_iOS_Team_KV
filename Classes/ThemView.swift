//
//  ThemView.swift
//  TanTaxi-Driver
//
//  Created by Excelent iMac on 10/10/18.
//  Copyright © 2018 Excellent Webworld. All rights reserved.
//

import UIKit

class ThemView: UIView {

    override func awakeFromNib() {
        self.backgroundColor = UIColor(red: 228/255, green: 132/255, blue: 40/255, alpha: 1.0)
    }
}
// MARK: - UIView Methods
final class CustomView: UIView {
    
    public var shadowLayer: CAShapeLayer!
    @IBInspectable public var isRounded:Bool = true
    public var cornerRadios : CGFloat = 12
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: isRounded ? (self.frame.size.height/2) : cornerRadios).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = themeBlueColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
            shadowLayer.shadowOpacity = 0.15
            shadowLayer.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
    
}
