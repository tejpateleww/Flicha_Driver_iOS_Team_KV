//
//  WalletTopUpVC.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 23/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit


@objc protocol SelectCardDelegate {
    
    func didSelectCard(dictData: [String:AnyObject])
}


class WalletTopUpVC: ParentViewController, SelectCardDelegate, delegatePesapalWebView {
   
    @IBOutlet var viewCardNumber: UIView!
    var strCardId = String()
    var strAmt = String()
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        viewMain.layer.cornerRadius = 5
        viewMain.layer.masksToBounds = true
        viewCardNumber.layer.cornerRadius = 5
        viewCardNumber.layer.masksToBounds = true
        viewCardNumber.layer.borderColor = UIColor.lightGray.cgColor
        viewCardNumber.layer.borderWidth = 1.5
        btnAddFunds.layer.cornerRadius = 5
        btnAddFunds.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
        {
            super.viewWillAppear(animated)
            self.SetLocalizable()
            self.navigationController?.isNavigationBarHidden = true
        }
    
    
    func SetLocalizable() {
        self.strTitle = "Top Up".localized
        self.showsBackButton = true
        self.createHeaderView()
        self.btnAddFunds.setTitle("Top Up".localized, for: .normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    @IBOutlet weak var lblCard: UILabel!
    
    @IBOutlet weak var ImgCard: UIImageView!
    @IBOutlet weak var lblDoller: UILabel!
    @IBOutlet weak var lblCardTitle: UILabel!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var btnAddFunds: UIButton!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnCardTitle: UIButton!
    
    
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func btnCardTitle(_ sender: UIButton) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletCardsVC") as! WalletCardsVC
        Singletons.sharedInstance.isFromTopUP = true
        next.delegateForTopUp = self
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func btnAddFunds(_ sender: UIButton) {
        
//        if strCardId == "" {
//            UtilityClass.showAlert(appName.kAPPName, message: "Please reselect card", vc: self)
//        }
//        else
        
        if txtAmount.text == ""
        {
            UtilityClass.showAlert(appName.kAPPName, message: "Please enter amount".localized, vc: self)
        }
        else
        {
//            webserviceOFTopUp()
            let next = self.storyboard?.instantiateViewController(withIdentifier: "PesapalWebViewViewController") as! PesapalWebViewViewController
            next.strUrl = "https://www.tantaxitanzania.com/pesapal/add_money/\(Singletons.sharedInstance.strDriverID)/\(txtAmount.text!.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: currency, with: ""))/driver"
//            let navController = UINavigationController.init(rootViewController: next)
//            UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: nil)
            self.navigationController?.pushViewController(next, animated: true)
//            self.present(next, animated: true, completion: nil)
            txtAmount.resignFirstResponder()
        }
    }
    
    @IBAction func txtAmount(_ sender: UITextField) {
        
        if let amountString = txtAmount.text?.currencyInputFormatting() {

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
    
    //-------------------------------------------------------------
    // MARK: - Select Card Delegate Methods
    //-------------------------------------------------------------
    
    func didSelectCard(dictData: [String : AnyObject]) {
        
        print(dictData)
        let strIconCard = dictData["Type"] as! String
        ImgCard.image = UIImage.init(named: setCreditCardImage(str: strIconCard))
        lblCardTitle.text = "\(dictData["CardNum2"] as! String)"
        strCardId = dictData["Id"] as! String
        
    }
    
    func setCreditCardImage(str: String) -> String {
        
        //   visa , mastercard , amex , diners , discover , jcb , other
        
        var strType = String()
        
        if str == "visa" {
            strType = "visa"
        }
        else if str == "mastercard" {
            strType = "mastercard"
        }
        else if str == "amex" {
            strType = "Amex"
        }
        else if str == "diners" {
            strType = "Diners Club"
        }
        else if str == "discover" {
            strType = "discover"
        }
        else if str == "jcb" {
            strType = "JCB"
        }
        else {
            strType = "iconDummyCard"
        }
        
        return strType
    }
    
    func didOrderPesapalStatus(status: Bool) {
        if status
        {
            
        }
    }
    
    
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods For TOP UP
    //-------------------------------------------------------------
    
    func webserviceOFTopUp() {
        
        var dictParam = [String:AnyObject]()
        
        strAmt = strAmt.trimmingCharacters(in: .whitespacesAndNewlines)
        
        dictParam[profileKeys.kDriverId] = Singletons.sharedInstance.strDriverID as AnyObject
        dictParam[walletAddMoney.kCardId] = strCardId as AnyObject
        dictParam[walletAddMoney.kAmount] = strAmt.replacingOccurrences(of: " ", with: "") as AnyObject
        
        webserviceForAddMoneyInWallet(dictParam as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                
                self.txtAmount.text = ""
                
                UtilityClass.showAlert(appName.kAPPName, message: (result as! NSDictionary).object(forKey: "message") as! String, vc: self)
                
                Singletons.sharedInstance.strCurrentBalance = ((result as! NSDictionary).object(forKey: "walletBalance") as! AnyObject).doubleValue
                
            }
            else {
                print(result)
                
                self.txtAmount.text = ""
                
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

/*
{
    message = "Add Money successfully";
    status = 1;
    walletBalance = "-4.63";
}
 */


