//
//  AccountInfoVC.swift
//  Flicha-Driver
//
//  Created by EWW073 on 15/04/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class AccountInfoVC: UIViewController {

    // ----------------------------------------------------
    // MARK: - --------- Outlets ---------
    // ----------------------------------------------------
    @IBOutlet var txtAccountNumber: UITextField!
    @IBOutlet var txtBankBranch: UITextField!
    @IBOutlet var txtBankName: UITextField!
    @IBOutlet var txtAccountHolderName: UITextField!
    @IBOutlet weak var btnNext: ThemeButton!
    
    
    // ----------------------------------------------------
    // MARK: - --------- Global Variables ---------
    // ----------------------------------------------------
    
   
    
    // ----------------------------------------------------
    // MARK: - --------- Lifecycle Methods ---------
    // ----------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLocalizable()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let BankName: String = userDefault.object(forKey: RegistrationFinalKeys.kBankName) as? String {
            txtBankName.text = BankName
        }
            
        if let BankAccountNo: String = userDefault.object(forKey: RegistrationFinalKeys.kBankAccountNo) as? String {
            txtAccountNumber.text = BankAccountNo
        }
            
        if let bankHolderName: String = userDefault.object(forKey: RegistrationFinalKeys.kbankHolderName) as? String {
            txtAccountHolderName.text = bankHolderName
        }
            
        if let bankBranch: String = userDefault.object(forKey: RegistrationFinalKeys.kBSB) as? String {
            txtBankBranch.text = bankBranch
        }
                  
    }
    // ----------------------------------------------------
    // MARK: - --------- IBAction Methods ---------
    // ----------------------------------------------------
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setLocalizable() {
        txtAccountHolderName.placeholder = "Account Holder Name".localized
        txtBankName.placeholder = "Bank Name".localized
        txtBankBranch.placeholder = "Bank Branch".localized
        txtAccountNumber.placeholder = "Account Number".localized
        btnNext.setTitle("Next".localized, for: .normal)
        //        lblHaveAnAccount.text = "".localized
        //        btnLogin.setTitle("".localized, for: .normal)
    }
    @IBAction func btnNext(_ sender: Any) {
//        self.performSegue(withIdentifier: "secondComplete", sender: self)
        let validator = CheckValidation()
        if validator.0 == true {
                      
            userDefault.set(self.txtAccountHolderName.text, forKey: RegistrationFinalKeys.kbankHolderName)
            userDefault.set(self.txtBankName.text, forKey: RegistrationFinalKeys.kBankName)
            userDefault.set(self.txtBankBranch.text, forKey: RegistrationFinalKeys.kBSB)
            userDefault.set(self.txtAccountNumber.text, forKey: RegistrationFinalKeys.kBankAccountNo)
            userDefault.set("4", forKey: RegistrationFinalKeys.kPageNo)
            self.performSegue(withIdentifier: "thirdComplete", sender: self)
        } else {
            
            let ValidationAlert = UIAlertController(title: "App Name".localized, message: validator.1, preferredStyle: UIAlertController.Style.alert)
            ValidationAlert.addAction(UIAlertAction(title: "Dismiss".localized, style: .cancel, handler: nil))
            self.present(ValidationAlert, animated: true, completion: nil)
        }
        
    }
        
    func CheckValidation() -> (Bool,String) {
        //        let sb = Snackbar()
        var isValidate:Bool = true
        var ValidationMessage:String = ""
        
        //        sb.createWithAction(text: "Upload Car Registration", actionTitle: "Dismiss".localized, action: { print("Button is push") })
        if txtAccountNumber.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            //            sb.createWithAction(text: "Please enter account number".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
            isValidate = false
            ValidationMessage = "Please enter account number".localized
        }else if txtBankName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            //            sb.createWithAction(text: "Please enter bank name".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
            isValidate = false
            ValidationMessage = "Please enter bank name".localized
            
        }else if txtBankBranch.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            //            sb.createWithAction(text:"Please enter bank branch".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
            isValidate = false
            ValidationMessage = "Please enter bank branch".localized
            
        }else if txtAccountHolderName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            //            sb.createWithAction(text: "Please enter account holder name".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
            isValidate = false
            ValidationMessage = "Please enter account holder name".localized
        }
        
        //        sb.show()
        return (isValidate,ValidationMessage)
        
    }
}
