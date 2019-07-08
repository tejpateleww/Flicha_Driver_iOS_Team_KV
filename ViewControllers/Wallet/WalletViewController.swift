//
//  WalletViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 06/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController, UIScrollViewDelegate {

    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    @IBOutlet weak var viewBalance: UIView!
    @IBOutlet weak var viewCards: UIView!
    @IBOutlet weak var viewTransfer: UIView!
    @IBOutlet var lblNavTitle: UILabel!
    
    
    override func loadView() {
        super.loadView()
    }
    
    @IBAction func btnCallHelpLine(_ sender: Any) {
        CallButtonClicked()
    }
    
    func CallButtonClicked()     //  Call Button
    {
        let contactNumber = WebSupport.HelplineNumber
        
        if contactNumber == "" {
            
            //            UtilityClass.showAlertWithCompletion(title: "\(appName)", message: "Contact number is not available") { (index, title) in
            //            }
            
            UtilityClass.showAlertWithCompletion(appName.kAPPName, message: "Contact number is not available", vc: self, completionHandler: {_ in
            })
        }
        else
        {
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPAD {
            stackViewForList.spacing = 20
            
        }
 
        viewOptions.layer.cornerRadius = 5
//        viewOptions.layer.masksToBounds = true
        viewBalance.layer.cornerRadius = viewBalance.frame.height / 2
//        viewBalance.layer.masksToBounds = true
        viewTransfer.layer.cornerRadius = viewTransfer.frame.height / 2
//        viewTransfer.layer.masksToBounds = true
        viewCards.layer.cornerRadius = viewCards.frame.height / 2
//        viewCards.layer.masksToBounds = true
        
        
        scrollObj.delegate = self
        scrollObj.isScrollEnabled = false
        
        bPaySelected()
        
        webserviceOfTransactionHistory()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .lightContent
        self.setLocalizable()
    }
    
    func setLocalizable()
    {
        self.lblNavTitle.text = "Wallet".localized
        self.lblCurrentBalance.text = "\("Balance".localized) \n \(Singletons.sharedInstance.strCurrentBalance) \(currency)"
        self.lblTransfer.text = "Transfer".localized
        
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        //        pageCtrl.currentPage = Int(pageNumber)
        //        pageCtrl.currentPageIndicatorTintColor = UIColor.black
        
    }
    
   
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    
    @IBOutlet weak var scrollObj: UIScrollView!
    
    
//    @IBOutlet weak var pageCtrl: UIPageControl!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewOptions: UIView!
    
    @IBOutlet weak var lblCurrentBalance: UILabel!
    @IBOutlet weak var imgBpay: UIImageView!
    @IBOutlet weak var imgTravel: UIImageView!
    @IBOutlet weak var imgEntertainment: UIImageView!
    
    @IBOutlet weak var lblCards: UILabel!
    @IBOutlet weak var lblTransfer: UILabel!
    @IBOutlet weak var lblBpay: UILabel!
    @IBOutlet weak var lblTravel: UILabel!
    @IBOutlet weak var lblEntertainment: UILabel!
    
    @IBOutlet weak var stackViewForList: UIStackView!
    
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func btnBalance(_ sender: UIButton) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletBalanceMainVC") as! WalletBalanceMainVC
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    
    @IBAction func btnTransfer(_ sender: UIButton) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletTransferViewController") as! WalletTransferViewController
        self.navigationController?.pushViewController(next, animated: true)
  
    }
    
    
    @IBAction func btnCards(_ sender: UIButton) {
        
        if(Singletons.sharedInstance.CardsVCHaveAryData.count == 0)
        {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletAddCardsViewController") as! WalletAddCardsViewController
//            next.delegateAddCard = self
            self.navigationController?.pushViewController(next, animated: true)
        }
        else
        {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletCardsVC") as! WalletCardsVC
            self.navigationController?.pushViewController(next, animated: true)
        }
       
    }
    
    @IBAction func btnBpay(_ sender: UIButton) {
        
        bPaySelected()
        
        scrollObj.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @IBAction func btnTravel(_ sender: UIButton) {
        
        travelSelected()
        
        scrollObj.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: true)
    }
    
    @IBAction func btnEntertainment(_ sender: UIButton) {
        
        entertainmentSelected()
        
        imgBpay.image = UIImage(named: "iconDollerGrey")
        imgEntertainment.image = UIImage(named: "iconEntertainmentSelected")
        imgTravel.image = UIImage(named: "iconTravelBag")
        
        scrollObj.setContentOffset(CGPoint(x: self.view.frame.size.width * 2, y: 0), animated: true)
    }
    
    func bPaySelected() {
        
        lblBpay.textColor = UIColor.init(red: 56/255, green: 145/255, blue: 219/255, alpha: 1.0)
        lblTravel.textColor = UIColor.init(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)
        lblEntertainment.textColor = UIColor.init(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)
        
        imgBpay.image = UIImage(named: "iconDollerSelected")
        imgEntertainment.image = UIImage(named: "iconEntertainmentUnSelected")
        imgTravel.image = UIImage(named: "iconTravelBag")
    }
    
    func travelSelected() {
        
        lblBpay.textColor = UIColor.init(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)
        lblTravel.textColor = UIColor.init(red: 56/255, green: 145/255, blue: 219/255, alpha: 1.0)
        lblEntertainment.textColor = UIColor.init(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)
        
        imgBpay.image = UIImage(named: "iconDollerGrey")
        imgEntertainment.image = UIImage(named: "iconEntertainmentUnSelected")
        imgTravel.image = UIImage(named: "iconTravelBagSelected")
    }
    
    func entertainmentSelected() {
        
        lblBpay.textColor = UIColor.init(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)
        lblTravel.textColor = UIColor.init(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)
        lblEntertainment.textColor = UIColor.init(red: 56/255, green: 145/255, blue: 219/255, alpha: 1.0)
        
    }
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods Transaction History
    //-------------------------------------------------------------
    
    func webserviceOfTransactionHistory() {
        
        webserviceForTransactionHistoryInWallet(Singletons.sharedInstance.strDriverID as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                
                Singletons.sharedInstance.strCurrentBalance = ((result as! NSDictionary).object(forKey: "walletBalance") as AnyObject).doubleValue
                let currentRatio = Double(Singletons.sharedInstance.strCurrentBalance)
                
                self.lblCurrentBalance.text = "\("Balance".localized) \n \(Singletons.sharedInstance.strCurrentBalance) \(currency)"
//                self.lblCurrentBalance.text = "\(currency)\(Singletons.sharedInstance.strCurrentBalance)"
                
//                self.lblAvailableFundsDesc.text = "\(currency)\(Singletons.sharedInstance.strCurrentBalance)"
                
//                self.aryData = (result as! NSDictionary).object(forKey: "history") as! [[String:AnyObject]]
                
                Singletons.sharedInstance.walletHistoryData = (result as! NSDictionary).object(forKey: "history") as! [[String:AnyObject]]
                
                self.webserviceOFGetAllCards()
                
//                self.tableView.reloadData()
                
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
    
    var aryCards = [[String:AnyObject]]()
    
    func webserviceOFGetAllCards() {
        
        webserviceForCardListingInWallet(Singletons.sharedInstance.strDriverID as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                
                self.aryCards = (result as! NSDictionary).object(forKey: "cards") as! [[String:AnyObject]]
                
                Singletons.sharedInstance.CardsVCHaveAryData = self.aryCards
                
//                Singletons.sharedInstance.isCardsVCFirstTimeLoad = false
//                self.tableView.reloadData()
//                self.refreshControl.endRefreshing()
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
    
    @IBAction func btnBackToHome(_ sender: UIButton) {
        
//        ((((self.navigationController?.childViewControllers[1]) as! CustomSideMenuViewController).childViewControllers[0] as! UINavigationController).childViewControllers[0] as! TabbarController).childViewControllers[0] as! ContentViewController)
        
        let tabbarVC = ((self.navigationController as! UINavigationController).viewControllers[1] as! CustomSideMenuViewController)//.childViewControllers[0]) as! UINavigationController).viewControllers[0] as! TabbarController
        
        
        self.navigationController?.popToViewController(tabbarVC, animated: true)
    }
    

}

//-------------------------------------------------------------
// MARK: - BpayVC
//-------------------------------------------------------------


class BpayVC: UIViewController {
    
    @IBOutlet weak var txtbillerCode: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtCustomerRefrence: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        viewTop.layer.cornerRadius = 5
//        viewTop.layer.masksToBounds = true
        
//        btnSubmit.layer.cornerRadius = 5
//        btnSubmit.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var btnSubmiT: UIButton!
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        
    }
    
}


//-------------------------------------------------------------
// MARK: - TravelVC
//-------------------------------------------------------------

class TravelVC: UIViewController {
    
    @IBOutlet weak var lblTrain: UILabel!
    
    @IBOutlet weak var lblFerry: UILabel!
    @IBOutlet weak var lblVline: UILabel!
    @IBOutlet weak var lblTram: UILabel!
    @IBOutlet weak var lblBus: UILabel!
    @IBOutlet weak var lblFlight: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTop.layer.cornerRadius = 5
        viewTop.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var viewTop: UIView!
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func btnActions(_ sender: UIButton) {
        
        switch sender.tag {
            
            
        case 1:
            showWebSite(strHeager: "TRAIN", strURL: "http://www.metrotrains.com.au/")
            
        case 2:
            showWebSite(strHeager: "BUS", strURL: "https://www.ptv.vic.gov.au/projects/buses")
            
        case 3:
            showWebSite(strHeager: "TRAM", strURL: "https://www.ptv.vic.gov.au/getting-around/maps/metropolitan-trams/")
            
        case 4:
            showWebSite(strHeager: "VLINE", strURL: "https://www.vline.com.au/")
            
        case 5:
            showWebSite(strHeager: "FERRY", strURL: "https://www.ptv.vic.gov.au/getting-around/ferries/")
            
        case 6:
            showWebSite(strHeager: "FLIGHT", strURL: "http://www.jetstar.com/au/en/home")
            
        default: break
       
            
        }
        
    }
    
    
    func showWebSite(strHeager: String, strURL: String) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "webViewVC") as! webViewVC
        next.headerName = strHeager
        next.strURL = strURL
        self.navigationController?.present(next, animated: true, completion: nil)
    }
}

