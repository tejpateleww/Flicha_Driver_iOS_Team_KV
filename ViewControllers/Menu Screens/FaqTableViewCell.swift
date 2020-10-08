//
//  FaqTableViewCell.swift
//  Flicha-Driver
//
//  Created by EWW074 - Sj's iMAC on 05/10/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class FaqTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_Question: UILabel!
    @IBOutlet weak var lbl_Answer: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
