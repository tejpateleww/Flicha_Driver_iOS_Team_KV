//
//  Extensions.swift
//  TanTaxi User
//
//  Created by EWW-iMac Old on 03/10/18.
//  Copyright © 2018 Excellent Webworld. All rights reserved.
//

import Foundation
import UIKit


// MARK:- UIColor

extension UIColor {
    
//    convenience init(hex: String) {
//        var red:   CGFloat = 0.0
//        var green: CGFloat = 0.0
//        var blue:  CGFloat = 0.0
//        var alpha: CGFloat = 1.0
//        var hex:   String = hex
//        
//        if hex.hasPrefix("#") {
//            let index = hex.index(hex.startIndex, offsetBy: 1)
//            hex         = String(hex.suffix(from: index))
//        }
//        
//        let scanner = Scanner(string: hex)
//        var hexValue: CUnsignedLongLong = 0
//        if scanner.scanHexInt64(&hexValue) {
//            switch (hex.count) {
//            case 3:
//                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
//                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
//                blue  = CGFloat(hexValue & 0x00F)              / 15.0
//            case 4:
//                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
//                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
//                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
//                alpha = CGFloat(hexValue & 0x000F)             / 15.0
//            case 6:
//                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
//                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
//                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
//            case 8:
//                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
//                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
//                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
//                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
//            default:
//                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
//            }
//        } else {
//            print("Scan hex error")
//        }
//        self.init(red:red, green:green, blue:blue, alpha:alpha)
//    }
}

//MARK:- UIFont

extension UIFont {
    class func regular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name:  AppRegularFont, size: manageFont(font: size))!
    }
    class func semiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppSemiboldFont, size: manageFont(font: size))!
    }
    class func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppBoldFont, size: manageFont(font: size))!
    }
    
    private class func manageFont(font : CGFloat) -> CGFloat {
        let cal  = windowHeight * font
        print(CGFloat(cal / CGFloat(screenHeightDeveloper)))
//        return CGFloat(cal / CGFloat(screenHeightDeveloper))
        
        return font
    }

}


//MARK:- UIView

extension UIView {
    
    func setGradientLayer(LeftColor:CGColor, RightColor:CGColor, BoundFrame:CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = BoundFrame
        gradient.colors = [LeftColor, RightColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        self.layer.addSublayer(gradient)
        
    }
    
}
