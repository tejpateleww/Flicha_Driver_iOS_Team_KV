//
//  ReceiveRequestViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 06/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import SRCountdownTimer
import NVActivityIndicatorView
import MarqueeLabel

class ReceiveRequestViewController: UIViewController, SRCountdownTimerDelegate {

    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var viewRequestReceive: UIView!
    
    @IBOutlet weak var lblReceiveRequest: UILabel!
    
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblPickUpLocationInfo: UILabel!
    @IBOutlet weak var lblPickupLocation: MarqueeLabel!
    @IBOutlet weak var lblDropoffLocationInfo: UILabel!
    @IBOutlet weak var lblDropoffLocation: MarqueeLabel!
    
    //    @IBOutlet weak var lblFlightNumber: UILabel!
    //    @IBOutlet weak var lblNotes: UILabel!
    
    //    @IBOutlet weak var stackViewFlightNumber: UIStackView!
    
    //    @IBOutlet weak var stackViewNotes: UIStackView!
    
    @IBOutlet weak var btnReject: UIButton!{
        didSet {
            btnReject.setTitle("Reject".localized, for: .normal)
            btnReject.titleLabel?.font = UIFont.bold(ofSize: 17)
        }
    }
    @IBOutlet weak var btnAccepted: UIButton!{
        didSet {
            btnAccepted.setTitle("Accept".localized, for: .normal)
            
            btnAccepted.titleLabel?.font = UIFont.bold(ofSize: 17)
        }
    }
    @IBOutlet weak var lblTitleRecieve: UILabel! {
        didSet {
            lblTitleRecieve.text = "Receive Request".localized
            lblTitleRecieve.font = UIFont.regular(ofSize: 25)
        }
    }
    @IBOutlet weak var lblTitleBookingArrive: UILabel! {
        didSet {
                   lblTitleBookingArrive.text = "New Booking Request Arrived".localized
                   lblTitleBookingArrive.font = UIFont.regular(ofSize: 15)
               }
    }
    
    @IBOutlet weak var viewDetails: UIView!
    
    @IBOutlet weak var viewCountdownTimer: SRCountdownTimer!
    //    @IBOutlet var constratintHorizontalSpaceBetweenButtonAndTimer: NSLayoutConstraint!
    
    var isAccept : Bool!
    var delegate: ReceiveRequestDelegate!
    
    var strPickupLocation = String()
    var strDropoffLocation = String()
    var strGrandTotal = String()
    var strEstimateFare = String()
    var strRequestMessage = String()
    var strFlightNumber = String()
    var strNotes = String()
    
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CountDownView()
        
//        btnReject.layer.cornerRadius = 5
//        btnReject.layer.masksToBounds = true
//
//        btnAccepted.layer.cornerRadius = 5
//        btnAccepted.layer.masksToBounds = true
//
//        btnAccepted.layer.borderWidth = 1
//        btnAccepted.layer.borderColor = ThemeYellowColor.cgColor
        
        boolTimeEnd = false
        isAccept = false
        
//        self.playSound()
        
