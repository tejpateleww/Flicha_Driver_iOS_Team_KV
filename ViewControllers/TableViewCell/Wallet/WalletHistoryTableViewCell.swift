//
//  WalletHistoryTableViewCell.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 28/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class WalletHistoryTableViewCell: UITableViewCell {

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
    
    @IBOutlet weak var lblDateOfTransfer: UILabel!
    @IBOutlet weak var lblTransferStatus: UILabel!
    @IBOutlet weak var lblTransferStatusHeight: NSLayoutConstraint! // 17
    
    @IBOutlet weak var lblAmount: UILabel!
    
    
    

}
