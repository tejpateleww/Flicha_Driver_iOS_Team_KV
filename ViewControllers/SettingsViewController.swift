//
//  SettingsViewController.swift
//  Flicha-Driver
//
//  Created by Apple on 21/05/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
   
    @IBOutlet weak var tblVw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarInViewController(controller: self, naviTitle: "Settings".localized, leftImage: iconBack, rightImages: [], isTranslucent: false)
         
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func switchClick(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
        Singletons.sharedInstance.isPushSettingsOn = !Singletons.sharedInstance.isPushSettingsOn
        var dictParam = [String: AnyObject]()
        dictParam["DriverId"] = Singletons.sharedInstance.strDriverID as AnyObject
        dictParam["Notification"] = Singletons.sharedInstance.isPushSettingsOn ? "1" as AnyObject : "0" as AnyObject
        webserviceForUpdateSettings(dictParam as AnyObject) { (result, status) in
            if status {
                if let profile = result["profile"] as? [String: Any] {
                    if let notification = profile["Notification"] as? NSString {
                        Singletons.sharedInstance.isPushSettingsOn = notification.boolValue
                        userDefault.set(notification.boolValue, forKey: "DefaultNotificationSetting")
                    }
                }
                self.tblVw.reloadData()
            }
        }
    }
}

extension SettingsViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingCell
        cell.selectionStyle = .none
        cell.lblTitle.text = "Push Notification".localized
        cell.lblDesc.text = "Allow Push Notifications?".localized
        cell.lblTitle.font = UIFont.bold(ofSize: 20)
        cell.lblDesc.font = UIFont.regular(ofSize: 12)
        cell.btnSwitch.isSelected = Singletons.sharedInstance.isPushSettingsOn
        cell.btnSwitch.addTarget(self, action: #selector(switchClick(_:)), for: .touchUpInside)
        return cell
    }
    
}

class SettingCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnSwitch: UIButton!
   
}