        fillAllFields()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setLocalization()
    }
    
    func setLocalization(){
        lblReceiveRequest.text = "Receive Request".localized
        lblMessage.text = "New booking request arrived".localized
//        lblGrandTotal.text = "Grand Total is".localized
        lblPickUpLocationInfo.text = "Pick up location".localized
        lblDropoffLocationInfo.text = "Drop off location".localized
        btnReject.setTitle("Reject".localized, for: .normal)
        btnAccepted.setTitle("Accept".localized, for: .normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func CountDownView() {
        
//        viewCountdownTimer.labelFont = UIFont(name: "HelveticaNeue-Light", size: 30.0)
        //                    self.timerView.timerFinishingText = "End"
        viewCountdownTimer.lineWidth = 4
        viewCountdownTimer.lineColor = themeLineColor
        viewCountdownTimer.trailLineColor = ThemeYellowColor
        viewCountdownTimer.labelTextColor = ThemeYellowColor
        viewCountdownTimer.labelFont = UIFont.bold(ofSize: 20)
        viewCountdownTimer.delegate = self
        viewCountdownTimer.start(beginingValue: 30, interval: 1)
//        lblMessage.text = "New booking request arrived from \(appName.kAPPName)"
        
    }
    
    func fillAllFields() {
        
//        if Singletons.sharedInstance.passengerType == "" {
//
//            viewDetails.isHidden = true
//
//            lblGrandTotal.isHidden = true
////            constratintHorizontalSpaceBetweenButtonAndTimer.priority = 1000
////            stackViewFlightNumber.isHidden = true
////            stackViewNotes.isHidden = true
//        }
//        else {
            viewDetails.isHidden = false
            print(strGrandTotal)
            print(strPickupLocation)
            print(strDropoffLocation)
            print(strFlightNumber)
            print(strNotes)
//            if strGrandTotal != "0" {
//                lblGrandTotal.text = "Grand Total : \(strGrandTotal) \(currency)"
//            } else if strEstimateFare != "0" {
                lblGrandTotal.text = "\("Estimate Fare".localized) : \(strEstimateFare) \(currency)"
//            }
        
            lblMessage.text = strRequestMessage
            lblPickupLocation.text = strPickupLocation
            lblDropoffLocation.text = strDropoffLocation
            
//            if strFlightNumber.count == 0 {
//                stackViewFlightNumber.isHidden = true
//            }
//            else {
//                stackViewFlightNumber.isHidden = false
//                lblFlightNumber.text = strFlightNumber
//            }
//
//            if strNotes.count == 0 {
//                stackViewNotes.isHidden = true
//            }
//            else {
//                stackViewNotes.isHidden = false
//                lblNotes.text = strNotes
//            }
//        }
        
    }
    
    func timerDidEnd() {
        
        if (isAccept == false)
        {
            if (boolTimeEnd) {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print(#function)
                self.delegate.didRejectedRequest()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Sound Implement Methods
    //-------------------------------------------------------------
    
    var audioPlayer:AVAudioPlayer!
    
    func playSound() {
        
//        guard let url = Bundle.main.url(forResource: "\(RingToneSound)", withExtension: "mp3") else { return }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            //            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer.numberOfLoops = 4
//            audioPlayer.play()
//        }
//        catch let error {
//            print(error.localizedDescription)
//        }
    }
    
    func stopSound() {
        
//        guard let url = Bundle.main.url(forResource: "\(RingToneSound)", withExtension: "mp3") else { return }
//        
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            try AVAudioSession.sharedInstance().setActive(true)
//            
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer.stop()
//        }
//        catch let error {
//            print(error.localizedDescription)
//        }
    }
    

    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    var boolTimeEnd = Bool()
    
    @IBAction func btnRejected(_ sender: UIButton) {
        if Connectivity.isConnectedToInternet() == false {
            UtilityClass.showAlert("App Name".localized, message: "Sorry! Not connected to internet".localized, vc: self)
            return
        }
        
         Singletons.sharedInstance.firstRequestIsAccepted = false
        isAccept = false
        boolTimeEnd = true
        delegate.didRejectedRequest()
        self.viewCountdownTimer.end()
//        self.stopSound()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnAcceped(_ sender: UIButton) {
        if Connectivity.isConnectedToInternet() == false {
            UtilityClass.showAlert("App Name".localized, message: "Sorry! Not connected to internet".localized, vc: self)
            return
        }
        
        Singletons.sharedInstance.firstRequestIsAccepted = false
        
        isAccept = true
        boolTimeEnd = true
        delegate.didAcceptedRequest()
        self.viewCountdownTimer.end()
        self.stopSound()
        self.dismiss(animated: true, completion: nil)
    }
    // ------------------------------------------------------------
    

    

}
