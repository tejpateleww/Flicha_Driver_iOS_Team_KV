//
//  NotificationVC.swift
//  Flicha-Driver
//
//  Created by EWW073 on 16/04/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {

    // ----------------------------------------------------
    // MARK: - --------- Outlets ---------
    // ----------------------------------------------------
    
    @IBOutlet weak var tblNotification: UITableView!
    
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
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        cell.selectionStyle = .none
       
        return cell
    }
}
