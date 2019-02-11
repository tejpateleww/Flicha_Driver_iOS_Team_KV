//
//  DriverVehiclesTableViewCell.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 11/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class DriverVehiclesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if dataView != nil
        {
        
//            dataView.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 1, scale: true)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // section 1
    @IBOutlet var lblTopDetails: UILabel!
    @IBOutlet var btnDriverTermsandConditions: UIButton!
    @IBOutlet var lblSelectupTo3Vehicles: UILabel!
    
    
    
    // section 2
    
    @IBOutlet var dataView: UIView!
    @IBOutlet var lblVehicleName: UILabel!
    @IBOutlet var btnCheckMark: UIButton!
    
    
    // section 3
    
    @IBOutlet var btnNext: UIButton!
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
