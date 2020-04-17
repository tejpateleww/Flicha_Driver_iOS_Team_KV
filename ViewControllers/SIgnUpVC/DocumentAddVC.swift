//
//  DocumentAddVC.swift
//  Flicha-Driver
//
//  Created by EWW073 on 15/04/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class DocumentAddVC: UIViewController {

    // ----------------------------------------------------
    // MARK: - --------- Outlets ---------
    // ----------------------------------------------------
    
    
    
    // ----------------------------------------------------
    // MARK: - --------- Global Variables ---------
    // ----------------------------------------------------
    
    
    
    // ----------------------------------------------------
    // MARK: - --------- Lifecycle Methods ---------
    // ----------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // ----------------------------------------------------
    // MARK: - --------- IBAction Methods ---------
    // ----------------------------------------------------
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
