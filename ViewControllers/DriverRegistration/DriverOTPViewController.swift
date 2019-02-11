//
//  DriverOTPViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 11/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class DriverOTPViewController: UIViewController {

    var userDefault = UserDefaults.standard
    var otpCode = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBOutlet var txtOTP: UITextField!
    
    @IBAction func btnNext(_ sender: Any) {
        
//        if userDefault.object(forKey: OTPCodeStruct.kOTPCode) == nil {
//            otpCode = 0
//        }
//        else {
//            otpCode = userDefault.object(forKey: OTPCodeStruct.kOTPCode) as! Int
//        }
//
//        if txtOTP.text == String(otpCode)
//        {
            let driverVC = self.navigationController?.viewControllers.last as! DriverRegistrationViewController
        
        let personalDetailsVC = driverVC.children[2] as! DriverPersonelDetailsViewController
        driverVC.viewTwo.backgroundColor = ThemeYellowColor
//        driverVC.imgBank.image = UIImage.init(named: iconBankSelect)
                        let x = self.view.frame.size.width * 2
                        driverVC.scrollObj.setContentOffset(CGPoint(x:x, y:0), animated: true)
//            driverVC.segmentController.selectedIndex = 2
            personalDetailsVC.setDataForProfile()
//            self.userDefault.set(self.txtOTP.text, forKey: savedDataForRegistration.kKeyOTP)
//            self.userDefault.set(2, forKey: savedDataForRegistration.kPageNumber)
//        }
//        else
//        {
//            let alert = UIAlertController(title: "Wrong OTP", message: "Please check your OTP code", preferredStyle: .alert)
//
//            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//
//            alert.addAction(ok)
//
//            self.present(alert, animated: true, completion: nil)
//        }
       
    }
    @IBAction func btnLogin(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    

}
