//
//  SetPasscodeViewController.swift
//  TickTok User
//
//  Created by Excelent iMac on 22/12/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class SetPasscodeViewController: UIViewController {

    
    var aryPassword = [String]()
    var aryRetypePassword = [String]()
    var aryImagesPassword = [String]()
    var aryImagesRetypePassword = [String]()
    var isChangePassword = Bool()
    var strPassword = String()
    var strRetypePassword = String()
    var strImages = String()
    var strCheckOldPassword = String()
    
    
     var isCheckPasscodeTrue = Bool()
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet var btnNumber: [UIButton]!
    @IBOutlet var imgPasscodes: [UIImageView]!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lblPassword: UILabel!
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(isChangePassword && Singletons.sharedInstance.setPasscode != "")
        {
            lblPassword.text = "Enter old password"
        }
        else
        {
            lblPassword.text = "Create password"
        }
  
    }
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    var checkPasscode = String()
    
    
    func removeCheckPasscodeAndIcons() {
        
        checkPasscode.removeAll()
        aryImagesPassword.removeAll()
        
        for i in 0..<imgPasscodes.count
        {
            imgPasscodes[i].image = UIImage(named: "iconLockStar")
        }
    }

    @IBAction func btnNumbersAction(_ sender: UIButton) {
//        let strOldPasscode = Singletons.sharedInstance.setPasscode

        if(isChangePassword)
        {
            if(isCheckPasscodeTrue == false)
            {
                  if checkPasscode.count <= 4 {
                checkPasscode.append(sender.currentTitle!)
                imgPasscodes[checkPasscode.count - 1].image = UIImage(named: "iconDot")
                aryImagesPassword.append("iconDot")
                
                
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        
                        if self.checkPasscode.count == 4 {
                            if (Singletons.sharedInstance.setPasscode == "")
                            {
                                self.removeCheckPasscodeAndIcons()
                                self.lblPassword.text = "Retype Passcode"
                                self.isCheckPasscodeTrue = true
                                
                            }
                            else
                            {
                                if Singletons.sharedInstance.setPasscode != self.checkPasscode {
                                    self.lblPassword.text = "Incorrect Passcode"
                                    self.removeCheckPasscodeAndIcons()
                                }
                                else {
                                    self.removeCheckPasscodeAndIcons()
                                    self.isCheckPasscodeTrue = true
                                    self.lblPassword.text = "Create Passcode"
                                }
                            }
                        }
                    }
                }
            }
            else if (isCheckPasscodeTrue)
            {
                
                // Create New Passcode
                
                if checkPasscode.count < 4 {
                    
                    checkPasscode.append(sender.currentTitle!)
                    imgPasscodes[checkPasscode.count-1].image = UIImage(named: "iconDot")
                    aryImagesPassword.append("iconDot")
                    
                    if checkPasscode.count == 4 {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            
                            self.lblPassword.text = "Retype Passcode"
                            
                            self.aryImagesPassword.removeAll()
                            for i in 0..<self.imgPasscodes.count
                            {
                                self.imgPasscodes[i].image = UIImage(named: "iconLockStar")
                            }
                        }
                        
                    }
                }
                else {
                    // Retype New Passcode
                    
                    if strRetypePassword.count < 4 {
                        
                        strRetypePassword.append(sender.currentTitle!)
                        imgPasscodes[strRetypePassword.count-1].image = UIImage(named: "iconDot")
                        aryImagesRetypePassword.append("iconDot")
                        
                        if strRetypePassword.count == 4 {
                            
                            
                            if checkPasscode != strRetypePassword {
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    
//                                    self.lblPassword.text = "Retype Passcode"
                                    
                                    self.strRetypePassword.removeAll()
                                    self.aryImagesRetypePassword.removeAll()
                                    
                                    for i in 0..<self.imgPasscodes.count
                                    {
                                        self.imgPasscodes[i].image = UIImage(named: "iconLockStar")
                                    }
                                }
                            }
                            else {
                                
                                Singletons.sharedInstance.setPasscode = checkPasscode
                                UserDefaults.standard.set(Singletons.sharedInstance.setPasscode, forKey: "Passcode")
                                
                                UtilityClass.showAlertWithCompletion(appName.kAPPName, message: "Passcode change successfully", vc: self, completionHandler: { ACTION in
                                    
                                    self.navigationController?.popViewController(animated: true)
                                })
                            }
                        }
                    }
                }
            }
        }
        else if (strPassword.count != 4)
        {
            strPassword.append(sender.currentTitle!)
            print("strPassword : \(strPassword)")
            imgPasscodes[strPassword.count-1].image = UIImage(named: "iconDot")
            
            aryImagesPassword.append("iconDot")
            
            if strPassword.count == 4 {

                    lblPassword.text = "Verify Passcode"
                    
                    for i in 0..<imgPasscodes.count
                    {
                        imgPasscodes[i].image = UIImage(named: "iconLockStar")
                    }
            }
        }
        else
        {
             if strRetypePassword.count < 4 {
                
                strRetypePassword.append(sender.currentTitle!)
                print("strRetypePassword : \(strRetypePassword)")
                imgPasscodes[strRetypePassword.count-1].image = UIImage(named: "iconDot")
                
                aryImagesRetypePassword.append("iconDot")
                
                if strRetypePassword.count == 4 {
                    
                    if strPassword != strRetypePassword {
                        
                        lblPassword.text = "Retype Password"
                        
                        strRetypePassword.removeAll()
                        
                        for i in 0..<imgPasscodes.count
                        {
                            imgPasscodes[i].image = UIImage(named: "iconLockStar")
                        }
                    }
                    else {
                        
                        Singletons.sharedInstance.setPasscode = strPassword
                        UserDefaults.standard.set(Singletons.sharedInstance.setPasscode, forKey: "Passcode")
                        
                        Singletons.sharedInstance.passwordFirstTime = true
                        
                        if(isChangePassword)
                        {
                            self.navigationController?.popViewController(animated: true)
                        }
                        else
                        {
                            if checkPresentation() {
                                
                                self.dismiss(animated: true, completion: nil)
                            }
                            else {
//                                let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
//                                self.navigationController?.pushViewController(next, animated: true)
                                let tabbarVC = ((self.navigationController as! UINavigationController).viewControllers[1] as! CustomSideMenuViewController)
                                self.navigationController?.popToViewController(tabbarVC, animated: true)
                            }
                        }
                        
                    }
                    
                }
            }
        }
        
    }
    
    func checkPresentation() -> Bool {
        if (presentingViewController != nil) {
            return true
        }
        if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        }
        if (tabBarController?.presentingViewController is UITabBarController) {
            return true
        }
        return false
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        
        if (isChangePassword) {
            
            if (!isCheckPasscodeTrue)
            {
                if checkPasscode.count < 4 && checkPasscode.count != 0 {
                    checkPasscode.removeLast()
                    aryImagesPassword.removeLast()
                    
                    if aryImagesPassword.count < 4 && aryImagesPassword.count >= 0 {
                        
                        for j in 0..<imgPasscodes.count {
                            
                            if aryImagesPassword.count > j {
                                imgPasscodes[j].image = UIImage(named: "iconDot")
                            }
                            else {
                                imgPasscodes[j].image = UIImage(named: "iconLockStar")
                            }
                        }
                    }
                }
            }
            else if (isCheckPasscodeTrue) {
                
                if strPassword.count < 4 && strPassword.count != 0 {
                    
                    strPassword.removeLast()
                    aryImagesPassword.removeLast()
                    
                    if aryImagesPassword.count < 4 && aryImagesPassword.count >= 0 {
                        
                        for j in 0..<imgPasscodes.count {
                            
                            if aryImagesPassword.count > j {
                                imgPasscodes[j].image = UIImage(named: "iconDot")
                            }
                            else {
                                imgPasscodes[j].image = UIImage(named: "iconLockStar")
                            }
                        }
                        
                    }
                    
                }
                else if strRetypePassword.count < 4 && strRetypePassword.count != 0 {
                    
                    strRetypePassword.removeLast()
                    aryImagesRetypePassword.removeLast()
                    
                    if aryImagesRetypePassword.count < 4 && aryImagesRetypePassword.count >= 0 {
                        
                        for j in 0..<imgPasscodes.count {
                            
                            if aryImagesRetypePassword.count > j {
                                imgPasscodes[j].image = UIImage(named: "iconDot")
                            }
                            else {
                                imgPasscodes[j].image = UIImage(named: "iconLockStar")
                            }
                        }
                    }
                }
            }
            
        }
        else if strPassword.count <= 4 && strPassword.count != 0 {
            strPassword.removeLast()
            aryImagesPassword.removeLast()
           
            
            if aryImagesPassword.count <= 4 && aryImagesPassword.count >= 0
            {
                for j in 0..<imgPasscodes.count {
                   
                    if aryImagesPassword.count > j {
                        imgPasscodes[j].image = UIImage(named: "iconDot")
                    }
                    else {
                        imgPasscodes[j].image = UIImage(named: "iconLockStar")
                    }
                }
            }
            
            
            print("Removerd strPassword = \(strPassword)")
        }
        else if strRetypePassword.count <= 4 && strRetypePassword.count != 0 {
            
            strRetypePassword.removeLast()
            aryImagesRetypePassword.removeLast()
            
            if aryImagesRetypePassword.count <= 4 && aryImagesRetypePassword.count >= 0
            {
                for j in 0..<imgPasscodes.count {
                    
                    if aryImagesRetypePassword.count > j {
                        imgPasscodes[j].image = UIImage(named: "iconDot")
                    }
                    else {
                        imgPasscodes[j].image = UIImage(named: "iconLockStar")
                    }
                }
            }
            
             print("Removerd strRetypePassword = \(strRetypePassword)")
        }
        
    }
    @IBAction func btnBack(_ sender: UIButton) {
       
        if checkPresentation() {

//            self.dismiss(animated: false, completion: nil)
//            self.tabBarController?.selectedIndex = 0
//            
//            let tabbar =  (((((((self.presentingViewController as! UINavigationController).childViewControllers).last as! CustomSideMenuViewController).childViewControllers[0]) as! UINavigationController).childViewControllers[0]) as! TabbarController)
//            tabbar.selectedIndex = 0

        }
        else {

           self.navigationController?.popViewController(animated: true)

        }
//
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}



