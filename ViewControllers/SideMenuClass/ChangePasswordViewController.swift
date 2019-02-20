//
//  ChangePasswordViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 07/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class ChangePasswordViewController: ParentViewController {

    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
//    @IBOutlet var iconPassword: UIImageView!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet weak var txtConfirmPass: ThemeTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView?.btnBack.addTarget(self, action: #selector(self.nevigateToBack), for: .touchUpInside)
        
//
//        iconPassword.image = UIImage.init(named: "iconLock")?.withRenderingMode(.alwaysTemplate)
//        iconPassword.tintColor = UIColor.white

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setLicalization()
    }
    func setLicalization()
    {
        self.headerView?.lblTitle.text = "Change Password".localized
        txtNewPassword.placeholder = "New Password".localized
        txtConfirmPass.placeholder = "Confirm Password".localized
        btnSubmit.setTitle("Submit".localized, for: .normal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        headerView?.backgroundColor = UIColor.clear
        headerView?.imgBottomLine.isHidden = true
        headerView?.lblTitle.textColor = UIColor.white

        headerView?.lblHeaderTitle.text = "Change Password"
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        btnSubmit.clipsToBounds = true
    }
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var txtNewPassword: UITextField!
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
   
    @IBAction func btnSubmit(_ sender: UIButton) {
        
        let Validator:(Bool,String) = self.isValidate()
        
        
        if Validator.0 == true {
          
            WebservieceChengePassword()
        
        }
        else {
           
            let alert = UIAlertController(title: "App Name".localized, message: Validator.1, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
  
    }
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    func isValidate() -> (Bool,String) {
        var isValid:Bool = true
        var ValidatorMessage:String = ""
        if self.txtNewPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            isValid = false
            ValidatorMessage = "Please enter password".localized
        } else if (self.txtNewPassword.text?.count)! < 8 {
            isValid = false
            ValidatorMessage = "Password must contain at least 8 characters.".localized
        } else if self.txtConfirmPass.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            isValid = false
            ValidatorMessage = "Please enter confirm password".localized
        } else if self.txtConfirmPass.text != self.txtNewPassword.text {
            isValid = false
            ValidatorMessage = "Password and confirm password must be same".localized
        }
        
        return (isValid,ValidatorMessage)
    }
    
    @objc func nevigateToBack()
    {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: TabbarController.self) {
                self.sideMenuController?.embed(centerViewController: controller)
                break
                
            }
        }
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Webservice For Change Password
    //-------------------------------------------------------------
    
    func WebservieceChengePassword()
    {
        
        var dictdata = [String:AnyObject]()
        
        dictdata["DriverId"] = Singletons.sharedInstance.strDriverID as AnyObject
        dictdata["Password"] = txtNewPassword.text as AnyObject
        
        webserviceForChangePassword(dictdata as AnyObject) { (result, status) in
            
                if (status) {
                    
                    print(result)
                    
                    if let res = result as? String {
                        UtilityClass.showAlert("App Name".localized, message: res, vc: self)
                    }
                    else if let resDict = result as? NSDictionary {
                        
                        let alert = UIAlertController(title: "App Name".localized, message: (resDict).object(forKey: GetResponseMessageKey()) as? String, preferredStyle: .alert)
                        let OK = UIAlertAction(title: "OK".localized, style: .default, handler: { ACTION in
                            
                            self.navigationController?.popViewController(animated: true)
                        })
                        alert.addAction(OK)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else if let resAry = result as? NSArray {
                        UtilityClass.showAlert("App Name".localized, message: ((resAry).object(at: 0) as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                    }
                    
                } else {
                    
                    print(result)
                    
                    if let res = result as? String {
                        UtilityClass.showAlert("App Name".localized, message: res, vc: self)
                    }
                    else if let resDict = result as? NSDictionary {
                        UtilityClass.showAlert("App Name".localized, message: (resDict).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                    }
                    else if let resAry = result as? NSArray {
                        UtilityClass.showAlert("App Name".localized, message: ((resAry).object(at: 0) as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                    }
                    
                }

            }
    }
    
}
