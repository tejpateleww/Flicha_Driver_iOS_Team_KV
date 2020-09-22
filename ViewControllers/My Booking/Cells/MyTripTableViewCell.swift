//
//  MyTripTableViewCell.swift
//  Pappea Driver
//
//  Created by EWW-iMac Old on 04/07/19.
//  Copyright © 2019 baps. All rights reserved.
//

import UIKit
import Foundation



class MyTripTableViewCell: UITableViewCell {
    @IBOutlet weak var cellContainerView: CustomView! {
        didSet {
            cellContainerView.isRounded = false
        }
    }
//    @IBOutlet weak var lblPickup: UILabel!
//    @IBOutlet weak var lblDropoff: UILabel!
//    @IBOutlet weak var lblName: UILabel!
//    @IBOutlet weak var lblBookin: UILabel!
//    @IBOutlet weak var lblDate: UILabel!
//    @IBOutlet var lblKM: UILabel!
    
//    @IBOutlet var imgVehicleModel: UIImageView!
   
    @IBOutlet weak var btnSendReceipt: UIButton!
//    @IBOutlet var lblModelName: ThemeLabel!
    @IBOutlet var lblBookingDate: ThemeLabel!
    @IBOutlet var lblPickup: ThemeLabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPriceTitle: ThemeLabel!
    @IBOutlet weak var lblPickupTitle: ThemeLabel!
    @IBOutlet var lblBookingId: ThemeLabel!

    @IBOutlet weak var imgVW: UIImageView!
    @IBOutlet var lblDropoff: ThemeLabel!
    @IBOutlet var lblDriverName: ThemeLabel!
    @IBOutlet weak var lblCancel: ThemeLabel!
    
    @IBOutlet weak var conVwAcceptHeight: NSLayoutConstraint!
    @IBOutlet weak var conVwAcceptWidth: NSLayoutConstraint!
    override func draw(_ rect: CGRect) {
        setup()
    }
    
    func setup(){
        selectionStyle = .none
//        cellContainerView.roundCorners([.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 5)
        btnSendReceipt.layer.cornerRadius = 5
        btnSendReceipt.backgroundColor = ThemeYellowColor
        btnSendReceipt.titleLabel?.font = UIFont.bold(ofSize: 15)
        lblPickupTitle.text = "Pick up".localized
//        btnSendReceipt.layer.borderColor = UIColor.white.cgColor
//        btnSendReceipt.layer.borderWidth = 1.5
//        btnSendReceipt.clipsToBounds = true
    }
    func hideAcceptRequestButton(isHide: Bool) {
        /*
        if isHide {
            if cellContainerView.shadowLayer !=  nil {
                cellContainerView.shadowLayer.removeFromSuperlayer()
                cellContainerView.shadowLayer = nil
            }
            cellContainerView.layoutSubviews()
            cellContainerView.layoutIfNeeded()
        }else {
            
            if cellContainerView.shadowLayer !=  nil {
                cellContainerView.shadowLayer.removeFromSuperlayer()
                cellContainerView.shadowLayer = nil
            }
//            guard cellContainerView.shadowLayer !=  nil else { return }
            
            cellContainerView.layoutSubviews()
            cellContainerView.layoutIfNeeded()
        }
          conVwAcceptHeight.constant =  isHide ? 0 : 30
        */
    }
}
