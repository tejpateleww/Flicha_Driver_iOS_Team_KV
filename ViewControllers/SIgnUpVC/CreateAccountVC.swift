//
//  CreateAccountVC.swift
//  Flicha-Driver
//
//  Created by EWW073 on 15/04/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    // ----------------------------------------------------
    // MARK: - --------- Outlets ---------
    // ----------------------------------------------------
    
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var txtGender: ThemeTextField!
    
    @IBOutlet weak var txtFirstname: ThemeTextField!
    @IBOutlet weak var txtLastname: ThemeTextField!
    @IBOutlet weak var txtEmailId: ThemeTextField!
    @IBOutlet weak var txtPhoneNo: ThemeTextField!
    @IBOutlet weak var txtAddress: ThemeTextField!
    @IBOutlet weak var txtPassword: ThemeTextField!
    @IBOutlet weak var txtConfirmPassword: ThemeTextField!
    // ----------------------------------------------------
    // MARK: - --------- Global Variables ---------
    // ----------------------------------------------------
    
    var arrayGender = ["Male","Female"]
    lazy var pickerView = UIPickerView()
    
    // ----------------------------------------------------
    // MARK: - --------- Lifecycle Methods ---------
    // ----------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yourAttributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.foregroundColor : ThemeYellowColor]
        let attributeString = NSMutableAttributedString(string: "SIGN IN".localized,
                                                        attributes: yourAttributes)
        btnSignIn.setAttributedTitle(attributeString, for: .normal)
        
        pickerView.delegate = self
        
        let verifyOtpVC: VerifyOtpVC = UIViewController.viewControllerInstance(storyBoard: .LoginRegistration)
        let accountInfo: AccountInfoVC = UIViewController.viewControllerInstance(storyBoard: .LoginRegistration)
        let vehicleAddVC: VehicleAddVC = UIViewController.viewControllerInstance(storyBoard: .LoginRegistration)
        let documentAddVC: DocumentAddVC = UIViewController.viewControllerInstance(storyBoard: .LoginRegistration)
        
        
//        self.navigationController?.viewControllers.append(accountInfo)
//                    self.navigationController?.pushViewController(vehicleAddVC, animated: true)
        
