//
//  LanguageTVCell.swift
//  HJM
//
//  Created by EWW80 on 22/08/19.
//  Copyright © 2019 Raj iMac. All rights reserved.
//

import UIKit

 protocol SetLanguageDelegate {
    func setLanguage(Language:String)
}

class LanguageTVCell: UITableViewCell {

    @IBOutlet var imgMenu: UIImageView!
   
    @IBOutlet var btnLanguage: UIButton!
    @IBOutlet var lblMenuItem: UILabel!
    
    var Delegate:SetLanguageDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.btnLanguage.isUserInteractionEnabled = false
    }
    
    @IBAction func btnLangChange(_ sender: UIButton) {
        /*
        if sender.isSelected == true {
            self.btnLanguage.isSelected = false
            userDefault.set("en", forKey: "language")
            self.Delegate.setLanguage(Language: "en")
        } else if sender.isSelected == false {
            self.btnLanguage.isSelected = true
            userDefault.set("ab", forKey: "language")
            self.Delegate.setLanguage(Language: "ab")
           
        }
        userDefault.synchronize()
        */
//        (UIApplication.shared.delegate as? AppDelegate)?.setLanguage()
    }
    


   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