/*
 if aryPassword.count < 4 {
 aryPassword.append(sender.currentTitle!)
 
 strPassword.append(sender.currentTitle!)
 
 if aryPassword.count == 1 {
 imgPasscodes[0].image = UIImage(named: "iconDot")
 }
 else if aryPassword.count == 2 {
 imgPasscodes[1].image = UIImage(named: "iconDot")
 }
 else if aryPassword.count == 3 {
 imgPasscodes[2].image = UIImage(named: "iconDot")
 }
 else if aryPassword.count == 4 {
 imgPasscodes[3].image = UIImage(named: "iconDot")
 
 lblPassword.text = "Verify Password"
 for i in 0..<imgPasscodes.count
 {
 imgPasscodes[i].image = UIImage(named: "iconStartUnselect")
 }
 }
 }
 else {
 
 if aryRetypePassword.count < 4 {
 
 aryRetypePassword.append(sender.currentTitle!)
 //                lblPassword.text = "Verify Password"
 if aryRetypePassword.count == 1 {
 imgPasscodes[0].image = UIImage(named: "iconDot")
 }
 else if aryRetypePassword.count == 2 {
 imgPasscodes[1].image = UIImage(named: "iconDot")
 }
 else if aryRetypePassword.count == 3 {
 imgPasscodes[2].image = UIImage(named: "iconDot")
 }
 else if aryRetypePassword.count == 4 {
 
 for i in 0..<aryPassword.count {
 
 if aryRetypePassword[i] != aryPassword[i] {
 aryRetypePassword.removeAll()
 self.lblPassword.text = "Retype Password"
 
 for i in 0..<imgPasscodes.count
 {
 imgPasscodes[i].image = UIImage(named: "iconStartUnselect")
 }
 }
 
 //                        if aryRetypePassword[i] != aryPassword[i]
 
 
 
 }
 }
 }
 }
 
 */
