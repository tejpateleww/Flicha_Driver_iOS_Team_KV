//
//  updateDriverSelectVehicleTypesViewControllerViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 28/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import IQDropDownTextField

class updateDriverSelectVehicleTypesViewControllerViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,IQDropDownTextFieldDelegate
{
    
    
    var userDefault = UserDefaults.standard
    var aryDataCarsAndTaxiIDs = [String]()
    var aryDataDeliveryServicesIDs = [String]()
    var aryDataCarsAndTaxi = [[String : AnyObject]]()

    var aryDataCarsAndTaxiVehicleTypes = [String]()
    var aryDataDeliveryServicesVehicleTypes = [String]()
    var strVehicleClass = String()
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        Singletons.sharedInstance.isFromRegistration = false
        
        getData()
        txtNoOfPassenger.isOptionalDropDown = true
        txtNoOfPassenger.itemList = ["1","2","3","4","5","6","7","8","9","10"]

//        viewbtnCarsAndTexis.layer.borderWidth = 1
//        viewbtnDeliveryService.layer.borderWidth = 1
        
//        viewbtnCarsAndTexis.layer.cornerRadius = 3
//        viewbtnDeliveryService.layer.cornerRadius = 3
//
//        viewbtnCarsAndTexis.layer.masksToBounds = true
//        viewbtnDeliveryService.layer.masksToBounds = true
        
//        let profileData = Singletons.sharedInstance.dictDriverProfile
//        if let carType = (profileData?.object(forKey: "profile") as! NSDictionary).object(forKey: "CategoryId") as? String
//        {
//            if carType == "1" {
//                CarAndTexis()
//            }
//            else {
//                 DeliveryService()
//            }
//        }
        
//        let driverVehicleVC = self.childViewControllers.first as! updateDriverVehicleTypesViewController
//        driverVehicleVC.setupVehicleSelection()