//        self.navigationController?.viewControllers.append(accountInfo)
//        self.navigationController?.viewControllers.append(vehicleAddVC)
//        self.navigationController?.pushViewController(documentAddVC, animated: true)
        
        delay(0.1) {
            if let currentPage = userDefault.object(forKey: RegistrationFinalKeys.kPageNo) as? String {
                switch currentPage {
                case "2":
                    //                    self.performSegue(withIdentifier: "firstComplete", sender: self)
                    break
                case "3":
                    //                    self.navigationController?.viewControllers.append(verifyOtpVC)
                    self.navigationController?.pushViewController(accountInfo, animated: true)
                    break
                case "4":
                    //                    self.navigationController?.viewControllers.append(verifyOtpVC)
                    self.navigationController?.viewControllers.append(accountInfo)
                    self.navigationController?.pushViewController(vehicleAddVC, animated: true)
                    
                    break
                case "5":
                    //                    self.navigationController?.viewControllers.append(verifyOtpVC)
                    self.navigationController?.viewControllers.append(accountInfo)
                    self.navigationController?.viewControllers.append(vehicleAddVC)
                    self.navigationController?.pushViewController(documentAddVC, animated: true)
                    
                    
                    break
                default:
                    break
                }
            }
        }
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let fullName: String = userDefault.object(forKey: RegistrationFinalKeys.kFullname) as? String {
            let arrData = fullName.components(separatedBy: "||")
            txtFirstname.text = arrData.first
            txtLastname.text = arrData.last
        }

        if let email: String = userDefault.object(forKey: RegistrationFinalKeys.kEmail) as? String {
            txtEmailId.text = email
        }
        
        if let mobileNo: String = userDefault.object(forKey: RegistrationFinalKeys.kMobileNo) as? String {
            txtPhoneNo.text = mobileNo
        }
        
        if let gender: String = userDefault.object(forKey: RegistrationFinalKeys.kGender) as? String {
            txtGender.text = gender
        }

        if let address: String = userDefault.object(forKey: RegistrationFinalKeys.kAddress) as? String {
            txtAddress.text = address
        }

        if let password: String = userDefault.object(forKey: RegistrationFinalKeys.kPassword) as? String {
            txtPassword.text = password
            txtConfirmPassword.text = password
        }
        
    }
    // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
        if let vc = segue.destination as? VerifyOtpVC {
            vc.strEmail = txtEmailId.text
            vc.strMobileNo = txtPhoneNo.text
        }
        
    }
    // ----------------------------------------------------
    // MARK: - --------- IBAction Methods ---------
    // ----------------------------------------------------
    func checkValidation() -> Bool {
        
        let isEmailAddressValid = isValidEmailAddress(emailID: txtEmailId.text!)
        if txtFirstname.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            UtilityClass.showAlert("App Name".localized, message: "Please enter first name".localized, vc: self)
            return false
        }else if txtLastname.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            UtilityClass.showAlert("App Name".localized, message: "Please enter last name".localized, vc: self)
            return false
        } else if txtEmailId.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0
        {
            UtilityClass.showAlert("App Name".localized, message: "Please enter email".localized, vc: self)
            return false
        }
        else if (!isEmailAddressValid)
        {
            UtilityClass.showAlert("App Name".localized, message: "Please enter a valid email".localized, vc: self)
            
            return false
        }
        else if txtPhoneNo.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0
        {
            UtilityClass.showAlert("App Name".localized, message: "Please enter mobile number".localized, vc: self)
            return false
        }
        else if txtPhoneNo.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count != 10
        {
            UtilityClass.showAlert("App Name".localized, message: "Please enter valid mobile number".localized, vc: self)
            return false
        }else if txtGender.text?.count == 0 {
            UtilityClass.showAlert("App Name".localized, message: "Please select gender".localized, vc: self)
            return false
        }else if txtAddress.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            UtilityClass.showAlert("App Name".localized, message: "Please enter address".localized, vc: self)
            return false
        }else if txtPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            UtilityClass.showAlert("App Name".localized, message: "Please enter password".localized, vc: self)
            return false
        } else if (txtPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count)! < 8
        {
            UtilityClass.showAlert("App Name".localized, message: "Password must contain at least 8 characters".localized, vc: self)
            return false
        }
        else if txtConfirmPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0
        {
            UtilityClass.showAlert("App Name".localized, message: "Please enter confirm password".localized, vc: self)
            return false
        }
        else if txtConfirmPassword.text! != txtPassword.text
        {
            UtilityClass.showAlert("App Name".localized, message: "Password and confirm password must be same".localized, vc: self)
            return false
        }
        
        return true
    }
    func isValidEmailAddress(emailID: String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z)-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailID as NSString
            let results = regex.matches(in: emailID, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
        }
        catch _ as NSError {
            returnValue = false
        }
        
        return returnValue
    }
    @IBAction func btnSigninTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextClick(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "firstComplete", sender: self)
       if checkValidation() {
            let fullName = txtFirstname.text! + "||" + txtLastname.text!
            userDefault.set(fullName, forKey: RegistrationFinalKeys.kFullname)
            userDefault.set(self.txtEmailId.text, forKey: RegistrationFinalKeys.kEmail)
            userDefault.set(self.txtPhoneNo.text, forKey: RegistrationFinalKeys.kMobileNo)
            userDefault.set(self.txtGender.text, forKey: RegistrationFinalKeys.kGender)
            userDefault.set(self.txtAddress.text, forKey: RegistrationFinalKeys.kAddress)
            userDefault.set(self.txtPassword.text, forKey: RegistrationFinalKeys.kPassword)
            userDefault.set("2", forKey: RegistrationFinalKeys.kPageNo)
//            userDefault.set(self.txtConfirmPassword.text, forKey: RegistrationFinalKeys.kMobileNo)
            self.performSegue(withIdentifier: "firstComplete", sender: self)
        }
    }
}

// ----------------------------------------------------
// MARK: - --------- UITextField Delegate Methods ---------
// ----------------------------------------------------

extension CreateAccountVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtGender {
            textField.inputView = pickerView
            if textField.text!.isEmpty {
                textField.text = arrayGender.first?.localized
                //                selectedGender = arrayGender.first
            }
        }
    }
}

// ----------------------------------------------------
// MARK: - --------- Pickerview Delegate Methods ---------
// ----------------------------------------------------

extension CreateAccountVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayGender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayGender[row].localized
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtGender.text = arrayGender[row].localized
        //        selectedGender = arrayGender[row]
    }
}

