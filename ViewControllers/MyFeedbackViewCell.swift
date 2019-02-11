//
//  MyFeedbackViewCell.swift
//  TanTaxi-Driver
//
//  Created by excellent Mac Mini on 01/11/18.
//  Copyright © 2018 Excellent Webworld. All rights reserved.
//

import UIKit
import FloatRatingView

class MyFeedbackViewCell: UITableViewCell {

    
//
    @IBOutlet var viewCell: UIView!
//
    @IBOutlet var lblDateTime: UILabel!

    @IBOutlet var viewRatings: HCSStarRatingView!
    @IBOutlet var lblPassengerName: UILabel!

    @IBOutlet var lblComments: UILabel!

    @IBOutlet var lblPickUpAddress: UILabel!

    @IBOutlet var lblDropUpAddress: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
