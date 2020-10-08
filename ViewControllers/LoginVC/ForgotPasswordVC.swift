//
//  ForgotPasswordVC.swift
//  Flicha-Driver
//
//  Created by EWW073 on 14/04/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var txtEmail: ThemeTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtEmail.placeholder = "Email Address".localized
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func sendClick(_ sender: UIButton) {
        if txtEmail.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            UtilityClass.showAlert("App Name".localized, message: "Please enter email address".localized, vc: self)
        }else {
            webserviceForgotPassword()
        }

    }
    func webserviceForgotPassword()
    {
        var params = [String:AnyObject]()
        params[RegistrationFinalKeys.kEmail] = txtEmail.text as AnyObject
        
        webserviceForForgotPassword(params as AnyObject) { (result, status) in
            
            if (status) {
                
                print(result)
                let alert = UIAlertController(title: "App Name".localized, message: result.object(forKey: GetResponseMessageKey()) as? String, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                print(result)
                
                if let res = result as? String {
                    UtilityClass.showAlert("App Name".localized, message: res, vc: self)
                }
                else if let resDict = result as? NSDictionary {
                    UtilityClass.showAlert("App Name".localized, message: resDict.object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }
                else if let resAry = result as? NSArray {
                    UtilityClass.showAlert("App Name".localized, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }
            }
        }
    }
}
