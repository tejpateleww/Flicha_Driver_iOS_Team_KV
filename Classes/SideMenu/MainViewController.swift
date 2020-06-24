//
//  MainViewController.swift
//  HJM
//
//  Created by EWW80 on 23/08/19.
//  Copyright © 2019 Raj iMac. All rights reserved.
//

import UIKit
import LGSideMenuController

class MainViewController: LGSideMenuController {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        rightViewWidth = view.frame.width * 0.75
//        rightViewPresentationStyle = .scaleFromBig
//        rightViewBackgroundColor = UIColor.AppColor.purple
        
       
        leftViewWidth = view.frame.width * 0.75
        leftViewPresentationStyle = .scaleFromBig
        leftViewBackgroundColor = themeBlueColor
        
        rootViewLayerBorderWidth = 0.0
        rootViewLayerBorderColor = .clear
        rootViewLayerShadowRadius = 0.0
        isLeftViewSwipeGestureEnabled = true
        
        /*
        if let lang = userDefault.value(forKey: "language") as? String, lang == "en" {
            isLeftViewSwipeGestureEnabled = true
            isRightViewSwipeGestureEnabled = false
        } else {
            isRightViewSwipeGestureEnabled = true
            isLeftViewSwipeGestureEnabled = false
        }
         */
//         (UIApplication.shared.delegate as? AppDelegate)?.setLanguage()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        
    }

}

