//
//  DriverRegistrationViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 10/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
//import TTSegmentedControl

class DriverRegistrationViewController: UIViewController, UIScrollViewDelegate //SPSegmentControlCellStyleDelegate, SPSegmentControlDelegate
{

    var percentIndicatorViewLabel = String()
     var selectedIndex = Int()
    private let borderColor: UIColor = UIColor(hue: 1, saturation: 0, brightness: 1, alpha: 0.5)
    private let backgroundColor: UIColor = UIColor(hue: 1, saturation: 0, brightness: 1, alpha: 0.08)
    
    
//    @IBOutlet var viewBank: UIView!
//    @IBOutlet var viewDriver: UIView!
//    @IBOutlet var viewEmail: UIView!
//    @IBOutlet var viewCar: UIView!
//    @IBOutlet var viewAttachment: UIView!
    @IBOutlet var viewMainLine: UIView!
    
    @IBOutlet weak var viewOneTwoLine: UIView!
    @IBOutlet weak var viewTwoThreeLine: UIView!
    @IBOutlet weak var viewThreeForeLine: UIView!
    @IBOutlet weak var viewFourFifthLine: UIView!
    
    
    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet var viewNavi: UIView!
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewThree: UIView!
    @IBOutlet weak var viewFore: UIView!
    @IBOutlet weak var viewFifth: UIView!
    @IBOutlet weak var lblone: UILabel!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblThree: UILabel!
    @IBOutlet weak var lblFore: UILabel!
    @IBOutlet weak var lblFifth: UILabel!
   
    
//    @IBOutlet var imgDriver: UIImageView!
//    @IBOutlet var imgMail: UIImageView!
//    @IBOutlet var imgBank: UIImageView!
//    @IBOutlet var imgCar: UIImageView!
//    @IBOutlet var imgAttachment: UIImageView!
    
    
    
    @IBOutlet weak var constraintHeightOfPagingView: NSLayoutConstraint! // 80
    
    
    var arrImageUnselected = [iconMailUnselect, iconDriverUnselect, iconBankUnselect, iconCarUnselect, iconAttachmentUnselect]
    var arrImageSelected = [iconMailSelect, iconDriverSelect, iconBankSelect, iconCarSelect, iconAttachmentSelect]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
//        print(UserDefaults.standard.object(forKey: savedDataForRegistration.kPageNumber))
        
