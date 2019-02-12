//
//  CarAndTaxiesVC.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 16/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

@objc protocol getVehicleIdAndNameDelegate {
    
    func didgetIdAndName(id: String, Name: String)
}

protocol getEstimateFareForDispatchJobsNow {
    
    func didSelectVehicleModelNow()
}

class CarAndTaxiesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var lblSelectModel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var lblSelectCarType: UILabel!
    
    //-------------------------------------------------------------
    // MARK: - Global Declaration
    //-------------------------------------------------------------
    var aryChooseCareModel = [String]()
    var aryChooseCarName = [String]()
    var aryData = NSArray()
//    var selectedCells = NSMutableArray()
    
    var selectedCells:[Int] = []
    
    weak var delegate: getVehicleIdAndNameDelegate!

    var delegateForEstimate: getEstimateFareForDispatchJobs!
    var delegateForEstimateNow: getEstimateFareForDispatchJobsNow!

    var strId = String()
    var strType = String()
    
    var indexPathSample = NSIndexPath()
  
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        viewMain.layer.cornerRadius = 8
        viewMain.layer.masksToBounds = true

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
//        tableView.separatorStyle = .none
        
        tableView.allowsMultipleSelection = false
        indexPathSample = NSIndexPath(row: 23, section: 0)
        
        
        print(aryData.count)
        
        if Singletons.sharedInstance.isFromRegistration == false
        {
            for i in 0..<self.aryData.count
            {
                let vehicleID = ((self.aryData as NSArray).object(at: i) as! NSDictionary).object(forKey: "Id") as! String
                let anotherVehicleID : Int = Int(vehicleID)!
                for j in 0..<Singletons.sharedInstance.arrVehicleClass.count
                {
                    if (anotherVehicleID == (Singletons.sharedInstance.arrVehicleClass.object(at: j)) as! Int)
                    {
                        self.aryChooseCareModel.append(((self.aryData as NSArray).object(at: i) as! NSDictionary).object(forKey: "Id") as! String)
                        self.aryChooseCarName.append(((self.aryData as NSArray).object(at: i) as! NSDictionary).object(forKey: "Name") as! String)
                        self.selectedCells.append(i)
                    }
                }
                
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        btnOK.setTitle("Done".localized, for: .normal)
        lblSelectModel.text = "Select Card".localized
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    //-------------------------------------------------------------
    // MARK: - TableView Methods
    //-------------------------------------------------------------
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarAndTaxiesTableViewCell") as! CarAndTaxiesTableViewCell
        cell.selectionStyle = .none
        
        
//        cell.lblCarModelClass.text = "".localized
//        cell.lblCarModelDescription.text = "".localized
        
        let dictData = aryData.object(at: indexPath.row) as! NSDictionary
        
        cell.lblCarModelClass.text = dictData.object(forKey: "Name") as? String
//        cell.lblCarModelDescription.text = "".localized
        //dictData.object(forKey: "Description") as? String
        
        cell.btnTickMark.imageView?.contentMode = .scaleAspectFit
        cell.btnTickMark.setImage(UIImage.init(named: "Unchecked"), for: .normal)

        if selectedCells.count != 0
        {
            print(selectedCells)
            print(indexPath.row)
            
            if self.selectedCells.contains(indexPath.row)
            {
                cell.btnTickMark.setImage(UIImage.init(named: "checked"), for: .normal)
            }
            else
            {
                cell.btnTickMark.setImage(UIImage.init(named: "Unchecked"), for: .normal)
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

        let dictData = aryData.object(at: indexPath.row) as! NSDictionary
        
        if self.selectedCells.count == 3
        {
            if self.selectedCells.contains(indexPath.row) {
                self.aryChooseCareModel.remove(at: self.selectedCells.index(of: indexPath.row)!)
                self.aryChooseCarName.remove(at: self.selectedCells.index(of: indexPath.row)!)
                self.selectedCells.remove(at: self.selectedCells.index(of: indexPath.row)!)
            }
            else
            {
                let sb = Snackbar()
                sb.createWithAction(text: "You can select only three types.", actionTitle: "DISMISS", action: { print("Button is push") })
                sb.show()
            }
            
        }
        else
        {
            if self.selectedCells.contains(indexPath.row)
            {
                self.aryChooseCareModel.remove(at: self.selectedCells.index(of: indexPath.row)!)
                self.aryChooseCarName.remove(at: self.selectedCells.index(of: indexPath.row)!)
                self.selectedCells.remove(at: self.selectedCells.index(of: indexPath.row)!)
            }
            else {
                self.selectedCells.append(indexPath.row)
                self.aryChooseCareModel.append(dictData["Id"] as! String)
                self.aryChooseCarName.append(dictData["Name"] as! String)
            }
        }
        
        tableView.reloadData()
       
    }

    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------

    @IBOutlet weak var btnOK: UIButton!
    @IBAction func btnOK(_ sender: UIButton)
    {
 
        let joined = aryChooseCareModel.joined(separator: ",")
        UserDefaults.standard.set(joined, forKey: RegistrationFinalKeys.kVehicleClass)
        
        Singletons.sharedInstance.vehicleClass = joined
        
        let joinedName = aryChooseCarName.joined(separator: ",")
        UserDefaults.standard.set(joinedName, forKey: RegistrationFinalKeys.kCarThreeTypeName)
        
        if strId != nil
        {
            delegate?.didgetIdAndName(id: strId, Name: strType)
        }
        if Singletons.sharedInstance.isFromRegistration == true
        {
            NotificationCenter.default.post(name: Notification.Name("setCarType"), object: nil)
        }
        else
        {
            NotificationCenter.default.post(name: Notification.Name("setCarTypeUpdate"), object: nil)
        }
        
//            delegateForBookLater.didgetIdAndName(id: strId, Name: strType)
//            delegateForEstimateNow?.didSelectVehicleModelNow()
            delegateForEstimate?.didSelectVehicleModel()
            self.dismiss(animated: true, completion: nil)
  
    }
    
}
