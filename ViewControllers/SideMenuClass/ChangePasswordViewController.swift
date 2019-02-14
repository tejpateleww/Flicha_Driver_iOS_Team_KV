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
        
        
        let inputText = txtNewPassword.text!
        
        if inputText.count > 7 {
            
             WebservieceChengePassword()
        }
        else {
           
            let alert = UIAlertController(title: appName.kAPPName, message: "Password should be minimum 8 characters", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
  
    }
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    
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
                        UtilityClass.showAlert(appName.kAPPName, message: res, vc: self)
                    }
                    else if let resDict = result as? NSDictionary {
                        
                        let alert = UIAlertController(title: appName.kAPPName, message: (resDict).object(forKey: "message") as? String, preferredStyle: .alert)
                        let OK = UIAlertAction(title: "OK", style: .default, handler: { ACTION in
                            
                            self.navigationController?.popViewController(animated: true)
                        })
                        alert.addAction(OK)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else if let resAry = result as? NSArray {
                        UtilityClass.showAlert(appName.kAPPName, message: ((resAry).object(at: 0) as! NSDictionary).object(forKey: "message") as! String, vc: self)
                    }
                    
                } else {
                    
                    print(result)
                    
                    if let res = result as? String {
                        UtilityClass.showAlert(appName.kAPPName, message: res, vc: self)
                    }
                    else if let resDict = result as? NSDictionary {
                        UtilityClass.showAlert(appName.kAPPName, message: (resDict).object(forKey: "message") as! String, vc: self)
                    }
                    else if let resAry = result as? NSArray {
                        UtilityClass.showAlert(appName.kAPPName, message: ((resAry).object(at: 0) as! NSDictionary).object(forKey: "message") as! String, vc: self)
                    }
                    
                }

            }
    }
    
}