//-------------------------------------------------------------
// MARK: - EntertainmentVC
//-------------------------------------------------------------

class EntertainmentVC: UIViewController {
    
    @IBOutlet weak var lblDiscount: UILabel!
    
    @IBOutlet weak var lblFestival: UILabel!
    @IBOutlet weak var lblGiftCard: UILabel!
    @IBOutlet weak var lblRetail: UILabel!
    @IBOutlet weak var lblGroceries: UILabel!
    @IBOutlet weak var lblMovie: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTop.layer.cornerRadius = 5
        viewTop.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var viewTop: UIView!
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
   
    @IBAction func btnAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 11:
            showWebSite(strHeager: "MOVIE", strURL: "https://www.hoyts.com.au/")
            
        case 12:
            showWebSite(strHeager: "GROCERIES", strURL: "https://www.coles.com.au/")
            
        case 13:
            showWebSite(strHeager: "RETAILS", strURL: "https://www.chadstone.com.au/")
            
        case 14:
            showWebSite(strHeager: "DISCOUNT", strURL: "https://www.chadstone.com.au/whats-on")
            
        case 15:
            showWebSite(strHeager: "GIFT CARD", strURL: "https://www.chadstone.com.au/services-facilities/services/gift-card")
            
        case 16:
            showWebSite(strHeager: "FESTIVAL", strURL: "https://www.festival.melbourne/2017/")
            
        default: break
            
        }
        
    }
    
    
    
    func showWebSite(strHeager: String, strURL: String) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "webViewVC") as! webViewVC
        next.headerName = strHeager
        next.strURL = strURL
        self.navigationController?.present(next, animated: true, completion: nil)
    }
    
}



