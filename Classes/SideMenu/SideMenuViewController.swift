//
//  SideMenuViewController.swift
//  HJM
//
//  Created by EWW80 on 21/08/19.
//  Copyright © 2019 Raj iMac. All rights reserved.
//

import UIKit
import LGSideMenuController
import Kingfisher
class SideMenuViewController: UIViewController {
    
    // ----------------------------------------------------
    // MARK: -Outlets
    // ----------------------------------------------------
    @IBOutlet var tableviewSideMenu: UITableView!
    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var vwHeader: UIView! {
        didSet {
            vwHeader.clipsToBounds = true
            vwHeader.layer.cornerRadius = 50
            vwHeader.layer.maskedCorners = [.layerMaxXMaxYCorner]
        }
    }
    // ----------------------------------------------------
    // MARK: Variables
    // ----------------------------------------------------
    /* comment for complain
     var MenuItems = ["My Jobs","Bank Details","Driver Earnings","Truck Information","Documents","Invite Friend","Notifications","Settings","Complains","Language"]
     var menuImages = [#imageLiteral(resourceName: "myJOb"),#imageLiteral(resourceName: "bankDetails"),#imageLiteral(resourceName: "driverEarn"),#imageLiteral(resourceName: "truckInfo"),#imageLiteral(resourceName: "document"),#imageLiteral(resourceName: "imginvitefriend-unselect"),#imageLiteral(resourceName: "imgnotification-unselect"),#imageLiteral(resourceName: "setting"),#imageLiteral(resourceName: "complain"),#imageLiteral(resourceName: "imglang-unselect")]
     */
    /*
     var MenuItems = ["My Jobs","Bank Details","Driver Earnings","Truck Information","Documents","Invite Friend","Notifications","Settings","Language"]
     var menuImages = [#imageLiteral(resourceName: "myJOb"),#imageLiteral(resourceName: "bankDetails"),#imageLiteral(resourceName: "driverEarn"),#imageLiteral(resourceName: "truckInfo"),#imageLiteral(resourceName: "document"),#imageLiteral(resourceName: "imginvitefriend-unselect"),#imageLiteral(resourceName: "imgnotification-unselect"),#imageLiteral(resourceName: "setting"),#imageLiteral(resourceName: "imglang-unselect")]
     */
    var MenuItems = ["Home","My Jobs","Notifications","Settings","Help","Logout"]
    var menuImages = [#imageLiteral(resourceName: "f_home"),#imageLiteral(resourceName: "f_myRide"),#imageLiteral(resourceName: "f_notification"),#imageLiteral(resourceName: "f_setting"),#imageLiteral(resourceName: "f_help"),#imageLiteral(resourceName: "f_logout")]
    //[UIImage(named: "imgmy-booking-unselect"),UIImage(named: "imgfavourite-unselect"),UIImage(named: "imgpayment-option-unselect"),UIImage(named: "imgwallet-UNselect"),UIImage(named: "imginvitefriend-unselect"),UIImage(named: "imgnotification-unselect"),UIImage(named: "imghelp-unselect")]
    
    private var gradientLayer = CAGradientLayer()
    private var gradientApplied: Bool = false
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // ----------------------------------------------------
    // MARK: -View LifeCycle
    // ----------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
        tableviewSideMenu.isScrollEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(setProfileData), name: .setLoginData, object: nil)
        
        self.setProfileData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        SideMenuBackground()
    }
    @objc func setProfileData() {
        self.profileUpdate()
        tableviewSideMenu.reloadData()
    }
    func profileUpdate() {
        let profile: NSMutableDictionary = NSMutableDictionary(dictionary: (Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary))
        imgVw.contentMode = .scaleAspectFill
        imgVw.sd_setImage(with: URL(string: profile.object(forKey: "Image") as! String))
        lblEmail.text  = profile.object(forKey: "Email") as? String
        lblUsername.text = profile.object(forKey: "Fullname") as? String
    }
    @IBAction func profileClick(_ sender: Any) {
        
        guard let NavController = sideMenuController?.rootViewController as? UINavigationController else {
            return
        }
        guard let HomePage = NavController.children[0] as? HomeViewController else {
            return
        }
        NavController.popToRootViewController(animated: false)
        let vc:UpdateProfilePersonelDetailsVC = UIViewController.viewControllerInstance(storyBoard: .Main)
        HomePage.navigationController?.pushViewController(vc, animated: false)
        sideMenuController?.hideLeftView()
        sideMenuController?.hideRightView()
        sideMenuController?.isLeftViewSwipeGestureEnabled = false
        sideMenuController?.isRightViewSwipeGestureEnabled = false
    }
}


