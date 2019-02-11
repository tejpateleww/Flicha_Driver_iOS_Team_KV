//
//  DispatchJobsViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 12/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class DispatchJobsViewController: ParentViewController
{

    
    @IBOutlet var btnBookNow: UIButton!
    
    @IBOutlet var btnBookLater: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        btnBookNow.layer.cornerRadius = btnBookNow.frame.size.height/2
        btnBookNow.layer.masksToBounds = true
        
        btnBookLater.layer.cornerRadius = btnBookLater.frame.size.height/2
        btnBookLater.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
