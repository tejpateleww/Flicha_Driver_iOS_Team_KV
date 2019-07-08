//
//  WalletBalanceMainVC.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 23/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class WalletBalanceMainVC: ParentViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        webserviceOfTransactionHistory()
        tableView.reloadData()
    }

    
    var aryData = [[String:AnyObject]]()
    @IBOutlet var viewTopUp: UIView!
    @IBOutlet var viewTransfer: UIView!
    @IBOutlet var viewHistory: UIView!
    
    @IBOutlet var imgTopUp: UIImageView!
    @IBOutlet var imgTransfer: UIImageView!
    @IBOutlet var imgHistory: UIImageView!
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
//        self.tableView.addSubview(self.refreshControl)
        
        if Singletons.sharedInstance.walletHistoryData.count == 0 {
             webserviceOfTransactionHistory()
        }
        else {
            aryData = Singletons.sharedInstance.walletHistoryData
            let currentRatio = Double(Singletons.sharedInstance.strCurrentBalance)
            
            self.lblAvailableFundsDesc.text = "\(String(format: "%.2f", currentRatio)) \(currency)"
            
        }
//       imgLKR.image = UIImage.init(named: "roundDollar")?.withRenderingMode(.alwaysTemplate)
//        imgLKR.tintColor = UIColor.gray
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.strTitle = "Balance".localized
        self.showsBackButton = true
        self.createHeaderView()
        self.setLocalizable()
        self.viewTopUp.backgroundColor = themeGrayBGColor
        self.imgTopUp.image = UIImage.init(named: "iconTNZUnselected")
        self.lblTopUp.textColor = UIColor.black
        self.viewTransfer.backgroundColor = themeGrayBGColor
        self.imgTransfer.image = UIImage.init(named: "iconTransferBankUnselected")
        self.lblTransferToBank.textColor = UIColor.black
        self.viewHistory.backgroundColor = themeGrayBGColor
        self.imgHistory.image = UIImage.init(named: "iconWalletHistoryUnselected")
        self.lblHistory.textColor = UIColor.black
        self.lblAvailableFundsDesc.textColor = ThemeYellowColor
        
        webserviceOfTransactionHistory()
        tableView.reloadData()
    }
    
    
    func setLocalizable() {
    
        self.lblTopUp.text = "Top Up".localized
        self.lblTransferToBank.text = "Transfer To Bank".localized
        self.lblHistory.text = "History".localized
        self.lblAvailableFunds.text = "Available Funds".localized
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        viewAvailableFunds.layer.cornerRadius = 5
        viewAvailableFunds.layer.masksToBounds = true
        
        viewCenter.layer.cornerRadius = 5
        viewCenter.layer.masksToBounds = true
        
        viewBottom.layer.cornerRadius = 5
        viewBottom.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var viewAvailableFunds: UIView!
    @IBOutlet weak var lblAvailableFunds: UILabel!
    @IBOutlet weak var lblAvailableFundsDesc: UILabel!
    
    @IBOutlet var imgLKR: UIImageView!
    
    @IBOutlet weak var viewCenter: UIView!
    
//    @IBOutlet weak var imgTopUp: UIImageView!
    @IBOutlet weak var lblTopUp: UILabel!
    
    @IBOutlet weak var imgTansferToBank: UIImageView!
    @IBOutlet weak var lblTransferToBank: UILabel!
    
//    @IBOutlet weak var imgHistory: UIImageView!
    @IBOutlet weak var lblHistory: UILabel!
    
    
    @IBOutlet weak var viewBottom: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
  
    //-------------------------------------------------------------
    // MARK: - TableView Methods
    //-------------------------------------------------------------
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (aryData.count <= 5) ? aryData.count : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletBalanceMainTableViewCell") as! WalletBalanceMainTableViewCell
        cell.selectionStyle = .none
        
        let dictData = aryData[indexPath.row]
        
        cell.lblTransferTitle.text = dictData["Description"] as? String
        cell.lblTransferDateAndTime.text = dictData["UpdatedDate"] as? String
        
        let amount = "\(dictData["Amount"] ?? "00" as AnyObject)"
//        let currentRatio = Double(dictData["Amount"] as! String)!
        let currentRatio = Double(amount)
//        if dictData["Status"] as! String == "failed" {
//            cell.statusHeight.constant = 20.5
//            cell.lblStatus.isHidden = false
//            cell.lblStatus.text = "Transaction Failed"
//            cell.lblStatus.textColor = themeYellowColor//UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
//            cell.lblPrice.text = "\(dictData["Type"] as! String) \(String(format: "%.2f", currentRatio!))"
//            cell.lblPrice.textColor = UIColor.red
//        }
//        else {
//            cell.statusHeight.constant = 0
//            cell.lblStatus.isHidden = true
//
//            cell.lblPrice.text = "\(dictData["Type"] as! String) \(String(format: "%.2f", currentRatio!))"
//            cell.lblPrice.textColor = UIColor.init(red: 0, green: 144/255, blue: 81/255, alpha: 1.0)
//            cell.statusHeight.constant = 17
//            cell.lblStatus.isHidden = false
//            cell.lblStatus.text = "Transaction Pending"
//            cell.lblStatus.textColor = themeYellowColor//UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
//        }
        if dictData["Status"] as! String == "failed" {
            
            cell.lblPrice.text = "-\(dictData["Amount"] as! String) \(currency)"//\(dictData["Type"] as! String)
            cell.lblPrice.textColor = ThemeYellowColor//UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
            
            cell.statusHeight.constant = 20.5
            cell.lblStatus.isHidden = false
            cell.lblStatus.text = "Transaction Failed"
            cell.lblStatus.textColor = ThemeYellowColor//UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        }
        else if dictData["Status"] as! String == "pending" {
            cell.lblPrice.text = "-\(dictData["Amount"] as! String) \(currency)"//\(dictData["Type"] as! String)
            cell.lblPrice.textColor = ThemeYellowColor//UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
            
            cell.statusHeight.constant = 17
            cell.lblStatus.isHidden = false
            cell.lblStatus.text = "Transaction Pending"
            cell.lblStatus.textColor = ThemeYellowColor//UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        }
        else {
            
            if dictData["Type"] as! String == "-" {
                cell.statusHeight.constant = 0
                cell.lblStatus.isHidden = true
                
                cell.lblPrice.text = "+\(dictData["Amount"] as! String) \(currency)"//\(dictData["Type"] as! String)
                cell.lblPrice.textColor = UIColor.green
            }
            else {
                cell.statusHeight.constant = 0
                cell.lblStatus.isHidden = true
                
                cell.lblPrice.text = "+\(dictData["Amount"] as! String) \(currency)"//\(dictData["Type"] as! String)
                cell.lblPrice.textColor = UIColor.green
                //                cell.lblPrice.textColor = UIColor.init(red: 0, green: 144/255, blue: 81/255, alpha: 1.0)
            }
            
        }
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func btnTopUP(_ sender: UIButton) {
        
        self.viewTopUp.backgroundColor = UIColor.black
        self.imgTopUp.image = UIImage.init(named: "iconTNZSelected")
        self.lblTopUp.textColor = ThemeYellowColor
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletTopUpVC") as! WalletTopUpVC
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    
    @IBAction func btnTransferToBank(_ sender: UIButton) {
        
        self.viewTransfer.backgroundColor = UIColor.black
        self.imgTransfer.image = UIImage.init(named: "iconTransferBankSelected")
        self.lblTransferToBank.textColor = ThemeYellowColor
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletTransferToBankVC") as! WalletTransferToBankVC
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func btnHistory(_ sender: UIButton) {
        
        self.viewHistory.backgroundColor = UIColor.black
        self.imgHistory.image = UIImage.init(named: "iconWalletHistorySelected")
        self.lblHistory.textColor = ThemeYellowColor
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletHistoryViewController") as! WalletHistoryViewController
        self.navigationController?.pushViewController(next, animated: true)
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
                
                self.lblAvailableFundsDesc.text = "\(String(format: "%.2f", currentRatio)) \(currency)"
                
                self.aryData = (result as! NSDictionary).object(forKey: "history") as! [[String:AnyObject]]
                
                Singletons.sharedInstance.walletHistoryData = self.aryData
                
                self.tableView.reloadData()
                
                self.refreshControl.endRefreshing()
                
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