// ----------------------------------------------------
// MARK: -Tableview Datasource & Delegate Methods
// ----------------------------------------------------
extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if section == 0 {
            return 1
        }else {
            return MenuItems.count  //menuContainerViewController?.contentViewControllers.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            cell.backgroundColor = themeBlueColor
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
            //guard let Lang = userDefault.value(forKey: "language") as? String else {return UITableViewCell() }
            cell.lblMenu.text = MenuItems[indexPath.row].localized
            //   cell.lblMenu.textAlignment = (Lang == "en") ? NSTextAlignment.left : NSTextAlignment.right
            
            cell.imgMenu.image = menuImages[indexPath.row]
            cell.rightImgMenu.image = menuImages[indexPath.row]
            return cell
        }
 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SelectOption(Index: indexPath.row)
        /*
        if indexPath.section == 0 {
            
            guard let NavController = sideMenuController?.rootViewController as? UINavigationController else {
                return
            }
            guard let HomePage = NavController.children[0] as? HomeVC else {
                return
            }
            NavController.popToRootViewController(animated: false)
            let MyProfilePage:ProfileViewController = UIViewController.viewControllerInstance(storyBoard: AppStoryboards.Main)
            HomePage.navigationController?.pushViewController(MyProfilePage, animated: false)
            sideMenuController?.hideLeftView()
            sideMenuController?.hideRightView()
            sideMenuController?.isLeftViewSwipeGestureEnabled = false
            sideMenuController?.isRightViewSwipeGestureEnabled = false
            
        } else {
            //            let MenuTitle = self.MenuItems[indexPath.row]
            if indexPath.row == 7 {
                
                guard let NavController = sideMenuController?.rootViewController as? UINavigationController else {
                    return
                }
                guard let HomePage = NavController.children[0] as? HomeVC else {
                    return
                }
                NavController.popToRootViewController(animated: false)
                let changeLanguageVC:ChangeLanguageViewController = UIViewController.viewControllerInstance(storyBoard: AppStoryboards.Main)
                HomePage.navigationController?.pushViewController(changeLanguageVC, animated: false)
                sideMenuController?.hideLeftView()
                sideMenuController?.hideRightView()
                sideMenuController?.isLeftViewSwipeGestureEnabled = false
                sideMenuController?.isRightViewSwipeGestureEnabled = false
                
                /*
                 if let Lang = userDefault.value(forKey: "language") as? String  {
                 if Lang == "ab" {
                 userDefault.set("en", forKey: "language")
                 self.setLanguage(Language: "en")
                 } else if Lang == "en" {
                 userDefault.set("ab", forKey: "language")
                 self.setLanguage(Language: "ab")
                 }
                 userDefault.synchronize()
                 (UIApplication.shared.delegate as? AppDelegate)?.setLanguage()
                 }
                 */
            }else if indexPath.row == 8 {
                if Singleton.shared().currentBookingData != nil {
                    AlertMessage.showMessageForError("Please complete your running trip before logout.")
                    return
                }
                DispatchQueue.main.async {
                    let Logoutalert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
                    Logoutalert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (UIAlertAction) in
                        
                        self.logoutAPI()
                        appDel.GoToLogout()
                    }))
                    Logoutalert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(Logoutalert, animated: true, completion: nil)
                }
            }else {
                self.SelectOption(Index: indexPath.row)
            }
        } */
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        }
        return 50 // (indexPath.row == 8 || indexPath.section == 0) ? UITableView.automaticDimension : 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    
}

//MARK:- Custom Methods

extension SideMenuViewController {
    
    func setLayout() {
//        NotificationCenter.default.addObserver(self, selector: #selector(TableViewReload), name: NotificationSidemenuReloadKey, object: nil)
        registerNIBs()
    }
    
    func setLanguage(Language: String) {
        
        if Language == "fr" {
            sideMenuController?.isRightViewSwipeGestureEnabled = false
            sideMenuController?.isLeftViewSwipeGestureEnabled = true
        }else {
            sideMenuController?.isLeftViewSwipeGestureEnabled = false
            sideMenuController?.isRightViewSwipeGestureEnabled = true
        }
        sideMenuController?.hideLeftView()
        sideMenuController?.hideRightView()
//        NotificationCenter.default.post(name: NotificationSidemenuReloadKey, object: nil)
    }
    
    @objc func TableViewReload() {
        tableviewSideMenu.reloadData()
    }
    
