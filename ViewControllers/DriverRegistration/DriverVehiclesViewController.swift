//
//  DriverVehiclesViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 11/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class DriverVehiclesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet var BicycleView: UIView!
    @IBOutlet var motorBikeView: UIView!
    @IBOutlet var CarDeliveryView: UIView!
    @IBOutlet var VanView: UIView!
    @IBOutlet var T2View: UIView!
    @IBOutlet var T3View: UIView!
    // ------------------------------------------------------------
    
    @IBOutlet var btnBicycle: UIButton!
    @IBOutlet var btnMotorbike: UIButton!
    @IBOutlet var btnCarDelivery: UIButton!
    @IBOutlet var btnVanTrays: UIButton!
    @IBOutlet var btn2Ttruck: UIButton!
    @IBOutlet var btn3Ttruck: UIButton!
    
    
    @IBOutlet var tableView: UITableView!
    
    
    
    var strTitle = String()
    var strTermsAndCondition = String()
    var strSelectVehicle = String()
    
    var aryVehicles = [String]()
    var selectedCells:[Int] = []
    var intCarModel: [Int] = []
    
    var userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        strTitle = "Please select which delivery classes you are a part of. You must be 18 years of age or over as per"
        strTermsAndCondition = "Driver Terms and Conditions."
        strSelectVehicle = "Select up to 3 vehicles."
        
        aryVehicles = ["Bicycle", "Motorbike", "Car Delivery", "Van / Trays", "2T truck", "3T truck"]
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
        
//       tableView.backgroundColor = UIColor.white
        
//        webserviceForVehicleTypes()
       
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        webserviceForVehicleTypes()
        self.title = "App Name".localized

    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    // ------------------------------------------------------------

    //-------------------------------------------------------------
    // MARK: - Actions
    
    //-------------------------------------------------------------
    @IBAction func btnBicycle(_ sender: UIButton) {
    }
    @IBAction func btnMotorbike(_ sender: Any) {
    }
    @IBAction func btnCarDelivery(_ sender: Any) {
    }
    @IBAction func btnVanTrays(_ sender: Any) {
    }
    @IBAction func btn2Ttruck(_ sender: Any) {
    }
    @IBAction func btn3Ttruck(_ sender: Any) {
    }
    
    // ------------------------------------------------------------
    
    //-------------------------------------------------------------
    // MARK: - Table View Methods
    //-------------------------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            if strTitle == ""
            {
                return 0
            }
            return 1
        } else if section == 1 {
            
            if self.aryData.count == 0 {
                return 0
            }
            else{
                return self.aryData.count
            }
            
        } else if section == 2 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellTop = tableView.dequeueReusableCell(withIdentifier: "DriverVehiclesTableViewCellTop") as! DriverVehiclesTableViewCell
        let cellDetails = tableView.dequeueReusableCell(withIdentifier: "DriverVehiclesTableViewCellData") as! DriverVehiclesTableViewCell
        let cellBottom = tableView.dequeueReusableCell(withIdentifier: "DriverVehiclesTableViewCellBottom") as! DriverVehiclesTableViewCell
        
        cellTop.selectionStyle = .none
        cellDetails.selectionStyle = .none
        cellBottom.selectionStyle = .none
        
        let lblpleaseSelectWhichDelivery = "Please select which vehicle classes you are a part of.".localized
        let lblyoumustbe = "You must be 18 years of age or over as per".localized
        cellTop.lblTopDetails.text =  "\(lblpleaseSelectWhichDelivery)\(lblyoumustbe)"
//        "Please select which vehicle classes you are a part of.You must be 18 years of age or over as per".localized
//        cellTop.lblTopDetails.text = "".localized
        cellTop.btnDriverTermsandConditions.setTitle("Driver term and condition.".localized, for: .normal)
         cellTop.lblSelectupTo3Vehicles.text = "Select up to three vehicles.".localized
        cellDetails.btnNext.setTitle("Next".localized, for: .normal)
        
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
            cellDetails.dataView.layer.borderColor = UIColor.gray.cgColor
            
            if (self.selectedCells.contains(indexPath.row))
            {
                cellDetails.btnCheckMark.setImage(UIImage(named: "iconCheckMarkSelected"), for: .normal)
            }
            else
            {
                cellDetails.btnCheckMark.setImage(UIImage(named: "iconCheckMarkUnSelected"), for: .normal)
            }
            return cellDetails
        } else if indexPath.section == 2 {
            
            if self.aryChooseCareModel.count == 0 {
                
//                UtilityClass.showAlert(appName.kAPPName, message: "Please select car model", vc: self)
            }
            else if Singletons.sharedInstance.isDriverVehicleTypesViewControllerFilled == false {
                UtilityClass.showAlert("App Name".localized, message: "Please enter all document\'s detail.".localized, vc: self)
            }
            else {
                cellBottom.btnNext.addTarget(self, action: #selector(self.MoveToNext), for: .touchUpInside)
            }
            return cellBottom
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
    
    @objc func MoveToNext()
    {
        let joined = aryChooseCareModel.joined(separator: ",")
        userDefault.set(joined, forKey: RegistrationFinalKeys.kVehicleClass)
        
        let driverVC = self.navigationController?.viewControllers.last as! DriverRegistrationViewController
                let x = self.view.frame.size.width * 4
                driverVC.scrollObj.setContentOffset(CGPoint(x:x, y:0), animated: true)
        
//        driverVC.segmentController.selectedIndex = 5
        driverVC.viewFifth.backgroundColor = ThemeYellowColor
//        driverVC.imgAttachment.image = UIImage.init(named: iconAttachmentSelect)
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
                print(result)
                
                self.aryData = result["delivery_services"] as! [[String:AnyObject]]
                
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
                print(result)
//                let alert = UIAlertController(title: nil, message: result.object(forKey: "message") as? String, preferredStyle: .alert)
//                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alert.addAction(ok)
//                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