//        else if aryRetypePassword.count <= 4 {
//            aryRetypePassword.append(sender.currentTitle)
//            comparePasscode()
//        }



/*
 if aryPassword.count <= 3 {
 
 if aryPassword.count == 1 {
 imgPasscodes[0].image = UIImage(named: "iconLockStar")
 }
 else if aryPassword.count == 2 {
 imgPasscodes[1].image = UIImage(named: "iconStartUnselect")
 }
 else if aryPassword.count == 3 {
 imgPasscodes[2].image = UIImage(named: "iconStartUnselect")
 }
 //            else if aryPassword.count == 4 {
 //                imgPasscodes[3].image = UIImage(named: "iconDot")
 //            }
 aryPassword.removeLast()
 }
 else {
 
 if aryRetypePassword.count <= 3 {
 
 if aryRetypePassword.count == 1 {
 imgPasscodes[0].image = UIImage(named: "iconStartUnselect")
 }
 else if aryRetypePassword.count == 2 {
 imgPasscodes[1].image = UIImage(named: "iconStartUnselect")
 }
 else if aryRetypePassword.count == 3 {
 imgPasscodes[2].image = UIImage(named: "iconStartUnselect")
 }
 //            else if aryPassword.count == 4 {
 //                imgPasscodes[3].image = UIImage(named: "iconDot")
 //            }
 aryRetypePassword.removeLast()
 }
 
 }
 */