        if UserDefaults.standard.object(forKey: savedDataForRegistration.kPageNumber) != nil
        {
            let pageNO = UserDefaults.standard.object(forKey: savedDataForRegistration.kPageNumber) as! Int
//            var driverVC = UIViewController()
//            if let VC = self.navigationController?.viewControllers.last as? DriverRegistrationViewController
//            {
//                driverVC = VC
//            }

            if pageNO == 0
            {
                self.setCornertoView(View: viewOne, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblone)
                self.setCornertoView(View: viewTwo, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblTwo)
                self.setCornertoView(View: viewThree, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblThree)
                self.setCornertoView(View: viewFore, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblFore)
                self.setCornertoView(View: viewFifth, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblFifth)
                viewOneTwoLine.backgroundColor = themeGrayTextColor
                viewTwoThreeLine.backgroundColor = themeGrayTextColor
                viewThreeForeLine.backgroundColor = themeGrayTextColor
                viewFourFifthLine.backgroundColor = themeGrayTextColor
            }
            
            if pageNO == 1
            {
                self.setCornertoView(View: viewOne, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblone)
                self.setCornertoView(View: viewTwo, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblTwo)
                self.setCornertoView(View: viewThree, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblThree)
                self.setCornertoView(View: viewFore, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblFore)
                self.setCornertoView(View: viewFifth, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblFifth)
                viewOneTwoLine.backgroundColor = ThemeYellowColor
                viewTwoThreeLine.backgroundColor = themeGrayTextColor
                viewThreeForeLine.backgroundColor = themeGrayTextColor
                viewFourFifthLine.backgroundColor = themeGrayTextColor
            }
            else if pageNO == 2
            {
                self.setCornertoView(View: viewOne, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblone)
                self.setCornertoView(View: viewTwo, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblTwo)
                self.setCornertoView(View: viewThree, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblThree)
                self.setCornertoView(View: viewFore, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblFore)
                self.setCornertoView(View: viewFifth, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblFifth)
                viewOneTwoLine.backgroundColor = ThemeYellowColor
                viewTwoThreeLine.backgroundColor = ThemeYellowColor
                viewThreeForeLine.backgroundColor = themeGrayTextColor
                viewFourFifthLine.backgroundColor = themeGrayTextColor
            }
            else if pageNO == 3
            {
                self.setCornertoView(View: viewOne, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblone)
                self.setCornertoView(View: viewTwo, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblTwo)
                self.setCornertoView(View: viewThree, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblThree)
                self.setCornertoView(View: viewFore, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblFore)
                self.setCornertoView(View: viewFifth, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblFifth)
                viewOneTwoLine.backgroundColor = ThemeYellowColor
                viewTwoThreeLine.backgroundColor = ThemeYellowColor
                viewThreeForeLine.backgroundColor = ThemeYellowColor
                viewFourFifthLine.backgroundColor = themeGrayTextColor
            }
            else if pageNO == 4
            {
                self.setCornertoView(View: viewOne, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblone)
                self.setCornertoView(View: viewTwo, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblTwo)
                self.setCornertoView(View: viewThree, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblThree)
                self.setCornertoView(View: viewFore, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblFore)
                self.setCornertoView(View: viewFifth, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblFifth)
                viewOneTwoLine.backgroundColor = ThemeYellowColor
                viewTwoThreeLine.backgroundColor = ThemeYellowColor
                viewThreeForeLine.backgroundColor = ThemeYellowColor
                viewFourFifthLine.backgroundColor = ThemeYellowColor
            }
//            else if pageNO == 5
//            {
//
//            }
//          if pageNO == 1
//            {
//                driverVC.viewOne.backgroundColor = ThemeYellowColor
//
//                driverVC.lblone.textColor = UIColor.white
////                driverVC.imgMail.image = UIImage.init(named: iconMailSelect)
////                driverVC.imgDriver.image = UIImage.init(named: iconDriverSelect)
//            }
//            else if pageNO == 2
//          {
//            driverVC.lblone.text = "01"
//            driverVC.lblTwo.text = "02"
//
//            }
//            else if pageNO == 3
//            {
//                driverVC.lblone.text = "01"
//                driverVC.lblTwo.text = "02"
//                driverVC.lblThree.text = "03"
//            }
//            else if pageNO == 4
//            {
//                driverVC.lblone.text = "01"
//                driverVC.lblTwo.text = "02"
//                driverVC.lblThree.text = "03"
//                driverVC.lblFore.text = "04"
//                driverVC.lblFifth.text = "05"
//
//            }
//
            
            
            let page = self.view.frame.size.width * CGFloat(pageNO)
            self.scrollObj.setContentOffset(CGPoint(x: page, y: 0), animated: true)
        
        //                = UserDefaults.standard.object(forKey: savedDataForRegistration.kPageNumber) as! Int
        }
        else
        {
            
            if let driverVC = self.navigationController?.viewControllers.last as? DriverRegistrationViewController
            {
                self.setCornertoView(View: driverVC.viewOne, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: driverVC.lblone)
                self.setCornertoView(View: driverVC.viewTwo, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: driverVC.lblTwo)
                self.setCornertoView(View: driverVC.viewThree, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: driverVC.lblThree)
                self.setCornertoView(View: driverVC.viewFore, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: driverVC.lblFore)
                self.setCornertoView(View: driverVC.viewFifth, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: driverVC.lblFifth)
            }
//            driverVC.viewOne.backgroundColor = ThemeYellowColor
//            driverVC.lblone.text = "01"
//            driverVC.lblone.textColor = UIColor.white
        }
        
    }
