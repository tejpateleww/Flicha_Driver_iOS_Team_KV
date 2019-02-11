//
//  VerifyPasswordViewController.swift
//  TickTok User
//
//  Created by Excelent iMac on 22/12/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class VerifyPasswordViewController: UIViewController {

    
    var aryPassword = [String]()
    var aryRetypePassword = [String]()
    var aryImages = [String]()
    var aryImagesPassword = [String]()
    var aryImagesRetypePassword = [String]()
    
    var isFromDelegate = Bool()
    var strPassword = String()
    var strRetypePassword = String()
    var strImages = String()
    
    var strStatusToNavigate = String()
    var isFromSetting = Bool()
    var isCheckPasscodeTrue = Bool()
    var isFromAppDelegate = Bool()
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        if(isFromDelegate == true)
//        {
//            self.btnBackAction.isHidden = true
//        }
        if (isFromAppDelegate) {
            
            btnBackAction.isHidden = true
        }
        else {
            btnBackAction.isHidden = false
            
        }
        
        // If you can't remember your passcode, you must sign out of TiCKTOC and login with your email address and password.

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet var btnNumber: [UIButton]!
    
    @IBOutlet var imgPasscodes: [UIImageView]!
    
    @IBOutlet weak var lblPassword: UILabel!
    
    @IBOutlet weak var btnBackAction: UIButton!
    
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func btnNumbersAction(_ sender: UIButton) {
        
        if strRetypePassword.count < 4 {
            
            strRetypePassword.append(sender.currentTitle!)
            print("strRetypePassword : \(strRetypePassword)")
            imgPasscodes[strRetypePassword.count-1].image = UIImage(named: "iconDot")
            
            aryImagesPassword.append("iconDot")
            
            if strRetypePassword.count == 4 {
                
                if Singletons.sharedInstance.setPasscode != strRetypePassword {
                    
                    lblPassword.text = "Retype Password"
                    strRetypePassword.removeAll()
                    aryImagesPassword.removeAll()
                    for i in 0..<imgPasscodes.count
                    {
                        imgPasscodes[i].image = UIImage(named: "iconDot")
                    }
                }
                else {

                    if checkPresentation() {
                         Singletons.sharedInstance.passwordFirstTime = true
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    else {
                        Singletons.sharedInstance.passwordFirstTime = true
                        
                     
                        if strStatusToNavigate == "TiCKPay" {
                            
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "PayViewController") as! PayViewController
                            self.navigationController?.pushViewController(next, animated: true)
                        }
                        else if strStatusToNavigate == "wallet" {
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
                            self.navigationController?.pushViewController(next, animated: true)
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
    
    @IBAction func btnClearAction(_ sender: UIButton) {
        
       if strRetypePassword.count < 4 && strRetypePassword.count != 0 {
        
        strRetypePassword.removeLast()
        aryImagesPassword.removeLast()
        
            if aryImagesPassword.count < 4 && aryImagesPassword.count >= 0
            {
                
                for i in 0..<imgPasscodes.count
                {
                    if aryImagesPassword.count > i {
                        imgPasscodes[i].image = UIImage(named: "iconDot")
                    }
                    else {
                        imgPasscodes[i].image = UIImage(named: "iconLockStar")
                    }
                    
                }
            }
        
            print("Removerd strRetypePassword = \(strRetypePassword)")
        }
        
    }
    @IBAction func btnBack(_ sender: UIButton) {
        
        if checkPresentation() {
            
//            self.dismiss(animated: true, completion: nil)
//            
//            let tabbarVC = (((self.presentingViewController as! UINavigationController).viewControllers[1]) as! CustomSideMenuViewController)//.childViewControllers[0]) as! UINavigationController).viewControllers[0] as! TabbarController
//            
//            self.dismiss(animated: true, completion: nil)
////            self.navigationController?.popToViewController(tabbarVC, animated: true)
//            
//            let tabbar =  (((((((self.presentingViewController as! UINavigationController).viewControllers[1]) as! CustomSideMenuViewController).childViewControllers[0]) as! UINavigationController).childViewControllers[0]) as! TabbarController)
//            tabbar.selectedIndex = 0
        }
        else {
            
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
  
    
    @IBAction func btnForgot(_ sender: UIButton) {
        
        let msg = "If you can't remember your passcode, you must sign out from \(appName.kAPPName) and login with your email address and password."
        
        let alert = UIAlertController(title: appName.kAPPName, message: msg, preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: { ACTIOn in
            
            let socket = (UIApplication.shared.delegate as! AppDelegate).SocketManager
            
            socket.off(socketApiKeys.kReceiveBookingRequest)
            socket.off(socketApiKeys.kBookLaterDriverNotify)
            
            socket.off(socketApiKeys.kGetBookingDetailsAfterBookingRequestAccepted)
            socket.off(socketApiKeys.kAdvancedBookingInfo)
            
            socket.off(socketApiKeys.kReceiveMoneyNotify)
            socket.off(socketApiKeys.kAriveAdvancedBookingRequest)
            
            socket.off(socketApiKeys.kDriverCancelTripNotification)
            socket.off(socketApiKeys.kAdvancedBookingDriverCancelTripNotification)
            
            socket.disconnect()
            
            UserDefaults.standard.set(nil, forKey: "Passcode")
            
          
            
            self.performSegue(withIdentifier: "signOuyFromPasscode", sender: nil)
        })
        let Cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(OK)
        alert.addAction(Cancel)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    

}
