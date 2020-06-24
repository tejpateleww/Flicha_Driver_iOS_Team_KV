//
//  MenuCell.swift
//  HJM
//
//  Created by EWW80 on 21/08/19.
//  Copyright © 2019 Raj iMac. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    // MARK: -Outlets
    
    @IBOutlet var lblMenu: UILabel!
    @IBOutlet var imgMenu: UIImageView!
    @IBOutlet var rightImgMenu: UIImageView!
    
    @IBOutlet weak var conRightHeight: NSLayoutConstraint!
    @IBOutlet weak var conLeftHeight: NSLayoutConstraint!

    // MARK: -LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
  
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
