//
//  DeliverServiceTableViewCell.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 17/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class DeliverServiceTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewDetails.layer.cornerRadius = 3
        self.viewDetails.layer.borderWidth = 1
        self.viewDetails.layer.borderColor = UIColor.init(red: 169/255, green: 169/255, blue: 169/255, alpha: 1.0).cgColor
        
        self.viewDetails.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var lblDeliveryService: UILabel!
    
    @IBOutlet weak var btnTickMark: UIButton!
    
    
    

}
