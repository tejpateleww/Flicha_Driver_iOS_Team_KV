//
//  WalletHistoryViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 23/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class WalletHistoryViewController: ParentViewController, UITableViewDataSource, UITableViewDelegate {

    
    var aryData = [[String:AnyObject]]()
    
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
      
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        self.tableView.addSubview(self.refreshControl)

        if Singletons.sharedInstance.walletHistoryData.count != 0 {
            aryData = Singletons.sharedInstance.walletHistoryData
        }
        else {
            webserviceOfTransactionHistory()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var tableView: UITableView!
    

    //-------------------------------------------------------------
    // MARK: - TableView Methods
    //-------------------------------------------------------------
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletHistoryTableViewCell") as! WalletHistoryTableViewCell
        cell.selectionStyle = .none
//        cell.lblTransferTitle.text = ""
//        cell.lblDateOfTransfer.text = ""
        
        let dictData = aryData[indexPath.row]
//
        cell.lblTransferTitle.text = dictData["Description"] as? String
        cell.lblDateOfTransfer.text = dictData["UpdatedDate"] as? String
//
//        if dictData["Status"] as! String == "failed" {
//
//            cell.lblAmount.text = "\(dictData["Type"] as! String) \(dictData["Amount"] as! String)"
//            cell.lblAmount.textColor = UIColor.red
//        }
//        else {
//
//            cell.lblAmount.text = "\(dictData["Type"] as! String) \(dictData["Amount"] as! String)"
//            cell.lblAmount.textColor = UIColor.init(red: 0, green: 144/255, blue: 81/255, alpha: 1.0)
//        }
        if dictData["Status"] as! String == "failed" {
            
            cell.lblAmount.text = "\(dictData["Amount"] as! String) \(currency)"//\(dictData["Type"] as! String)
            cell.lblAmount.textColor = ThemeYellowColor //UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)//
            
            cell.lblTransferStatusHeight.constant = 17
            cell.lblTransferStatus.isHidden = false
            cell.lblTransferStatus.text = "Transaction Failed"
            cell.lblTransferStatus.textColor = ThemeYellowColor //UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        }
        else if dictData["Status"] as! String == "pending" {
            cell.lblAmount.text = "\(dictData["Amount"] as! String) \(currency)"//\(dictData["Type"] as! String)
            cell.lblAmount.textColor = ThemeYellowColor //UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
            
            cell.lblTransferStatusHeight.constant = 17
            cell.lblTransferStatus.isHidden = false
            cell.lblTransferStatus.text = "Transaction Pending"
            cell.lblTransferStatus.textColor = ThemeYellowColor //UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        }
        else {
            
            if dictData["Type"] as! String == "-" {
                cell.lblTransferStatusHeight.constant = 0
                cell.lblTransferStatus.isHidden = true
                
                cell.lblAmount.text = "\(dictData["Amount"] as! String) \(currency)"//\(dictData["Type"] as! String)
                cell.lblAmount.textColor = UIColor.green
            }
            else {
                cell.lblTransferStatusHeight.constant = 0
                cell.lblTransferStatus.isHidden = true
                
                cell.lblAmount.text = "\(dictData["Amount"] as! String) \(currency)"//\(dictData["Type"] as! String)
                cell.lblAmount.textColor = UIColor.green//UIColor.init(red: 0, green: 144/255, blue: 81/255, alpha: 1.0)
            }
            
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 82
//    }
    
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods Transaction History
    //-------------------------------------------------------------
    
    func webserviceOfTransactionHistory() {
        
        webserviceForTransactionHistoryInWallet(Singletons.sharedInstance.strDriverID as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                
                self.aryData = (result as! NSDictionary).object(forKey: "history") as! [[String:AnyObject]]
                
                Singletons.sharedInstance.strCurrentBalance = ((result as! NSDictionary).object(forKey: "walletBalance") as! AnyObject).doubleValue
                
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
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
