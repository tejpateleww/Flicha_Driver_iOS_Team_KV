//
//  SplashViewController.swift
//  TanTaxi-Driver
//
//  Created by EWW-iMac Old on 18/02/19.
//  Copyright © 2019 Excellent Webworld. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if Connectivity.isConnectedToInternet()
        {
            print("Yes! internet is available.")
            let LoginPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let NavigationControl = UINavigationController(rootViewController: LoginPage)
            NavigationControl.setNavigationBarHidden(true, animated:false)
            (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = NavigationControl
//              self.webserviceOfAppSetting()
            // do some tasks..
        }
        else
        {
            UtilityClass.showAlert("App Name".localized, message: "Sorry! Not connected to internet".localized, vc: self)
            //                UtilityClass.showAlert("App Name".localized, message: "Sorry! Not connected to internet".localized, vc: self)
            
            return
        }
        // Do any additional setup after loading the view.
    }
    
    
    func webserviceOfAppSetting() {
        //        version : 1.0.0 , (app_type : AndroidPassenger , AndroidDriver , IOSPassenger , IOSDriver)
        
        
        let nsObject: AnyObject? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject
        let version = nsObject as! String
        
        var param = String()
        
        param = version + "/" + "IOSDriver"
        
        webserviceForAppSetting(param as AnyObject) { (result, status) in
            
            if(status) {
                print(result)
                /*
                 {
                 "status": true,
                 "update": false,
                 "message": "Ticktoc app new version available"
                 }
                 */
                //                self.viewMain.isHidden = true
                
                if ((result as! NSDictionary).object(forKey: "update") as? Bool) != nil {
                    
                    let alert = UIAlertController(title: "App Name".localized, message: (result as! NSDictionary).object(forKey: GetResponseMessageKey()) as? String, preferredStyle: .alert)
                    let UPDATE = UIAlertAction(title: "Update".localized, style: .default, handler: { ACTION in
                        
                        UIApplication.shared.openURL(NSURL(string: appName.kAPPUrl)! as URL)
                    })
                    let Cancel = UIAlertAction(title: "Cancel".localized, style: .default, handler: { ACTION in
                        
                        if(Singletons.sharedInstance.isDriverLoggedIN)
                        {
                            App_Delegate.GoToHome()
                            /* Raj381
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "CustomSideMenuViewController") as! CustomSideMenuViewController
                            self.navigationController?.pushViewController(next, animated: true)
                            */
                        } else {
                            let LoginPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            let NavigationControl = UINavigationController(rootViewController: LoginPage)
                            (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = NavigationControl
                        }
                    })
                    alert.addAction(UPDATE)
                    alert.addAction(Cancel)
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    
//                    if(Singletons.sharedInstance.isDriverLoggedIN)
//                    {
//                        let next = self.storyboard?.instantiateViewController(withIdentifier: "CustomSideMenuViewController") as! CustomSideMenuViewController
//                        self.navigationController?.pushViewController(next, animated: false)
//                    } else {
                        let LoginPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        let NavigationControl = UINavigationController(rootViewController: LoginPage)
                        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = NavigationControl
//                    }
                    //                    if(Singletons.sharedInstance.isDriverLoggedIN)
                    //                    {
                    //                        let next = self.storyboard?.instantiateViewController(withIdentifier: "CustomSideMenuViewController") as! CustomSideMenuViewController
                    //                        self.navigationController?.pushViewController(next, animated: true)
                    //                    }
                    
                }
                
                //                if(SingletonClass.sharedInstance.isUserLoggedIN)
                //                {
                //                    self.performSegue(withIdentifier: "segueToHomeVC", sender: nil)
                //                }//bhaveshbhai
                
                
            }
            else {
                print(result)
                /*
                 {
                 "status": false,
                 "update": false,
                 "maintenance": true,
                 "message": "Server under maintenance, please try again after some time"
                 }
                 */
                
                if let res = result as? String {
                    UtilityClass.showAlert("App Name".localized, message: res, vc: self)
                }
                else if let update = (result as! NSDictionary).object(forKey: "update") as? Bool {
                    
                    if (update) {
                        //                        UtilityClass.showAlert(appName.kAPPName, message: (result as! NSDictionary).object(forKey: "message") as! String, vc: self)
                        
                        UtilityClass.showAlertWithCompletion("App Name".localized, message: (result as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self, completionHandler: { ACTION in
                            
                            UIApplication.shared.open((NSURL(string: appName.kAPPUrl)! as URL), options: [:], completionHandler: { (status) in
                                
                            })//openURL(NSURL(string: appName.kAPPUrl)! as URL)
                        })
                    }
                    else {
                        UtilityClass.showAlert("App Name".localized, message: (result as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                    }
                    
                }
                /*
                 {
                 "status": false,
                 "update": true,
                 "message": "Ticktoc app new version available, please upgrade your application"
                 }
                 */
                //                if let res = result as? String {
                //                    UtilityClass.showAlert(appName.kAPPName, message: res, vc: self)
                //                }
                //                else if let resDict = result as? NSDictionary {
                //                    UtilityClass.showAlert(appName.kAPPName, message: resDict.object(forKey: "message") as! String, vc: self)
                //                }
                //                else if let resAry = result as? NSArray {
                //                    UtilityClass.showAlert(appName.kAPPName, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: "message") as! String, vc: self)
                //                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
