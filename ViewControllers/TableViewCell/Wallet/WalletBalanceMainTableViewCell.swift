//
//  WalletBalanceMainTableViewCell.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 23/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class WalletBalanceMainTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    
    @IBOutlet weak var lblTransferTitle: UILabel!
    
    @IBOutlet weak var lblTransferDateAndTime: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
     @IBOutlet weak var statusHeight: NSLayoutConstraint!  // 20.5
     @IBOutlet weak var lblStatus: UILabel!

}
