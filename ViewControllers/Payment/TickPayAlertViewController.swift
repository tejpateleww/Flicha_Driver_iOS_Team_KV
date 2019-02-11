//
//  TickPayAlertViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 11/12/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class TickPayAlertViewController: UIViewController {

    
    var strMessage = String()
    var strAmount = String()
    var strBtnNo = String()
    var isBtnYesVisible = Bool()
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Singletons.sharedInstance.strIsFirstTimeTickPay == "FromInVoice" {
            SetData()
        }
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func btnYes(_ sender: UIButton) {
        
        Singletons.sharedInstance.strIsFirstTimeTickPay = "FormAlertYes"
        dismiss(animated: true, completion: nil)
        
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "InVoiceReceiptViewController") as! InVoiceReceiptViewController
        next.strFinalAmount = self.strAmount

        self.navigationController?.pushViewController(next, animated: true)
        
//        self.navigationController?.popViewController(animated: true)
        
//        self.dismiss(animated: true, completion: {
//
//        })
    
//        let nav = (self.presentingViewController?.childViewControllers[0] as! TabbarController).childViewControllers.last as! PayViewController
//        nav.performSegue(withIdentifier: "segueForInVoice", sender: nil)

        
        
//        if Singletons.sharedInstance.isfirstTimeTickPay {
////            let next = self.storyboard?.instantiateViewController(withIdentifier: "InVoiceReceiptViewController") as! InVoiceReceiptViewController
////
////            self.navigationController?.pushViewController(next, animated: true)
//             Singletons.sharedInstance.isfirstTimeTickPay = false
//            self.performSegue(withIdentifier: "segueForInVoice", sender: nil)
//        }
        
        
    }
    
    @IBAction func btnNo(_ sender: UIButton) {
        
        Singletons.sharedInstance.strIsFirstTimeTickPay = "FormAlertNo"
        
//        if btnNo.titleLabel?.text == "OK" {
//            self.dismiss(animated: true, completion: nil)
//            self.navigationController?.popViewController(animated: true)
//
//        }
//        else {
//              self.navigationController?.popViewController(animated: true)
//        }
       
        self.dismiss(animated: true) {
            
        }
        
        
    }
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    func SetData() {
        
        lblMessage.text = strMessage
        btnNo.setTitle(strBtnNo, for: .normal)
        btnYes.isHidden = isBtnYesVisible
        
        Singletons.sharedInstance.strIsFirstTimeTickPay = ""
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is InVoiceReceiptViewController {
            let InvoiceReceipt = segue.destination as! InVoiceReceiptViewController
            InvoiceReceipt.strFinalAmount = self.strAmount

        }
        
    }
    
}
