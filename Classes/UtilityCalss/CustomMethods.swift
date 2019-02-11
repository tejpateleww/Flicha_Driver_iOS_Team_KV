//
//  CustomMethods.swift
//   TenTaxi-Driver
//
//  Created by Excellent Webworld on 25/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

//-------------------------------------------------------------
// MARK: -  For Activity Indicator
//-------------------------------------------------------------

func loadingAnimation(loadingUI : NVActivityIndicatorView?, loadingBG : UIView, view : UIView, navController : UINavigationController) -> (NVActivityIndicatorView, UIView) {
    var loadUI = loadingUI
    let loadBG = loadingBG
    let x = (view.frame.size.width / 2)
    let y = (view.frame.size.height / 2)
    loadUI = NVActivityIndicatorView(frame: CGRect(x: x, y: y, width: 100, height: 100))
    loadUI!.center = CGPoint(x: view.frame.size.width  / 2, y: view.frame.size.height / 2)
    
    
    loadBG.backgroundColor = UIColor.lightGray
    loadBG.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
    loadBG.center = navController.view.center
    loadBG.layer.cornerRadius = 5
    loadBG.layer.opacity = 0.5
    navController.view.addSubview(loadBG)
    navController.view.addSubview(loadUI!)
    
    loadUI!.type = .ballTrianglePath
    loadUI!.color = UIColor.white
    loadUI!.startAnimating()
    
    return (loadUI!, loadBG)
}
