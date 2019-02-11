//
//  DeliverServiceVC.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 16/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

@objc protocol getVehicleServiceIdAndNameDelegate {
    
    func didgetIdAndNameFromVehicleService(id: String, Name: String)
}
//protocol getEstimateFareForDispatchJobsNowDeliveryService {
//    
//    func didSelectVehicleModelNowDeliveryService()
//}

class DeliverServiceVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblSelectModel: UILabel!
    //-------------------------------------------------------------
    // MARK: - Global Declaration
    //-------------------------------------------------------------
    
    var aryData = NSArray()
    var selectedCells = NSMutableArray()
    
    weak var delegate: getVehicleServiceIdAndNameDelegate!
    
    var delegateForEstimate: getEstimateFareForDispatchJobs!
    
    var strId = String()
    var strType = String()
    
    var indexPathSample = NSIndexPath()
    
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewMain.layer.cornerRadius = 3
        viewMain.layer.masksToBounds = true
        btnOK.layer.cornerRadius = 3
        btnOK.layer.masksToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.allowsMultipleSelection = false
        indexPathSample = NSIndexPath(row: 23, section: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


    
    //-------------------------------------------------------------
    // MARK: - TableView Methods
    //-------------------------------------------------------------
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeliverServiceTableViewCell") as! DeliverServiceTableViewCell
        cell.selectionStyle = .none
        
        let dictData = aryData.object(at: indexPath.row) as! NSDictionary
        
        cell.lblDeliveryService .text = dictData.object(forKey: "Name") as? String
        cell.btnTickMark.setImage(UIImage(named: "iconCheckMarkUnSelected"), for: .normal)
        
        if (indexPathSample as IndexPath == indexPath)
        {
            
            cell.btnTickMark.setImage(UIImage.init(named: "iconCheckMarkSelected"), for: .normal)
            
            strId = dictData.object(forKey: "Id") as! String
            strType = dictData.object(forKey: "Name") as! String
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        indexPathSample = indexPath as NSIndexPath
        
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        return 65
        
    }
    
    
    
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    
    @IBOutlet weak var btnOK: UIButton!
    @IBAction func btnOK(_ sender: UIButton) {
     
        delegate.didgetIdAndNameFromVehicleService(id: strId, Name: strType)
//        delegateForEstimate.didSelectVehicleModel()
//        delegateForEstimateNow?.didSelectVehicleModelNow()
        delegateForEstimate?.didSelectVehicleModel()
        self.dismiss(animated: true, completion: nil)
 
    }

}
