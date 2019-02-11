//
//  DispatchJobsBookNowViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 12/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import NVActivityIndicatorView


class DispatchJobsBookNowViewController: UIViewController, getVehicleIdAndNameDelegate, getVehicleServiceIdAndNameDelegate , UITextFieldDelegate, GMSAutocompleteViewControllerDelegate,getEstimateFareForDispatchJobsNow, UINavigationControllerDelegate ,getEstimateFareForDispatchJobs{
   
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var txtContactName: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtCustomerEmail: UITextField!
    @IBOutlet weak var txtPickupLocation: UITextField!
    @IBOutlet weak var txtDropLocation: UITextField!
    @IBOutlet weak var txtFareAmount: UITextField!
    
    @IBOutlet var txtSelectVehicleType: UITextField!
    @IBOutlet var btnAccount: UIButton!
    @IBOutlet var btnAcountOK: UIButton!
    @IBOutlet var btnCollect: UIButton!
    @IBOutlet var btnCollectOK: UIButton!
    
    @IBOutlet weak var stackViewMobileNumber: UIStackView!
    @IBOutlet weak var stackViewSelectVehicleType: UIStackView!
    
    @IBOutlet weak var btnCall: UIButton!
    
    @IBOutlet weak var btnSelectVehicleTypeImage: UIButton!
    @IBOutlet weak var btnSelectVehicleType: UIButton!
    
    @IBOutlet weak var viewMobileView: UIView!
    
    @IBOutlet weak var ViewSelectVehicleType: UIView!
    
    @IBOutlet var txtFlightNumber: UITextField!
    @IBOutlet var txtNotes: UITextField!
   
    @IBOutlet var txtEta: UITextField!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    // From Car and Taxi
    func didgetIdAndName(id: String, Name: String) {
        
        if id == "" || Name == "" {
//            UtilityClass.showAlert(appName.kAPPName, message: "", vc: self)
        }
        else {
            vehicleTypeData.Id = id
            vehicleTypeData.Name = Name
            btnSelectVehicleType.setTitle("  \(Name)", for: .normal)
            btnSelectVehicleType.setTitleColor(UIColor.black, for: .normal)
        }

        
//        txtSelectVehicleType.text = Name
    }
    
    // From Delivery Service
    func didgetIdAndNameFromVehicleService(id: String, Name: String) {
        
        if id == "" || Name == "" {
//            UtilityClass.showAlert(appName.kAPPName, message: "", vc: self)
        }
        else {
            vehicleTypeData.Id = id
            vehicleTypeData.Name = Name
            btnSelectVehicleType.setTitle("  \(Name)", for: .normal)
            btnSelectVehicleType.setTitleColor(UIColor.black, for: .normal)
        }
        
        
//        txtSelectVehicleType.text = Name
    }
    
    var aryVehiclesTypes = [String]()
    var dictParam = [String:AnyObject]()
  
    var strVehicleClass = String()
    
    var vehicleTypeData: (Id: String, Name: String) = (Id: "", Name: "")
    
    var allElemsContained_Cars_and_taxi = Bool()
    var allElemsContained_Delivery_services = Bool()
    
    var BoolCurrentLocation = Bool()
    var convertDateToString = String()
    var paymentType = String()

    var strAmounts = String()
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        txtSelectVehicleType.delegate = self
       
//        btnSelectVehicleType.layer.cornerRadius = 3
//        btnSelectVehicleType.layer.masksToBounds = true
        
//        stackViewMobileNumber.layer.cornerRadius = 3
//        stackViewMobileNumber.layer.masksToBounds = true
//
//        stackViewSelectVehicleType.layer.cornerRadius = 3
//        stackViewSelectVehicleType.layer.masksToBounds = true
//
        
        txtMobileNumber.delegate = self
        
        
        webserviceforGetCarModels()
//        txtSelectVehicleType.inputView = nil
        
        paymentType = "account"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        
        btnSelectVehicleType.layer.cornerRadius = 3
        btnSelectVehicleType.layer.masksToBounds = true
        
       
        
        stackViewSelectVehicleType.layer.cornerRadius = 3
        stackViewSelectVehicleType.layer.borderWidth = 1
        stackViewSelectVehicleType.layer.masksToBounds = true
        
