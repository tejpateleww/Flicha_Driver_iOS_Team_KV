//
//  PastJobsListTableViewCell.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 15/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class PastJobsListTableViewCell: UITableViewCell {

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
    
    // First View height is : 86.5
    
    @IBOutlet var lblDateTime: UILabel!
    // Total cell Height is : 301.5
    @IBOutlet weak var lblGrandTotalTitle: UILabel!
    @IBOutlet weak var lblPaymentTypeInfo: UILabel!
    @IBOutlet weak var lblSubTotalTitle: UILabel!
    @IBOutlet weak var lblPassengerMail: UILabel!
    @IBOutlet weak var lblNightFare: UILabel!
    @IBOutlet weak var lblCarModes: UILabel!
    @IBOutlet weak var lbltripDuration: UILabel!
    @IBOutlet weak var lblDiscountInFo: UILabel!
    @IBOutlet weak var lblTripDistance: UILabel!
    @IBOutlet weak var lblDropTimeTitle: UILabel!
    @IBOutlet weak var lblpickUpTime: UILabel!
    @IBOutlet weak var lblPassengerNumTitle: UILabel!
    @IBOutlet weak var lblDropLocation: UILabel!
    @IBOutlet weak var lblPassengerName: UILabel!
    @IBOutlet weak var lblWaitingTimecosts: UILabel!
    @IBOutlet weak var lblTollFees: UILabel!
    @IBOutlet weak var lblWaitingTimes: UILabel!
    @IBOutlet weak var lblTripFare: UILabel!
    @IBOutlet weak var lblBookingId: UILabel!
    @IBOutlet weak var lblDropoffLocation: UILabel!
    @IBOutlet weak var lblDropoffLocationDescription: UILabel!
    @IBOutlet weak var lblBooingId: UILabel!
    @IBOutlet weak var viewAllDetails: UIView! // HEIGHT IS : 215
    @IBOutlet weak var lblPickupLocationDesc: UILabel!
    @IBOutlet weak var lblpassengerEmail: UILabel!
    @IBOutlet weak var lblTaX: UILabel!
    @IBOutlet weak var lblPassengerNo: UILabel!
    @IBOutlet weak var lblPickupTime: UILabel!
    @IBOutlet weak var lblDropOffTimeDesc: UILabel!
    @IBOutlet weak var lblTripDistanceDesc: UILabel!
    @IBOutlet weak var lbltripDurationDesc: UILabel!
    @IBOutlet weak var lblCarModelDesc: UILabel!
    @IBOutlet weak var lblNightFareDesc: UILabel!
    @IBOutlet weak var lblFlightNumInFo: UILabel!
    @IBOutlet weak var lblTripFareDesc: UILabel!
    @IBOutlet weak var lblWaitingTimeCostDesc: UILabel!
    @IBOutlet weak var lblTollFeeDesc: UILabel!
    @IBOutlet weak var lblTripStatusInfo: UILabel!
    @IBOutlet weak var lblBokingChargeDesc: UILabel!
    @IBOutlet weak var lblTaxDesc: UILabel!
    @IBOutlet weak var lblDiscountDesc: UILabel!
    @IBOutlet weak var lblSubTotalDesc: UILabel!
    @IBOutlet weak var lblGrandTotalDesc: UILabel!
    @IBOutlet weak var lblPaymentType: UILabel!
    @IBOutlet weak var lblFlightNumber: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblNotesTitle: UILabel!
    @IBOutlet weak var lblTripStatusDetail: UILabel!
    @IBOutlet weak var lblWaitingTime: UILabel!
    @IBOutlet var lblDispatcherName: UILabel!
    @IBOutlet var lblDispatcherEmail: UILabel!
    @IBOutlet var lblDispatcherNumber: UILabel!
    @IBOutlet var lblDispatcherNameTitle: UILabel!
    @IBOutlet var lblDispatcherEmailTitle: UILabel!
    @IBOutlet var lblDispatcherNumberTitle: UILabel!
    @IBOutlet var stackViewEmail: UIStackView!
    @IBOutlet var stackViewName: UIStackView!
    @IBOutlet var stackViewNumber: UIStackView!
    @IBOutlet weak var lblBookingFare: UILabel!
    
    @IBOutlet var viewCell: UIView!
    
    
    @IBOutlet weak var PickupTimeStackView: UIStackView!
    @IBOutlet weak var DropOffTimeStackView: UIStackView!
    @IBOutlet weak var DistanceTravelStackView: UIStackView!
    @IBOutlet weak var WaitingTimeStackView: UIStackView!
    @IBOutlet weak var WaitingTimeCostStackView: UIStackView!
    @IBOutlet weak var BookingFareStackView: UIStackView!
    @IBOutlet weak var TripFareStackView: UIStackView!
    @IBOutlet weak var TollFeesStackView: UIStackView!
    @IBOutlet weak var TaxStackView: UIStackView!
    @IBOutlet weak var SubTotalStackView: UIStackView!
    @IBOutlet weak var DiscountStackView: UIStackView!
    @IBOutlet weak var TotalStackView: UIStackView!
    @IBOutlet weak var PaymentTypeStackView: UIStackView!
    @IBOutlet weak var TripStatusStackView: UIStackView!
    
    
    
}
