//
//  CarAndTaxiesTableViewCell.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 17/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class CarAndTaxiesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        self.viewBackground.layer.cornerRadius = 3
//        self.viewBackground.layer.borderWidth = 1
//        self.viewBackground.layer.borderColor = UIColor.init(red: 169/255, green: 169/255, blue: 169/255, alpha: 1.0).cgColor
//
//        self.viewBackground.layer.masksToBounds = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var lblCarModelClass: UILabel!
    @IBOutlet weak var lblCarModelDescription: UILabel!
    
    @IBOutlet weak var btnTickMark: UIButton!
    
    @IBOutlet weak var viewBackground: UIView!
    
    
    
    
    
    
    
    
    

}
