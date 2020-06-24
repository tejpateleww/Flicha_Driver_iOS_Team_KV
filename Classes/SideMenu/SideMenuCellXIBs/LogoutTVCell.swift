//
//  LogoutTVCell.swift
//  HJM
//
//  Created by EWW80 on 22/08/19.
//  Copyright © 2019 Raj iMac. All rights reserved.
//

import UIKit

class LogoutTVCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel! {
        didSet {
            lblTitle.text = "Logout".localized
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
                self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
