//
//  PassengerInfoViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 06/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import MessageUI

class PassengerInfoViewController: UIViewController,MFMessageComposeViewControllerDelegate {
  
    

    
    var strPickupLocation = String()
    var strDropoffLocation = String()
    var imgURL = String()
    var strPassengerName = String()
    var strPassengerMobileNumber = String()
    
    var strFlightNumber = String()
    var strNotes = String()
    
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    //view
    @IBOutlet weak var viewPassengerInfo: UIView!
   //image
    @IBOutlet weak var imgPassengerProfile: UIImageView!
    //label
    @IBOutlet weak var lblPickUpLocationInFo: UILabel!
    @IBOutlet weak var lblDroPoffLocationInFo: UILabel!
    @IBOutlet weak var lblFlightNumberInFo: UILabel!
    @IBOutlet weak var lblNotesInFo: UILabel!
  
    @IBOutlet weak var lblPickupLocationDetails: UILabel!
    @IBOutlet weak var lblDropoffLocationDetails: UILabel!
    @IBOutlet weak var lblContactNumber: UILabel!
    @IBOutlet weak var lblPassengerInfo: UILabel!
    @IBOutlet weak var lblPassengerName: UILabel!
    @IBOutlet weak var lblFlightNumber: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblFlightNumberDetail: UILabel!
    @IBOutlet weak var lblNotesDetail: UILabel!
    
    //stackview
    @IBOutlet weak var stackViewFlightNumber: UIStackView!
    @IBOutlet weak var stackViewNotes: UIStackView!
    //button
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackViewFlightNumber.isHidden = true
        stackViewNotes.isHidden = true
        
        viewPassengerInfo.layer.cornerRadius = 5
        viewPassengerInfo.layer.masksToBounds = true
        
        btnOK.layer.cornerRadius = 5
        btnOK.layer.masksToBounds = true
        
        setDataToAllFileds()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setlocalization()
    }

    func setlocalization()
    {
        lblPassengerInfo.text = "Passenger Info".localized
        lblPickUpLocationInFo.text = "Pick up location".localized
        lblDroPoffLocationInFo.text = "Drop off location".localized
        lblFlightNumberInFo.text = "Flight No".localized
        lblNotesInFo.text = "Notes".localized
        btnOK.setTitle("OK".localized, for: .normal)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgPassengerProfile.layer.cornerRadius = imgPassengerProfile.frame.size.width/2
        imgPassengerProfile.layer.masksToBounds = true
    }
    
    func setDataToAllFileds() {
        
        
        if strFlightNumber.count == 0 {
            stackViewFlightNumber.isHidden = true
        }
        else {
            stackViewFlightNumber.isHidden = false
            lblFlightNumber.text = strFlightNumber
        }
        
        if strNotes.count == 0 {
            stackViewNotes.isHidden = true
        }
        else {
            stackViewNotes.isHidden = false
            lblNotesDetail.text = strNotes
        }
        
        
        lblPickupLocationDetails.text = strPickupLocation
        lblDropoffLocationDetails.text = strDropoffLocation
        lblPassengerName.text = strPassengerName
        imgPassengerProfile.sd_setShowActivityIndicatorView(true)
        //        imgPassengerProfile.sd_addActivityIndicator()
        if(imgURL != "" )
        {
            imgPassengerProfile.sd_setIndicatorStyle(UIActivityIndicatorView.Style.gray)
            imgPassengerProfile.sd_setImage(with: URL(string:  WebserviceURLs.kImageBaseURL + imgURL)) { (image, error, cacheType, url) in
                self.imgPassengerProfile.sd_removeActivityIndicator()
            }
        }
        
        if strPassengerMobileNumber == "" {
            strPassengerMobileNumber = "Not Available"
        }
        
//        var attributedString = NSAttributedString(string: strPassengerMobileNumber)
//        let textRange = NSMakeRange(0, attributedString.length)
        
//        attributedString.addAttribute(NSUnderlineStyleAttributeName,
//                                      value: NSUnderlineStyle.styleSingle.rawValue,
//                                      range: textRange)

        let attributedString = NSAttributedString(
            string: NSLocalizedString(strPassengerMobileNumber, comment: ""),
            attributes:[
                NSAttributedString.Key.underlineStyle:1.0
            ])
        
            //[.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        
        
        btnCall.setAttributedTitle(attributedString, for: .normal)
        
//        btnCall.setTitle(strPassengerMobileNumber, for: .normal)
    
        
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Message delegate Method
    //-------------------------------------------------------------

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------

    @IBAction func btnMessage(_ sender: Any) {
        if (MFMessageComposeViewController.canSendText()) {
            
            
            let contactNumber = strPassengerMobileNumber
            
            if contactNumber == "" {
                UtilityClass.showAlert("App Name".localized, message: "Contact number  is not available", vc: self)
            }
            else {
                let controller = MFMessageComposeViewController()
                controller.body = ""
                controller.recipients = [strPassengerMobileNumber]
                controller.messageComposeDelegate = self
                self.present(controller, animated: true, completion: nil)
                
            }
           
        }
    }
    
    
    @IBAction func swipeDownToDismiss(_ sender: UISwipeGestureRecognizer) {
        
         self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnOK(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
//        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCall(_ sender: UIButton) {
        
        let contactNumber = strPassengerMobileNumber
        
        if contactNumber == "" {
            UtilityClass.showAlert("App Name".localized, message: "Contact number  is not available", vc: self)
        }
        else {
            callNumber(phoneNumber: contactNumber)
        }
    }
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    
    
}
