//
//  DriverListViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 30/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class DriverVehicleListViewController: UIViewController {

    @IBOutlet weak var imgCarRegistration: UIImageView!
    @IBOutlet weak var lblCarName: UILabel!
    @IBOutlet weak var lblCarRegistrationNumber: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setData()
        
        // Do any additional setup after loading the view.
    }
    
    func setData()
    {
        lblCarName.text = (((Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary)).object(forKey: "Vehicle") as! NSDictionary).object(forKey: "Company") as? String
        lblCarRegistrationNumber.text =  ((Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary).object(forKey: "Vehicle") as! NSDictionary).object(forKey: "VehicleRegistrationNo") as? String
        
        
        let strImageURL =  ((Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary).object(forKey: "Vehicle") as! NSDictionary).object(forKey: "VehicleImage") as! String
        
//        UtilityClass.setImage(url: strImageURL, imageView: imgCarRegistration)
        imgCarRegistration.sd_setShowActivityIndicatorView(true)
        
        

        imgCarRegistration.sd_setImage(with: URL(string: strImageURL), placeholderImage: nil, options: []) { (image, error, cacheType, url) in
            self.imgCarRegistration.sd_removeActivityIndicator()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
