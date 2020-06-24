//
//  HostViewController.swift
//  HJM
//
//  Created by EWW80 on 21/08/19.
//  Copyright © 2019 Raj iMac. All rights reserved.
//

import UIKit
import LGSideMenuController

class HostViewController: UIViewController {
    // ----------------------------------------------------
    // MARK: -Outlets
    // ----------------------------------------------------
    
    
    // ----------------------------------------------------
    // MARK: -Globals
    // ----------------------------------------------------
  
    
    // ----------------------------------------------------
    // MARK: -ViewLifeCycle
    // ----------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
   
    
    
    @IBAction func btnMenuTapped(_ sender: UIBarButtonItem) {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
        
        /*if let lang = userDefault.value(forKey: "language") as? String{
            if lang == "en" {
                
            }else{
                
                
                sideMenuController?.showRightView(animated: true, completionHandler: nil)
            }
//        (UIApplication.shared.delegate as? AppDelegate)?.setLanguage()
        }*/
    }
    // ----------------------------------------------------
    // MARK: -Custom Methods
    // ----------------------------------------------------
}
