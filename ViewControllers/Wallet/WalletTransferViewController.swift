//
//  WalletTransferViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 23/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import AVFoundation
import SDWebImage

class WalletTransferViewController: ParentViewController, UITextFieldDelegate {

    var amount = String()
   
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        CustomCameraVC = imagePicker
//        viewQRCodeScanner = imagePicker.view

        scrollObj.isScrollEnabled = false
        
//        btnSubmitMoney.layer.cornerRadius = 5
//        btnSubmitMoney.layer.masksToBounds = true
        
        if DeviceType.IS_IPAD || DeviceType.IS_IPHONE_4_OR_LESS {
            
            constraintHeightOfTopView.constant = 280
            constraintHeightOfBottomView.constant = 288
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        f = false
        self.viewSendMoney.backgroundColor = UIColor.black
        self.imgSendMoney.image = UIImage.init(named: "iconSendMoneySelected")
        self.lblSendMoney.textColor = ThemeYellowColor
        
        
        self.viewReceiveMoney.backgroundColor = themeGrayBGColor
        self.imgReceiveMoney.image = UIImage.init(named: "iconReceiveMoneyUnselected")
        self.lblReceiveMoney.textColor = themeGrayTextColor
        
        self.viewTransferToBank.backgroundColor = themeGrayBGColor
        self.imgTransferToBank.image = UIImage.init(named: "iconTransferBankUnselected")
        self.lblTransferToBank.textColor = themeGrayTextColor
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet var viewReceiveMoney: UIView!
    @IBOutlet weak var scrollObj: UIScrollView!
    @IBOutlet weak var btnSendMoney: UIButton!
    @IBOutlet weak var viewEnterMoney: UIView!
    
    @IBOutlet var viewTransferToBank: UIView!
    @IBOutlet var viewSendMoney: UIView!
    @IBOutlet weak var btnSubmitMoney: UIButton!
    @IBOutlet weak var txtEnterMoney: UITextField!
    
    @IBOutlet weak var constraintHeightOfTopView: NSLayoutConstraint! // 360
    @IBOutlet weak var constraintHeightOfBottomView: NSLayoutConstraint! // 208
    
    @IBOutlet var imgSendMoney: UIImageView!
    @IBOutlet var imgReceiveMoney: UIImageView!
    @IBOutlet var imgTransferToBank: UIImageView!
    
    
    @IBOutlet var lblSendMoney: UILabel!
    @IBOutlet var lblReceiveMoney: UILabel!
    @IBOutlet var lblTransferToBank: UILabel!
    
    //-------------------------------------------------------------
    // MARK: - Action
    //-------------------------------------------------------------
    
    @IBAction func btnSubmitMoney(_ sender: UIButton) {
    
//        if Singletons.sharedInstance.strQRCodeForSendMoney != "" && amount != "" {
//            let currrentBalance = Singletons.sharedInstance.strCurrentBalance
//            let enterdAmount = (amount as NSString).doubleValue
//
//            print("enterdAmount : \(enterdAmount)")
//            print("currrentBalance : \(currrentBalance)")
//
//            if enterdAmount > currrentBalance {
//                UtilityClass.showAlert(appName.kAPPName, message: "Your current balance is lower then entered amount", vc: self)
//            }
//            else {
//                self.webserviceOfSendMoney()
//            }
//        }
//        else if Singletons.sharedInstance.strQRCodeForSendMoney == "" {
//            UtilityClass.showAlert(appName.kAPPName, message: "Please Scane QR Code", vc: self)
//        }
//        else {
//            UtilityClass.showAlert(appName.kAPPName, message: "Please enter amount", vc: self)
//        }
    
    }
    
    @IBAction func txtEnterMoney(_ sender: UITextField) {
    
        if let amountString = txtEnterMoney.text?.currencyInputFormatting() {
            txtEnterMoney.text = amountString
            
            
            let unfiltered = amountString   //  "!   !! yuahl! !"
            
            
            var y = amountString.replacingOccurrences(of: "$", with: "", options: .regularExpression, range: nil)
            y = y.replacingOccurrences(of: " ", with: "")
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
            
            amount = y
            print("amount : \(amount)")
            
            print("QRCode : \(Singletons.sharedInstance.strQRCodeForSendMoney)")
        
        }
        
    }
    
    
    
    @IBAction func btnSendMoney(_ sender: UIButton) {
        
//        viewEnterMoney.isHidden = false
//
//        scrollObj.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
//        viewEnterMoney.isHidden = false
        
        self.viewSendMoney.backgroundColor = UIColor.black
        self.imgSendMoney.image = UIImage.init(named: "iconSendMoneySelected")
        self.lblSendMoney.textColor = ThemeYellowColor
        scrollObj.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
        
        self.viewReceiveMoney.backgroundColor = themeGrayBGColor
        self.imgReceiveMoney.image = UIImage.init(named: "iconReceiveMoneyUnselected")
        self.lblReceiveMoney.textColor = themeGrayTextColor
    }
    
    
    @IBAction func btnReceiveMoney(_ sender: UIButton) {
        
//        viewEnterMoney.isHidden = true
        
        scrollObj.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: true)
        
        self.viewReceiveMoney.backgroundColor = UIColor.black
        self.imgReceiveMoney.image = UIImage.init(named: "iconReceiveMoneySelected")
        self.lblReceiveMoney.textColor = ThemeYellowColor
        
        
        self.viewSendMoney.backgroundColor = themeGrayBGColor
        self.imgSendMoney.image = UIImage.init(named: "iconSendMoneyUnselected")
        self.lblSendMoney.textColor = themeGrayTextColor
        
        
    }
    
