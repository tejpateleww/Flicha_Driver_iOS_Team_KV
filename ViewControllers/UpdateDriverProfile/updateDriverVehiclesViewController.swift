//
//  updateDriverVehiclesViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 28/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class updateDriverVehiclesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var strTitle = String()
    var strTermsAndCondition = String()
    var strSelectVehicle = String()
    
    var aryVehicles = [String]()
    var selectedCells:[Int] = []
    var intCarModel: [Int] = []
    
    var userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        tableView.tableFooterView = UIView()

        strTitle = "Please select which delivery classes you are a part of. You must be 18 years of age or over as per"
        strTermsAndCondition = "Driver Terms and Conditions."
        strSelectVehicle = "Select up to 3 vehicles."
        
        aryVehicles = ["Bicycle", "Motorbike", "Car Delivery", "Van / Trays", "2T truck", "3T truck"]
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
        
//        tableView.backgroundColor = UIColor.white
        
        webserviceForVehicleTypes()
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MoveToNext()
        webserviceForVehicleTypes()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------

    
    
    @IBOutlet var tableView: UITableView!
    
    
    
    //-------------------------------------------------------------
    // MARK: - Table View Methods
    //-------------------------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            if strTitle == ""
            {
                return 0
            }
            return 1
        }
        else
        {
            
            if self.aryData.count == 0
            {
                return 0
            }
            else
            {
                return self.aryData.count
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellTop = tableView.dequeueReusableCell(withIdentifier: "updateDriverVehiclesTableViewCellTop") as! updateDriverVehiclesViewControllerTableViewCell
        let cellDetails = tableView.dequeueReusableCell(withIdentifier: "updateDriverVehiclesTableViewCellData") as! updateDriverVehiclesViewControllerTableViewCell
        
        cellTop.selectionStyle = .none
        cellDetails.selectionStyle = .none
        cellTop.btnDriverTermsandConditions.setTitle("Driver term and condition.".localized, for: .normal)
        cellTop.lblSelectupTo3Vehicles.text = "Select up to three vehicles." .localized
        
        
        if indexPath.section == 0 {
            
            cellTop.lblTopDetails.text = strTitle
            cellTop.btnDriverTermsandConditions.setTitle(strTermsAndCondition, for: .normal)
            cellTop.lblSelectupTo3Vehicles.text = strSelectVehicle
            
            return cellTop
        } else if indexPath.section == 1 {
            
            let dictData = aryData[indexPath.row]
            
//            cellDetails.backgroundColor = UIColor.white
            cellDetails.lblVehicleName.text = dictData["Name"] as? String
            //            cellDetails.dataView.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 1, scale: true)
            
            cellDetails.dataView.layer.borderWidth = 1
            cellDetails.dataView.layer.masksToBounds = true
//            cellDetails.dataView.layer.borderColor = UIColor.gray.cgColor
            
            if (self.selectedCells.contains(indexPath.row))
            {
                cellDetails.btnCheckMark.setImage(UIImage(named: "iconCheckMarkSelected"), for: .normal)
            }
            else
            {
                cellDetails.btnCheckMark.setImage(UIImage(named: "iconCheckMarkUnSelected"), for: .normal)
            }
            return cellDetails
        } else {
            return UITableViewCell()
        }
        
    }
    
    var aryChooseCareModel = [String]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.selectedCells.count == 3
        {
            if self.selectedCells.contains(indexPath.row) {
                self.aryChooseCareModel.remove(at: self.selectedCells.index(of: indexPath.row)!)
                self.selectedCells.remove(at: self.selectedCells.index(of: indexPath.row)!)
            }
            else
            {
                let sb = Snackbar()
                sb.createWithAction(text: "You can select only three types.", actionTitle: "DISMISS", action: { print("Button is push") })
                sb.show()
            }
            
        } else {
            if self.selectedCells.contains(indexPath.row) {
                self.aryChooseCareModel.remove(at: self.selectedCells.index(of: indexPath.row)!)
                self.selectedCells.remove(at: self.selectedCells.index(of: indexPath.row)!)
            } else {
                self.selectedCells.append(indexPath.row)
                self.aryChooseCareModel.append(aryCarModel[indexPath.row])
            }
        }
         MoveToNext()
        
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 {
            return 65
        }
        else if indexPath.section == 2 {
            return 65
        }
        return UITableView.automaticDimension
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    //    func giveShadow()
    //    {
    //        BicycleView.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 1, scale: true)
    //        motorBikeView.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 1, scale: true)
    //        CarDeliveryView.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 1, scale: true)
    //        VanView.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 1, scale: true)
    //        T2View.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 1, scale: true)
    //        T3View.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 1, scale: true)
    //    }
    
    func MoveToNext()
    {
        let joined = aryChooseCareModel.joined(separator: ",")
//        userDefault.set(joined, forKey: RegistrationFinalKeys.kCarModel)
        
        Singletons.sharedInstance.vehicleClass = joined
        
        
    }
    // ------------------------------------------------------------
    
    
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    
    var aryData = [[String:AnyObject]]()
    var aryCarModel = [String]()
    
    func webserviceForVehicleTypes()
    {
        webserviceForVehicalModelList("" as AnyObject) { (result, status) in
            
            if (status)
            {
//                print(result)
                
                self.aryData = result["delivery_services"] as! [[String:AnyObject]]
                
                for (i,_) in self.aryData.enumerated()
                {
                    var dataOFCars = self.aryData[i]
                    let CarModelID = dataOFCars["Id"] as! String
                    self.aryCarModel.append(CarModelID)
                }
                
                self.gettingSelectedVehiclesForDrivers()
                self.tableView.reloadData()
                
                //cars_and_taxi
            }
            else
            {
//                print(result)
                if let res = result as? String {
                    UtilityClass.showAlert(appName.kAPPName, message: res, vc: self)
                }
                else if let resDict = result as? NSDictionary {
                    UtilityClass.showAlert(appName.kAPPName, message: resDict.object(forKey: "message") as! String, vc: self)
                }
                else if let resAry = result as? NSArray {
                    UtilityClass.showAlert(appName.kAPPName, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: "message") as! String, vc: self)
                }
            }
        }
    }
    
    func gettingSelectedVehiclesForDrivers()
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
                    self.selectedCells.append(i)
                }
            }
            
        }
        
    }

}