//

    override func viewDidLoad()
    {
        super.viewDidLoad()
//        imgMail.image = UIImage.init(named: iconMailSelect)
//        imgDriver.image = UIImage.init(named: iconDriverUnselect)
//        imgBank.image = UIImage.init(named: iconBankUnselect)
//        imgCar.image = UIImage.init(named: iconCarUnselect)
//        imgAttachment.image = UIImage.init(named: iconAttachmentUnselect)

        viewMainLine.backgroundColor = UIColor.clear
//        viewOne.backgroundColor = ThemeYellowColor
//        viewTwo.backgroundColor = UIColor.white
//        viewThree.backgroundColor = UIColor.white
//        viewFore.backgroundColor = UIColor.white
//        viewFifth.backgroundColor = UIColor.white
        
        
        
  
//        self.viewOne.layer.cornerRadius = viewOne.frame.size.width / 2
//        self.viewOne.clipsToBounds = true
//        self.viewTwo.layer.cornerRadius = viewTwo.frame.size.width / 2
//        self.viewTwo.layer.borderColor = themeGrayTextColor
//        self.viewTwo.layer.borderWidth = 1.0
//        self.viewTwo.clipsToBounds = true
//        self.viewThree.layer.cornerRadius = viewThree.frame.size.width / 2
//        self.viewThree.clipsToBounds = true
//        self.viewFore.layer.cornerRadius = viewFore.frame.size.width / 2
//        self.viewFore.clipsToBounds = true
//        self.viewFifth.layer.cornerRadius = viewFifth.frame.size.width / 2
//        self.viewFifth.clipsToBounds = true

        lblone.text = "01"
        lblTwo.text = "02"
        lblThree.text = "03"
        lblFore.text = "04"
        lblFifth.text = "05"
        
        self.setCornertoView(View: viewOne, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: lblone)
        self.setCornertoView(View: viewTwo, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblTwo)
        self.setCornertoView(View: viewThree, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblThree)
        self.setCornertoView(View: viewFore, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblFore)
        self.setCornertoView(View: viewFifth, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: lblFifth)

        if DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPAD {
            constraintHeightOfPagingView.constant = 50
        }

    }
    func setCornertoView(View: UIView, BGColor : UIColor, borderColor : UIColor, textcolor : UIColor , label : UILabel)
    {
        View.layer.cornerRadius = View.frame.size.width / 2
        View.backgroundColor = BGColor
        View.layer.borderColor = borderColor.cgColor
        View.layer.borderWidth = 1.0
        label.textColor = textcolor
        View.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
//        self.setNavigationBar()


    }
    
    func setNavigationBar()
    {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isOpaque = true
        self.navigationController?.navigationBar.isTranslucent = true

        if self.selectedIndex == 0
        {
            self.navigationItem.titleView = nil
            let lblTitle = UILabel.init(frame: CGRect (x: 0, y: 0, width: 100, height: 30))
//            lblTitle.text = "Tan Taxi"
            lblTitle.textColor = ThemeYellowColor
            lblTitle.textAlignment = .center
            lblTitle.font = UIFont.init(name: CustomeFontProximaNovaBold, size: 11)
            self.navigationItem.titleView = lblTitle
        }
        else if  self.selectedIndex == 1
        {
            self.navigationItem.titleView = nil
            let lblTitle = UILabel.init(frame: CGRect (x: 0, y: 0, width: 100, height: 30))
//            lblTitle.text = "Re"
            lblTitle.textColor = ThemeYellowColor
            lblTitle.textAlignment = .center
            lblTitle.font = UIFont.init(name: CustomeFontProximaNovaBold, size: 11)
            self.navigationItem.titleView = lblTitle
        }
        else if  self.selectedIndex == 2
        {
            self.navigationItem.titleView = nil
            let img = UIImage(named: kNavIcon)
            let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imgView.image = img
            // setContent mode aspect fit
            imgView.contentMode = .scaleAspectFit
            self.navigationItem.titleView = imgView

        }
        else if  self.selectedIndex == 3
        {
        self.navigationItem.titleView = nil
            let img = UIImage(named: kNavIcon)
            let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imgView.image = img
            // setContent mode aspect fit
            imgView.contentMode = .scaleAspectFit
            self.navigationItem.titleView = imgView

        }
        else if  self.selectedIndex == 4
        {
        self.navigationItem.titleView = nil
            let img = UIImage(named: kNavIcon)
            let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imgView.image = img
            // setContent mode aspect fit
            imgView.contentMode = .scaleAspectFit
            self.navigationItem.titleView = imgView

        }
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = ThemeYellowColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : ThemeYellowColor]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage.init()
        self.navigationController?.view.backgroundColor = UIColor.clear