    func registerNIBs(){
        let header = UINib(nibName: "HeaderTableViewCell", bundle: nil)
        tableviewSideMenu.register(header, forCellReuseIdentifier: "HeaderTableViewCell")
        
        let Language = UINib(nibName: "LanguageTVCell", bundle: nil)
        tableviewSideMenu.register(Language, forCellReuseIdentifier: "LanguageTVCell")
        
        let LanguageAB = UINib(nibName: "LanguageABCell", bundle: nil)
        tableviewSideMenu.register(LanguageAB, forCellReuseIdentifier: "LanguageABCell")
        
        let logout = UINib(nibName: "LogoutTVCell", bundle: nil)
        tableviewSideMenu.register(logout, forCellReuseIdentifier: "LogoutTVCell")
    }
    
    func SideMenuBackground(){
        if gradientLayer.superlayer != nil {
            gradientLayer.removeFromSuperlayer()
        }
        
        let topColor = themeBlueColor
        let bottomColor = themeBlueColor
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func SelectOption(Index:Int) {
        let MenuTitle = self.MenuItems[Index]
        guard let NavController = sideMenuController?.rootViewController as? UINavigationController else {
            return
        }
        guard let HomePage = NavController.children[0] as? HomeViewController else {
            return
        }
        NavController.popToRootViewController(animated: false)
        switch MenuTitle {
        case "Home":
          let vc:HomeViewController = UIViewController.viewControllerInstance(storyBoard: .Main)
           
          // HomePage.navigationController?.pushViewController(vc, animated: false)
        case "My Jobs" :
            let MyBookingPage:MyBookingVC = UIViewController.viewControllerInstance(storyBoard: AppStoryboards.MyBooking)
                       //                SingletonClass.SharedInstance.GetMyBookingStoryBoard().instantiateViewController(withIdentifier: "MyBookingVC") as! MyBookingVC
            HomePage.navigationController?.pushViewController(MyBookingPage, animated: false)
            break
            
        case "Notifications":
            let vc:NotificationVC = UIViewController.viewControllerInstance(storyBoard: .Main)
                     
            HomePage.navigationController?.pushViewController(vc, animated: false)
            break
        case "Settings":
            let vc:SettingsViewController = UIViewController.viewControllerInstance(storyBoard: .Main)
                               
            HomePage.navigationController?.pushViewController(vc, animated: false)
            break
        case "Help":
            let bankDetail : HelpDetailVC = UIViewController.viewControllerInstance(storyBoard: .Main)
            HomePage.navigationController?.pushViewController(bankDetail, animated: false)
            
        case "Logout":
            let LogoutConfirmation = UIAlertController(title: "App Name".localized, message: "Are you sure you want to logout?".localized, preferredStyle: .alert)
                  LogoutConfirmation.addAction(UIAlertAction(title: "Logout".localized, style: .destructive, handler: { (UIAlertAction) in
                      self.webserviceOFSignOut()
                    
                  }))
                  LogoutConfirmation.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
                  self.present(LogoutConfirmation, animated: true, completion: nil)
            break
        default:
            break
        }
        /*
        switch MenuTitle {
        case "My Jobs":
            let MyBookingPage:MyBookingVC = UIViewController.viewControllerInstance(storyBoard: AppStoryboards.MyBooking)
            //                SingletonClass.SharedInstance.GetMyBookingStoryBoard().instantiateViewController(withIdentifier: "MyBookingVC") as! MyBookingVC
            HomePage.navigationController?.pushViewController(MyBookingPage, animated: false)
        case "Notifications":
            let MyBookingPage:NotificationViewController = UIViewController.viewControllerInstance(storyBoard: .Main)
            
            HomePage.navigationController?.pushViewController(MyBookingPage, animated: false)
        case "Bank Details":
            
            if Singleton.shared().driverDutyOn {
                AlertMessage.showMessageForError("You can't update detail while duty on.")
                break
            }
            
            let bankDetail:BankDetailsViewController = UIViewController.viewControllerInstance(storyBoard: .Main)
            
            HomePage.navigationController?.pushViewController(bankDetail, animated: false)
        case "Settings":
            if Singleton.shared().driverDutyOn {
                AlertMessage.showMessageForError("You can't update detail while duty on.")
                break
            }
            
            let bankDetail:SettingViewController = UIViewController.viewControllerInstance(storyBoard: .Main)
            
            HomePage.navigationController?.pushViewController(bankDetail, animated: false)
        case "Complains":
            let bankDetail:HelpVC = UIViewController.viewControllerInstance(storyBoard: .Help)
            
            HomePage.navigationController?.pushViewController(bankDetail, animated: false)
            
        case "Truck Information":
            if Singleton.shared().driverDutyOn {
                AlertMessage.showMessageForError("You can't update detail while duty on.")
                break
            }
            
            let truckInfo:TruckInfoViewController = UIViewController.viewControllerInstance(storyBoard: .Main)
            
            HomePage.navigationController?.pushViewController(truckInfo, animated: false)
            
        case "Documents":
            if Singleton.shared().driverDutyOn {
                AlertMessage.showMessageForError("You can't update detail while duty on.")
                break
            }
            
            let truckDocuement:TruckDocumentsViewController = UIViewController.viewControllerInstance(storyBoard: .Main)
            HomePage.navigationController?.pushViewController(truckDocuement, animated: false)
            
        case "Invite Friend":
            let inviteFriendVC:InviteFriendVC = UIViewController.viewControllerInstance(storyBoard: .Main)
            HomePage.navigationController?.pushViewController(inviteFriendVC, animated: false)
            
        case "Driver Earnings":
            if let accessEarning = Singleton.shared().accessEarning , accessEarning { //Change for company driver
                if accessEarning {
                    let driverEarnVC: DriverEarningVC = UIViewController.viewControllerInstance(storyBoard: .DriverEarnings)
                    HomePage.navigationController?.pushViewController(driverEarnVC, animated: false)
                }                
            }else {
                AlertMessage.showMessageForError("You are not authorize to access earnings.")
            }
            
        default:
            break
        } */
        
        sideMenuController?.hideLeftView()
        sideMenuController?.hideRightView()
        sideMenuController?.isLeftViewSwipeGestureEnabled = false
        sideMenuController?.isRightViewSwipeGestureEnabled = false
    }
    
}
extension Notification.Name {
    