        btnSubmit.layer.cornerRadius = 5
        btnSubmit.layer.masksToBounds = true
        
        btnCancel.layer.cornerRadius = 5
        btnCancel.layer.masksToBounds = true
        
        btnCall.layer.masksToBounds = true
        
        btnCall.clipsToBounds = true
        
        txtMobileNumber.layer.masksToBounds = true
        btnSelectVehicleTypeImage.layer.masksToBounds = true
        
        viewMobileView.layer.cornerRadius = 5
        viewMobileView.layer.borderWidth = 0.3
        viewMobileView.layer.borderColor = UIColor.gray.cgColor
        viewMobileView.layer.masksToBounds = true
        
        stackViewMobileNumber.layer.cornerRadius = 3
        stackViewMobileNumber.layer.borderWidth = 1
        stackViewMobileNumber.layer.masksToBounds = true
        
        ViewSelectVehicleType.layer.cornerRadius = 5
        ViewSelectVehicleType.layer.borderWidth = 0.3
        ViewSelectVehicleType.layer.borderColor = UIColor.gray.cgColor
        ViewSelectVehicleType.layer.masksToBounds = true
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationOfCarAndTaxi = segue.destination as? CarAndTaxiesVC {
            destinationOfCarAndTaxi.delegate = self
            destinationOfCarAndTaxi.delegateForEstimate = self
            destinationOfCarAndTaxi.aryData = self.aryData_Cars_and_taxi as NSArray
        }
        if let destinationOfDeleveryService = segue.destination as? DeliverServiceVC {
            destinationOfDeleveryService.delegate = self
            destinationOfDeleveryService.delegateForEstimate = self
            destinationOfDeleveryService.aryData = self.aryData_Delivery_services as NSArray
        }
        
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Delegate Methods
    //-------------------------------------------------------------
    
    func didSelectVehicleModelNow() {
        
        webserviceOFEstimateFare()

        
    }
    
    func didSelectVehicleModel() {
        webserviceOFEstimateFare()

    }
    
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func txtFareAmount(_ sender: UITextField) {
        
        if let amountString = txtFareAmount.text?.currencyInputFormatting() {
            txtFareAmount.text = amountString
            
//            let unfiltered = amountString   //  "!   !! yuahl! !"
            
            let y = amountString.replacingOccurrences(of: "$", with: "", options: .regularExpression, range: nil)
            print(y)
            // Array of Characters to remove
//            let removal: [Character] = ["$",","," "]    // ["!"," "]
//
//            // turn the string into an Array
//            let unfilteredCharacters = unfiltered
//
//            // return an Array without the removal Characters
//            let filteredCharacters = unfilteredCharacters.filter { !removal.contains($0) }
//
//            // build a String with the filtered Array
//            let filtered = String(filteredCharacters)
//
//            print(filtered) // => "yeah"
//
//            // combined to a single line
//            print(String(unfiltered.filter { !removal.contains($0) })) // => "yuahl"
//
//            strAmounts = String(unfiltered.filter { !removal.contains($0) })
            print("amount : \(y)")
            
        }
    }
    

    @IBAction func btnSelectVehicleType(_ sender: UIButton) {
        
        
        
        if txtPickupLocation.text!.count == 0 {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Pickup Location", vc: self)
        }
        else if txtDropLocation.text!.count == 0 {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Dropoff Location", vc: self)
        }
        else {
            
            if allElemsContained_Cars_and_taxi {
                self.performSegue(withIdentifier: "segueCarsAndTaxi", sender: nil)
            }
            else {
                self.performSegue(withIdentifier: "segueDeliveryServices", sender: nil)
            }
        }
        
        
//        if allElemsContained_Cars_and_taxi {
//            self.performSegue(withIdentifier: "segueCarsAndTaxi", sender: nil)
//        }
//        else {
//            self.performSegue(withIdentifier: "segueDeliveryServices", sender: nil)
//        }
        
    }
    
    
    @IBAction func txtSelectVehicleType(_ sender: UITextField) {
       
    }
    
    @IBAction func btnAccount(_ sender: UIButton) {
        AccountClicked()
    }
    
    @IBAction func btnAcountOK(_ sender: UIButton) {
        AccountClicked()
    }
    
