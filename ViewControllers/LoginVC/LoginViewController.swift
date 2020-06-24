 //
 //  LoginViewController.swift
 //  TiCKTOC-Driver
 //
 //  Created by Excellent Webworld on 12/10/17.
 //  Copyright © 2017 Excellent Webworld. All rights reserved.
 //
 
 import UIKit
 import CoreLocation
 //import ACFloatingTextfield_Swift
 
 class LoginViewController: UIViewController, CLLocationManagerDelegate,UITextFieldDelegate {
    
    let manager = CLLocationManager()
    
    var currentLocation = CLLocation()
    
    var strLatitude = Double()
    var strLongitude = Double()
    
    var strEmailForForgotPassword = String()
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    //textFiled
    @IBOutlet weak var txtMobile: ThemeTextField!
    @IBOutlet weak var txtPassword: ThemeTextField!
    
    @IBOutlet weak var lblDonTHaveAnyAccount: UILabel!
    //view
    @IBOutlet weak var viewLogin: UIView!
    //    @IBOutlet weak var viewMain: UIView!
    //view
    @IBOutlet weak var btnForgotPassWord: LocalizButton!
    @IBOutlet var btnSignIn: ThemeButton!
    @IBOutlet var btnSignUp: LocalizButton!
    
    @IBOutlet var lblLaungageName: UILabel!
    
   
    //    @IBOutlet weak var constraintHeightOfLogo: NSLayoutConstraint! // 140
    //    @IBOutlet weak var constraintHeightOfTextFields: NSLayoutConstraint! // 50
    //    @IBOutlet weak var constraintTopOfLogo: NSLayoutConstraint! // 60
    
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    func setLocalization() {
        
        if let SelectedLanguage = UserDefaults.standard.value(forKey: "i18n_language") as? String {
            if SelectedLanguage == "en" {
                lblLaungageName.text = "SW"
            } else if SelectedLanguage == "sw" {
                lblLaungageName.text = "EN"
            }
        }
        self.txtMobile.placeholder = "Mobile Number".localized
        self.txtPassword.placeholder = "Password".localized
        self.btnForgotPassWord.setTitle("Forgot Password?".localized, for: .normal)
//        self.btnSignIn.setTitle("Sign In".localized, for: .normal)
//        self.btnSignUp.setTitle("Sign Up".localized, for: .normal)
        self.lblDonTHaveAnyAccount.text = "Don't have an account?".localized
        
    }
    
    override func loadView() {
            super.loadView()
    
    
//        txtMobile.text = "3698523698"
//            txtPassword.text = "12345678"
    
//            Utilities.setStatusBarColor(color: UIColor.clear)
    
//            if Connectivity.isConnectedToInternet()
//            {
//                print("Yes! internet is available.")
                self.webserviceOfAppSetting()
                // do some tasks..
//            }
//            else
//            {
//                UtilityClass.showAlertWithCompletion(appName.kAPPName, message: "Sorry! Not connected to internet".localized, vc: self) { (status) in
//                    self.navigationController?.popViewController(animated: false)
//                }
////                UtilityClass.showAlert(appName.kAPPName, message: "Sorry! Not connected to internet".localized, vc: self)
//                return
//            }
        
//            if Connectivity.isConnectedToInternet()
//            {
//                print("Yes! internet is available.")
//                // do some tasks..
//            }
//            else {
//                UtilityClass.showAlert(appName.kAPPName, message: "Sorry! Not connected to internet".localized, vc: self)
//            }
    
//            webserviceOfAppSetting()
    //
        }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let yourAttributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.foregroundColor : ThemeYellowColor]
        let attributeString = NSMutableAttributedString(string: "SIGN UP".localized,
                                                        attributes: yourAttributes)
        btnSignUp.setAttributedTitle(attributeString, for: .normal)
        
        txtMobile.delegate = self
        lblLaungageName.layer.cornerRadius = 5
        lblLaungageName.backgroundColor = ThemeYellowColor
        lblLaungageName.layer.borderColor = UIColor.black.cgColor
        lblLaungageName.layer.borderWidth = 0.5
        
        if let SelectedLanguage = UserDefaults.standard.value(forKey: "i18n_language") as? String {
            if SelectedLanguage == "en" {
                lblLaungageName.text = "EN"
            } else if SelectedLanguage == "sw" {
                    lblLaungageName.text = "SW"
            }
        }
        
        #if targetEnvironment(simulator)
        txtMobile.text = "9865322145"
        txtPassword.text = "12345678"
        #endif
        
        
        
