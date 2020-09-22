//
//  NotificationVC.swift
//  Flicha-Driver
//
//  Created by EWW073 on 16/04/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class NotificationVC: BaseViewController {

    // ----------------------------------------------------
    // MARK: - --------- Outlets ---------
    // ----------------------------------------------------
    
    @IBOutlet weak var tblNotification: UITableView!
    @IBOutlet weak var lblNoDataFound: UILabel! {
        didSet {
            lblNoDataFound.text = "No data found".localized
            lblNoDataFound.textColor = .lightGray
        }
    }
    var arrayDict = [[String: Any]]()
    // ----------------------------------------------------
    // MARK: - --------- Global Variables ---------
    // ----------------------------------------------------
    
    
    
    // ----------------------------------------------------
    // MARK: - --------- Lifecycle Methods ---------
    // ----------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblNotification.delegate = self
        tblNotification.dataSource = self
        tblNotification.estimatedRowHeight = 72
        tblNotification.rowHeight = UITableView.automaticDimension
        tblNotification.tableFooterView = UIView()
        self.setNavigationBarInViewController(controller: self, naviTitle: "Notifications".localized, leftImage: iconBack, rightImages: [], isTranslucent: false)
        webserviceNotificationList(Singletons.sharedInstance.strDriverID as AnyObject) { (result, status) in
            if status {
                print(result)
                if let arrResult = result["data"] as? [[String: Any]] {
                    self.arrayDict = arrResult
                    self.tblNotification.reloadData()
                }
            }
        }
    }
}

// ----------------------------------------------------
// MARK: - --------- Tableview Delegate Methods ---------
// ----------------------------------------------------

extension NotificationVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lblNoDataFound.isHidden = (arrayDict.count != 0)
        return arrayDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        cell.selectionStyle = .none
        let dict = arrayDict[indexPath.row]
        cell.lblTitle.text = dict["NotificationName"] as? String ?? ""
        cell.lblDescription.text = dict["Description"] as? String ?? ""
        if let strNotificationName = dict["NotificationType"] as? String {
            if strNotificationName == "DutyStatus" || strNotificationName == "Logout" {
                cell.img.image = UIImage.init(named: "sessionexpire")
            }else if strNotificationName == "CompleteBooking" {
                cell.img.image = UIImage.init(named: "notificationSucess")
            }else if strNotificationName == "CancelBooking" {
                cell.img.image = UIImage.init(named: "notification-cancel")
            }
        }
        return cell
    }
}