    @IBAction func btnCollect(_ sender: UIButton) {
        CollectClicked()
    }
    
    @IBAction func btnCollectOK(_ sender: UIButton) {
        CollectClicked()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        
        
        var FareAmountWithDollar = txtFareAmount.text
        if(FareAmountWithDollar?.count != 0)
        {
        FareAmountWithDollar?.removeFirst()
        
        let fareAmount = Double(FareAmountWithDollar!.trimmingCharacters(in: .whitespacesAndNewlines))
        print("Fareamount: \(String(describing: fareAmount))")
        
        if totalEastimateFare > fareAmount! {
            UtilityClass.showAlert(appName.kAPPName, message: "You cannot enter estimate fare less than \(totalEastimateFare). ", vc: self)
        }
        else {
            if (validationForDispathcJobsNow()) {
                
                webserviceOfDispatchJobsNow()
            }
        }
        }
        else
        {
            UtilityClass.showAlert(appName.kAPPName, message: "Please enter all fields", vc: self)
        }
        
       
        
    }
    
    func backToback()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func txtPickupLocation(_ sender: UITextField) {
        
         pickupLocation()
    }
    
    @IBAction func txtDropLocation(_ sender: UITextField) {
        
        dropOffLocation()
    }
    
    
    func AccountClicked()
    {
        btnAccount.backgroundColor = UIColor.init(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0)
        btnAcountOK.setImage(UIImage(named: "iconCheckMark"), for: .normal)
        btnAcountOK.backgroundColor = UIColor.init(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0)
        
        paymentType = "account"
        
        btnCollect.backgroundColor = UIColor.white
        btnCollectOK.setImage(UIImage(named: ""), for: .normal)
        btnCollectOK.backgroundColor = UIColor.white
        
    }
    func CollectClicked()
    {
        btnCollect.backgroundColor = UIColor.init(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0)
        btnCollectOK.backgroundColor = UIColor.init(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0)
        btnCollectOK.setImage(UIImage(named: "iconCheckMark"), for: .normal)
        
        paymentType = "collect"
        
        btnAccount.backgroundColor = UIColor.white
        btnAcountOK.setImage(UIImage(named: ""), for: .normal)
        btnAcountOK.backgroundColor = UIColor.white
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtMobileNumber {
            let resultText: String? = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
            
            if resultText!.count >= 11 {
                return false
            }
            else {
                return true
            }
        }
        
        return true
    }
    
    
    
    var aryData = [[String:AnyObject]]()
    var aryData_Cars_and_taxi = [[String:AnyObject]]()
    var aryData_Delivery_services = [[String:AnyObject]]()
    
    var aryCarModelID = [String]()
    
    var aryData_Cars_and_taxi_IDs = [String]()
    var aryData_Delivery_services_IDs = [String]()
    
    var aryData_Cars_and_taxi_VehicleTypes = [String]()
    var aryData_Delivery_services_VehicleTypes = [String]()
    
    //-------------------------------------------------------------
    // MARK: - Vehicle Model List
    //-------------------------------------------------------------
    
