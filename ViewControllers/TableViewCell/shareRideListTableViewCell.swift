//
//  shareRideListTableViewCell.swift
//   TenTaxi-Driver
//
//  Created by Excelent iMac on 22/06/18.
//  Copyright © 2018 Excellent Webworld. All rights reserved.
//

import UIKit

class shareRideListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var viewDetails: UIView!
    
    @IBOutlet weak var lblPickUpLocation: UILabel!
    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var lblBookingID: UILabel!
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDropLocation: UILabel!
    @IBOutlet weak var lblDropoffAddress: UILabel!
    
    @IBOutlet weak var lblPickupAddress: UILabel!
    
    @IBOutlet weak var lblPaymentTypeDetail: UILabel!
    @IBOutlet weak var lblStatusDetail: UILabel!
    @IBOutlet weak var lblPaymentType: UILabel!
    @IBOutlet weak var lblStatusInfo: UILabel!
    
    @IBOutlet weak var lblPaymentTypeInFo: UILabel!
    
    @IBOutlet weak var lblNumberOfPassengers: UILabel!
    
    @IBOutlet weak var btnCallToPassenger: UIButton!
    
    @IBOutlet weak var btnTrackYourTrip: UIButton!
    
    

}
