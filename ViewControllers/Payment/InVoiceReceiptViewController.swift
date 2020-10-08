//
//  InVoiceReceiptViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 16/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import M13Checkbox

class InVoiceReceiptViewController: ParentViewController, UIPickerViewDelegate, UINavigationControllerDelegate {

    let pickerView = UIPickerView()
    
    var pickerData: [String] = [String]()
    
    var strPaymentInputMethod = String()
     var strFinalAmount = String()
     var BoolCurrentLocation = Bool()
    
    var strInvoiceType = String()
    var strCustomerName = String()
    var strTiCKPayId = String()
    
    var dictData = NSMutableDictionary()
    var strDescription = String()
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dictData = NSMutableDictionary(dictionary: Singletons.sharedInstance.dictDriverProfile as NSDictionary)
        
        let profile = dictData.object(forKey: "profile") as! NSDictionary
        
        if let description = profile.object(forKey: "Description") as? String {
            strDescription = description
        }
        
        
        pickerData = ["Send Via…", "Send Via SMS", "Send Via Email"]
        
        self.pickerView.delegate = self
        
        txtPhoneNumber.isHidden = true
        txtEmailId.isHidden = true
        
        setEmailView()
        fillTextFields()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillTextFields() {
        
        txtDescription.text = strDescription
        txtTotalAmount.text = Singletons.sharedInstance.strAmoutOFTickPay
    }
    

    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    
    @IBOutlet weak var txtSendVia: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtCustomerName: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtTotalAmount: UITextField!
    
    @IBOutlet weak var viewEmailOption: M13Checkbox!
    @IBOutlet weak var viewSMSOption: M13Checkbox!
    
    
    //-------------------------------------------------------------
    // MARK: - Picker Methods
    //-------------------------------------------------------------
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        strPaymentInputMethod = pickerData[row]
        
        if row == 1 {
            
            txtPhoneNumber.isHidden = false
            txtEmailId.isHidden = true
            txtEmailId.text = ""
            strInvoiceType = "SMS"
        }
        else if row == 2 {
            txtPhoneNumber.isHidden = true
            txtPhoneNumber.text = ""
            txtEmailId.isHidden = false
            strInvoiceType = "Email"
        }
        else {
            txtPhoneNumber.isHidden = true
            txtEmailId.isHidden = true
            txtPhoneNumber.text = ""
            txtEmailId.text = ""
        }
        
        setTextFields()
    }
    
    func setTextFields() {
        
        txtSendVia.text = strPaymentInputMethod
        
    }
    
    
    // For Mobile Number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtPhoneNumber {
            let resultText: String? = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
            //            return (resultText?.count ?? 0) <= 10
            
            if resultText!.count >= 11 {
                return false
            }
            else {
                return true
            }
        }
        
        return true
    }
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    func setEmailView() {
        
        viewEmailOption.checkState = .checked
        viewEmailOption.tintColor = UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        viewSMSOption.checkState = .unchecked
        
        txtPhoneNumber.isHidden = true
        txtPhoneNumber.text = ""
        txtEmailId.isHidden = false
        strInvoiceType = "Email"
    }
    
    func setSMSView() {
        
        viewSMSOption.checkState = .checked
        viewSMSOption.tintColor = UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        viewEmailOption.checkState = .unchecked
        
        txtPhoneNumber.isHidden = false
        txtEmailId.isHidden = true
        txtEmailId.text = ""
        strInvoiceType = "SMS"
        
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func btnEmailSelection(_ sender: UIButton) {
        setEmailView()
    }
    

    @IBAction func btnSMSSelection(_ sender: UIButton) {
        setSMSView()
    }
    
    
    @IBAction func txtSendVia(_ sender: UITextField) {
        
        txtSendVia.inputView = pickerView
    }
    @IBAction func btnSend(_ sender: UIButton) {
   
        webserviceOFSendInvoice()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationOfCarAndTaxi = segue.destination as? TickPayAlertViewController {
            destinationOfCarAndTaxi.strBtnNo = "OK"
            destinationOfCarAndTaxi.strMessage = "Payment Receipt send successfully!"
            destinationOfCarAndTaxi.isBtnYesVisible = true

        }
        
    }
    
    func webserviceOFSendInvoice() {
        
//        TickpayId,InvoiceType,CustomerName,Notes,Amount,Email,MobileNo(InvoiceType : SMS/Email)
        
        var param = [String:AnyObject]()
        
        strTiCKPayId = Singletons.sharedInstance.strTickPayId
        
        if strInvoiceType == "" {
            UtilityClass.showAlert("App Name".localized, message: "Select Invoice Type", vc: self)
        }
        else {
            param["InvoiceType"] = strInvoiceType as AnyObject
        }
        
        param["TickpayId"] = strTiCKPayId as AnyObject
        
        if strInvoiceType == "SMS" {
            param["MobileNo"] = txtPhoneNumber.text as AnyObject
        }
        else {
            param["Email"] = txtEmailId.text as AnyObject
        }
        
        
        param["CustomerName"] = txtCustomerName.text as AnyObject
        param["Notes"] = txtDescription.text as AnyObject
        
        param["Amount"] =  Singletons.sharedInstance.strTickPayAmt as AnyObject
        print(param)
        
        if(validations() == true)
        {
        
        webserviceForSendInvoice(param as AnyObject) { (result, status) in

            if (status) {
                print(result)

                Singletons.sharedInstance.strIsFirstTimeTickPay = "FromInVoice"
                Singletons.sharedInstance.strTickPayAmt = ""
                self.navigationController?.popViewController(animated: true)


            }
            else{
                print(result)
                if let res = result as? String {
                    UtilityClass.showAlert("App Name".localized, message: res, vc: self)
                }
                else if let resDict = result as? NSDictionary {
                    UtilityClass.showAlert("App Name".localized, message: resDict.object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }
                else if let resAry = result as? NSArray {
                    UtilityClass.showAlert("App Name".localized, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }

            }
        }
        }
    }
    
    func validations() -> Bool
    {
        let isEmailAddressValid = isValidEmailAddress(emailID: txtEmailId.text!)
        //        let providePassword = txtPassword.text
        
        //        let isPasswordValid = isPwdLenth(password: providePassword!)
        
        if (txtPhoneNumber.isHidden == true)
        {
            if txtEmailId.text!.count == 0
            {
                UtilityClass.showAlert("App Name".localized, message: "Please Enter Email Id".localized, vc: self)
                return false
            }
            else if (!isEmailAddressValid)
            {
                UtilityClass.showAlert("App Name".localized, message: "Please Enter Valid Email ID".localized, vc: self)
                
                return false
            }
        }
        else
        {
             if txtPhoneNumber.text!.count == 0
            {
                
                UtilityClass.showAlert("App Name".localized, message: "Please Enter Phone number".localized, vc: self)
                
                return false
            }
        }
        
       
       
         if txtCustomerName.text!.count == 0 {
            UtilityClass.showAlert("App Name".localized, message: "Please enter Customer Name.".localized, vc: self)
            return false
        }
        else if txtDescription.text!.count == 0 {
            UtilityClass.showAlert("App Name".localized, message: "Please enter description".localized, vc: self)
            return false
        }
        
        
        return true
    }
    
    
    func isValidEmailAddress(emailID: String) -> Bool
    {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z)-9.-]+\\.[A-Za-z]{2,3}"
        
        do{
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailID as NSString
            let results = regex.matches(in: emailID, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
        }
        catch _ as NSError
        {
            returnValue = false
        }
        
        return returnValue
    }
    
}
