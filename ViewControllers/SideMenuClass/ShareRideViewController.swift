//
//  ShareRideViewController.swift
//   TenTaxi-Driver
//
//  Created by Excelent iMac on 18/06/18.
//  Copyright © 2018 Excellent Webworld. All rights reserved.
//

import UIKit

class ShareRideViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource {

    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var switchShareRide: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblShareRide: UILabel!
    //-------------------------------------------------------------
    // MARK: - Global Declaration
    //-------------------------------------------------------------
    
    private var isShareRideOn = Bool()
    let driverId = Singletons.sharedInstance.strDriverID
    
    var labelNoData = UILabel()
    
    var aryShareRideListing = [[String:AnyObject]]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.init(red: 207/255, green: 120/255, blue: 35/255, alpha: 1)
        
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        webserviceOfShareRideListing()
        
        tableView.reloadData()
       
    }
    
   
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelNoData = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.labelNoData.text = "Loading..."
        self.labelNoData.textAlignment = .center
        self.view.addSubview(self.labelNoData)
        self.tableView.isHidden = true
        
        self.tableView.tableFooterView = UIView()
        self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        self.tableView.addSubview(self.refreshControl)

        self.switchShareRide.isOn = Singletons.sharedInstance.isShareRideOn
        
        webserviceOfShareRideListing()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        lblShareRide.text = "".localized
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func switchShareRide(_ sender: UISwitch) {
        
        webserviceOfShareRide()
    }
    
    //-------------------------------------------------------------
    // MARK: - TableView Methods
    //-------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryShareRideListing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shareRideListTableViewCell") as! shareRideListTableViewCell
        cell.selectionStyle = .none
        
        let currentData = aryShareRideListing[indexPath.row]
        
        cell.lblDriverName.text = NSMutableAttributedString(string: "\(currentData["PassengerName"] ?? "Passenger name is not available" as AnyObject)").string
        cell.lblBookingID.text = "Booking Id: \(currentData["Id"] as? String ?? "Booking Id:")"
        cell.lblStatus.text = currentData["Status"] as? String
        cell.lblPaymentType.text = currentData["PaymentType"] as? String
        cell.lblPickupAddress.text = currentData["PickupLocation"] as? String
        cell.lblDropoffAddress.text = currentData["DropoffLocation"] as? String
        cell.lblNumberOfPassengers.text = currentData["NoOfPassenger"] as? String
        
        
        cell.lblDriverName.text = "Passenger".localized
        cell.lblBookingID.text = "Booking Id".localized
        cell.lblPickUpLocation.text = "Pick up location".localized
        cell.lblDropLocation.text = "Drop off location".localized
        cell.lblStatus.text = "Trip Status :" .localized
        cell.lblPaymentType.text = "Payment Type :".localized
        cell.lblNumberOfPassengers.text = "Number Of Passenger".localized
//        cell.btnTrackYourTrip.setTitle("".localized, for: .normal)
        
        cell.btnCallToPassenger.tag = indexPath.row
        cell.btnCallToPassenger.addTarget(self, action: #selector(self.callToPassenger(_:)), for: .touchUpInside)
        
        cell.btnTrackYourTrip.tag = indexPath.row
        cell.btnTrackYourTrip.addTarget(self, action: #selector(self.trackYourTrip(sender:)), for: .touchUpInside)
        
        cell.viewDetails.isHidden = !expandedCellPaths.contains(indexPath)
        
        
        return cell
    }
    
    @objc func callToPassenger(_ sender: UIButton) {
        
        let currentData = aryShareRideListing[sender.tag]
        let cellNumber: String = currentData["PassengerMobileNo"] as! String
        
        if let url = URL(string: "tel://\(cellNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    var expandedCellPaths = Set<IndexPath>()
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if let cell = tableView.cellForRow(at: indexPath) as? shareRideListTableViewCell {
            cell.viewDetails.isHidden = !cell.viewDetails.isHidden
            if cell.viewDetails.isHidden {
                expandedCellPaths.remove(indexPath)
            } else {
                expandedCellPaths.insert(indexPath)
            }
            tableView.beginUpdates()
            tableView.endUpdates()
          
        }
       
    }
    
    
    @objc func trackYourTrip(sender: UIButton) {
        
        let currentData = aryShareRideListing[sender.tag]
        
        let id:String = (currentData as! NSDictionary).object(forKey: "Id")! as! String
        
        Singletons.sharedInstance.bookingId = id
        
        //                 Post notification
        NotificationCenter.default.post(name: NotificationTrackRunningTrip, object: nil)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    
    func webserviceOfShareRide() {
        
        webserviceForManageShareRideFlag(driverId as AnyObject) { (result, status) in
            
            if (status) {
                
                if let res = (result as? [String:AnyObject]) {
                    if let flagStatus = res["flag"] as? String {
                        if flagStatus == "1" {
                            Singletons.sharedInstance.isShareRideOn = true
                        }else {
                            Singletons.sharedInstance.isShareRideOn = false
                        }
                    }
                    else if let flagStatus = res["flag"] as? Int {
                        if flagStatus == 1 {
                            Singletons.sharedInstance.isShareRideOn = true
                        }else {
                            Singletons.sharedInstance.isShareRideOn = false
                        }
                    }
                    
                    self.switchShareRide.isOn = Singletons.sharedInstance.isShareRideOn
                    if let statusMessage = res["message"] as? String {
                        UtilityClass.showAlert(appName.kAPPName, message: statusMessage, vc: self)
                    }
                }
            }
            else {
                if let res = (result as? [String:AnyObject]) {
                    if let statusMessage = res["message"] as? String {
                        UtilityClass.showAlert(appName.kAPPName, message: statusMessage, vc: self)
                    }
                }  
            }
        }
    }
    
    // ----------------------------------------------------------------------
    
    func webserviceOfShareRideListing() {
        
        webserviceForShareRideListing(driverId as AnyObject) { (result, status) in
            
            if (status) {
                
                if let res = result as? [String:AnyObject] {
                    if let _shareRideList = res["share_ride"] as? NSArray {
                        if _shareRideList.count != 0 {
                            self.aryShareRideListing = _shareRideList as! [[String : AnyObject]]
                            
                            self.labelNoData.removeFromSuperview()
                            self.tableView.isHidden = false
                            
                            self.tableView.reloadData()
                            
                        }
                        else {
                            self.labelNoData.text = "There are no data"
                            self.tableView.isHidden = true
                        }
                        self.refreshControl.endRefreshing()
                    }
                }
                
            }
            else {
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

/*
{
    "status": true,
    "message": "Your share ride setting updated successfully",
    "flag": 0
}
 */
