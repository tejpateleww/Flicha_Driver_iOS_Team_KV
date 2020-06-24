//
//  VerifyOtpVC.swift
//  Flicha-Driver
//
//  Created by Apple on 15/06/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class VerifyOtpVC: UIViewController {
    var strEmail: String!
    var strMobileNo: String!
    var nOtp: Int!
    @IBOutlet weak var btnResendOTP: UIButton! {
           didSet {
               btnResendOTP.titleLabel?.font = UIFont.init(name: CustomeFontUbuntuRegular, size: 15)
           }
       }
    @IBOutlet weak var btnNext: ThemeButton!
    @IBOutlet weak var txtOTP: ThemeTextField! {
        didSet {
            txtOTP.placeholder = "Enter Mobile OTP".localized
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        btnNext.setTitle("Next".localized, for: .normal)
        webserviceForGetOTPCode()
        // Do any additional setup after lo`ading the view.
    }
    @IBAction func btnNext(_ sender: Any) {
        let validator = CheckValidation()
        if validator.0 == true {
            userDefault.set("3", forKey: RegistrationFinalKeys.kPageNo)
            self.performSegue(withIdentifier: "secondComplete", sender: self)
        } else {
            
            let ValidationAlert = UIAlertController(title: "App Name".localized, message: validator.1, preferredStyle: UIAlertController.Style.alert)
            ValidationAlert.addAction(UIAlertAction(title: "Dismiss".localized, style: .cancel, handler: nil))
            self.present(ValidationAlert, animated: true, completion: nil)
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

      
    @IBAction func resendClick(_ sender: UIButton) {
        self.webserviceForGetOTPCode()
    }
    func webserviceForGetOTPCode() {
        var dictData = [String:AnyObject]()
        dictData[RegistrationFinalKeys.kEmail] = strEmail as AnyObject
        dictData[RegistrationFinalKeys.kMobileNo] = strMobileNo as AnyObject
        
        webserviceForOTPDriverRegister(dictData as AnyObject) { (result, status) in
            
            if(status) {
                print(result)
                if let otp = result.object(forKey: "otp") as? Int {
                    self.nOtp = otp
                }
                
            }else {
                print(result)
                let alert = UIAlertController(title: "App Name".localized, message: result.object(forKey: GetResponseMessageKey()) as? String, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Dismiss".localized, style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            //
            //            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            //
        }
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func CheckValidation() -> (Bool,String) {
        //        let sb = Snackbar()
        var isValidate:Bool = true
        var ValidationMessage:String = ""
                
        if txtOTP.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            //            sb.createWithAction(text: "Please enter account holder name".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
            isValidate = false
            ValidationMessage = "Please enter mobile OTP".localized
        }else if Int(txtOTP.text!)  != nOtp {
            isValidate = false
            ValidationMessage = "Incorrect verification code".localized
        }
                
        return (isValidate,ValidationMessage)
        
    }
}
