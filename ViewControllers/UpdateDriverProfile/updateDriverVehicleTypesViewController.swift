//
//  updateDriverVehicleTypesViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 28/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class updateDriverVehicleTypesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    var aryOfTitles = [String]()
    var aryyOfDetails = [String]()
    var strOFTopLabel = String()
    var sbView = UIView()
    var ShadowSize = CGSize()
    
    var aryChooseCareModel = [String]()
    
    var aryData = [[String:AnyObject]]()
    var aryCarModel = [String]()
    
    var arrSelectedCarModels = NSMutableArray()
    
    var selectedCells:[Int] = []
    
    var intCarModel: [Int] = []
    var userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strOFTopLabel = "Please select which vehicle classes you are a part of. Select up to 3 classes of 4-door vehicles. You must be 21 years of age or over."
        
        ShadowSize = CGSize(width: 1, height: 1)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
//        tableView.backgroundColor = UIColor.clear
        
//        tableView.tableFooterView = UIView()
      
//        webserviceForVehicleTypes()
        
        //         giveShadow()
    }
    
    
    func setupVehicleSelection()
    {
//        if(Singletons.sharedInstance.arrVehicleClass != nil)
//        {
//            self.selectedCells = Singletons.sharedInstance.arrVehicleClass as! [Int]
            webserviceForVehicleTypes()
            tableView.reloadData()
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MoveToNext()
//        webserviceForVehicleTypes()
    }
    
    
    
    @IBOutlet var tableView: UITableView!
    
    //-------------------------------------------------------------
    // MARK: - Table View Methods
    //-------------------------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            if strOFTopLabel == "" {
                return 0
            }
            return 1
        }
        else {
            
            if aryData.count == 0
            {
                return 0
            }
            return aryData.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cellTop = tableView.dequeueReusableCell(withIdentifier: "updateDriverVehicleTypesTOP") as! updateDriverVehicleTypesViewControllerTableViewCell
        let cellDetails = tableView.dequeueReusableCell(withIdentifier: "updateDriverVehicleTypesData") as! updateDriverVehicleTypesViewControllerTableViewCell
        
        
        cellTop.selectionStyle = .none
        cellDetails.selectionStyle = .none
     
        
        //        cellDetails.layoutIfNeeded()
        
        //        tableView.layoutIfNeeded()
        
        
        if indexPath.section == 0 {
            
            return cellTop
        } else if indexPath.section == 1 {
            
            let dictData = aryData[indexPath.row]
            
            cellDetails.classView.layer.borderWidth = 1
            cellDetails.classView.layer.masksToBounds = true
//            cellDetails.classView.layer.borderColor = UIColor.gray.cgColor
            
//            cellDetails.backgroundColor = UIColor.white
            cellDetails.lblTitlesOFClass.text = dictData["Name"] as? String
            cellDetails.lblClassDetails.text = dictData["Description"] as? String
            //            cellDetails.classView.dropShadow(color: .gray, opacity: 1, offSet: ShadowSize, radius: 1, scale: true)
            
            if (self.selectedCells.contains(indexPath.row))
            {
                cellDetails.btnCheckMark.setImage(UIImage(named: "iconCheckMarkSelected"), for: .normal)
            }
            else
            {
                cellDetails.btnCheckMark.setImage(UIImage(named: "iconCheckMarkUnSelected"), for: .normal)
            }
            //            cellDetails.accessoryType = self.selectedCells.contains(indexPath.row) ? .checkmark : .none
            
            return cellDetails
        } else {
            return UITableViewCell()
        }
        
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if self.selectedCells.count == 3
        {
            if self.selectedCells.contains(indexPath.row) {
                self.aryChooseCareModel.remove(at: self.selectedCells.index(of: indexPath.row)!)
                self.selectedCells.remove(at: self.selectedCells.index(of: indexPath.row)!)
                
            }
            else
            {
                let ValidationAlert = UIAlertController(title: "App Name".localized, message: "You can only select three types".localized, preferredStyle: UIAlertController.Style.alert)
                ValidationAlert.addAction(UIAlertAction(title: "Dismiss".localized, style: .cancel, handler: nil))
                self.present(ValidationAlert, animated: true, completion: nil)
//                let sb = Snackbar()
//                sb.createWithAction(text: "You can only select three types".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
//                sb.show()
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
    
    func MoveToNext()
    {
        
        let joined = aryChooseCareModel.joined(separator: ",")
    
        Singletons.sharedInstance.vehicleClass = joined
        
    }

    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------

    
    func webserviceForVehicleTypes()
    {
        webserviceForVehicalModelList("" as AnyObject) { (result, status) in
            
            if (status)
            {
//                print(result)
                
                self.aryData = result["cars_and_taxi"] as! [[String:AnyObject]]
                self.gettingSelectedVehiclesForDrivers()

                for (i,_) in self.aryData.enumerated()
                {
                    var dataOFCars = self.aryData[i]
                    let CarModelID = dataOFCars["Id"] as! String
                    self.aryCarModel.append(CarModelID)
                }

                self.tableView.reloadData()
 
                //cars_and_taxi
            }
            else
            {
//                print(result)
                if let res = result as? String {
                    UtilityClass.showAlert("App Name".localized, message: res, vc: self)
                }
                else if let resDict = result as? NSDictionary {
                    UtilityClass.showAlert("App Name".localized, message: resDict.object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }
                else if let resAry = result as? NSArray {
                    UtilityClass.showAlert("App Name".localized, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
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
