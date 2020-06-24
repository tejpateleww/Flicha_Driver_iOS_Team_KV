//
//  ViewController.swift
//  HJM
//
//  Created by Raj iMac on 19/08/19.
//  Copyright © 2019 Raj iMac. All rights reserved.
//

import UIKit
import LGSideMenuController

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    func setNavigationBarInViewController (controller : UIViewController,naviColor : UIColor = themeBlueColor, naviTitle : String, leftImage : String , rightImages : [String], isTranslucent : Bool,isDutyButton: Bool = false)
    {
//        UIApplication.shared.statusBarStyle = .lightContent
        controller.navigationController?.isNavigationBarHidden = false
        controller.navigationController?.navigationBar.isOpaque = false;
        
        controller.navigationController?.navigationBar.isTranslucent = isTranslucent
        
        controller.navigationController?.navigationBar.barTintColor = naviColor;
        controller.navigationController?.navigationBar.tintColor = UIColor.white;
        if naviTitle == "Home" {
            controller.navigationItem.titleView = UIView()
            controller.navigationController?.navigationBar.backgroundColor = .clear

        } else {
            controller.navigationItem.title = naviTitle
            controller.navigationController?.navigationBar.backgroundColor = themeBlueColor

        }
        controller.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationController?.navigationBar.shadowImage = UIImage()
        LanguageUpdate()
        if leftImage != "" {
            
            let btnLeft = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            btnLeft.setImage(UIImage.init(named: leftImage), for: .normal)
            btnLeft.layer.setValue(controller, forKey: "controller")
            
            if leftImage == kMenuIcon {
                btnLeft.addTarget(self, action: #selector(self.OpenMenuAction), for: .touchUpInside)
                //                controller.frostedViewController.panGestureEnabled = true
            }
                //            else if leftImage == kClose_Icon {
                //                btnLeft.addTarget(self, action: #selector(DismissViewController(_:)), for: .touchUpInside)
                //            }
            else {
                btnLeft.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
//                if controller.frostedViewController != nil {
                    //                    controller.frostedViewController.panGestureEnabled = false
//                }
            }
            
            let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            LeftView.addSubview(btnLeft)
            
            let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
            btnLeftBar.style = .plain
            controller.navigationItem.leftBarButtonItem = btnLeftBar
            
        }
      
        if rightImages.count != 0 {
            var arrButtons = [UIBarButtonItem]()
            rightImages.forEach { (title) in
                let btnRight = UIButton.init()
                btnRight.setImage(UIImage.init(named: title), for: .normal)
                btnRight.frame =  CGRect(x: 0, y: 0, width: 40, height: 40)
                btnRight.layer.setValue(controller, forKey: "controller")
                btnRight.clipsToBounds = true
                btnRight.adjustsImageWhenHighlighted = false
                switch title {
                case "editP" :
                    btnRight.addTarget(self, action: #selector(self.editClick(_:)), for: .touchUpInside)
                    
                default :
                    break
                }
               /*
                switch title {
                case sos:
                    btnRight.addTarget(self, action: #selector(self.sosAction), for: .touchUpInside)
                    
                case edit:
                    btnRight.addTarget(self, action: #selector(self.editClick(_:)), for: .touchUpInside)
                case iconWhiteTicket:
                    btnRight.addTarget(self, action: #selector(self.myTicketClick(_:)), for: .touchUpInside)
                default:
                      btnRight.addTarget(self, action: #selector(self.btnCallAction), for: .touchUpInside)
                } */
                let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: btnRight)
                btnRightBar.style = .plain
                arrButtons.append(btnRightBar)
            }
         
            controller.navigationItem.rightBarButtonItems = arrButtons
            
        }
        if isDutyButton {
//            controller.navigationItem.rightBarButtonItems?.insert(btnDuty, at: 0)
            controller.navigationItem.rightBarButtonItems = [btnDuty]
        }
        
    }
    var btnDuty: UIBarButtonItem {
         
        let btnRight = UIButton.init()
        btnRight.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btnRight.setImage(UIImage.init(named: dutyOff), for: .normal)
        btnRight.setImage(UIImage.init(named: dutyOn), for: .selected)
        btnRight.addTarget(self, action: #selector(self.dutyChangeClick(_:)), for: .touchUpInside)
        btnRight.adjustsImageWhenHighlighted = false
        btnRight.adjustsImageWhenDisabled = true
        btnRight.isSelected = (Singletons.sharedInstance.driverDuty == "1") ? true : false
        let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: btnRight)
        btnRightBar.style = .plain
        return btnRightBar
    }
    
    @objc class func DismissViewController (_ sender: UIButton?)
    {
        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
        controller?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc class func poptoViewController (_ sender: UIButton?)
    {
        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
        controller?.navigationController?.popViewController(animated: true)
    }
    @objc class func OpenMenuViewController (_ sender: UIButton?)
    {
        
        //        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
        //        controller?.frostedViewController.view.endEditing(true)
        //        controller?.frostedViewController.presentMenuViewController()
        //        controller?.sideMenuViewController?._presentLeftMenuViewController()
    }
    
    
    
    func setNavBarWithMenu(Title:String, IsNeedRightButton:Bool){
        
        if Title == "Home"
        {
            //            let titleImage = UIImageView(frame: CGRect(x: 10, y: 0, width: 100, height: 30))
            //            titleImage.contentMode = .scaleAspectFit
            //            titleImage.image = UIImage(named: "Title_logo")
            ////            titleImage.backgroundColor  = themeYellowColor
            //             self.navigationItem.titleView = titleImage
            self.title = title?.uppercased()
        }
        else
        {
            self.navigationItem.title = Title.uppercased()
        }
        
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        
        let leftNavBarButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(self.OpenMenuAction))
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
    }
    
    func setNavBarWithBack(Title:String, IsNeedRightButton:Bool) {
        self.navigationController?.navigationBar.isTranslucent = true
        
        if Title == "Home" {
            let titleImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
            titleImage.contentMode = .scaleAspectFit
            titleImage.image = UIImage(named: "Title_logo")
            self.navigationItem.titleView = titleImage
        } else {
            self.navigationItem.title = Title.uppercased().localizedUppercase
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : themeBlueColor,NSAttributedString.Key.font: UIFont.bold(ofSize: 19.0)]
        let leftNavBarButton = UIBarButtonItem(image: UIImage(named: "iconLeftArrow"), style: .plain, target: self, action: #selector(self.btnBackAction))
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationController?.view.backgroundColor = .white
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = themeBlueColor
        //        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        //        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        //        self.navigationController?.navigationBar.layer.shadowRadius = 3.0
        //        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        //        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        if UserDefaults.standard.value(forKey: "i18n_language") != nil {
            if let language = UserDefaults.standard.value(forKey: "i18n_language") as? String {
                if language == "sw" {
                    //                    btnLeft.semanticContentAttribute = .forceLeftToRight
                    
                    //                    image = UIImage.init(named: "icon_BackWhite")?.imageFlippedForRightToLeftLayoutDirection()
                }
            }
        }
    }
    
    
    func setupNavigationBarColor(_ navigationController: UINavigationController?) {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func LanguageUpdate() {
        
        if let lang = userDefault.value(forKey: "language") as? String {
            if lang == "en" {
                self.navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
                if let NavController = self.navigationController?.children {
                    NavController.last?.view.semanticContentAttribute = .forceLeftToRight
                }
            }
            else {
                self.navigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
                if let NavController = self.navigationController?.children {
                    NavController.last?.view.semanticContentAttribute = .forceRightToLeft
                }
            }
        }
    }


    
    // MARK:- Navigation Bar Button Action Methods
    
    @objc func OpenMenuAction()
    {
        if sideMenuController?.isRightViewVisible == true{
            sideMenuController?.hideRightView()
        }
        else if sideMenuController?.isLeftViewVisible == true  {
            sideMenuController?.hideLeftView()
        }else
        {
            /* if let lang = userDefault.value(forKey: "language") as? String{
                if lang == "en" {
                    sideMenuController?.showLeftView(animated: true, completionHandler: nil)
                }else{
                    sideMenuController?.showRightView(animated: true, completionHandler: nil)
                }
            } */
            sideMenuController?.showLeftView(animated: true, completionHandler: nil)
        }
    }
    
    @objc func btnBackAction()
    {
        if self.navigationController?.children.count == 1 {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        else {
            self.navigationController?.popViewController(animated: false)
        }
        
    }
    
    @objc func btnCallAction() {
       /*
        let contactNumber = helpLineNumber
        if contactNumber == "" {
            //                    UtilityClass.setCustomAlert(title: "\(appName)", message: "Contact number is not available") { (index, title) in
            //                    }
        }else {
            callNumber(phoneNumber: contactNumber)
        } */
    }
    @objc func sosAction() {
        /*
        if let _ = Singleton.shared().currentBookingData {
            let sosOption:SOSOptionPopUp = UIViewController.viewControllerInstance(storyBoard: .CustomPopup)
            self.present(sosOption, animated: true, completion: nil)
        }else {
            let contactNumber = helpLineNumber
            if contactNumber == "" {
                //                    UtilityClass.setCustomAlert(title: "\(appName)", message: "Contact number is not available") { (index, title) in
                //                    }
            }
            else
            {
                callNumber(phoneNumber: contactNumber)
            }
        } */
       
    }
    @IBAction func editClick(_ sender: UIButton) {
        if let controller = sender.layer.value(forKey: "controller") as? UpdateProfilePersonelDetailsVC {
            controller.getData()
        }
        /*
        if let controller = sender.layer.value(forKey: "controller") as? BankDetailsViewController {
            if !controller.isEditEnable {
                controller.isEditEnable = true
            }            
        }else if let  controller = sender.layer.value(forKey: "controller") as? ProfileViewController {
            if !controller.IsEdit {
                controller.IsEdit = true
            }
        } */
    }
    @IBAction func myTicketClick(_ sender: UIButton) {
        
       /* if let controller = sender.layer.value(forKey: "controller") as? GenerateTicketVC {
            let ticketVc:MyTicketVC = UIViewController.viewControllerInstance(storyBoard: .Help)
            
            controller.navigationController?.pushViewController(ticketVc, animated: false)
        } */
    }
    @IBAction func dutyChangeClick(_ sender: UIButton) {
        let profile = NSMutableDictionary(dictionary: (Singletons.sharedInstance.dictDriverProfile as NSDictionary).object(forKey: "profile") as! NSDictionary)
        let vehicle = profile.object(forKey: "Vehicle") as! NSDictionary
        
        var dictData = [String:AnyObject]()
        dictData[profileKeys.kDriverId] = vehicle.object(forKey: "DriverId") as AnyObject
        
        if Singletons.sharedInstance.latitude == nil || Singletons.sharedInstance.longitude == nil || Singletons.sharedInstance.latitude == 0 || Singletons.sharedInstance.longitude == 0
        {
            UtilityClass.showAlert("App Name".localized, message: "Please turn on location", vc: self)
        }
        else
        {
            
            dictData[RegistrationFinalKeys.kLat] = Singletons.sharedInstance.latitude as AnyObject
            dictData[RegistrationFinalKeys.kLng] = Singletons.sharedInstance.longitude as AnyObject
            
            webserviceForDriverChangeDutyStatusOrShiftDutyStatus(dictData as AnyObject) { (result, status) in
                
                if (status) {
                    
                    print(result)
                    //                    self.headerView?.btnSwitch.isEnabled = true
                    
                    if ((result as! NSDictionary).object(forKey: "duty") as! String == "off") {
                        //                        self.headerView?.btnSwitch.setImage(UIImage(named: "iconSwitchOff"), for: .normal)
                        sender.isSelected = false
                        Singletons.sharedInstance.driverDuty = "0"
                        UtilityClass.showAlert("", message: (result as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                        UIApplication.shared.isIdleTimerDisabled = false
                        guard let socket = (UIApplication.shared.delegate as! AppDelegate).Socket else { return }
                        socket.disconnect()
                        
                    }else {
                        sender.isSelected = true
                        //                        self.headerView?.btnSwitch.setImage(UIImage(named: "iconSwitchOn"), for: .normal)
                        Singletons.sharedInstance.driverDuty = "1"
                        
                        if let socket = (UIApplication.shared.delegate as! AppDelegate).Socket {
                            socket.connect()
                        }
                        
                        UIApplication.shared.isIdleTimerDisabled = true
                        
                        UtilityClass.showAlert("", message: (result as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                        
                        let contentVC = (self.navigationController?.children[0] as? TabbarController)?.children[0] as? HomeViewController
                        contentVC?.UpdateDriverLocation()
                        
                    }
                    UserDefaults.standard.set(Singletons.sharedInstance.driverDuty, forKey: "DriverDuty")
                }else {
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
                    
                    //                    self.headerView?.btnSwitch.isEnabled = true
                    
                    
                }
            }
        }
    }

    func setDuty(_ sender: UIButton) {
        /*
        let changeDuty = DutyChangeModel.init()
        
        guard let driverID = Singleton.shared().loginUserData?.driverDetails.id else { return }
        
        /*
         driver_id,
         lat,
         lng,
         truck_type,
         device_token,
         specified_city,
         destination,
         within_city
         type
         */
        //        type (all,specified_city,within_city)
        
        
        changeDuty.driver_id = driverID
        
        guard let currentLocation = Singleton.shared().currentLocation else { return }
        
        changeDuty.lat = String(currentLocation.coordinate.latitude)
        changeDuty.lng = String(currentLocation.coordinate.longitude)
        changeDuty.device_token = Singleton.shared().deviceToken.isEmptyOrWhitespace() ? "dsadasdsajdbaskddassad" : Singleton.shared().deviceToken
        changeDuty.truck_type = "dsdas"
//        changeDuty.city = "dsdas"
        changeDuty.type = "0"
        changeDuty.specified_city = "0"
        changeDuty.destination = "0"
        changeDuty.within_city = "0"
        UserWebserviceSubclass.updateDriverDuty(objUpdateDuty: changeDuty) { (response, status) in
            if status {
                let duty = response["duty"].boolValue
                if duty {
                    self.showSuccess(response: response)
                }else {
                    self.showError(response: response)
                     SocketIOManager.shared.closeConnection()
                }
                 sender.isSelected = duty
                Singleton.shared().driverDutyOn = duty
             
            }else {
                self.showError(response: response)
            }
        }
        */
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