//        if self.navigationController?.viewControllers.count == 1
//        {
//            let btnSideMenu:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: kMenuIcon), style: UIBarButtonItemStyle.plain, target: self, action: #selector(btnSidemenuClicked(_:)))
//            self.navigationItem.leftBarButtonItem = btnSideMenu
//        }
//        else
//        {
        let btnBack:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: kBackIcon), style: UIBarButtonItem.Style.plain, target: self, action: #selector(btnBackClicked(_:)))
            self.navigationItem.leftBarButtonItem = btnBack
//        }
    }
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
//    @IBOutlet var segmentController: SPSegmentedControl!
    
    @IBOutlet weak var scrollObj: UIScrollView!
    
    
    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    @IBOutlet var thirdView: UIView!
    @IBOutlet var fourthView: UIView!
    @IBOutlet var fifthView: UIView!
    @IBOutlet var sixthView: UIView!
    
    
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    
    func backButtonClicked() {
        
        if (self.scrollObj.frame.size.width / self.view.frame.width) == 0 {
            
        }
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let pageNo = CGFloat(scrollView.contentOffset.x / scrollView.frame.size.width)
//         headerView?.btnSignOut.isHidden = true
//        if (pageNo >= 2)
//        {
//            headerView?.btnSignOut.isHidden = false
//        }
//        segmentController.selectItemAt(index: Int(pageNo), animated: true)
    }
    
    
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func btnSidemenuClicked(_ sender: Any)
    {
//        self.revealViewController() .revealToggle(animated: true)
    }
    
    @objc @IBAction func btnBackClicked (_ sender: Any)
    {
//         navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        if UserDefaults.standard.object(forKey: savedDataForRegistration.kPageNumber) != nil
        {
            let pageNO = UserDefaults.standard.object(forKey: savedDataForRegistration.kPageNumber) as! Int
            
        
            let driverVC = self.navigationController?.viewControllers.last as! DriverRegistrationViewController
            
            if pageNO == 1
            {
                let EmailVC = driverVC.children[pageNO - 1] as! DriverEmailViewController
                EmailVC.txtMobile.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kMobileNo) as? String
                EmailVC.txtEmail.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kEmail) as? String
                EmailVC.txtPassword.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kPassword) as? String
                EmailVC.txtConPassword.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kPassword) as? String
            }
            else if pageNO == 2
            {
                let personalVC = driverVC.children[pageNO - 1] as! DriverPersonelDetailsViewController
                let picData = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kDriverImage)
                let image = UIImage(data:picData as! Data,scale:1.0)
                personalVC.txtDOB.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kKeyDOB) as? String
                personalVC.txtFullName.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kFullname) as? String
                personalVC.txtAddress.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kAddress) as? String
                personalVC.txtInviteCode.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kReferralCode) as? String
                let sreGender = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kGender) as! String
                if sreGender == "Male"
                {
                    personalVC.btnMale.setImage(UIImage.init(named: "iconRadioSelected"), for: .normal)
                }
                else
                {
                    personalVC.btnMale.setImage(UIImage.init(named: "iconRadioSelected"), for: .normal)
                }

                if image == nil
                {
                    personalVC.imgProfile.image = UIImage.init(named: "iconUsers")
                }
                else
                {
                    personalVC.imgProfile.image = image
                }
            }
            else if pageNO == 3
            {
                
                let BankVC = driverVC.children[pageNO - 1] as! DriverBankDetailsViewController

                BankVC.txtAccountHolderName.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kbankHolderName) as? String
                BankVC.txtBankName.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kBankName) as? String
                BankVC.txtBankBranch.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kBSB) as? String
                BankVC.txtAccountHolderName.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kbankHolderName) as? String
                
            }
            else if pageNO == 4
            {

                let VehicleVC = driverVC.children[pageNO - 1] as! DriverSelectVehicleTypesViewController
                
                
                //        txtVehicleRegistrationNumber = vehicle Plate Number = VehicleRegistrationNo
                //        txtCompany = vehicle model = VehicleModelName
                //        txtCarType = vehicle type = VehicleClass
                //        txtVehicleMake = vehicle make = CompanyModel
                //        txtNumberPassenger = number of passenger = NoOfPassenger
                
                
                VehicleVC.txtVehicleRegistrationNumber.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kVehicleRegistrationNo) as? String
                VehicleVC.txtCompany.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kVehicleModelName) as? String
                VehicleVC.txtCarType.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kVehicleClass) as? String
                VehicleVC.txtVehicleMake.text = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kCompanyModel) as? String
                VehicleVC.txtNumberPassenger.selectedItem = UserDefaults.standard.value(forKey: RegistrationFinalKeys.kNumberOfPasssenger) as? String
            }
           
            let page = self.view.frame.size.width * CGFloat(pageNO - 1)
            self.scrollObj.setContentOffset(CGPoint(x: page, y: 0), animated: true)
            UserDefaults.standard.set(pageNO - 1, forKey: savedDataForRegistration.kPageNumber)
            
            if pageNO == 0
            {
//                UserDefaults.standard.removeObject(forKey: savedDataForRegistration.kPageNumber)
                for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                    print("\(key) = \(value) \n")
                    
                    if key == "Token" {
                        
                    }
                    else {
                        UserDefaults.standard.removeObject(forKey: key)
                    }
                }
                
                navigationController?.popViewController(animated: true)
            }
            else
            {
                UserDefaults.standard.set(pageNO - 1, forKey: savedDataForRegistration.kPageNumber)
            }
            self.viewDidLayoutSubviews()
            //                = UserDefaults.standard.object(forKey: savedDataForRegistration.kPageNumber) as! Int
        }
        else
        {
            
            let driverVC = self.navigationController?.viewControllers.last as! DriverRegistrationViewController
            self.setCornertoView(View: driverVC.viewOne, BGColor: ThemeYellowColor, borderColor: ThemeYellowColor, textcolor: UIColor.white, label: driverVC.lblone)
            self.setCornertoView(View: driverVC.viewTwo, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: driverVC.lblTwo)
            self.setCornertoView(View: driverVC.viewThree, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: driverVC.lblThree)
            self.setCornertoView(View: driverVC.viewFore, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: driverVC.lblFore)
            self.setCornertoView(View: driverVC.viewFifth, BGColor: UIColor.white, borderColor: themeGrayTextColor, textcolor: themeGrayTextColor, label: driverVC.lblFifth)
            
            navigationController?.popViewController(animated: true)
            //            driverVC.viewOne.backgroundColor = ThemeYellowColor
            //            driverVC.lblone.text = "01"
            //            driverVC.lblone.textColor = UIColor.white
        }
