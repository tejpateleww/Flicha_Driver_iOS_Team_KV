//
//  DriverSelectVehicleTypesViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 24/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
//import ACFloatingTextfield_Swift
import IQDropDownTextField

class DriverSelectVehicleTypesViewController: UIViewController,getVehicleIdAndNameDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,IQDropDownTextFieldDelegate
{

    
    @IBOutlet var btnNext: UIButton!
    
    @IBOutlet weak var constraintHeightOfTextFields: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightOfImage: NSLayoutConstraint!
    @IBOutlet weak var constraintTopOfNextButton: NSLayoutConstraint!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var lblHaveAnAccount: UILabel!
    var userDefault = UserDefaults.standard
    var aryDataCarsAndTaxi = [[String : AnyObject]]()
    
    var allElemsContainedCarsandTaxi = Bool()
    var allElemsContainedDeliveryServices = Bool()
    
    var aryCarModelID = [String]()
    
    @IBOutlet weak var btnChoosePhoto: UIButton!
    var aryDataCarsAndTaxiIDs = [String]()
    var aryDataDeliveryServicesIDs = [String]()
    
    var aryDataCarsAndTaxiVehicleTypes = [String]()
    var aryDataDeliveryServicesVehicleTypes = [String]()
    var strVehicleClass = String()
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLocalizable()
        
    }
    
    func setLocalizable()
    {
        self.title = "App Name".localized

        txtVehicleRegistrationNumber.placeholder = "Vehicle Plate Number".localized
        txtCompany.placeholder = "Vehicle Model".localized
        txtVehicleMake.placeholder = "Vehicle Make".localized
        txtCarType.placeholder = "Vehicle Type".localized
        txtNumberPassenger.placeholder = "Number Of Passenger".localized
        btnNext.setTitle("Next".localized, for: .normal)
//        lblHaveAnAccount.text = "".localized
//        btnLogin.setTitle("".localized, for: .normal)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set("", forKey: RegistrationFinalKeys.kCarThreeTypeName)
        UserDefaults.standard.synchronize()
        
        if DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPAD {
            constraintHeightOfImage.constant = 120
            constraintHeightOfTextFields.constant = 30
            constraintTopOfNextButton.constant = 10
        }
        btnChoosePhoto.layer.cornerRadius = btnChoosePhoto.frame.size.width / 2
        btnChoosePhoto.layer.masksToBounds = true
        imgVehicle.layer.cornerRadius = imgVehicle.frame.size.width / 2
        imgVehicle.layer.masksToBounds = true

//        AppDelegate.isFromRegistration = true
        Singletons.sharedInstance.isFromRegistration = true
        
        viewbtnCarsAndTexis.layer.borderWidth = 1
        viewbtnDeliveryService.layer.borderWidth = 1
        
        viewbtnCarsAndTexis.layer.cornerRadius = 3
        viewbtnDeliveryService.layer.cornerRadius = 3
        
        viewbtnCarsAndTexis.layer.masksToBounds = true
        viewbtnDeliveryService.layer.masksToBounds = true
        
//        imgVehicle.layer.cornerRadius = imgVehicle.frame.size.width / 2
//        imgVehicle.layer.masksToBounds = true
        
        
        
//         CarAndTexis()
        
        viewCarsAndTexis.isHidden = true
        viewDeliveryService.isHidden = true
        
        txtNumberPassenger.isOptionalDropDown = true
        txtNumberPassenger.itemList = ["1","2","3","4","5","6","7","8","9","10"]
        
        
        txtNumberPassenger.font = UIFont.init(name: CustomeFontUbuntuRegular, size: 14)
        txtNumberPassenger.textColor = UIColor.black
        txtNumberPassenger.backgroundColor = UIColor.white
        txtNumberPassenger.setValue(UIColor.black , forKeyPath: "placeholderLabel.textColor")
        
        
        
        txtNumberPassenger.layer.cornerRadius = 2
        txtNumberPassenger.layer.shadowRadius = 3.0
        txtNumberPassenger.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        txtNumberPassenger.layer.shadowOffset = CGSize (width: 1.0, height: 1.0)
        txtNumberPassenger.layer.shadowOpacity = 1.0
        
        let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 20.0, height: 20.0))
        LeftView.backgroundColor = UIColor.clear
        
        txtNumberPassenger.leftView = LeftView
        txtNumberPassenger.leftViewMode = .always
    
        
        self.webserviceforGetCarModels()
        NotificationCenter.default.addObserver(self, selector: #selector(setDataInCarType), name: Notification.Name("setCarType"), object: nil)

        
    }

    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?)
    {
        txtNumberPassenger.selectedItem = item
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
   
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        btnNext.layer.cornerRadius = btnNext.frame.size.height/2
        btnNext.clipsToBounds = true
    }
    
    @objc func setDataInCarType()
    {
        if UserDefaults.standard.object(forKey: RegistrationFinalKeys.kCarThreeTypeName) != nil
        {
            let carType: String = UserDefaults.standard.object(forKey: RegistrationFinalKeys.kCarThreeTypeName) as! String
            txtCarType.text = carType
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField == txtCarType
        {
//            self.view.endEditing(true)
            self.view.endEditing(true)
            self.perform(#selector(openCarAndTaxis), with: nil, afterDelay: 0.3)
           
            return false
        }
        
        return true
    }
    
    @objc func openCarAndTaxis() {
         CarAndTexis()
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    
    @IBOutlet weak var imgVehicle: UIImageView!
    
    @IBOutlet weak var txtVehicleRegistrationNumber: UITextField!
    @IBOutlet weak var txtCompany: UITextField!
    @IBOutlet weak var txtCarType: UITextField!
    
  
    @IBOutlet var txtVehicleMake: ThemeTextField!
    
    @IBOutlet var txtNumberPassenger: IQDropDownTextField!
    @IBOutlet weak var btnCarsAndTexis: UIButton!
    @IBOutlet weak var btnDeliveryService: UIButton!
    
    @IBOutlet weak var viewCarsAndTexis: UIView!
    @IBOutlet weak var viewDeliveryService: UIView!
    
    @IBOutlet weak var viewbtnCarsAndTexis: UIView!
    @IBOutlet weak var viewbtnDeliveryService: UIView!
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    
    @IBAction func btnCARSandTEXIS(_ sender: UIButton)
    {
        
        Singletons.sharedInstance.boolTaxiModel = true
        userDefault.set(Singletons.sharedInstance.boolTaxiModel, forKey: "boolTaxiModel")
        
        let validator = isValidateForCarAndTaxi()
        
        if validator.0 == true {
            self.view.endEditing(true)
            CarAndTexis()
        } else {
    
            let ValidationAlert = UIAlertController(title: "App Name".localized, message: validator.1, preferredStyle: UIAlertController.Style.alert)
            ValidationAlert.addAction(UIAlertAction(title: "Dismiss".localized, style: .cancel, handler: nil))
            self.present(ValidationAlert, animated: true, completion: nil)
        }
        
        
//        let driverVC = self.navigationController?.viewControllers.last as! DriverRegistrationViewController
//        let x = self.view.frame.size.width * 4
//        driverVC.scrollObj.setContentOffset(CGPoint(x:x, y:0), animated: true)
        
    }
    
//    @IBAction func TapToProfilePicture(_ sender: UITapGestureRecognizer)
//    {
//    }
    @IBAction func btnNext(_ sender: Any)
    {
        Singletons.sharedInstance.boolTaxiModel = true
        userDefault.set(Singletons.sharedInstance.boolTaxiModel, forKey: "boolTaxiModel")
        
        let validator = isValidateForNext()
        
        if validator.0 == true {
            setData()
            let driverVC = self.navigationController?.viewControllers.last as! DriverRegistrationViewController
            
            driverVC.viewFifth.backgroundColor = ThemeYellowColor
            //            driverVC.imgAttachment.image = UIImage.init(named: iconAttachmentSelect)
            let x = self.view.frame.size.width * 4
            driverVC.scrollObj.setContentOffset(CGPoint(x:x, y:0), animated: true)
            UserDefaults.standard.set(4, forKey: savedDataForRegistration.kPageNumber)
            
            driverVC.viewDidLayoutSubviews()
            
        } else {
            
            let ValidationAlert = UIAlertController(title: "App Name".localized, message: validator.1, preferredStyle: UIAlertController.Style.alert)
            ValidationAlert.addAction(UIAlertAction(title: "Dismiss".localized, style: .cancel, handler: nil))
            self.present(ValidationAlert, animated: true, completion: nil)
        }
        
    }

    func didgetIdAndName(id: String, Name: String  ) {
        
        if id == "" || Name == "" {
            //            UtilityClass.showAlert(appName.kAPPName, message: "", vc: self)
        }
        else {
        
            print(id)
            print(Name)
//            vehicleTypeData.Id = id
//            vehicleTypeData.Name = Name
//            btnSelectVehicleType.setTitle("  \(Name)", for: .normal)
//            btnSelectVehicleType.setTitleColor(UIColor.black, for: .normal)
        }
        
        
        //        txtSelectVehicleType.text = Name
    }
    
    @IBAction func btnDELIVERYservice(_ sender: UIButton)
    {
        
        Singletons.sharedInstance.boolTaxiModel = false
        userDefault.set(Singletons.sharedInstance.boolTaxiModel, forKey: "boolTaxiModel")
        
        let validator = isValidateForDeliveryService()
        
        if validator.0 == true {
            DeliveryService()
        }  else {
            
            let ValidationAlert = UIAlertController(title: "App Name".localized, message: validator.1, preferredStyle: UIAlertController.Style.alert)
            ValidationAlert.addAction(UIAlertAction(title: "Dismiss".localized, style: .cancel, handler: nil))
            self.present(ValidationAlert, animated: true, completion: nil)
        }
        
        
        //        let driverVC = self.navigationController?.viewControllers.last as! DriverRegistrationViewController
        //        let x = self.view.frame.size.width * 5
        //        driverVC.scrollObj.setContentOffset(CGPoint(x:x, y:0), animated: true)
        
}
    

    func isValidateForDeliveryService() -> (Bool,String) {
        var isValidate:Bool = true
        var validatorMessage:String = ""
    
//        let sb = Snackbar()
        
        if txtCompany.text == "" {
            isValidate = false
            validatorMessage = "Enter Company Name"
//            sb.createWithAction(text: "Enter Company Name", actionTitle: "Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        else if txtCarType.text == "" {
            isValidate = false
            validatorMessage = "Enter Car Color"
//            sb.createWithAction(text: "Enter Car Color", actionTitle: "Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        else if txtVehicleRegistrationNumber.text == "" {
            isValidate = false
            validatorMessage = "Vehicle Registration Document".localized
//            sb.createWithAction(text: "Vehicle Registration Document".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        else if imgVehicle.image == UIImage(named: "iconProfileLocation") {
            isValidate = false
            validatorMessage = "Choose Photo".localized
//            sb.createWithAction(text: "Choose Photo".localized, actionTitle:"Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        
        return (isValidate,validatorMessage)
    }

    func isValidateForNext() -> (Bool,String) {
        var isValidate:Bool = true
        var validatorMessage:String = ""
    
//        let sb = Snackbar()
        
        if txtVehicleRegistrationNumber.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            isValidate = false
            validatorMessage = "Please enter vehicle plate number".localized
//            sb.createWithAction(text: "Please enter vehicle plate number".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        else if txtCompany.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            isValidate = false
            validatorMessage = "Please enter vehicle model".localized
//            sb.createWithAction(text: "Please enter vehicle model".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        else if txtVehicleMake.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            isValidate = false
            validatorMessage = "Please enter vehicle make".localized
//            sb.createWithAction(text: "Please enter vehicle make".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        else if txtCarType.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            isValidate = false
            validatorMessage = "Please select vehicle type".localized
//            sb.createWithAction(text: "Please select vehicle type".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        else if txtNumberPassenger.selectedItem == nil ||  txtNumberPassenger.selectedItem == "" || txtNumberPassenger.selectedItem == "Number Of Passenger".localized
        {
            isValidate = false
            validatorMessage = "Please enter no of passenger".localized
//            sb.createWithAction(text: "Please enter no of passenger".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        else if imgVehicle.image == UIImage(named: "iconCARPlaceholder") || imgVehicle.image == nil //UIImage.init(named: "")
        {
            isValidate = false
            validatorMessage = "Please select vehicle image".localized
//            sb.createWithAction(text: "Please select vehicle image".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        return(isValidate,validatorMessage)
    }

    func isValidateForCarAndTaxi() -> (Bool,String) {
        var isValidate:Bool = true
        var validatorMessage:String = ""
        
//        let sb = Snackbar()
        
        if txtCompany.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            isValidate = false
            validatorMessage = "Please enter vehicle model".localized
//            sb.createWithAction(text: "Please enter vehicle model".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        else if txtCarType.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            isValidate = false
            validatorMessage = "Please select vehicle type".localized
//            sb.createWithAction(text: "Please select vehicle type".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        else if txtVehicleRegistrationNumber.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            isValidate = false
            validatorMessage = "Vehicle Registration Document".localized
//            sb.createWithAction(text: "Vehicle Registration Document".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        else if imgVehicle.image == nil {
            isValidate = false
            validatorMessage = "Choose Photo".localized
//            sb.createWithAction(text: "Choose Photo".localized, actionTitle: "Dismiss".localized, action: { print("Button is push") })
//            sb.show()
        }
        
        return(isValidate,validatorMessage)
    }


    func CarAndTexis()
    {
        Singletons.sharedInstance.isDriverVehicleTypesViewControllerFilled = true
        self.view.endEditing(true)
//        setData()
//        btnCarsAndTexis.setImage(UIImage(named: "iconCheckMarkSelected"), for: .normal)
//        btnDeliveryService.setImage(UIImage(named: "iconCheckMarkUnSelected"), for: .normal)
//
//        viewCarsAndTexis.isHidden = false
//        viewDeliveryService.isHidden = true
        self.performSegue(withIdentifier: "segueCarsAndTaxi", sender: nil)
    }
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
                
                self.getVehicleName()
                
            }
            else
            {
                print(result)
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
    func getVehicleName()
    {
//        let data = Singletons.sharedInstance.dictDriverProfile
//        print(data!)
        
//        strVehicleClass = (((data?.object(forKey: "profile") as! NSDictionary).object(forKey: "Vehicle") as! NSDictionary).object(forKey: "VehicleClass") as! String)
//        let userCars = strVehicleClass.components(separatedBy: ",")
//
//        let list_Cars_and_taxi = aryDataCarsAndTaxiVehicleTypes
//        let listSet_Cars_and_taxi = Set(list_Cars_and_taxi)
//        let findListSet_Cars_and_taxi = Set(userCars)
//
//        allElemsContainedCarsandTaxi = findListSet_Cars_and_taxi.isSubset(of: listSet_Cars_and_taxi)
        
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationOfCarAndTaxi = segue.destination as? CarAndTaxiesVC {
            destinationOfCarAndTaxi.delegate = self as? getVehicleIdAndNameDelegate
            destinationOfCarAndTaxi.delegateForEstimate = self as? getEstimateFareForDispatchJobs
            destinationOfCarAndTaxi.aryData = self.aryDataCarsAndTaxi as NSArray
        }
    }
    
    
    func DeliveryService()
    {
        Singletons.sharedInstance.isDriverVehicleTypesViewControllerFilled = true
        setData()
        btnCarsAndTexis.setImage(UIImage(named: "iconCheckMarkUnSelected"), for: .normal)
        btnDeliveryService.setImage(UIImage(named: "iconCheckMarkSelected"), for: .normal)
        
        viewCarsAndTexis.isHidden = true
        viewDeliveryService.isHidden = false
    }
    
    
    @IBAction func btnChoosePicture(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Choose Photo".localized, message: nil, preferredStyle: .alert)
        
        let Gallery = UIAlertAction(title: "Select photo from gallery".localized
, style: .default, handler: { ACTION in
            self.PickingImageFromGallery()
        })
        let Camera  = UIAlertAction(title: "Select photo from camera".localized
, style: .default, handler: { ACTION in
            self.PickingImageFromCamera()
        })
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        
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
        picker.mediaTypes = [kUTTypeImage as String]
//            UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
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
    
    // ------------------------------------------------------------
    
    func setData()
    {
        
        //         String DRIVER_REGISTER_PARAM_VEHICLE_IMAGE = "VehicleImage";
//        String DRIVER_REGISTER_PARAM_VEHICLE_RIGISTRATION_NO = "VehicleRegistrationNo";
//        String DRIVER_REGISTER_PARAM_VEHICLE_MODEL_NAME = "VehicleModelName";
//        String DRIVER_REGISTER_PARAM_VEHICLE_MAKE = "CompanyModel";
//        String DRIVER_REGISTER_PARAM_VEHICLE_TYPE = "VehicleClass";
//        String DRIVER_REGISTER_PARAM_NO_OF_PASSENGER = "NoOfPassenger";
        
//        txtVehicleRegistrationNumber = vehicle Plate Number = VehicleRegistrationNo
//        txtCompany = vehicle model = VehicleModelName
//        txtCarType = vehicle type = VehicleClass
//        txtVehicleMake = vehicle make = CompanyModel
//        txtNumberPassenger = number of passenger = NoOfPassenger
        
        let vehicleRegistrationNumber = txtVehicleRegistrationNumber.text
        let VehiclaCompanyModelName = txtCompany.text // CompanyModel
        let vehicleClasscarType = txtCarType.text
        let VehiclaMakeCompanyModel = txtVehicleMake.text
        let vehiclePassenger = txtNumberPassenger.selectedItem
        
        if imgVehicle.image != nil
        {
            let imageData: NSData = imgVehicle.image!.pngData()! as NSData
            let myEncodedImageData: NSData = NSKeyedArchiver.archivedData(withRootObject: imageData) as NSData
            userDefault.set(myEncodedImageData, forKey: RegistrationFinalKeys.kVehicleImage)

        }

        
        userDefault.set(vehicleRegistrationNumber, forKey: RegistrationFinalKeys.kVehicleRegistrationNo)
        userDefault.set(VehiclaMakeCompanyModel, forKey: RegistrationFinalKeys.kCompanyModel)
        userDefault.set(vehicleClasscarType, forKey: RegistrationFinalKeys.kVehicleClass)
        userDefault.set(VehiclaCompanyModelName, forKey: RegistrationFinalKeys.kVehicleModelName)
        userDefault.set(vehiclePassenger, forKey: RegistrationFinalKeys.kNumberOfPasssenger)
       
    }
    
    
    // ------------------------------------------------------------
    
    
    
    
    

}
