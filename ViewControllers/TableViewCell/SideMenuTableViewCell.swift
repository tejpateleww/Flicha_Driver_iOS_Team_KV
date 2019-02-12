//
//  SideMenuTableViewCell.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 11/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet var btnLaungageChange: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // SideMenuIDriverProfile

    
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var lblDriverName: UILabel!
    @IBOutlet var lblContactNumber: UILabel!
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var btnUpdateProfile: UIButton!
    @IBOutlet weak var lblPaymentOption: UILabel!
    @IBOutlet weak var btnMyJob: UIButton!
    @IBOutlet weak var btnPaymentOption: UIButton!
    @IBOutlet weak var btnWallet: UIButton!
    @IBOutlet weak var btnMyRating: UIButton!
    @IBOutlet weak var btnInviteFriend: UIButton!
    
    @IBOutlet weak var viewMyJobs: UIView!
    
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var btnSupport: UIButton!
    
    @IBOutlet var lblLaungageName: UILabel!
    @IBOutlet weak var btnLegal: UIButton!
    @IBOutlet weak var viewWallet: UIView!
    @IBOutlet weak var viewPaymentOption: UIView!
    @IBOutlet weak var btnTripToDestination: UIButton!
    @IBOutlet weak var lblMyJobs: UILabel!
    @IBOutlet weak var lblMyRaitng: UILabel!
    @IBOutlet weak var iconPaymentOption: UIButton!
    @IBOutlet weak var lblLegal: UILabel!
    
    @IBOutlet weak var iconInviteFrnd: UIImageView!
    @IBOutlet weak var iconRating: UIImageView!
    @IBOutlet weak var iconWallet: UIImageView!
    @IBOutlet weak var lblWallet: UILabel!
    @IBOutlet weak var lblSupport: UILabel!
    
    @IBOutlet weak var iconLegal: UIImageView!
    @IBOutlet weak var iconSupport: UIImageView!
    
    @IBOutlet weak var imgLogout: UIImageView!
    @IBOutlet weak var lblInviteFrnd: UILabel!
    @IBOutlet weak var iconTripToDestination: UIImageView!
    // SideMenuItemsList
    @IBOutlet var imgItems: UIImageView!
    @IBOutlet var lblItemNames: UILabel!
    @IBOutlet weak var lblGmail: UILabel!
    @IBOutlet weak var lblTripToDestination: UILabel!
    @IBOutlet weak var btnLogOuts: UIButton!
    
    @IBOutlet weak var imgJob: UIImageView!
//    @IBOutlet weak var lblMyJob: UILabel!

}
