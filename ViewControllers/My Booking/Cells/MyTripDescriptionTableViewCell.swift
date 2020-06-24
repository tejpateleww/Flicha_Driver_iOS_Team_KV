//
//  MyTripDescriptionTableViewCell.swift
//  Pappea Driver
//
//  Created by EWW-iMac Old on 04/07/19.
//  Copyright © 2019 baps. All rights reserved.
//

import UIKit

class MyTripDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var cellContainerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    func setup() {
        selectionStyle = .none
    }

}

class FooterTableViewCell: UITableViewCell {
    @IBOutlet weak var cellContainerView: UIView!
    func setup(){
        selectionStyle = .none
        cellContainerView.roundCorners([.bottomRight,.bottomLeft], radius: 12)
    }
    override func draw(_ rect: CGRect) {
         setup()
    }
    
}
