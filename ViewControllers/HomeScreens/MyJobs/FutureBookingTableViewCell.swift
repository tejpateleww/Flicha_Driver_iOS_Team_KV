//
//  FutureBookingTableViewCell.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 16/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class FutureBookingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btnAction.layer.cornerRadius = 5
        btnAction.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
   
    @IBOutlet var lblDate: UILabel!
    @IBOutlet weak var lblPassengerName: UILabel!
    @IBOutlet weak var lblFlighNum: UILabel!
    
  
    @IBOutlet var viewCell: UIView!
    @IBOutlet weak var lblNoteas: UILabel!
    @IBOutlet weak var lblpeymentType: UILabel!
    @IBOutlet weak var lblCarMoidel: UILabel!
    @IBOutlet weak var lblTripDistance: UILabel!
    @IBOutlet weak var lblDropLoactionTilte: UILabel!
    @IBOutlet weak var lblPickUpLocation: UILabel!
    //    @IBOutlet weak var lblTimeAndDateAtTop: UILabel!
    @IBOutlet weak var lblPickUpTimeTitle: UILabel!
    @IBOutlet weak var lblPickupTimeValue: UILabel!
    
    
    @IBOutlet weak var lblBokingTitle: UILabel!
    @IBOutlet weak var lblBookingId: UILabel!
    @IBOutlet weak var lblDropOffLocationDesc: UILabel!
    @IBOutlet weak var lblDateAndTime: UILabel!
    @IBOutlet weak var lblPAssengerNum: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var viewSecond: UIView!
    @IBOutlet weak var lblPickupLocation: UILabel!
    @IBOutlet weak var lblPassengerNoDesc: UILabel!
    @IBOutlet weak var lblTripDestanceDesc: UILabel!
    @IBOutlet weak var lblCarModelDesc: UILabel!
    @IBOutlet weak var lblPaymentType: UILabel!
    @IBOutlet weak var lblFlightNumber: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet var lblDispatcherName: UILabel!
    @IBOutlet var lblDispatcherEmail: UILabel!
    @IBOutlet var lblDispatcherNumber: UILabel!
    @IBOutlet var lblDispatcherNameTitle: UILabel!
    @IBOutlet var lblDispatcherEmailTitle: UILabel!
    @IBOutlet var lblDispatcherNumberTitle: UILabel!
    @IBOutlet var stackViewEmail: UIStackView!
    @IBOutlet var stackViewName: UIStackView!
    @IBOutlet var stackViewNumber: UIStackView!
}
