//
//  LegalViewController.swift
//  TanTaxi-Driver
//
//  Created by excellent Mac Mini on 30/10/18.
//  Copyright © 2018 Excellent Webworld. All rights reserved.
//

import UIKit

class LegalViewController: ParentViewController {
    
    var driverFullName = String()
    var strReferralCode = String()
    var strReferralMoney = String()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
    @IBAction func btnPrivacyPolice(_ sender: UIButton)
    {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "LegalWebView") as! LegalWebView
        next.headerName = "Privacy Policy"
        next.strURL = WebSupport.PrivacyPolicyURL
//        "https://www.tantaxitanzania.com/front/privacypolicy"
        self.navigationController?.pushViewController(next, animated: false)

    }
    
    @IBAction func btnTumsAndCondition(_ sender: UIButton)
    {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "LegalWebView") as! LegalWebView
        next.headerName = "Terms & Conditions"
        next.strURL = WebSupport.TermsNConditionsURL
//        "https://www.tantaxitanzania.com/front/termsconditions"
        self.navigationController?.pushViewController(next, animated: false)
        
    }
    
    
    
}
