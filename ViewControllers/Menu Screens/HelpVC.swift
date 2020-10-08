//
//  HelpVC.swift
//  Flicha-Driver
//
//  Created by EWW073 on 16/04/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class HelpVC: BaseViewController {
   
    // ----------------------------------------------------
    // MARK: - --------- Outlets ---------
    // ----------------------------------------------------
    
    @IBOutlet weak var tblHelp: UITableView!
    var arrData = [[String: Any]]()
    // ----------------------------------------------------
    // MARK: - --------- Global Variables ---------
    // ----------------------------------------------------
    
    
    
    // ----------------------------------------------------
    // MARK: - --------- Lifecycle Methods ---------
    // ----------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblHelp.delegate = self
        tblHelp.dataSource = self
        self.setNavigationBarInViewController(controller: self, naviTitle: "Help".localized, leftImage: iconBack, rightImages: [], isTranslucent: false)
        getFaqList()
    }
    func getFaqList(){
        webserviceForFAQList("" as AnyObject) { (result, status) in
            print(result)
            if let data = result["data"] as? [[String: Any]] {
                self.arrData = data
                self.tblHelp.reloadData()
            }
        }
    }
}

// ----------------------------------------------------
// MARK: - --------- Tableview Delegate Methods ---------
// ----------------------------------------------------

extension HelpVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "HelpTableViewCell") as! HelpTableViewCell
        let dict = arrData[indexPath.row]
        cell.txt.text = dict["Question"] as? String ?? ""
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:HelpDetailVC = UIViewController.viewControllerInstance(storyBoard: .Main)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
