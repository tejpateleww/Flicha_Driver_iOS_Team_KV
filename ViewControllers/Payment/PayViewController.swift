//
//  PayViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 12/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import FormTextField

class PayViewController: ParentViewController, UIPickerViewDataSource, UIPickerViewDelegate, CardIOPaymentViewControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet var textFields: [UITextField]!
    
   
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    
    var pickerData: [String] = [String]()
    
    var strPaymentInputMethod = String()
    
    var isCheckedTickPay = Bool()
    var strAmount = String()
    
    var aryMonths = [String]()
    var aryYears = [String]()
    var strSelectedMonth = String()
    var strSelectedYear = String()
    var isPasswordEntered = Bool()
    var creditCardValidator: CreditCardValidator!
    
    var isCreditCardValid = Bool()
    var validation = Validation()
    var inputValidator = InputValidator()
    
    var CardNumber = String()
    var strMonth = String()
    var strYear = String()
    var strCVV = String()
    
    var aryTempMonth = [String]()
    var aryTempYear = [String]()
    
    var steGetTickPayRate = String()
    var strGetTransactionFee = String()
    var strAmountOfTotal = String()
    
    var sendAmount = String()
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func loadView() {
        super.loadView()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webserviceOFGetTickpayRate()
      
        Singletons.sharedInstance.strIsFirstTimeTickPay = "first"
        txtCVV.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for textfield in self.textFields {
            textfield.layer.cornerRadius = 5.0
            textfield.layer.borderWidth = 1.0
            textfield.layer.borderColor = UIColor.gray.cgColor
            
            
            if(textfield.tag >= 1)
            {
                
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
                textfield.leftView = paddingView
                textfield.leftViewMode = .always
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        txtCardNumber.layer.borderWidth = 1
        txtCVV.layer.borderWidth = 1
        txtExpiryDate.layer.borderWidth = 1
        txtCardNumber.activeBorderColor = UIColor.gray
        txtCVV.activeBorderColor = UIColor.gray
        txtExpiryDate.activeBorderColor = UIColor.gray
        
        
       if Singletons.sharedInstance.strIsFirstTimeTickPay == "FormAlertYes" {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "InVoiceReceiptViewController") as! InVoiceReceiptViewController
            Singletons.sharedInstance.strIsFirstTimeTickPay = ""
            self.navigationController?.pushViewController(next, animated: true)
        }
        else if Singletons.sharedInstance.strIsFirstTimeTickPay == "FromInVoice" {
            
        
            let next = self.storyboard?.instantiateViewController(withIdentifier: "TickPayAlertViewController") as! TickPayAlertViewController
            next.modalPresentationStyle = .formSheet
            
            
            next.strBtnNo = "OK"
            next.strMessage = "Payment Receipt sent successfully!"
            next.isBtnYesVisible = true
            
           
            self.present(next, animated: true, completion: nil)
            
        }
        
        
        aryMonths = ["01","02","03","04","05","06","07","08","09","10","11","12"]
        aryYears = ["2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030"]
        
        aryTempMonth = ["01","02","03","04","05","06","07","08","09","10","11","12"]
        aryTempYear = ["2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030"]
        creditCardValidator = CreditCardValidator()
        pickerView.delegate = self
        
//        findCurrentMonthAndYear()
        
        cardNum()
        cardExpiry()
        cardCVV()
        
        
        let profileData = Singletons.sharedInstance.dictDriverProfile
        self.txtABNNumber.text = (profileData?.object(forKey: "profile") as! NSDictionary).object(forKey: "ABN") as? String
        self.txtCompanyName.text = (profileData?.object(forKey: "profile") as! NSDictionary).object(forKey: "Fullname") as? String
        
        
    }
 
    func cardNum() {
        txtCardNumber.inputType = .integer
        txtCardNumber.formatter = CardNumberFormatter()
        txtCardNumber.placeholder = "Card Number"
        
        
        validation.maximumLength = 19
        validation.minimumLength = 14
        let characterSet = NSMutableCharacterSet.decimalDigit()
        characterSet.addCharacters(in: " ")
        validation.characterSet = characterSet as CharacterSet
        inputValidator = InputValidator(validation: validation)
        
        txtCardNumber.inputValidator = inputValidator
    }
    
    func cardExpiry() {
        txtExpiryDate.inputType = .integer
        txtExpiryDate.formatter = CardExpirationDateFormatter()
        txtExpiryDate.placeholder = "Expiration Date (MM/YY)"
 
//        var validation = Validation()
        validation.minimumLength = 1
        let inputValidator = CardExpirationDateInputValidator(validation: validation)
        txtExpiryDate.inputValidator = inputValidator
        
        
        print("")
        
    }
    
    func cardCVV() {
 
        txtCVV.inputType = .integer
        txtCVV.placeholder = "CVC"
        
        validation.maximumLength = 3
        validation.minimumLength = 3
        validation.characterSet = NSCharacterSet.decimalDigits
        let inputValidator = InputValidator(validation: validation)
        txtCVV.inputValidator = inputValidator
        
    }
    

    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
  
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtABNNumber: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtPaymentInputMethod: UITextField!

    @IBOutlet weak var txtCardNumber: FormTextField!
    @IBOutlet weak var txtExpiryDate: FormTextField!
    @IBOutlet weak var txtCVV: FormTextField!
    
    @IBOutlet weak var viewTickPay: UIView!
    
    @IBOutlet weak var btnCheckMarkTickPay: UIButton!
    
    
    @IBOutlet weak var txtFinalMount: UITextField!
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    @IBAction func btnCheckMarkTickPay(_ sender: UIButton) {
        
        isCheckedTickPay = !isCheckedTickPay
        
        if (isCheckedTickPay) {
            
            btnCheckMarkTickPay.setImage(UIImage(named: "iconCheckMarkSelected"), for: .normal)
        }
        else {
            
            btnCheckMarkTickPay.setImage(UIImage(named: "iconCheckMarkUnSelected"), for: .normal)
        }
    }
    
    
    @IBAction func btnPaymentInputMethod(_ sender: UIButton) {
    }
    
    @IBAction func txtPaymentInputMethod(_ sender: UITextField) {

        txtPaymentInputMethod.inputView = pickerView
        
    }
    
    
    
    @IBAction func btnPayNow(_ sender: UIButton) {


        if txtCardNumber.text == "" {
            UtilityClass.showAlert("Missing", message: "Please Enter Card Number", vc: self)
        }

        else if txtCompanyName.text == ""
        {
            UtilityClass.showAlert("Missing", message: "Please Enter Company Name / Name", vc: self)
        }
        else if txtAmount.text == "" {
            UtilityClass.showAlert("Missing", message: "Please enter amount".localized, vc: self)
        }
        else if txtExpiryDate.text == "" {
            UtilityClass.showAlert("Missing", message: "Please Enter Expiry Date", vc: self)
        }
        else if txtCVV.isHidden == false {
            
            if txtCVV.text == "" {
                UtilityClass.showAlert("Missing", message: "Please enter CVV Number", vc: self)
            }
            else if txtCVV.text!.count != 3 {
                UtilityClass.showAlert("App Name".localized, message: "Please enter valid CVV Number", vc: self)
            }
        }
        else {
            
            webserviceofTiCKPay()
        }
 
        
        
    }
    
    //-------------------------------------------------------------
    // MARK: - Picker Methods
    //-------------------------------------------------------------
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            
            return aryMonths.count
        }
        else {
            return aryYears.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            
            return aryMonths[row]
        }
        else {
            return aryYears[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 1 {
//            currentYear = "2019"
            
            let year = aryYears[row]
            if Int(currentYear)! == Int(year)! {
                
                aryYears.removeFirst(row)
                for i in 0..<aryMonths.count {
                    if currentMonth == aryMonths[i] {
                        aryMonths.removeFirst(i - 1)
                    }
                }
                aryTempYear = aryYears
                pickerView.reloadAllComponents()
            }
            else {
                aryMonths = aryTempMonth
                aryYears = aryTempYear
                
                pickerView.reloadAllComponents()
            }
        }
        
        if component == 0 {
            strSelectedMonth = aryMonths[row]
        }
        else {
            strSelectedYear = aryYears[row]
            strSelectedYear.removeFirst(2)
        }
        
        txtExpiryDate.text = "\(strSelectedMonth)/\(strSelectedYear)"
    }
    

    func setTextFields() {
        
//        txtPaymentInputMethod.text = strPaymentInputMethod
        
    }
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    @IBAction func txtExpiryDate(_ sender: UITextField) {
        
            strSelectedMonth = aryMonths[0]
            strSelectedYear = aryYears[0]
    }
    
    @IBAction func txtEnterAmount(_ sender: UITextField) {
        
        if let amountString = txtAmount.text?.currencyInputFormatting() {
            txtAmount.text = amountString
//
//            let unfiltered = amountString   //  "!   !! yuahl! !"
//
//            // Array of Characters to remove
//            let removal: [Character] = ["$",","," "]    // ["!"," "]
//
//            // turn the string into an Array
//            let unfilteredCharacters = unfiltered
//
//            // return an Array without the removal Characters
//            let filteredCharacters = unfilteredCharacters.filter { !removal.contains($0) }
//
//            // build a String with the filtered Array
//            let filtered = String(filteredCharacters)
//
//            print(filtered) // => "yeah"
//
//            // combined to a single line
//            print(String(unfiltered.filter { !removal.contains($0) })) // => "yuahl"
//
//            strAmount = String(unfiltered.filter { !removal.contains($0) })
//            print("amount : \(strAmount)")
//
//            let amt = strAmount.trimmingCharacters(in: .whitespacesAndNewlines)
//
//            let doubleAmt = (amt as NSString).doubleValue
//            let doubleValue = (steGetTickPayRate as NSString).doubleValue
//
//            let countPercenteage = (doubleAmt * doubleValue)/100
//
//            let finalValue = ((strAmount as NSString).doubleValue)
//
//            txtFinalMount.text = "\(finalValue + countPercenteage)"
//            strAmountOfTotal = "\(finalValue + countPercenteage)"
//
//            if(finalValue < 100)
//            {
//                txtCVV.isHidden = true
//            }
//            else
//            {
//                txtCVV.isHidden = false
//            }
            
        }
        
    }

    
    @IBAction func btnScanCard(_ sender: UIButton) {
        
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC?.modalPresentationStyle = .formSheet
        present(cardIOVC!, animated: true, completion: nil)
        
    }
    
    var currentMonth = String()
    var currentYear = String()
    
    func findCurrentMonthAndYear() {
        
        let now = NSDate()
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        let curMonth = monthFormatter.string(from: now as Date)
        print("currentMonth : \(curMonth)")
        currentMonth = curMonth
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let curYear = yearFormatter.string(from: now as Date)
        print("currentYear : \(curYear)")
        currentYear = curYear
        
    }
    
    //-------------------------------------------------------------
    // MARK: - Scan Card Methods
    //-------------------------------------------------------------
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        
        print("CardInfo : \(cardInfo)")
        
        if let info = cardInfo {
            _ = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
            //            resultLabel.text = str as String
            
           
            
            print("Card Number : \(info.cardNumber)")
            print("Redacted Card Number : \(customStringFormatting(of: info.redactedCardNumber))")
            print("Month : \(info.expiryMonth)")
            print("Year : \(info.expiryYear)")
            print("CVV : \(info.cvv)")
            
            var years = String(info.expiryYear)
            years.removeFirst(2)
//            customStringFormatting(of: info.redactedCardNumber)
            
            print("Removed Year : \(years)")
            
            txtCardNumber.text = customStringFormatting(of: info.redactedCardNumber)
            txtExpiryDate.text = "\(info.expiryMonth)/\(years)"
            txtCVV.text = info.cvv
            
            CardNumber = String(info.cardNumber)
            strMonth = String(info.expiryMonth)
            strYear = String(years)
            strCVV = String(info.cvv)
            
            
            
        }
        paymentViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
//        resultLabel.text = "user canceled"
        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            _ = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
//            resultLabel.text = str as String
            txtCardNumber.text = info.redactedCardNumber
            txtExpiryDate.text = "\(info.expiryMonth)/\(info.expiryYear)"
        }
        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    
    func customStringFormatting(of str: String) -> String {
        return str.chunk(n: 4)
            .map{ String($0) }.joined(separator: " ")

    }
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    
    func webserviceofTiCKPay() {
//        DriverId,Name,Amount,CardNo,CVV,Expiry
        
        print("strAmount : \(strAmount)")
//        strAmount.removeFirst()
        print("finalAmount : \(strAmount)")
        
        var param = [String:AnyObject]()
        param["DriverId"] = Singletons.sharedInstance.strDriverID as AnyObject
        param["Name"] = txtCompanyName.text as AnyObject
        param["Amount"] = strAmount.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
        
        if CardNumber.count != 0 {
           
            param["CardNo"] = CardNumber as AnyObject
        }
        else {
//            (txtCardNumber.text!).replacingOccurrences(of: " ", with: "")
            
            param["CardNo"] = (txtCardNumber.text!).replacingOccurrences(of: " ", with: "") as AnyObject
        }
        
        if  txtCVV.isHidden == true {
            
        }
        else {
            
            if strCVV.count != 0 {
                param["CVV"] = strCVV as AnyObject
            }
            else {
                param["CVV"] = txtCVV.text! as AnyObject
            }
        }
        
       
        
//        param["Expiry"] = "\(strMonth)/\(strYear)" as AnyObject

        if strMonth.count != 0 && strYear.count != 0 {
            param["Expiry"] = "\(strMonth)/\(strYear)" as AnyObject
        }
        else {
             param["Expiry"] = txtExpiryDate.text as AnyObject
        }
        
        Singletons.sharedInstance.strAmoutOFTickPay = strAmountOfTotal.trimmingCharacters(in: .whitespacesAndNewlines)
       
        
        webserviceForTickPay(param as AnyObject) { (result, status) in

            if (status) {
                print(result)
                DispatchQueue.main.async {

                    if let res = result as? NSDictionary {
                        Singletons.sharedInstance.strTickPayId = String(describing: res.object(forKey: "tickpay_id")!)
                    }
        
                    let next = self.storyboard?.instantiateViewController(withIdentifier: "TickPayAlertViewController") as! TickPayAlertViewController
                    next.strAmount = self.strAmount
                    Singletons.sharedInstance.strTickPayAmt = self.strAmount
                    next.modalPresentationStyle = .formSheet
                    
                    self.present(next, animated: true, completion: nil)
   
                }


                self.txtCVV.text = ""
                self.txtAmount.text = ""
                self.txtCardNumber.text = ""
                self.txtExpiryDate.text = ""
            }
            else {
                print(result)

                DispatchQueue.main.async {

                    if let res = result as? String {
                        UtilityClass.showAlertAnother("App Name".localized, message: res, vc: self)
                    }
                    else {
                        UtilityClass.showAlertAnother("App Name".localized, message: (result as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                    }
                }
            }
        }
    }
    
   
    func webserviceOFGetTickpayRate() {
        
        
        webserviceForGetTickpayRate("" as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                if let res = result as? NSDictionary {
                    self.steGetTickPayRate = res.object(forKey: "rate") as! String
                    self.strGetTransactionFee = res.object(forKey: "TransactionFee") as! String
                    self.lblCredirAndDebitRate.text = "\(self.steGetTickPayRate)% Service fee"
                   
                    
                }
                
                
            }
            else {
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
    @IBOutlet weak var lblCredirAndDebitRate: UILabel!
    
    func validationForTiCKPay() -> Bool {
        
        
        return true
    }
    
    
    
    //-------------------------------------------------------------
    // MARK: - Segue Methods
    //-------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is InVoiceReceiptViewController {
            let InvoiceReceipt = segue.destination as! InVoiceReceiptViewController
            InvoiceReceipt.strFinalAmount = self.strAmount
        }
        
    }
    
    
}

extension Collection {
    public func chunk(n: IndexDistance) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}

extension String {
    var pairs: [String] {
        var result: [String] = []
        let characters = Array(self)
        stride(from: 0, to: characters.count, by: 2).forEach {
            result.append(String(characters[$0..<min($0+2, characters.count)]))
        }
        return result
    }
    mutating func insert(separator: String, every n: Int) {
        self = inserting(separator: separator, every: n)
    }
    func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: characters.count, by: n).forEach {
            result += String(characters[$0..<min($0+n, characters.count)])
            if $0+n < characters.count {
                result += separator
            }
        }
        return result
    }
}