        self.webserviceforGetCarModels()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setDataInCarTypeUpdate), name: Notification.Name("setCarTypeUpdate"), object: nil)
    }
    
    @objc func setDataInCarTypeUpdate()
    {
        if UserDefaults.standard.object(forKey: RegistrationFinalKeys.kCarThreeTypeName) != nil
        {
            let carType = UserDefaults.standard.object(forKey: RegistrationFinalKeys.kCarThreeTypeName) as! String
            txtCarType.text = carType
//            Singletons.sharedInstance.vehicleClass = carType
        }
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        getData()
        
        let profile: NSMutableDictionary = NSMutableDictionary(dictionary: (Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary))
        
        let Vehicle: NSMutableDictionary = NSMutableDictionary(dictionary: profile.object(forKey: "Vehicle") as! NSDictionary)
        
        let stringOFVehicleModel: String = Vehicle.object(forKey: "VehicleModel") as! String
        
        let stringToArrayOFVehicleModel = stringOFVehicleModel.components(separatedBy: ",")
        
        Singletons.sharedInstance.arrVehicleClass = NSMutableArray(array: stringToArrayOFVehicleModel.map { Int($0)!})
        setLocalizable()
    }
    @IBOutlet weak var btnSave: ThemeButton!
    func setLocalizable()
    {
        txtVehicleRegistrationNumber.placeholder = "Vehicle Plate Number".localized
        txtVehicleModel.placeholder = "Vehicle Model".localized
//        txtCompany.placeholder = "".localized
        txtCarType.placeholder = "Vehicle Type".localized
        txtNoOfPassenger.placeholder = "Number Of Passenger".localized
        btnSave.setTitle("Save".localized, for: .normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imgVehicle.layer.cornerRadius = imgVehicle.frame.width / 2
        imgVehicle.clipsToBounds = true
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    
    @IBOutlet weak var imgVehicle: UIImageView!
    
    @IBOutlet weak var txtVehicleRegistrationNumber: UITextField!
    @IBOutlet weak var txtCompany: UITextField!
    @IBOutlet weak var txtCarType: UITextField!

    @IBOutlet var txtNoOfPassenger: IQDropDownTextField!
    @IBOutlet var txtVehicleModel: UITextField!
    
    @IBOutlet weak var btnCarsAndTexis: UIButton!
    @IBOutlet weak var btnDeliveryService: UIButton!
    
    @IBOutlet weak var viewCarsAndTexis: UIView!
    @IBOutlet weak var viewDeliveryService: UIView!
    
    @IBOutlet weak var viewbtnCarsAndTexis: UIView!
    @IBOutlet weak var viewbtnDeliveryService: UIView!
    
    
    //-------------------------------------------------------------
    // MARK: - Actions and Custom Methods
    //-------------------------------------------------------------
    
    
    @IBAction func btnCARSandTEXIS(_ sender: UIButton) {
        
        Singletons.sharedInstance.boolTaxiModel = true
        userDefault.set(Singletons.sharedInstance.boolTaxiModel, forKey: "boolTaxiModel")
        
        let sb = Snackbar()
        
        if txtCompany.text == "" {
            
            sb.createWithAction(text: "Enter Company Name", actionTitle: "OK", action: { print("Button is push") })
            sb.show()
        }
        else if txtCarType.text == ""
        {
            sb.createWithAction(text: "Enter Car Type", actionTitle: "OK", action: { print("Button is push") })
            sb.show()
        }
        else if txtVehicleRegistrationNumber.text == "" {
            
            sb.createWithAction(text: "Enter Vehicle Registration No.", actionTitle: "OK", action: { print("Button is push") })
            sb.show()
        }
        else {
            CarAndTexis()
        }
        
        
        
        //        let driverVC = self.navigationController?.viewControllers.last as! DriverRegistrationViewController
        //        let x = self.view.frame.size.width * 4
        //        driverVC.scrollObj.setContentOffset(CGPoint(x:x, y:0), animated: true)
        
    }

    @IBAction func btnDELIVERYservice(_ sender: UIButton) {
        
        Singletons.sharedInstance.boolTaxiModel = false
        userDefault.set(Singletons.sharedInstance.boolTaxiModel, forKey: "boolTaxiModel")
        
        let sb = Snackbar()
        
        if txtCompany.text == "" {
            
            sb.createWithAction(text: "Enter Company Name", actionTitle: "OK", action: { print("Button is push") })
            sb.show()
        }
        else if txtCarType.text == "" {
            
            sb.createWithAction(text: "Enter Car Type", actionTitle: "OK", action: { print("Button is push") })
            sb.show()
        }
        else if txtVehicleRegistrationNumber.text == "" {
            
            sb.createWithAction(text: "Enter Vehicle Registration No.", actionTitle: "OK", action: { print("Button is push") })
            sb.show()
        }
        else  {
            DeliveryService()
        }
        
        
        
        
        //        let driverVC = self.navigationController?.viewControllers.last as! DriverRegistrationViewController
        //        let x = self.view.frame.size.width * 5
        //        driverVC.scrollObj.setContentOffset(CGPoint(x:x, y:0), animated: true)
        
    }
    
    
    func CarAndTexis()
    {
        
//        setData()
//        btnCarsAndTexis.setImage(UIImage(named: "iconCheckMarkSelected"), for: .normal)
//        btnDeliveryService.setImage(UIImage(named: "iconCheckMarkUnSelected"), for: .normal)
//
//        viewCarsAndTexis.isHidden = false
//        viewDeliveryService.isHidden = true
        
        self.performSegue(withIdentifier: "segueCarsAndTaxi", sender: nil)
        
    }
    
    func DeliveryService()
    {
        
        setData()
        btnCarsAndTexis.setImage(UIImage(named: "iconCheckMarkUnSelected"), for: .normal)
        btnDeliveryService.setImage(UIImage(named: "iconCheckMarkSelected"), for: .normal)
        
        viewCarsAndTexis.isHidden = true
        viewDeliveryService.isHidden = false
    }
    

    func setData()
    {
        let vehicleNumber = txtVehicleRegistrationNumber.text
        let VehiclaName = txtCompany.text
        let vehicleColor = txtCarType.text
    
        
        userDefault.set(vehicleNumber, forKey: RegistrationFinalKeys.kVehicleRegistrationNo)
        userDefault.set(VehiclaName, forKey: RegistrationFinalKeys.kCompanyModel)
        userDefault.set(vehicleColor, forKey: RegistrationFinalKeys.kCarThreeTypeName)
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField == txtCarType
        {
            self.view.endEditing(true)
            CarAndTexis()
            return false
        }
        
        return true
    }
    func getData()
    {
        let profile: NSMutableDictionary = NSMutableDictionary(dictionary: (Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary))
        let Vehicle: NSMutableDictionary = NSMutableDictionary(dictionary: profile.object(forKey: "Vehicle") as! NSDictionary )
        
        
        txtVehicleRegistrationNumber.text = Vehicle.object(forKey: "VehicleRegistrationNo") as? String
        txtVehicleModel.text = Vehicle.object(forKey: "VehicleModel") as? String
        
        txtCompany.text = Vehicle.object(forKey: "VehicleModelName") as? String

        let carType = Vehicle.object(forKey: "VehicleClass") as? String
        txtCarType.text = carType

        txtNoOfPassenger.selectedItem = Vehicle.object(forKey: "NoOfPassenger") as? String
        imgVehicle.sd_setImage(with: URL.init(string: Vehicle.object(forKey: "VehicleImage") as! String), completed: nil)
    }
    
    // ------------------------------------------------------------
    
    var dictData = NSMutableDictionary()
    
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?)
    {
        txtNoOfPassenger.selectedItem = item
    }
    @IBAction func btnChoosePicture(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Choose Options", message: nil, preferredStyle: .alert)
        
        let Gallery = UIAlertAction(title: "Gallery", style: .default, handler: { ACTION in
            self.PickingImageFromGallery()
        })
        let Camera  = UIAlertAction(title: "Camera", style: .default, handler: { ACTION in
            self.PickingImageFromCamera()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(Gallery)
        alert.addAction(Camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    func PickingImageFromGallery()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        
        // picker.stopVideoCapture()
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    func PickingImageFromCamera()
    {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        
        present(picker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage as? UIImage {
            imgVehicle.contentMode = .scaleToFill
            imgVehicle.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSave(_ sender: Any)
    {
        
        if (Validations()){
            
            if Singletons.sharedInstance.vehicleClass == "" {
                UtilityClass.showAlert(appName.kAPPName, message: "Please select at least one car type.", vc: self)
            }
            else {
                
                let profile: NSMutableDictionary = NSMutableDictionary(dictionary: (Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary))
                
                //            (Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile"))!.object(forKey: "profile") as! NSMutableDictionary
                
                let strVehicleClass = Singletons.sharedInstance.vehicleClass
                
                dictData["DriverId"] = profile.object(forKey: "Id") as? String as AnyObject
                dictData["VehicleClass"] = strVehicleClass as AnyObject
                dictData["CompanyModel"] = txtCompany.text as AnyObject
                dictData["VehicleRegistrationNo"] = txtVehicleRegistrationNumber.text as AnyObject
                dictData["NoOfPassenger"] = txtNoOfPassenger.selectedItem as AnyObject
                dictData["VehicleModelName"] = txtVehicleModel.text as AnyObject
                // DriverId,VehicleClass,VehicleColor,CompanyModel,VehicleRegistrationNo
                
                
                self.webserviceCallForProfileUpdate()
            }
           
        }
        
    }
    
    func Validations() -> Bool {
        
//        if (txtVehicleRegistrationNumber.text!.count == 0) {
//            UtilityClass.showAlert(appName.kAPPName, message: "Enter Vehicle Registration Number", vc: self)
//            return false
//        }
//        else if (txtCompany.text!.count == 0) {
//            UtilityClass.showAlert(appName.kAPPName, message: "Enter Company", vc: self)
//            return false
//        }
//        else if (txtCarType.text!.count == 0) {
//            UtilityClass.showAlert(appName.kAPPName, message: "Enter Car Type", vc: self)
//            return false
//        }
        if txtVehicleRegistrationNumber.text == "" {
            
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Vehicle Registration Number", vc: self)
            return false
        }
        else if txtCompany.text == "" {
            
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Company", vc: self)
            return false
        }
        else if txtVehicleModel.text == "" {
            
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Car Model", vc: self)
            return false
        }
        else if (txtCarType.text as! String) == "" {
            
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Car Type", vc: self)
            return false
        }
        else if txtNoOfPassenger.selectedItem == nil ||  txtNoOfPassenger.selectedItem == "" || txtNoOfPassenger.selectedItem == "Number of Passenger"
        {

            UtilityClass.showAlert(appName.kAPPName, message: "Enter Number of Passsenger", vc: self)
            return false
        }
        
        return true
    }
    
  
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    
    func webserviceforGetCarModels() {
        
        webserviceForVehicalModelList("" as AnyObject) { (result, status) in
            
            if (status)
            {
                print(result)
                
                //                let checkCarModelClass: Bool = Singletons.sharedInstance.boolTaxiModel
                
                
                self.aryDataCarsAndTaxi = result["cars_and_taxi"] as! [[String:AnyObject]]
                
                
                for (i,_) in self.aryDataCarsAndTaxi.enumerated()
                {
                    var dataOFCars = self.aryDataCarsAndTaxi[i]
                    let CarModelID = dataOFCars["Id"] as! String
                    let strCarModelNames = dataOFCars["Name"] as! String
                    self.aryDataCarsAndTaxiIDs.append(CarModelID)
                    self.aryDataCarsAndTaxiVehicleTypes.append(strCarModelNames)
                }
                
                
                
//                self.getVehicleName()
                
            }
            else
            {
                print(result)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationOfCarAndTaxi = segue.destination as? CarAndTaxiesVC
        {
            destinationOfCarAndTaxi.aryData = self.aryDataCarsAndTaxi as NSArray
            
//            let profile: NSMutableDictionary = NSMutableDictionary(dictionary: (Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary))
//            let Vehicle: NSMutableDictionary = NSMutableDictionary(dictionary: profile.object(forKey: "Vehicle") as! NSDictionary )
//
//            let carType = Vehicle.object(forKey: "VehicleClass") as? String
//            let carTypeID = Vehicle.object(forKey: "VehicleModel") as? String
//            let arryCarName = carType?.components(separatedBy: ",")
//            let arryCarID = carTypeID?.components(separatedBy: ",")
//            destinationOfCarAndTaxi.aryChooseCarName = arryCarName!
//            destinationOfCarAndTaxi.aryChooseCareModel = arryCarID!
        }
    }
    func webserviceCallForProfileUpdate()
    {
        
        webserviceForUpdateDriverProfileUpdateVehicleInfoDetails(dictData as AnyObject) { (result, status) in
            
            if (status) {
//                print(result)
                
//                The webservice call is https://www.tantaxitanzania.com/web/Drvier_Api/UpdateVehicleInfo and the params are {
//                CompanyModel = "0,0";
//                DriverId = 10;
//                NoOfPassenger = 2;
//                VehicleClass = "Standard,Premium";
//                VehicleModelName = "0,0";
//                VehicleRegistrationNo = "Gj 27";
//            }
                
                
                Singletons.sharedInstance.dictDriverProfile = NSMutableDictionary(dictionary: (result as! NSDictionary))
                
//                UserDefaults.standard.set(Singletons.sharedInstance.dictDriverProfile, forKey: driverProfileKeys.kKeyDriverProfile)
                
                Utilities.encodeDatafromDictionary(KEY: driverProfileKeys.kKeyDriverProfile, Param: Singletons.sharedInstance.dictDriverProfile)
                let alert = UIAlertController(title: appName.kAPPName, message: "Updated Successfully", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                print(result)
                
                if let res = (result as? String) {
                    UtilityClass.showAlert(appName.kAPPName, message: res, vc: self)
                }
                else {
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
    }
    
    @IBAction func btnBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
}
