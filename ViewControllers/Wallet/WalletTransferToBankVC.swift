//
//  WalletTransferToBankVC.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 23/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift


@objc protocol SelectBankCardDelegate {
    
    func didSelectBankCard(dictData: [String: AnyObject])
}

class WalletTransferToBankVC: ParentViewController, SelectBankCardDelegate {


    
    @IBOutlet var txtBankAccountNo: ACFloatingTextfield!
    
    @IBOutlet var txtBSB: ACFloatingTextfield!
    @IBOutlet var txtBankName: ACFloatingTextfield!
    @IBOutlet var txtAccountName: ACFloatingTextfield!
    @IBOutlet weak var lblcurrentBalance: UILabel!
    @IBOutlet var lblBSB: UILabel!
    @IBOutlet var lblBankAccNumber: UILabel!
    @IBOutlet var lblABN: UILabel!
    @IBOutlet var lblAccountHolderName: UILabel!
    @IBOutlet var lblBankName: UILabel!
    
    @IBOutlet weak var lblBsbDetail: UILabel!
    @IBOutlet weak var lblAbn: UILabel!
    @IBOutlet weak var lblAccountHolder: UILabel!
    @IBOutlet weak var constraintTopOfMoney: NSLayoutConstraint! // 40
    @IBOutlet weak var constraintHeightOfMoney: NSLayoutConstraint! // 40
    
    @IBOutlet weak var lblBSBTitle: UILabel!
    @IBOutlet weak var lblACNum: UILabel!
    @IBOutlet weak var lblBankAccount: UILabel!
    @IBOutlet weak var lblDoller: UILabel!
    
    
    var strAmt = String()
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        if DeviceType.IS_IPAD || DeviceType.IS_IPHONE_4_OR_LESS {
            constraintTopOfMoney.constant = 20
            constraintHeightOfMoney.constant = 30
        }
        
        viewMain.layer.cornerRadius = 5
        viewMain.layer.masksToBounds = true
        
        btnWithdrawFunds.layer.cornerRadius = 5
        btnWithdrawFunds.layer.masksToBounds = true
        
      txtBankAccountNo.keyboardType = .numberPad
        lblCurrentBalanceTitle.text = "\(Singletons.sharedInstance.strCurrentBalance)"
        let profileData = Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! [String : AnyObject]

        
       
        let strBSB = profileData["BSB"] as! String
        let strHolderName = profileData["BankHolderName"] as! String
        let strABN = profileData["ABN"] as! String
        let strBankName = profileData["BankName"] as! String
        let strAccNumber = profileData["BankAcNo"] as! String
      
        
        
        
//        lblAccountHolderName.text = ": \(strHolderName)"
//        lblABN.text = ": \(strABN)"
//        lblBankName.text = ": \(strBankName)"
//        lblBankAccNumber.text = ": \(strAccNumber)"
//        lblBSB.text = ":  \(strBSB)"
//
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func clearTextFields() {
        txtAccountName.text = ""
        //        txtABN.text = ""
        txtBankName.text = ""
        txtBankAccountNo.text = ""
        txtBSB.text = ""
        strAmt = ""
        
    }
    func setData() {
        
        self.view.backgroundColor = UIColor.white
        let profileData = Singletons.sharedInstance.dictDriverProfile
        //        txtNote.text = profileData.object(forKey: "Description") as? String
        //        txtABN.text = profileData.object(forKey: "ABN") as? String
        txtBSB.text = profileData!.object(forKey: "BSB") as? String
        txtBankName.text = profileData!.object(forKey: "BankName") as? String
        txtBankAccountNo.text = profileData!.object(forKey: "BankAccountNo") as? String
        txtAccountName.text = profileData!.object(forKey: "CompanyName") as? String
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        txtAccountName.lineColor = .black
        //        txtABN.lineColor = .black
        txtBankName.lineColor = .black
        txtBankAccountNo.lineColor = .black
        txtBSB.lineColor = .black
    }
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var lblCardTitle: UILabel!
    @IBOutlet weak var lblCurrentBalanceTitle: UILabel!
    
    @IBOutlet weak var txtAmount: UITextField!
    
    @IBOutlet weak var btnWithdrawFunds: UIButton!
    
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var btnCardTitle: UIButton!
    
    
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func btnCardTitle(_ sender: UIButton) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletCardsVC") as! WalletCardsVC
        Singletons.sharedInstance.isFromTransferToBank = true
        next.delegateForTransferToBank = self
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    
    
