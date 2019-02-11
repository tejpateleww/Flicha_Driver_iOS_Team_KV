//
//  PendingJobsListTableViewCell.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 15/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class PendingJobsListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnStartTrip.layer.cornerRadius = 5
        btnStartTrip.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    // total Cell Height is 158.5
    
    // First View height is 81
    @IBOutlet weak var lblBookingId: UILabel!
    
    @IBOutlet var lblBookingIDTitle: UILabel!
    @IBOutlet var lblPickupLocationTitle: UILabel!
    @IBOutlet weak var lblPickUpLocation: UILabel!
    @IBOutlet weak var btnStartTrip: UIButton!
    
    @IBOutlet var lblDropOffLoationTitle: UILabel!
    @IBOutlet weak var lblDispatcherEmailTitle: UILabel!
    @IBOutlet weak var lblPaymentTypeTitle: UILabel!
    
    @IBOutlet weak var lblPassengerName: UILabel!
 
    @IBOutlet var lblTripDetails: UILabel!
    @IBOutlet var lblTripDetailsTitle: UILabel!
    @IBOutlet weak var lblFlightNumTitle: UILabel!
    @IBOutlet weak var lblDropoffLocationDescription: UILabel!
    
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var lblPickupTimeTitle: UILabel!
    @IBOutlet var lblPassengerNoTitle: UILabel!
    @IBOutlet var lblPassengerEmailTitle: UILabel!
    @IBOutlet weak var lblCarModelTitle: UILabel!
    @IBOutlet weak var lblDateAndTime: UILabel!
    
    @IBOutlet weak var lblNotesTitle: UILabel!
    @IBOutlet weak var viewAllDetails: UIView! // Height is 72
    
    @IBOutlet weak var lblpassengerEmailDesc: UILabel!
    @IBOutlet weak var lblPassengerNoDesc: UILabel!
    @IBOutlet weak var lblPickupTimeDesc: UILabel!
    @IBOutlet weak var lblCarModelDesc: UILabel!
    @IBOutlet weak var lblFlightNumber: UILabel!
  
    @IBOutlet var viewCell: UIView!
    @IBOutlet var lblDispatcherNameTitle: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet var lblDispatcherName: UILabel!
    @IBOutlet var lblDispatcherEmail: UILabel!
    @IBOutlet var lblDispatcherNumber: UILabel!
    @IBOutlet var stackViewEmail: UIStackView!
    @IBOutlet var stackViewName: UIStackView!
    @IBOutlet var stackViewNumber: UIStackView!
    
    @IBOutlet var lblPaymentType: UILabel!
    
//    @IBOutlet weak var lblDispatcherNum: UILabel!
//    @IBOutlet weak var lblPassengerEmailInfo: UILabel!
//    
//    @IBOutlet weak var lblDropLocationInfo: UILabel!
//    
//    @IBOutlet weak var lblDispathcherName: UILabel!
//    
//    @IBOutlet weak var lblPAssengerNum: UILabel!
//    @IBOutlet weak var lblBookingIdDetails: UILabel!
//    
//    @IBOutlet weak var lblDEscriptiondetail: UILabel!
//    @IBOutlet weak var lblPickupDetail: UIStackView!
//    @IBOutlet weak var lblPickUpTime: UILabel!
//    @IBOutlet weak var lblPickupLocationDesc: UILabel!
//    
//    @IBOutlet weak var lblTripDistanceTitle: UILabel!

    
}
