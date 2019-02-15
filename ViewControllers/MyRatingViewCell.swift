//
//  MyFeedbackViewCell.swift
//  TEXLUXE-DRIVER
//
//  Created by Excellent WebWorld on 02/08/18.
//  Copyright © 2018 Excellent WebWorld. All rights reserved.
//

import UIKit
import FloatRatingView

class MyRatingViewCell: UITableViewCell {

    
    
    @IBOutlet weak var lblCommentTitle: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var viewCell: UIView!
    
    @IBOutlet var viewRating: HCSStarRatingView!
    @IBOutlet var lblDateTime: UILabel!
    
//    @IBOutlet var viewRating: FloatRatingView!//HCSStarRatingView!
    @IBOutlet var lblPassengerName: UILabel!
    
 
    
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
