//
//  DriverNewsTableViewCell.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 09/12/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class DriverNewsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var lblNewsTitle: UILabel!
 
    @IBOutlet weak var imgNews: UIImageView!
    
    @IBOutlet weak var lblNewsDescription: UILabel!
    
    @IBOutlet weak var viewNews: UIView!
    
}