    func webserviceforGetCarModels() {
        
        webserviceForVehicalModelList("" as AnyObject) { (result, status) in
            
            if (status)
            {
                print(result)
                
//                let checkCarModelClass: Bool = Singletons.sharedInstance.boolTaxiModel
                
              
                self.aryData_Cars_and_taxi = result["cars_and_taxi"] as! [[String:AnyObject]]
                self.aryData_Delivery_services = result["delivery_services"] as! [[String:AnyObject]]
                
                let activityData = ActivityData()
                
//                DispatchQueue.main.async {
                    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
//                }
                
                for (i,_) in self.aryData_Cars_and_taxi.enumerated()
                {
                    var dataOFCars = self.aryData_Cars_and_taxi[i]
                    let CarModelID = dataOFCars["Id"] as! String
                    let strCarModelNames = dataOFCars["Name"] as! String
                    self.aryData_Cars_and_taxi_IDs.append(CarModelID)
                    self.aryData_Cars_and_taxi_VehicleTypes.append(strCarModelNames)
                }
                
                for (i,_) in self.aryData_Delivery_services.enumerated()
                {
                    var dataOFCars = self.aryData_Delivery_services[i]
                    let CarModelID = dataOFCars["Id"] as! String
                    let strCarModelNames = dataOFCars["Name"] as! String
                    self.aryData_Delivery_services_IDs.append(CarModelID)
                    self.aryData_Delivery_services_VehicleTypes.append(strCarModelNames)
                }
          
                self.getVehicleName()

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
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    func getVehicleName()
    {
        let data = Singletons.sharedInstance.dictDriverProfile
        print(data!)
    
        strVehicleClass = (((data?.object(forKey: "profile") as! NSDictionary).object(forKey: "Vehicle") as! NSDictionary).object(forKey: "VehicleClass") as! String)
        let userCars = strVehicleClass.components(separatedBy: ",")
        print(userCars)
        
        let list_Cars_and_taxi = aryData_Cars_and_taxi_VehicleTypes
        let listSet_Cars_and_taxi = Set(list_Cars_and_taxi)
        let findListSet_Cars_and_taxi = Set(userCars)
        
        allElemsContained_Cars_and_taxi = findListSet_Cars_and_taxi.isSubset(of: listSet_Cars_and_taxi)
        
        print("allElemsContained_Cars_and_taxi : \(allElemsContained_Cars_and_taxi)")
        
        let list_Delivery_services = aryData_Delivery_services_VehicleTypes
        let listSet_Delivery_services = Set(list_Delivery_services)
        let findListSet_Delivery_services = Set(userCars)
        
        allElemsContained_Delivery_services = findListSet_Delivery_services.isSubset(of: listSet_Delivery_services)
        
        print("allElemsContained_Delivery_services : \(allElemsContained_Delivery_services)")
        
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    // ----------------------------------------------------------------------
    // ----------------------------------------------------------------------
    
    func pickupLocation() {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        
        BoolCurrentLocation = true
        
        present(acController, animated: true, completion: nil)
        
    }
    
    func dropOffLocation() {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        
        BoolCurrentLocation = false
        
        present(acController, animated: true, completion: nil)
    }
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        if BoolCurrentLocation {
            txtPickupLocation.text = place.formattedAddress
            if txtDropLocation.text!.count != 0 && vehicleTypeData.Id.count != 0 {
                webserviceOFEstimateFare()
            }
            
            }
        else {
            txtDropLocation.text = place.formattedAddress
            if txtPickupLocation.text!.count != 0 && vehicleTypeData.Id.count != 0 {
                webserviceOFEstimateFare()
            }
            }
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }
    
    // User cancelled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    
    func webserviceOfDispatchJobsNow() {
        
        //        DriverId,ModelId,PickupLocation,DropoffLocation,PassengerName,PassengerContact,PassengerEmail,FareAmount,PaymentType
        
//        strAmounts.removeFirst()
        
        let driverID = Singletons.sharedInstance.strDriverID
        let strVehicleType = vehicleTypeData.Id
        
        dictParam["DriverId"] = driverID as AnyObject
        dictParam["ModelId"] = strVehicleType as AnyObject
        dictParam["PickupLocation"] = txtPickupLocation.text as AnyObject
        dictParam["DropoffLocation"] = txtDropLocation.text as AnyObject
        dictParam["PassengerName"] = txtContactName.text as AnyObject
        dictParam["PassengerContact"] = txtMobileNumber.text as AnyObject
        dictParam["PassengerEmail"] = txtCustomerEmail.text as AnyObject
        dictParam["FareAmount"] = txtFareAmount.text!.replacingOccurrences(of: "\(currency)", with: "") as AnyObject
        dictParam["PaymentType"] = paymentType as AnyObject
        dictParam["TripFare"] = txtFareAmount.text!.replacingOccurrences(of: "\(currency)", with: "") as AnyObject
        
        dictParam["FlightNumber"] = txtFlightNumber.text as AnyObject
        dictParam["Notes"] = txtNotes.text as AnyObject
        
        webserviceForSubmitBookNowByDispatchJob(dictParam as AnyObject) { (result, status) in
            
            if (status) {
                print(result)

                let alert = UIAlertController(title: "Successfully", message: "Your dispatch job now request send", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default, handler: { ACTION in
                    
                    self.navigationController?.popViewController(animated: true)
                })
                
                alert.addAction(OK)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                print(result)
                
                if let res = result as? String {
                    UtilityClass.showAlert(appName.kAPPName, message: res, vc: self)
                }
                else if let resDict = result as? NSDictionary {
                    UtilityClass.showAlert(appName.kAPPName, message: (resDict.object(forKey: "message")) as! String, vc: self)
                }
                else if let resAry = result as? NSArray {
                    UtilityClass.showAlert(appName.kAPPName, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: "message") as! String, vc: self)
                }
            }
        }
        
    }
    
    var totalEastimateFare = Double()
     var totalETA = Int()
    func webserviceOFEstimateFare() {
        
        //        PickupLocation,DropoffLocation,ModelId
        
        var param = [String:AnyObject]()
        param["PickupLocation"] = txtPickupLocation.text as AnyObject
        param["DropoffLocation"] = txtDropLocation.text as AnyObject
        param["ModelId"] = vehicleTypeData.Id as AnyObject
        
        
        webserviceForGetEstimateFareForDispatchJobs(param as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                
                
                if let dataTotalFare = ((result as! NSDictionary).object(forKey: "estimate_fare") as! NSDictionary).object(forKey: "eta") as? Double {
                    
                    if(dataTotalFare == 0)
                    {
                        UtilityClass.showAlert(appName.kAPPName, message: "No drivers availabale", vc: self)
                    }
                    
                }
                if let dataTotalFare = ((result as! NSDictionary).object(forKey: "estimate_fare") as! NSDictionary).object(forKey: "total") as? Double {
                    self.txtFareAmount.text = "\(currency)\(dataTotalFare)"
                    self.totalEastimateFare = Double(dataTotalFare)
                }
                else if let stringTotalFare = ((result as! NSDictionary).object(forKey: "estimate_fare") as! NSDictionary).object(forKey: "total") as? String {
                    self.txtFareAmount.text = "\(currency)\(stringTotalFare)"
                    self.totalEastimateFare = Double(stringTotalFare)!
                }
                else if let floatTotalFare = ((result as! NSDictionary).object(forKey: "estimate_fare") as! NSDictionary).object(forKey: "total") as? Float {
                    self.txtFareAmount.text = "\(currency)\(floatTotalFare)"
                    self.totalEastimateFare = Double(floatTotalFare)
                    
                }
                
                if let dataTotalFare = ((result as! NSDictionary).object(forKey: "estimate_fare") as! NSDictionary).object(forKey: "eta") as? Int {
                    self.txtEta.text = "eta: \(dataTotalFare) mins"
                    self.totalETA = Int(dataTotalFare)
                }
                else if let stringTotalFare = ((result as! NSDictionary).object(forKey: "estimate_fare") as! NSDictionary).object(forKey: "eta") as? Int {
                    self.txtEta.text = "eta: \(stringTotalFare) mins"
                    self.totalETA = Int(stringTotalFare)
                }
                else if let floatTotalFare = ((result as! NSDictionary).object(forKey: "estimate_fare") as! NSDictionary).object(forKey: "eta") as? Int {
                    self.txtEta.text = "eta: \(floatTotalFare) mins"
                    self.totalETA = Int(floatTotalFare)
                    
                }
                
                
                
            }
            else {
                print(result)
            }
        }
    }
    
    func validationForDispathcJobsNow() -> Bool {
        
        if (txtContactName.text!.count == 0) {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Customer Name", vc: self)
            return false
        }
        else if (txtMobileNumber.text!.count == 0) {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Mobile Number", vc: self)
            return false
        }
//        else if (txtCustomerEmail.text!.count == 0) {
//            UtilityClass.showAlert(appName.kAPPName, message: "Enter Email ID", vc: self)
//            return false
//        }
        else if (txtPickupLocation.text!.count == 0) {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Pickup Location", vc: self)
            return false
        }
        else if (txtDropLocation.text!.count == 0) {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Dropoff Location", vc: self)
            return false
        }
        else if (txtFareAmount.text!.count == 0) {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Fare Amount", vc: self)
            return false
        }
        else if (vehicleTypeData.Id == "") {
            UtilityClass.showAlert(appName.kAPPName, message: "Select Vehicle Type", vc: self)
            return false
        }
        
        return true
    }
    
    
 
}