//        navigationController?.popViewController(animated: true)
    }
    
//    private func createCell(text: String, image: UIImage) -> SPSegmentedControlCell {
//        let cell = SPSegmentedControlCell.init()
//        cell.label.text = text
////        cell.backgroundColor = UIColor.green
//        cell.label.font = UIFont(name: "Avenir-Medium", size: 13.0)!
//        cell.imageView.image = image
//        return cell
//    }
//
//    private func createImage(withName name: String) -> UIImage
//    {
//        return UIImage.init(named: name)!//.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//    }
//
//
//
//    func selectedState(segmentControlCell: SPSegmentedControlCell, forIndex index: Int) {
//        SPAnimation.animate(0.1, animations:
//            {
////                segmentControlCell.imageView.tintColor = UIColor.clear
//
//                self.selectedIndex = index
//                self.setNavigationBar()
////                                segmentControlCell.imageView.tintColor = UIColor.clear
//
//
//                if self.selectedIndex == 0
//                {
//                    segmentControlCell.imageView.image = UIImage.init(named: self.arrImageSelected[0])
//                }
//                else if self.selectedIndex == 1
//                {
//                   segmentControlCell.imageView.image = UIImage.init(named: self.arrImageSelected[1])
//                }
//                else if self.selectedIndex == 2
//                {
//                    segmentControlCell.imageView.image = UIImage.init(named: self.arrImageSelected[2])
//                }
//                else if self.selectedIndex == 3
//                {
//                   segmentControlCell.imageView.image = UIImage.init(named: self.arrImageSelected[3])
//                }
//                else if self.selectedIndex == 4
//                {
//                    segmentControlCell.imageView.image = UIImage.init(named: self.arrImageSelected[4])
//                }
//
//        })
//
//        UIView.transition(with: segmentControlCell.label, duration: 0.1, options: [.transitionCrossDissolve, .beginFromCurrentState], animations: {
//            segmentControlCell.label.textColor = UIColor.clear
//
//
//            let x = CGFloat(index) * self.scrollObj.frame.size.width
//            self.scrollObj.setContentOffset(CGPoint(x:x, y:0), animated: true)
//
//        }, completion: nil)
//    }
//
//    func normalState(segmentControlCell: SPSegmentedControlCell, forIndex index: Int) {
//        SPAnimation.animate(0.1, animations: {
//            var i = 1
//            if self.selectedIndex >= index
//            {
////
////                if self.selectedIndex <= 0 {
////                    self.headerView?.btnSignOut.isHidden = true
////                }
////                else {
////                    self.headerView?.btnSignOut.isHidden = true
////                }
//
//                while i <= index {
//                    print(i)
////                    segmentControlCell.imageView.tintColor = UIColor.clear
//                    i = i + 1
//                }
//            }
//            else{
////                segmentControlCell.imageView.tintColor = UIColor.clear
//            }
//
//
//
//        })
//
//        UIView.transition(with: segmentControlCell.label, duration: 0.1, options: [.transitionCrossDissolve, .beginFromCurrentState], animations: {
//            segmentControlCell.label.textColor = UIColor.white
//        }, completion: nil)
//    }
//
//    func indicatorViewRelativPosition(position: CGFloat, onSegmentControl segmentControl: SPSegmentedControl) {
//        let percentPosition = position / (segmentControl.frame.width - position) / CGFloat(segmentControl.cells.count - 1) * 100
//        let intPercentPosition = Int(percentPosition)
//        self.percentIndicatorViewLabel = "scrolling: \(intPercentPosition)%"
//    }
//
    func setData(companyData: [[String:AnyObject]])
    {
        let company: [[String:AnyObject]] = companyData
//
//        if company == [[:]] {
//            company
//        }
//
//        self.userDefault.set(company, forKey: OTPCodeStruct.kCompanyList)
        
        print("SETDATA")
        
        print("otp = ;")
    }
    
    
    
}


