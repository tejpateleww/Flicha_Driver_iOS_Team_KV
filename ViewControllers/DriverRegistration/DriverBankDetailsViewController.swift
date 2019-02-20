//
//  DriverBankDetailsViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 09/02/18.
//  Copyright © 2018 Excellent Webworld. All rights reserved.
//

import UIKit
//import ACFloatingTextfield_Swift

class DriverBankDetailsViewController: UIViewController
{

    
    @IBOutlet var btnNext: UIButton!
    var userDefault =  UserDefaults.standard

    @IBOutlet var txtAccountNumber: UITextField!
    @IBOutlet var txtBankBranch: UITextField!
    @IBOutlet var txtBankName: UITextField!
    @IBOutlet var txtAccountHolderName: UITextField!
    
    @IBOutlet weak var constraintHeightOfImage: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightOfTextFields: NSLayoutConstraint!
    @IBOutlet weak var constraintTopOfNextButton: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPAD {
            constraintHeightOfImage.constant = 55
            constraintHeightOfTextFields.constant = 30
            constraintTopOfNextButton.constant = 10
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setLocalizable()
        self.title = "App Name".localized

    }
    func setLocalizable()
    {
        txtAccountHolderName.placeholder = "Account Holder Name".localized
        txtBankName.placeholder = "Bank Name".localized
        txtBankBranch.placeholder = "Bank Branch".localized
        txtAccountNumber.placeholder = "Account Number".localized
        btnNext.setTitle("Next".localized, for: .normal)
//        lblHaveAnAccount.text = "".localized
//        btnLogin.setTitle("".localized, for: .normal)
    }
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblHaveAnAccount: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnNext.layer.cornerRadius = btnNext.frame.size.height/2
        btnNext.clipsToBounds = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnNext(_ sender: Any) {
        
        let validator = CheckValidation()
        if validator.0 == true {
            let driverVC = self.navigationController?.viewControllers.last as! DriverRegistrationViewController
            
            //        let personalDetailsVC = driverVC.childViewControllers[2] as! DriverPersonelDetailsViewController
            driverVC.viewOne.backgroundColor = ThemeYellowColor
            //            driverVC.imgCar.image = UIImage.init(named: iconCarSelect)
            let x = self.view.frame.size.width * 3
            driverVC.scrollObj.setContentOffset(CGPoint(x:x, y:0), animated: true)
            
            
            
            self.userDefault.set(self.txtAccountHolderName.text, forKey: RegistrationFinalKeys.kbankHolderName)
            self.userDefault.set(self.txtBankName.text, forKey: RegistrationFinalKeys.kBankName)
            self.userDefault.set(self.txtBankBranch.text, forKey: RegistrationFinalKeys.kBSB)
            self.userDefault.set(self.txtAccountNumber.text, forKey: RegistrationFinalKeys.kBankAccountNo)
            self.userDefault.set(3, forKey: savedDataForRegistration.kPageNumber)
            driverVC.viewDidLayoutSubviews()
        } else {
            
            let ValidationAlert = UIAlertController(title: "App Name".localized, message: validator.1, preferredStyle: UIAlertController.Style.alert)
            ValidationAlert.addAction(UIAlertAction(title: "Dismiss".localized, style: .cancel, handler: nil))
            self.present(ValidationAlert, animated: true, completion: nil)
        }
        
    }
    
    func CheckValidation() -> (Bool,String)
    {
//        let sb = Snackbar()
        var isValidate:Bool = true
        var ValidationMessage:String = ""
        
        
//        sb.createWithAction(text: "Upload Car Registration", actionTitle: "Dismiss".localized, action: { print("Button is push") })
        
        if txtAccountHolderName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
//            sb.createWithAction(text: "Please enter account holder name".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
            isValidate = false
            ValidationMessage = "Please enter account holder name".localized
        }
        else if txtBankName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
//            sb.createWithAction(text: "Please enter bank name".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
            isValidate = false
            ValidationMessage = "Please enter bank name".localized

        }
            
            
        else if txtBankBranch.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
//            sb.createWithAction(text:"Please enter bank branch".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
            isValidate = false
            ValidationMessage = "Please enter bank branch".localized

        }
            
        else if txtAccountNumber.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
//            sb.createWithAction(text: "Please enter account number".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
            isValidate = false
            ValidationMessage = "Please enter account number".localized
        }
        
//        sb.show()
        return (isValidate,ValidationMessage)

    }

}
