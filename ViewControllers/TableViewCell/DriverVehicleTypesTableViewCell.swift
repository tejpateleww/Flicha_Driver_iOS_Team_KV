//
//  DriverVehicleTypesTableViewCell.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 11/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class DriverVehicleTypesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if (classView != nil )
        {
//            classView.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 1, scale: true)
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
    }
    
    // section 1
    
    @IBOutlet var lblTopDetails: UILabel!
    
    
    
    // section 2
    
    @IBOutlet var lblTitlesOFClass: UILabel!
    @IBOutlet var lblClassDetails: UILabel!
    @IBOutlet var btnCheckMark: UIButton!
    
    
    @IBOutlet var classView: UIView!
    
    
    // section 3
    
    @IBOutlet var btnNext: UIButton!
    
    
    
    
    
    
    
    

}
