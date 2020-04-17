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
    }
    
    // ----------------------------------------------------
    // MARK: - --------- IBAction Methods ---------
    // ----------------------------------------------------

    @IBAction func btnSigninTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

