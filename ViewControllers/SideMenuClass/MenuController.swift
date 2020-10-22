//
//  MenuController.swift
//  TiCKTOC-Driver
//  Created by Excellent Webworld on 11/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import SideMenuController
import SDWebImage

let KEnglish : String = "EN"
let KSwiley : String = "SW"

class  MenuController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    var aryItemNames = [String]()
    var aryItemIcons = [String]()
    
    var driverFullName = String()
    var driverImage = UIImage()
    var driverMobileNo = String()
    var strImagPath = String()
    var strSelectedLaungage = String()
    private var previousIndex: NSIndexPath?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        strSelectedLaungage = KEnglish
        
        aryItemNames = [kMyJobs,kPaymentOption,kWallet,kMyRating,kInviteFriend,kSettings,kLegal,kSupport,kLogout]
        
        aryItemIcons = [kiconMyJobs,kiconPaymentOption,kiconWallet,kiconMyRating,kiconInviteFriend,kiconSettings,klegal
            ,kiconSupport,kIconLogout]
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(MenuController.setRating), name: NSNotification.Name(rawValue: "rating"), object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        giveGradientColor()
        getDataFromSingleton()
    }
    
    func giveGradientColor() {
        
        let colorTop =  UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor//(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        let colorMiddle =  UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor//UIColor(red: 36/255, green: 24/255, blue: 3/255, alpha: 0.5).cgColor
        let colorBottom = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor//UIColor(red: 64/255, green: 43/255, blue: 6/255, alpha: 0.8).cgColor
        //
        //        let gradientLayer = CAGradientLayer()
        //        gradientLayer.colors = [ colorTop, colorMiddle, colorBottom]
        //        gradientLayer.locations = [ 0.0, 0.5, 1.0]
        //        gradientLayer.frame = self.view.bounds
        //        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    @objc func setRating() {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Mark: tableview method
    
    @IBOutlet var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if aryItemNames.count == 0 {
                return 0
            }
            return 1
        }
        else if section == 1 {
            return 1// return aryItemNames.count
        }
        else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let cellProfile = tableView.dequeueReusableCell(withIdentifier: "SideMenuIDriverProfile") as! SideMenuTableViewCell
        let cellItemList = tableView.dequeueReusableCell(withIdentifier: "SideMenuItemsList") as! SideMenuTableViewCell
        
        cellProfile.selectionStyle = .none
        cellItemList.selectionStyle = .none
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        
        if indexPath.section == 0 {
            
            cellProfile.imgProfile.layer.cornerRadius = cellProfile.imgProfile.frame.width / 2
            cellProfile.imgProfile.layer.masksToBounds = true
            cellProfile.imgProfile.layer.borderColor = ThemeYellowColor.cgColor
            cellProfile.imgProfile.layer.borderWidth = 1.0
            cellProfile.lblDriverName.text = driverFullName
            cellProfile.lblGmail.text = driverMobileNo
            //            cellProfile.lblRating.text = Singletons.sharedInstance.strRating
            cellProfile.imgProfile.sd_setImage(with: URL(string: strImagPath))
            cellProfile.btnUpdateProfile.addTarget(self, action: #selector(self.updateProfile), for: .touchUpInside)
            cellProfile.lblLaungageName.layer.cornerRadius = 5
            cellProfile.lblLaungageName.backgroundColor = ThemeYellowColor
            cellProfile.lblLaungageName.layer.borderColor = UIColor.black.cgColor
            cellProfile.lblLaungageName.layer.borderWidth = 0.5
            
            if let SelectedLanguage = UserDefaults.standard.value(forKey: "i18n_language") as? String {
                if SelectedLanguage == "en" {
                    cellProfile.lblLaungageName.text = "SW"
                } else if SelectedLanguage == "sw" {
                    cellProfile.lblLaungageName.text = "EN"
                }
            }
//            cellProfile.lblLaungageName.text = strSelectedLaungage
            
            cellProfile.btnLaungageChange.addTarget(self, action: #selector(btnLaungageClicked(_:)), for: .touchUpInside)
            //            .layer.cornerRadius = btnHome.frame.size.height / 2
            //            btnMyJob.clipsToBounds = true
            //            btnMyJob.borderColor = UIColor.red
            return cellProfile
        }
        else if indexPath.section == 1 {
            //            cellItemList.lblItemNames.text = aryItemNames[indexPath.row]
            //            cellItemList.imgItems.image = UIImage(named: aryItemIcons[indexPath.row])
            
            cellItemList.lblMyJobs.text = "My Jobs".localized
            cellItemList.lblMyRaitng.text = "My Ratings".localized
            cellItemList.lblInviteFrnd.text = "Invite Friends".localized
            cellItemList.lblTripToDestination.text = "Trip to Destination".localized
            cellItemList.lblLegal.text = "Legal".localized
            cellItemList.lblSupport.text = "Support".localized
            cellItemList.btnLogOut.setTitle("Log Out".localized, for: .normal)
            cellItemList.lblPaymentOption.text = "Payment Options".localized
            cellItemList.btnMyJob.addTarget(self, action: #selector(self.MyJob), for: .touchUpInside)
            //            cellItemList.btnMyJob.tag = indexPath.row
            cellItemList.btnPaymentOption.addTarget(self, action: #selector(self.PayMentOption), for: .touchUpInside)
            cellItemList.btnWallet.addTarget(self, action: #selector(self.Wallet), for: .touchUpInside)
            cellItemList.btnMyRating.addTarget(self, action: #selector(self.MyRating), for: .touchUpInside)
            cellItemList.btnInviteFriend.addTarget(self, action: #selector(self.InviteFriend), for: .touchUpInside)
            cellItemList.btnTripToDestination.addTarget(self, action: #selector(self.setting), for: .touchUpInside)
            cellItemList.btnLegal.addTarget(self, action: #selector(self.Legal), for: .touchUpInside)
            cellItemList.btnSupport.addTarget(self, action: #selector(self.Support), for: .touchUpInside)
            cellItemList.btnLogOuts.addTarget(self, action: #selector(self.LogOut), for: .touchUpInside)
            
            cellItemList.btnMyJob.layer.shadowOpacity = 0.7
            cellItemList.btnMyJob.layer.shadowRadius = 15.0
            cellItemList.btnMyJob.layer.shadowColor = UIColor.black.cgColor
            cellItemList.btnPaymentOption.layer.shadowOpacity = 0.7
            cellItemList.btnPaymentOption.layer.shadowRadius = 15.0
            cellItemList.btnPaymentOption.layer.shadowColor = UIColor.black.cgColor
            cellItemList.btnWallet.layer.shadowOpacity = 0.7
            cellItemList.btnWallet.layer.shadowRadius = 15.0
            cellItemList.btnWallet.layer.shadowColor = UIColor.black.cgColor
            cellItemList.btnMyRating.layer.shadowOpacity = 0.7
            cellItemList.btnMyRating.layer.shadowRadius = 15.0
            cellItemList.btnMyRating.layer.shadowColor = UIColor.black.cgColor
            cellItemList.btnInviteFriend.layer.shadowOpacity = 0.7
            cellItemList.btnInviteFriend.layer.shadowRadius = 15.0
            cellItemList.btnInviteFriend.layer.shadowColor = UIColor.black.cgColor
            cellItemList.btnTripToDestination.layer.shadowOpacity = 0.7
            cellItemList.btnTripToDestination.layer.shadowRadius = 15.0
            cellItemList.btnTripToDestination.layer.shadowColor = UIColor.black.cgColor
            cellItemList.btnLegal.layer.shadowOpacity = 0.7
            cellItemList.btnLegal.layer.shadowRadius = 15.0
            cellItemList.btnLegal.layer.shadowColor = UIColor.black.cgColor
            cellItemList.btnSupport.layer.shadowOpacity = 0.7
            cellItemList.btnSupport.layer.shadowRadius = 15.0
            cellItemList.btnSupport.layer.shadowColor = UIColor.black.cgColor
            cellItemList.btnLogOuts.layer.cornerRadius = cellItemList.btnLogOuts.frame.size.height / 2
            cellItemList.btnLogOuts.clipsToBounds = true
            return cellItemList
        }
        else {
            return UITableViewCell()
        }
        
    }
    @objc func btnLaungageClicked(_ sender : UIButton)
    {
        
        //        sender.isSelected = !sender.isSelected
        
//        if strSelectedLaungage == KEnglish
//        {
//            strSelectedLaungage = KSwiley
//        }
//        else
//        {
//            strSelectedLaungage = KEnglish
//        }
//
//        self.tableView.reloadData()
        
        if let SelectedLanguage = UserDefaults.standard.value(forKey: "i18n_language") as? String {
            if SelectedLanguage == "en" {
                setLayoutForswahilLanguage()
                
            } else if SelectedLanguage == "sw" {
                setLayoutForenglishLanguage()
            }
        }
        self.navigationController?.loadViewIfNeeded()
        self.tableView.reloadData()
        NotificationCenter.default.post(name: NotificationChangeLanguage, object: nil)
        
    }
        
    @objc func MyJob(){
        //
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MyJobsViewController") as!    MyJobsViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
        //     sideMenuController?.performSegue(withIdentifier: "SegueSideMenuToMyJob", sender: self)
    }
    
    
    @objc func PayMentOption(){
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WalletCardsVC") as! WalletCardsVC
        self.navigationController?.pushViewController(viewController, animated: true)
        
        
    }
    @objc func Wallet(){
        //        if(Singletons.sharedInstance.CardsVCHaveAryData.count == 0)
        //        {
        //            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
        //            self.navigationController?.pushViewController(viewController, animated: true)
        //            
        //        }
        //        else
        //        {
        //            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WalletCardsVC") as! WalletCardsVC
        //            self.navigationController?.pushViewController(viewController, animated: true)
        //            
        //        }
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    @objc func MyRating(){
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MyRatingViewController") as! MyRatingViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func InviteFriend(){
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "InviteDriverViewController") as! InviteDriverViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func setting(){
        
        let storyboard = UIStoryboard(name: "TripToDestination", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TripToDestinationViewController") as! TripToDestinationViewController

        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func Legal(){
//        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LegalViewController") as! LegalViewController
//        self.navigationController?.pushViewController(viewController, animated: true)
   }
    
    @objc func  Support(){
        
        UtilityClass.showAlert(appName.kAPPName, message: "This feature is coming soon", vc: self)
        
//        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "webViewVC") as! webViewVC
//        viewController.headerName = "Support".localized
////        viewController.headerName = "\("App Name".localized) - Terms & Conditions"
//        viewController.strURL = WebSupport.SupportURL
////        "https://www.tantaxitanzania.com/front/termsconditions"
//        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    @objc func LogOut(){
        
//        self.webserviceOFSignOut()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //    //[kMyJobs,kPaymentOption,kWallet,kMyRating,kInviteFriend,kSettings,kLogout]
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
    //
    //        if indexPath.section == 1
    //        {
    //
    //            let strCellItemTitle = aryItemNames[indexPath.row]
    //
    //            if strCellItemTitle == kWallet
    //            {
    //                if(Singletons.sharedInstance.CardsVCHaveAryData.count == 0)
    //                {
    //                      let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WalletAddCardsViewController") as! WalletAddCardsViewController
    //                    self.navigationController?.pushViewController(viewController, animated: true)
    //
    //                }
    //                else
    //                {
    //                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WalletCardsVC") as! WalletCardsVC
    //                    self.navigationController?.pushViewController(viewController, animated: true)
    //
    //
    //                }
    //            }
    //            else if strCellItemTitle == kWallet
    //            {
    //
    //                //                self.moveToComingSoon()
    //                //                   UserDefaults.standard.set(Singletons.sharedInstance.isPasscodeON, forKey: "isPasscodeON")
    //
    //                if (Singletons.sharedInstance.isPasscodeON) {
    //                    //                    if Singletons.sharedInstance.setPasscode == "" {
    //                    //                        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SetPasscodeViewController") as! SetPasscodeViewController
    //                    //                        self.navigationController?.pushViewController(viewController, animated: true)
    //                    //                    }
    //                    //                    else {
    //                    //                        if (Singletons.sharedInstance.passwordFirstTime) {
    //                    //
    //                    //                            let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
    //                    //                            self.navigationController?.pushViewController(next, animated: true)
    //                    //                        }
    //                    //                        else {
    //                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "VerifyPasswordViewController") as! VerifyPasswordViewController
    //                    viewController.strStatusToNavigate = "wallet"
    //                    self.navigationController?.pushViewController(viewController, animated: true)
    //
    //                    //                        }
    //                }
    //
    //                else
    //                {
    //                    let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
    //                    self.navigationController?.pushViewController(next, animated: true)
    //                }
    //
    //
    //
    //
    //                //                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SetPasscodeViewController") as! SetPasscodeViewController
    //                //                self.navigationController?.pushViewController(viewController, animated: true)
    //                //
    //
    //                //                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
    //                //                self.navigationController?.pushViewController(viewController, animated: true)
    //
    //            }
    ////            else if indexPath.row == 2 {
    ////
    ////                if (Singletons.sharedInstance.isPasscodeON) {
    ////                    let tabbar =  ((((((self.navigationController?.childViewControllers)?.last as! CustomSideMenuViewController).childViewControllers[0]) as! UINavigationController).childViewControllers[0]) as! TabbarController)
    ////                    tabbar.selectedIndex = 4
    ////                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "VerifyPasswordViewController") as! VerifyPasswordViewController
    ////                    self.present(viewController, animated: false, completion: nil)
    ////                    sideMenuController?.toggle()
    ////
    ////                }
    ////                else {
    ////                    let tabbar =  ((((((self.navigationController?.childViewControllers)?.last as! CustomSideMenuViewController).childViewControllers[0]) as! UINavigationController).childViewControllers[0]) as! TabbarController)
    ////                    tabbar.selectedIndex = 4
    ////
    ////                    sideMenuController?.toggle()
    ////                }
    ////
    ////            }
    ////            else if indexPath.row == 2 {
    //////                 self.moveToComingSoon()
    ////
    ////                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WeeklyEarningViewController") as! WeeklyEarningViewController
    ////                self.navigationController?.pushViewController(viewController, animated: true)
    ////            }
    ////            else if strCellItemTitle == kDriverNews {
    //////                self.moveToComingSoon()
    ////
    ////                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DriverNewsViewController") as! DriverNewsViewController
    ////                self.navigationController?.pushViewController(viewController, animated: true)
    ////
    ////            }
    //           else if strCellItemTitle == kInviteFriend {
    //                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "InviteDriverViewController") as! InviteDriverViewController
    //                self.navigationController?.pushViewController(viewController, animated: true)
    //            }
    ////            else if strCellItemTitle == kChangePassword {
    ////
    ////                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
    ////                self.navigationController?.pushViewController(viewController, animated: true)
    ////
    ////            }
    //            else if strCellItemTitle == kSettings {
    //
    //                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingPasscodeVC") as! SettingPasscodeVC
    //                self.navigationController?.pushViewController(viewController, animated: true)
    //
    //            }
    ////            else if strCellItemTitle == kMeter
    ////            {
    ////
    ////                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MeterViewController") as! MeterViewController
    ////                self.navigationController?.pushViewController(viewController, animated: true)
    ////            }
    ////            else if strCellItemTitle == kTripToDstination
    ////            {
//                    let storyboard = UIStoryboard(name: "TripToDestination", bundle: nil)
//                    let viewController = storyboard.instantiateViewController(withIdentifier: "TripToDestinationViewController") as! TripToDestinationViewController
    //
    ////                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TripToDestinationViewController") as! TripToDestinationViewController
    ////                self.navigationController?.pushViewController(viewController, animated: true)
    ////
    ////            }
    ////            else if strCellItemTitle == kShareRide {
    ////                let viewController = storyboard?.instantiateViewController(withIdentifier: "ShareRideViewController") as! ShareRideViewController
    ////                self.navigationController?.pushViewController(viewController, animated: true)
    //                //            }//binal
    //
    //        }
    //
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        }
        else if indexPath.section == 1 {
            return 524//self.view.frame.size.height
        }
        else {
            return 524
        }
    }
    
   
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    @objc func updateProfile()
    {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "EditDriverProfileVC") as! EditDriverProfileVC
        self.navigationController?.pushViewController(viewController, animated: true)
        //        self.sideMenuController?.embed(centerViewController: viewController)
    }
    func getDataFromSingleton()
    {
        let profile =  NSMutableDictionary(dictionary: (Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary))
        //         {
        
        
        //            NSMutableDictionary(Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as NSDictionary).object(forKey: "profile")
        
        driverFullName = profile.object(forKey: "Fullname") as! String
        driverMobileNo = profile.object(forKey: "Email") as! String
        strImagPath = profile.object(forKey: "Image") as! String
        
        
        //        }
        //        if let profile =  NSMutableDictionary(dictionary: (Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as NSDictionary).object(forKey: "profile") as) {
        //
        //
        //            //            NSMutableDictionary(Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as NSDictionary).object(forKey: "profile")
        //
        //            driverFullName = profile.object(forKey: "Fullname") as! String
        //            driverMobileNo = profile.object(forKey: "MobileNo") as! String
        //
        //            strImagPath = profile.object(forKey: "Image") as! String
        //        }
        
        tableView.reloadData()
    }
    
    // ------------------------------------------------------------
    
    func moveToComingSoon() {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ComingSoonVC") as! ComingSoonVC
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    

    
    
    
}