    static let setLoginData = Notification.Name("setLoginData")
    static let LogoutUser = Notification.Name("LogoutUser")
    static let CheckoutAddressChange = Notification.Name("CheckoutAddressChange")
}

//MARK: API integration
extension SideMenuViewController {
    func logoutAPI() {
        /*
        let logoutRequest = logoutModel()
        guard let driverID = Singleton.shared().loginUserData?.driverDetails.id else { return }
        
        guard let userID = Singleton.shared().loginUserData?.id else { return }
        
        
        logoutRequest.device_token = Singleton.shared().deviceToken.isEmptyOrWhitespace() ? "dsadasdsajdbaskd" : Singleton.shared().deviceToken
        logoutRequest.user_id = userID
        logoutRequest.driver_id = driverID
        
        UserWebserviceSubclass.logoutDriver(objLogout: logoutRequest) { (response,status) in
            if status {
                SocketIOManager.shared.closeConnection()
                self.showSuccess(response: response)
            }else {
                self.showError(response: response)
            }
            //            Singleton.shared().driverDutyOn = false
        }
        
        */
    }
    func webserviceOFSignOut()
    {
        let srtDriverID = Singletons.sharedInstance.strDriverID
        
        let param = srtDriverID + "/" + Singletons.sharedInstance.deviceToken
        
        webserviceForSignOut(param as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                
                guard let socket = (UIApplication.shared.delegate as! AppDelegate).Socket else { return }
                
                socket.off(socketApiKeys.kReceiveBookingRequest)
                socket.off(socketApiKeys.kBookLaterDriverNotify)
                
                socket.off(socketApiKeys.kGetBookingDetailsAfterBookingRequestAccepted)
                socket.off(socketApiKeys.kAdvancedBookingInfo)
                
                socket.off(socketApiKeys.kReceiveMoneyNotify)
                socket.off(socketApiKeys.kAriveAdvancedBookingRequest)
                
                socket.off(socketApiKeys.kDriverCancelTripNotification)
                socket.off(socketApiKeys.kAdvancedBookingDriverCancelTripNotification)
                Singletons.sharedInstance.setPasscode = ""
                Singletons.sharedInstance.isPasscodeON = false
                socket.disconnect()
                
                for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                    print("\(key) = \(value) \n")
                    
                    if(key != "Token" && key != "i18n_language") {
                        UserDefaults.standard.removeObject(forKey: key)
                    }
                }
                UserDefaults.standard.set(false, forKey: "isTripDestinationShow")
                UserDefaults.standard.set(false, forKey: kIsSocketEmited)
                //  UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                Singletons.sharedInstance.isDriverLoggedIN = false
//                self.performSegue(withIdentifier: "SignOutFromSideMenu", sender: (Any).self)
                App_Delegate.GoToLogin()
                
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
}
