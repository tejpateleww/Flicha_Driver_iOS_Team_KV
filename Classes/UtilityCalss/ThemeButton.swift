//
//  ThemeButton.swift
//  TanTaxi-Driver
//
//  Created by Excelent iMac on 11/10/18.
//  Copyright © 2018 Excellent Webworld. All rights reserved.
//

import UIKit

class ThemeButton: UIButton {
    
    @IBInspectable public var isSubmitButton: Bool = false
    @IBInspectable public var isShadowNeeded: Bool = true
    
    override func awakeFromNib() {
        self.titleLabel?.font = UIFont.init(name: CustomeFontUbuntuMedium, size: 18)
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
        
        if isSubmitButton == true
        {
            self.backgroundColor = ThemeYellowColor
            setTitleColor(UIColor.black, for: .normal)
        }
        else
        {
            self.backgroundColor = UIColor(red: 114.0/255.0, green: 114.0/255.0, blue: 114.0/255.0, alpha: 1.0)
            setTitleColor(UIColor.black, for: .normal)
        }
        
        if isShadowNeeded {
//            self.layer.cornerRadius = 2
            self.layer.shadowRadius = 0
            self.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
            self.layer.shadowOffset = CGSize (width: 1.0, height: 4.0)
            self.layer.shadowOpacity = 0.3
            self.layer.masksToBounds = false
        }
    }
}


