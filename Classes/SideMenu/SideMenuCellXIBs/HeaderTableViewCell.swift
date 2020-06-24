//
//  HeaderTableViewCell.swift
//  HJM
//
//  Created by EWW80 on 21/08/19.
//  Copyright © 2019 Raj iMac. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    // ----------------------------------------------------
    // MARK: -Outlets
    // ----------------------------------------------------
    @IBOutlet var lblUserMail: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var imgUserProfile: UIImageView!
    
    // ----------------------------------------------------
    // MARK: -ViewLifeCycle
    // ----------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
         self.selectionStyle = .none
        
       
        imgUserProfile.layer.cornerRadius = imgUserProfile.frame.height / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
