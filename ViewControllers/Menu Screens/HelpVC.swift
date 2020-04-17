//
//  HelpVC.swift
//  Flicha-Driver
//
//  Created by EWW073 on 16/04/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {
   
    // ----------------------------------------------------
    // MARK: - --------- Outlets ---------
    // ----------------------------------------------------
    
    @IBOutlet weak var tblHelp: UITableView!
    
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
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "HelpTableViewCell") as! HelpTableViewCell
        cell.txt.text = "Lorem Ipsum is simply dummy"
        cell.selectionStyle = .none
        return cell
    }
}