    @IBAction func txtAmount(_ sender: UITextField) {
        
        if let amountString = txtAmount.text?.currencyInputFormatting() {
            
            
            //            txtAmount.text = amountString
            
            
            let unfiltered1 = amountString   //  "!   !! yuahl! !"
            
            
            var y = amountString.replacingOccurrences(of: "$", with: "", options: .regularExpression, range: nil)
            y = y.replacingOccurrences(of: " ", with: "")
            // Array of Characters to remove
            let removal1: [Character] = ["$"," "]    // ["!"," "]
            
            // turn the string into an Array
            let unfilteredCharacters1 = unfiltered1
            
            // return an Array without the removal Characters
            let filteredCharacters1 = unfilteredCharacters1.filter { !removal1.contains($0) }
            
            // build a String with the filtered Array
            let filtered1 = String(filteredCharacters1)
            
            print(filtered1) // => "yeah"
            
            // combined to a single line
            print(String(unfiltered1.filter { !removal1.contains($0) })) // => "yuahl"
            
            txtAmount.text = String(unfiltered1.filter { !removal1.contains($0) })
            
            
            
            // ----------------------------------------------------------------------
            // ----------------------------------------------------------------------
            let unfiltered = amountString   //  "!   !! yuahl! !"
            
            // Array of Characters to remove
            let removal: [Character] = ["$",","," "]    // ["!"," "]
            
            // turn the string into an Array
            let unfilteredCharacters = unfiltered
            
            // return an Array without the removal Characters
            let filteredCharacters = unfilteredCharacters.filter { !removal.contains($0) }
            
            // build a String with the filtered Array
            let filtered = String(filteredCharacters)
            
            print(filtered) // => "yeah"
            
            // combined to a single line
            print(String(unfiltered.filter { !removal.contains($0) })) // => "yuahl"
            
            strAmt = y
            print("amount : \(strAmt)")
            
            
            
            
        }
    }
    
    @IBAction func btnWithdrawFunds(_ sender: UIButton) {
        
//        UtilityClass.showAlert(appName.kAPPName, message: "This feature is not available right now.", vc: self)
        
        if validationOfTransferToBank()
        {
            webserviceCallToTransferToBank()
        }
        
    }
    
    //-------------------------------------------------------------
    // MARK: - Select Card Delegate Methods
    //-------------------------------------------------------------
    func validationOfTransferToBank() -> Bool {
        
        strAmt = strAmt.trimmingCharacters(in: .whitespacesAndNewlines)
        strAmt = strAmt.replacingOccurrences(of: " ", with: "")
        
        //        if txtABN.text!.count == 0 {
        //
        //            UtilityClass.setCustomAlert(title: "Missing", message: "Enter ABN Number") { (index, title) in
        //            }
        //            return false
        //        }
        if txtAmount.text!.count == 0 {
            
//            Utilities.showCustomAlert(title: "Missing", message: "Enter Amount") { (index, title) in
//            }
            Utilities.showAlert(appName.kAPPName, message: "Enter Amount", vc: (UIApplication.shared.keyWindow?.rootViewController)!)
            return false
        }
        else if txtAccountName.text!.count == 0 {
            
            Utilities.showAlert(appName.kAPPName, message: "Enter Account Holder Name", vc: (UIApplication.shared.keyWindow?.rootViewController)!)
            return false
        }
            
        else if txtBankName.text!.count == 0 {
            
            Utilities.showAlert(appName.kAPPName, message: "Enter Bank Name", vc: (UIApplication.shared.keyWindow?.rootViewController)!)
            return false
        }
        else if txtBankAccountNo.text!.count == 0 {
            Utilities.showAlert(appName.kAPPName, message: "Enter Bank Account Number", vc: (UIApplication.shared.keyWindow?.rootViewController)!)
            return false
        }
        else if txtBSB.text!.count == 0 {
            
            Utilities.showAlert(appName.kAPPName, message: "Enter BSB Number", vc: (UIApplication.shared.keyWindow?.rootViewController)!)
            return false
        }
            
            
        else if Double(strAmt)! > Singletons.sharedInstance.strCurrentBalance {
            
           Utilities.showAlert(appName.kAPPName, message: "Entered amout is more than current balance", vc: (UIApplication.shared.keyWindow?.rootViewController)!)
            return false
        }
        
        
        return true
    }
    
    func didSelectBankCard(dictData: [String : AnyObject]) {
        
        print(dictData)
        
        lblCardTitle.text = "\(dictData["Type"] as! String) \(dictData["CardNum2"] as! String)"
        
//        lblCurrentBalanceTitle = dictData["Type"] as? AnyObject
        
        //        dictData1["PassengerId"] = "1" as AnyObject
        //        dictData1["CardNo"] = "**** **** **** 1081" as AnyObject
        //        dictData1["Cvv"] = "123" as AnyObject
        //        dictData1["Expiry"] = "08/22" as AnyObject
        //        dictData1["CardType"] = "MasterCard" as AnyObject
        
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Webservice Call To transfer money to bank
    //-------------------------------------------------------------
    
    //DriverId,Amount,HolderName,ABN,BankName,BSB,AccountNo
    func  webserviceCallToTransferToBank()
    {
       
        let profileData = Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! [String : AnyObject]
        let strDriverID = profileData["Id"] as! String
        let strAmount = self.strAmt
        
        var dictData = [String : String]()
        dictData["DriverId"] = strDriverID
        dictData["Amount"] = strAmount
        dictData["HolderName"] = txtAccountName.text //as! String
        dictData["ABN"] = "" //as! String
        dictData["BankName"] = txtBankName.text //as! String
        dictData["BSB"] = txtBSB.text //as! String
        dictData["AccountNo"] = txtBankAccountNo.text //as! String
        
        webserviceForTransferMoneyToBank(dictData as AnyObject) { (result, status) in
            if(status)
            {
                
            }
            else
            {
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
//
    

}
