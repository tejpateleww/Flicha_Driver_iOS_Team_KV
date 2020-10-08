//
//  HelpDetailVC.swift
//  Flicha-Driver
//
//  Created by Apple on 22/05/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class HelpDetailVC: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    var faqArray : [FaqModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarInViewController(controller: self, naviTitle: "Help".localized, leftImage: iconBack, rightImages: [], isTranslucent: false)
        wscall()
        
        // Do any additional setup after loading the view.
    }
    
    func wscall() {
        let  paramer: [String: Any] = [:]
        
        webserviceForFAQList(paramer as AnyObject) { (result, status) in
            print(result)
            
            let data = (result as! [String:Any])["data"] as! [[String : Any]]
            
            data.forEach { (dict) in
                let newModal = FaqModel(dict: dict)
                self.faqArray.append(newModal)
            }
            
            print(self.faqArray)
            self.tblView.reloadData()
            
        }
    }
    
}

extension HelpDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FaqTableViewCell", for: indexPath) as! FaqTableViewCell
        
        let currentRowDict = faqArray[indexPath.row]
        
        cell.lbl_Question.text = currentRowDict.que
        cell.lbl_Answer.text = currentRowDict.ans
        
        return cell
    }
}

struct FaqModel {
    
    var id : String = ""
    var userType : String = ""
    var que : String = ""
    var ans : String = ""
    
    init(dict : [String : Any]) {
        
        self.id = dict["Id"] as! String
        self.userType = dict["UserType"] as! String
        self.que = dict["Question"] as! String
        self.ans = dict["Answer"] as! String
    }
}