//        Utilities.setStatusBarColor(color: UIColor.clear) 
       
        //
        
       
        //
        //        if DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPAD {
        //            constraintHeightOfLogo.constant = 120
        //            constraintHeightOfTextFields.constant = 35
        //            constraintTopOfLogo.constant = 40
        //        }
        //        self.viewMain.isHidden = false
        checkPass()
        
        strLatitude = 0
        strLongitude = 0
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            
            if manager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) || manager.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization))
            {
                if manager.location != nil
                {
                    currentLocation = manager.location!
                    
                    strLatitude = currentLocation.coordinate.latitude
                    strLongitude = currentLocation.coordinate.longitude
                }
                
                manager.startUpdatingLocation()
            }
        }
     
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.setLocalization()
//        self.title = "Ingia".localized
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func btnLaungageClicked(_ sender: Any)
    {
        
        if let SelectedLanguage = UserDefaults.standard.value(forKey: "i18n_language") as? String {
            if SelectedLanguage == "en" {
                setLayoutForswahilLanguage()
                lblLaungageName.text = "EN"
            } else if SelectedLanguage == "sw" {
                setLayoutForenglishLanguage()
                lblLaungageName.text = "SW"
            }
        }
        self.setLocalization()
    }
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        //        CustomSideMenuViewController
        
        if (validateAllFields()) {
            webserviceForLoginDrivers()
        }        
    }
    
    @IBAction func btnForgotPassword(_ sender: UIButton) {
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Forgot Password?".localized, message: "Please enter email".localized, preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Email".localized
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            
            self.strEmailForForgotPassword = (textField?.text)!
            
            if self.strEmailForForgotPassword == "" {
                NotificationCenter.default.post(name: Notification.Name("checkForgotPassword"), object: nil)
            }
            else {
                self.webserviceForgotPassword()
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .default, handler: { [weak alert] (_) in
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnFaceBook(_ sender: UIButton) {
    }
    
    @IBAction func btnSignUP(_ sender: UIButton) {
      
        //        performSegue(withIdentifier: "SegueToRegisterVc", sender: self)
    }
    
    @IBAction func btnGoogle(_ sender: UIButton) {
        
    }
    
    func checkPass() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.showAlertForPasswordWrong), name: Notification.Name("checkForgotPassword"), object: nil)
    }
    
    @objc func showAlertForPasswordWrong() {
        
        UtilityClass.showAlert("App Name".localized, message: "Please enter mobile number".localized, vc: self)
        
    }
    
    // ------------------------------------------------------------
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error)
        
    }
    
    // ------------------------------------------------------------
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    
    var dictData = [String:AnyObject]()
    
    func webserviceForLoginDrivers()
    {
        dictData["Username"] = txtMobile.text as AnyObject
        dictData["Password"] = txtPassword.text as AnyObject
        
        if strLatitude == 0 {
            dictData["Lat"] = "23.0012356" as AnyObject
        } else {
            dictData["Lat"] = strLatitude as AnyObject
        }
        
        if strLongitude == 0 {
            dictData["Lng"] = "72.0012341" as AnyObject
        } else {
            dictData["Lng"] = strLongitude as AnyObject
        }
        dictData["Token"] = Singletons.sharedInstance.deviceToken as AnyObject
        dictData["DeviceType"] = "1" as AnyObject
        
        
        webserviceForDriverLogin(dictParams: dictData as AnyObject) { (result, status) in
            
            if (status)
            {
                print(result)
                
                if ((result as! NSDictionary).object(forKey: "status") as! Int == 1)
                {
                    Singletons.sharedInstance.dictDriverProfile = NSMutableDictionary(dictionary: (result as! NSDictionary).object(forKey: "driver") as! NSDictionary)
                    Singletons.sharedInstance.isDriverLoggedIN = true
                    Utilities.encodeDatafromDictionary(KEY: driverProfileKeys.kKeyDriverProfile, Param: Singletons.sharedInstance.dictDriverProfile)
//                                        UserDefaults.standard.set(Singletons.sharedInstance.dictDriverProfile, forKey: driverProfileKeys.kKeyDriverProfile)
                                        UserDefaults.standard.set(true, forKey: driverProfileKeys.kKeyIsDriverLoggedIN)
                    
                    Singletons.sharedInstance.strDriverID = ((Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary).object(forKey: "Vehicle") as! NSDictionary).object(forKey: "DriverId") as! String
                    
                    Singletons.sharedInstance.driverDuty = ((Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary).object(forKey: "DriverDuty") as! String)
                    //                    Singletons.sharedInstance.showTickPayRegistrationSceeen =
                    
                    let profileData = Singletons.sharedInstance.dictDriverProfile
                    
                    if let currentBalance = (profileData?.object(forKey: "profile") as! NSDictionary).object(forKey: "Balance") as? Double
                    {
                        Singletons.sharedInstance.strCurrentBalance = currentBalance
                    }
                    if let driver = result["driver"] as? [String: Any] {
                        if let profile = driver["profile"] as? [String: Any] {
                            if let notification = profile["Notification"] as? NSString {
                                Singletons.sharedInstance.isPushSettingsOn = notification.boolValue
                                userDefault.set(notification.boolValue, forKey: "DefaultNotificationSetting")
                            }
                        }
                    }
                 
                    App_Delegate.GoToHome()
                    /*
                     let next = self.storyboard?.instantiateViewController(withIdentifier: "CustomSideMenuViewController") as! CustomSideMenuViewController
                     self.navigationController?.pushViewController(next, animated: true)
                     */
                    
                    
                }
                
            }
            else
            {
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
    
    // ------------------------------------------------------------
    
    func webserviceForgotPassword()
    {
        var params = [String:AnyObject]()
        params[RegistrationFinalKeys.kEmail] = strEmailForForgotPassword as AnyObject
        
        webserviceForForgotPassword(params as AnyObject) { (result, status) in
            
            if (status) {
                
                print(result)
                let alert = UIAlertController(title: "App Name".localized, message: result.object(forKey: GetResponseMessageKey()) as? String, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            } else {
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
    // ----------------------------------------------------------------------
    
    func webserviceOfAppSetting() {
        //        version : 1.0.0 , (app_type : AndroidPassenger , AndroidDriver , IOSPassenger , IOSDriver)
        
        
        let nsObject: AnyObject? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject
        let version = nsObject as! String
        
        var param = String()
        
        param = version + "/" + "IOSDriver"
        
        webserviceForAppSetting(param as AnyObject) { (result, status) in
            
            if(status) {
                print(result)
                /*
                 {
                 "status": true,
                 "update": false,
                 "message": "Ticktoc app new version available"
                 }
                 */
                //                self.viewMain.isHidden = true
                
                if ((result as! NSDictionary).object(forKey: "update") as? Bool) != nil {
                    
                    let alert = UIAlertController(title: "App Name".localized, message: (result as! NSDictionary).object(forKey: GetResponseMessageKey()) as? String, preferredStyle: .alert)
                    let UPDATE = UIAlertAction(title: "Update".localized, style: .default, handler: { ACTION in
                        
                        UIApplication.shared.openURL(NSURL(string: appName.kAPPUrl)! as URL)
                    })
                    let Cancel = UIAlertAction(title: "Cancel".localized, style: .default, handler: { ACTION in
                        
                        if(Singletons.sharedInstance.isDriverLoggedIN)
                        {
                            App_Delegate.GoToHome()
                            /* Raj381
                             let next = self.storyboard?.instantiateViewController(withIdentifier: "CustomSideMenuViewController") as! CustomSideMenuViewController
                            self.navigationController?.pushViewController(next, animated: true)
                            */
                        }
                    })
                    alert.addAction(UPDATE)
                    alert.addAction(Cancel)
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                   
                    if(Singletons.sharedInstance.isDriverLoggedIN)
                    {
                        App_Delegate.GoToHome()
                        /* Raj381
                        let next = self.storyboard?.instantiateViewController(withIdentifier: "CustomSideMenuViewController") as! CustomSideMenuViewController
                        self.navigationController?.pushViewController(next, animated: false) */
                    }
//                    if(Singletons.sharedInstance.isDriverLoggedIN)
//                    {
//                        let next = self.storyboard?.instantiateViewController(withIdentifier: "CustomSideMenuViewController") as! CustomSideMenuViewController
//                        self.navigationController?.pushViewController(next, animated: true)
//                    }
                    
                }
                
                //                if(SingletonClass.sharedInstance.isUserLoggedIN)
                //                {
                //                    self.performSegue(withIdentifier: "segueToHomeVC", sender: nil)
                //                }//bhaveshbhai
                
                
            }
            else {
                print(result)
                /*
                 {
                 "status": false,
                 "update": false,
                 "maintenance": true,
                 "message": "Server under maintenance, please try again after some time"
                 }
                 */
                
                if let res = result as? String {
                    UtilityClass.showAlert("App Name".localized, message: res, vc: self)
                }
                else if let update = (result as! NSDictionary).object(forKey: "update") as? Bool {
                    
                    if (update) {
                        //                        UtilityClass.showAlert(appName.kAPPName, message: (result as! NSDictionary).object(forKey: "message") as! String, vc: self)
                        
                        UtilityClass.showAlertWithCompletion("App Name".localized, message: (result as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self, completionHandler: { ACTION in
                            
//                            UIApplication.shared.open((NSURL(string: appName.kAPPUrl)! as URL), options: [:], completionHandler: { (status) in

//                            })//openURL(NSURL(string: appName.kAPPUrl)! as URL)

                            UIApplication.shared.open((NSURL(string: "itms-apps://itunes.apple.com/app/id1445179587")! as URL), options: [:], completionHandler: { (status) in

                            })
                        })
                    }
                    else {
                        UtilityClass.showAlert("App Name".localized, message: (result as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                    }
                    
                }
                /*
                 {
                 "status": false,
                 "update": true,
                 "message": "Ticktoc app new version available, please upgrade your application"
                 }
                 */
                //                if let res = result as? String {
                //                    UtilityClass.showAlert(appName.kAPPName, message: res, vc: self)
                //                }
                //                else if let resDict = result as? NSDictionary {
                //                    UtilityClass.showAlert(appName.kAPPName, message: resDict.object(forKey: "message") as! String, vc: self)
                //                }
                //                else if let resAry = result as? NSArray {
                //                    UtilityClass.showAlert(appName.kAPPName, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: "message") as! String, vc: self)
                //                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtMobile {
            let resultText: String? = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
            
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
    // MARK: - Validation Methods
    //-------------------------------------------------------------
    
    func validateAllFields() -> Bool
    {
        //        let isEmailAddressValid = isValidEmailAddress(emailID: txtEmailAddress.text!)
        //        let providePassword = txtPassword.text
        
        //        let isPasswordValid = isPwdLenth(password: providePassword!)
        
        
        if txtMobile.text!.count == 0
        {
            UtilityClass.showAlert("App Name".localized, message: "Please enter mobile number".localized, vc: self)
            return false
        }
//        else if txtMobile.text!.count != 10 {
//            UtilityClass.showAlert("App Name".localized, message: "Please enter valid phone number.", vc: self)
//            return false
//        }
        else if txtPassword.text!.count == 0
        {
            
            UtilityClass.showAlert("App Name".localized, message: "Please enter password".localized, vc: self)
            
            return false
        }
//        else if txtPassword.text!.count <= 5 {
//            UtilityClass.showAlert(appName.kAPPName, message: "Password should be more than 5 characters", vc: self)
//            return false
//        }
        
        
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
