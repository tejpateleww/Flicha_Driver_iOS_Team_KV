//
//  UpdateProfileAccountVC.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 24/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit


class UpdateProfileAccountVC: UIViewController {
    
    var strDriverID = String()
    
    var dictData = NSMutableDictionary()
    
    var sendData = [String:AnyObject]()
    
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        dictData = NSMutableDictionary(dictionary: Singletons.sharedInstance.dictDriverProfile as NSDictionary)
       
        
        let profile = dictData.object(forKey: "profile") as! NSDictionary
        strDriverID = profile.object(forKey: "Id") as! String
        
        
        
        setData()
        
        // ABN, BANK name, BSB,BANK account
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    
    @IBOutlet weak var txtAccountHolderName: UITextField!
    @IBOutlet weak var txtBankName: UITextField!
    @IBOutlet weak var txtBankAcNo: UITextField!
    @IBOutlet weak var txtABN: UITextField!
    @IBOutlet weak var txtBSB: UITextField!
    @IBOutlet weak var txtServiceDescription: UITextField!
    

    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveData(_ sender: UIButton) {
        
        if (validationForAccount())
        {
            
            sendData[profileKeys.kDriverId] = strDriverID as AnyObject
            sendData[RegistrationFinalKeys.kbankHolderName] = txtAccountHolderName.text as AnyObject
            sendData[RegistrationFinalKeys.kBankName] = txtBankName.text as AnyObject
            sendData[RegistrationFinalKeys.kBankAccountNo] = txtBankAcNo.text as AnyObject
            sendData[RegistrationFinalKeys.kABN] = txtABN.text as AnyObject
            sendData[RegistrationFinalKeys.kBSB] = txtBSB.text as AnyObject
            sendData[RegistrationFinalKeys.kServiceDescription] = txtServiceDescription.text as AnyObject
            
            webservieMethods()
        }
        
    }
    
    func validationForAccount() -> Bool {
        
        if (txtAccountHolderName.text!.count == 0) {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Name", vc: self)
            return false
        }
        else if (txtBankName.text!.count == 0) {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Bank Name", vc: self)
            return false
        }
        else if (txtBSB.text!.count == 0) {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter BSB", vc: self)
            return false
        }
        else if (txtBankAcNo.text!.count == 0) {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Bank Account Number", vc: self)
            return false
        }
//        else if (txtABN.text!.count == 0) {
//            UtilityClass.showAlert(appName.kAPPName, message: "Enter ABN Number", vc: self)
//            return false
//        }
//        else if (txtServiceDescription.text!.count == 0) {
//            UtilityClass.showAlert(appName.kAPPName, message: "Enter Service Description", vc: self)
//            return false
//        }
        
        
        return true
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    
    func webservieMethods()
    {
        webserviceForUpdateDriverProfileBankAccountDetails(sendData as AnyObject) { (result, status) in
            
            if (status) {
                
                print(result)
                
                Singletons.sharedInstance.dictDriverProfile = NSMutableDictionary(dictionary: (result as! NSDictionary))
                
//                UserDefaults.standard.set(Singletons.sharedInstance.dictDriverProfile, forKey: driverProfileKeys.kKeyDriverProfile)
                
                Utilities.encodeDatafromDictionary(KEY: driverProfileKeys.kKeyDriverProfile, Param: Singletons.sharedInstance.dictDriverProfile)
                
                let alert = UIAlertController(title: appName.kAPPName, message: "Updated Successfully", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                
                print(result)
                
                if let res = result as? String {
                    UtilityClass.showAlert(appName.kAPPName, message: res, vc: self)
                }
                else if let resDict = result as? NSDictionary {
                    UtilityClass.showAlert(appName.kAPPName, message: resDict.object(forKey: "message") as! String, vc: self)
                }
                else if let resAry = result as? NSArray {
                    UtilityClass.showAlert(appName.kAPPName, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: "message") as! String, vc: self)
                }
            }
            
        }
    }
    
    func setData()
    {
        
        let profile: NSMutableDictionary = NSMutableDictionary(dictionary: (Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile")) as! NSDictionary)
        
        

//        let Vehicle: NSMutableDictionary = profile.object(forKey: "Vehicle") as! NSMutableDictionary
//
        
        txtAccountHolderName.text = profile.object(forKey: "BankHolderName") as? String
        txtBankName.text = profile.object(forKey: "BankName") as? String
        txtBankAcNo.text = profile.object(forKey: "BankAcNo") as? String
        txtABN.text = profile.object(forKey: "ABN") as? String
        txtBSB.text = profile.object(forKey: "BSB") as? String
        txtServiceDescription.text = profile.object(forKey: "Description") as? String
        
        
    }
   
}