    @IBAction func btnSendBankAccount(_ sender: UIButton) {
        
        self.viewTransferToBank.backgroundColor = UIColor.black
        self.imgTransferToBank.image = UIImage.init(named: "iconSendMoneySelected")
        self.lblTransferToBank.textColor = ThemeYellowColor
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletTransferToBankVC") as! WalletTransferToBankVC
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    
    func webserviceOfSendMoney() {

        var dictParam = [String:AnyObject]()
        
//        amount.removeFirst()
        
        dictParam[walletSendMoney.kAmount] = amount.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
        dictParam[walletSendMoney.kQRCode] = Singletons.sharedInstance.strQRCodeForSendMoney as AnyObject
        dictParam[walletSendMoney.kSenderId] = Singletons.sharedInstance.strDriverID as AnyObject
        
        print("dictParam : \(dictParam)")
        
        webserviceForASendMoneyInWallet(dictParam as AnyObject) { (result, status) in
            
           
            
            if (status) {
                print(result)
                
                if let res = result as? String {
                    UtilityClass.showAlert(appName.kAPPName, message: res, vc: self)
                }
                else {
                    
                    Singletons.sharedInstance.strCurrentBalance = ((result as! NSDictionary).object(forKey: "walletBalance") as! AnyObject).doubleValue
                    
                    self.txtEnterMoney.text = ""
                    
                    NotificationCenter.default.post(name: Notification.Name("isSendMoneySucessfully"), object: nil)
                    
                    Singletons.sharedInstance.isSendMoneySuccessFully = true
                    
                   
                    UtilityClass.showAlert(appName.kAPPName, message: (result as! NSDictionary).object(forKey: "message")! as! String, vc: self)
                    
                }
  
            }
            else {
                print(result)
                
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
   
}
// ----------------------------------------------------------------------

extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
//        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = " "
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "\(currency)", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        print("Amount : \(number)")
        
        return formatter.string(from: number)!
    }
}
// ----------------------------------------------------------------------


//-------------------------------------------------------------
// MARK: - Send Money
//-------------------------------------------------------------

class WalletTransferSend: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var isReading: Bool = false
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    
    @IBOutlet var viewBG: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblQRScanner.isHidden = false
        lblFullName.isHidden = true
        lblMobileNumber.isHidden = true
        
        viewBG.layer.borderWidth = 1.0
        viewBG.layer.borderColor = UIColor.clear.cgColor
        
        // shadow
        viewBG.layer.shadowColor = UIColor.gray.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewBG.layer.shadowOpacity = 0.7
        viewBG.layer.shadowRadius = 4.0
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        NotificationCenter.default.addObserver(self, selector: #selector(self.isSendMoneySucessfully), name: Notification.Name("isSendMoneySucessfully"), object: nil)
        
        self.lblQRScanner.isHidden = false
        lblFullName.isHidden = true
        lblMobileNumber.isHidden = true
        
        captureSession = nil
        

//        startStopClick()
    }
    
    @objc func isSendMoneySucessfully() {
        self.lblQRScanner.isHidden = false
        lblFullName.isHidden = true
        lblMobileNumber.isHidden = true
        
        captureSession = nil
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    @IBOutlet weak var viewQRCodeScanner: UIView!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var lblQRScanner: UILabel!
    
    //-------------------------------------------------------------
    // MARK: - Action
    //-------------------------------------------------------------
    
    @IBAction func btnOpenCameraForQRCode(_ sender: UIBarButtonItem) {
        
        startStopClick()
        
        if Singletons.sharedInstance.isSendMoneySuccessFully {
            
        }
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    func startStopClick() {
        
        if !isReading {
            if (self.startReading()) {
//                btnStartStop.setTitle("Stop", for: .normal)
//                lblQRScanner.text = "Scanning for QR Code..."
            }
        }
        else {
            stopReading()
//            btnStartStop.setTitle("Start", for: .normal)
        }
        isReading = !isReading
    }
    
    func startReading() -> Bool {
        let captureDevice = AVCaptureDevice.default(for: .video)

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            // Do the rest of your work...
        } catch let error as NSError {
            // Handle any errors
            print(error)
            return false
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.frame = viewQRCodeScanner.layer.bounds
        viewQRCodeScanner.layer.addSublayer(videoPreviewLayer)
        
        /* Check for metadata */
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
        print(captureMetadataOutput.availableMetadataObjectTypes)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureSession?.startRunning()
        
        return true
    }
    
    @objc func stopReading() {
        
        captureSession?.stopRunning()
        captureSession = nil
        videoPreviewLayer.removeFromSuperlayer()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        for data in metadataObjects {
            let metaData = data as! AVMetadataObject
            print(metaData.description)
            let transformed = videoPreviewLayer?.transformedMetadataObject(for: metaData) as? AVMetadataMachineReadableCodeObject
            if let unwraped = transformed {
                print(unwraped.stringValue)
                
                
                Singletons.sharedInstance.strQRCodeForSendMoney = unwraped.stringValue!
                
                print("Singletons.sharedInstance.strQRCodeForSendMoney  ::  \(Singletons.sharedInstance.strQRCodeForSendMoney)")
                
                self.webserviceOfQRCodeDetails()
                
//                lblQRScanner.text = unwraped.stringValue
//                btnStartStop.setTitle("Start", for: .normal)
                self.performSelector(onMainThread: #selector(stopReading), with: nil, waitUntilDone: false)
                isReading = false;
            }
        }
    }
    
    func webserviceOfQRCodeDetails() {
        
        var param = [String:AnyObject]()
        param["QRCode"] = Singletons.sharedInstance.strQRCodeForSendMoney as AnyObject
        
        webserviceForQRCodeDetails(param as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                
                self.lblQRScanner.isHidden = true
                self.lblFullName.isHidden = false
                self.lblMobileNumber.isHidden = false
                
                let Fullname = "Name: \(((result as! NSDictionary).object(forKey: "data") as! NSDictionary).object(forKey: "Fullname") as! String)"
                let MobileNo = "Mobile No.: \(((result as! NSDictionary).object(forKey: "data") as! NSDictionary).object(forKey: "MobileNo") as! String)"
                _ = ((result as! NSDictionary).object(forKey: "data") as! NSDictionary).object(forKey: "Id") as! String
                _ = ((result as! NSDictionary).object(forKey: "data") as! NSDictionary).object(forKey: "QRCode") as! String
                
                self.lblFullName.text = Fullname
                self.lblMobileNumber.text = MobileNo
                
/*                {
                    data =     {
                        Fullname = "developer eww";
                        Id = 19;
                        MobileNo = 9998359464;
                        QRCode = "jsbS2dDmzpxqa2tdiaKXoag=";
                    };
                    status = 1;
                }
*/
            }
            else {
                print(result)
                
                self.lblQRScanner.isHidden = false
                self.lblFullName.isHidden = true
                self.lblMobileNumber.isHidden = true
            }
        }
    }
   
}
// ----------------------------------------------------------------------

//-------------------------------------------------------------
// MARK: - Receive Money
//-------------------------------------------------------------

class WalletTransferRecieve: UIViewController {
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var imgQRCode: UIImageView!
    
    
    //-------------------------------------------------------------
    // MARK: - Custom Method
    //-------------------------------------------------------------
    
    func setImage() {
        
        let profileData = Singletons.sharedInstance.dictDriverProfile
        if let QRCodeImage = (profileData?.object(forKey: "profile") as! NSDictionary).object(forKey: "QRCode") as? String {
        imgQRCode.sd_setImage(with: URL(string: QRCodeImage), completed: nil)
        }
    }
    
}




