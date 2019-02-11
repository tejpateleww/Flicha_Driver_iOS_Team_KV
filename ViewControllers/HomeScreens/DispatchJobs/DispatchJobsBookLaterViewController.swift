//
//  DispatchJobsBookLaterViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 12/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import GoogleMaps
import GooglePlaces

protocol getEstimateFareForDispatchJobs {
    
    func didSelectVehicleModel()
}

class DispatchJobsBookLaterViewController: UIViewController, getVehicleServiceIdAndNameDelegate, getVehicleIdAndNameDelegate, UITextFieldDelegate, GMSAutocompleteViewControllerDelegate, UINavigationControllerDelegate, WWCalendarTimeSelectorProtocol, getEstimateFareForDispatchJobs
{
    
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
    
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    
    var allElemsContained_Cars_and_taxi = Bool()
    var allElemsContained_Delivery_services = Bool()
    
    var BoolCurrentLocation = Bool()
    var paymentType = String()
    
    var setAmount = String()
    @IBOutlet var viewMobileNumber: UIView!
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSelectVehicleType.layer.cornerRadius = 3
        btnSelectVehicleType.layer.masksToBounds = true
        
//        txtSelectVehicleType.delegate = self
        webserviceforGetCarModels()
        
        paymentType = "account"
        
        btnBack.layer.cornerRadius = 5
        btnBack.layer.masksToBounds = true
        
        btnSubmit.layer.cornerRadius = 5
        btnSubmit.layer.masksToBounds = true
        
//        if UIDevice.current.name == "Bhavesh iPhone" {
//            
//            txtPickupLocation.text = "Sarkhej - Gandhinagar Hwy, Bodakdev, Ahmedabad, Gujarat 380054, India"
//            txtDropLocation.text = "Lal Darwaja, Ahmedabad, Gujarat 380001, India"
//        }
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
    
    func backToback()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        viewMobileNumber.layer.cornerRadius = 5
        viewMobileNumber.layer.borderWidth = 0.3
        viewMobileNumber.layer.borderColor = UIColor.gray.cgColor
        viewMobileNumber.layer.masksToBounds = true
        
        
        
        btnTimeAndDate.layer.cornerRadius = 5
        btnTimeAndDate.layer.borderWidth = 0.3
        btnTimeAndDate.layer.borderColor = UIColor.gray.cgColor
        btnTimeAndDate.layer.masksToBounds = true
    }
    
  
    
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
//    @IBOutlet var txtTimeAndDate: UITextField!
    @IBOutlet var btnTimeAndDate: UIButton!
    @IBOutlet var btnAccount: UIButton!
    @IBOutlet var btnAcountOK: UIButton!
    @IBOutlet var btnCollect: UIButton!
    @IBOutlet var btnCollectOK: UIButton!
    
    @IBOutlet var txtFlightNumber: UITextField!
    @IBOutlet var txtNotes: UITextField!
    
    
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
            //            let removal: [Character] = ["LKR",","," "]    // ["!"," "]
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
//            setAmount = String(unfiltered.filter { !removal.contains($0) })
            print("amount : \(y)")
            
        }
    }
    
 
    @IBAction func txtPickupLocation(_ sender: UITextField) {
        pickupLocation()
    }
    
    @IBAction func txtDropLocation(_ sender: UITextField) {
        dropOffLocation()
    }
   
    @IBOutlet weak var btnSelectVehicleType: UIButton!
    @IBAction func btnSelectVehicleType(_ sender: UIButton) {
        
        if txtPickupLocation.text!.count == 0 {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Pickup Location", vc: self)
        }
        else if txtDropLocation.text!.count == 0 {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Dropoff Location", vc: self)
        }
        else {
            
            if allElemsContained_Cars_and_taxi {
                self.performSegue(withIdentifier: "segueCarsAndTaxiFromLater", sender: nil)
            }
            else {
                self.performSegue(withIdentifier: "segueDeliveryServicesFromLater", sender: nil)
            }
        }
        
    }
    
    
    @IBAction func txtTimeAndDate(_ sender: UITextField) {
     SelectDateAndTimeClicked()
       
    }
    
    func SelectDateAndTimeClicked()
    {
        
        let selector = WWCalendarTimeSelector.instantiate()
        selector.optionCalendarFontColorPastDates = UIColor.gray
        selector.optionButtonFontColorDone = UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        selector.optionSelectorPanelBackgroundColor = UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        selector.optionCalendarBackgroundColorTodayHighlight = UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        selector.optionTopPanelBackgroundColor = UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        selector.optionClockBackgroundColorMinuteHighlightNeedle = UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        selector.optionClockBackgroundColorHourHighlight = UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        selector.optionClockBackgroundColorAMPMHighlight = UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        selector.optionCalendarBackgroundColorPastDatesHighlight = UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        selector.optionCalendarBackgroundColorFutureDatesHighlight = UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        selector.optionClockBackgroundColorMinuteHighlight = UIColor.init(red: 204/255, green: 3/255, blue: 0, alpha: 1.0)
        
        
        
        selector.delegate = self
        
        // 2. You can then set delegate, and any customization options
        //        selector.delegate = self
        selector.optionTopPanelTitle = "Please choose date"
        
        // 3. Then you simply present it from your view controller when necessary!
        self.present(selector, animated: true, completion: nil)
        
    }
    
    @IBAction func btnSelectDateAndTime(_ sender: UIButton) {
        SelectDateAndTimeClicked()
        
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
            if (validationForDispathcJobsLater()) {
                
                webserviceOfDispatchJobsLater()
            }
        }
        }
        else
        {
            UtilityClass.showAlert(appName.kAPPName, message: "Please enter all fields", vc: self)
        }
        
    }
    
    func pickupdateMethod(_ sender: UIDatePicker)
    {
        let dateFormaterView = DateFormatter()
        dateFormaterView.dateFormat = "hh:mm a yyyy/MM/dd"
        btnTimeAndDate.setTitle(dateFormaterView.string(from: sender.date), for: .normal)
//        txtTimeAndDate.text = dateFormaterView.string(from: sender.date)
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
    
    //-------------------------------------------------------------
    // MARK: - Delegate Methods
    //-------------------------------------------------------------
    
    func didSelectVehicleModel() {
       
        webserviceOFEstimateFare()
        
    }
    
    
    // ----------------------------------------------------------------------
    // ----------------------------------------------------------------------
    
    
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
            //            strPickupLocation = place.formattedAddress!
            //            doublePickupLat = place.coordinate.latitude
            //            doublePickupLng = place.coordinate.longitude
            
            
            if txtDropLocation.text!.count != 0 && vehicleTypeData.Id.count != 0 {
                webserviceOFEstimateFare()
            }
            
            
        }
        else {
            txtDropLocation.text = place.formattedAddress
            //            strDropoffLocation = place.formattedAddress!
            //            doubleDropOffLat = place.coordinate.latitude
            //            doubleDropOffLng = place.coordinate.longitude
            
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
    // MARK: - Calendar Method
    //-------------------------------------------------------------
    var currentDate = Date()

    var convertDateToString = String()
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date)
    {
        let order = Calendar.current.compare(currentDate, to: date, toGranularity: .day)
        
        
        switch order {
        case .orderedSame:
            self.selectDateFromCalendar(date: date)
        case .orderedAscending:
            self.selectDateFromCalendar(date: date)
        default: break
        }

          
   
    }
        func selectDateFromCalendar(date: Date)
        {
            let myDateFormatter: DateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
            
            let dateOfPostToApi: DateFormatter = DateFormatter()
            dateOfPostToApi.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            //        dateOfPostToApi.locale = Locale(identifier: NSLocale.current.identifier)
            
            convertDateToString = dateOfPostToApi.string(from: date)
            
            
            let finalDate = myDateFormatter.string(from: date)
            
            // get the date string applied date format
            let mySelectedDate = String(describing: finalDate)
            
            
            btnTimeAndDate.setTitle(mySelectedDate, for: .normal)
            btnTimeAndDate.setTitleColor(UIColor.black, for: .normal)
//            txtTimeAndDate.text = mySelectedDate
        }
    
    func WWCalendarTimeSelectorShouldSelectDate(_ selector: WWCalendarTimeSelector, date: Date) -> Bool {
      let order = Calendar.current.compare(currentDate, to: date, toGranularity: .day)
        
        switch order {
        case .orderedSame:
            return true
        case .orderedAscending:
            return true
        default:
            return false
        }
        
//        if currentDate <= date {
//
//            return true
//        }
//
//        return false
    }
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    
    var totalEastimateFare = Double()
    
    func webserviceOFEstimateFare() {
        
//        PickupLocation,DropoffLocation,ModelId
        
        var param = [String:AnyObject]()
        param["PickupLocation"] = txtPickupLocation.text as AnyObject
        param["DropoffLocation"] = txtDropLocation.text as AnyObject
        param["ModelId"] = vehicleTypeData.Id as AnyObject
        
        
        webserviceForGetEstimateFareForDispatchJobs(param as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
              
                
                
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
               
                
                
            }
            else {
                print(result)
            }
        }
    }
    
    
    func webserviceOfDispatchJobsLater() {
        
        //    DriverId,ModelId,PickupLocation,DropoffLocation,PassengerName,PassengerContact,PassengerEmail,FareAmount,PaymentType, PickupDateTime
        
        let driverID = Singletons.sharedInstance.strDriverID
        let strVehicleType = vehicleTypeData.Id

        dictParam["DriverId"] = driverID as AnyObject
        dictParam["ModelId"] = strVehicleType as AnyObject
        dictParam["PickupLocation"] = txtPickupLocation.text as AnyObject
        dictParam["DropoffLocation"] = txtDropLocation.text as AnyObject
        dictParam["PassengerName"] = txtContactName.text as AnyObject
        dictParam["PassengerContact"] = txtMobileNumber.text as AnyObject
        dictParam["PassengerEmail"] = txtCustomerEmail.text as AnyObject
//        dictParam["FareAmount"] = setAmount.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
        dictParam["PaymentType"] = paymentType as AnyObject
        dictParam["PickupDateTime"] = convertDateToString as AnyObject
        var FareAmountWithDollar = txtFareAmount.text
        FareAmountWithDollar?.removeFirst()
        
        let fareAmount = Double(FareAmountWithDollar!.trimmingCharacters(in: .whitespacesAndNewlines))
        dictParam["FareAmount"] = fareAmount! as AnyObject
        
        dictParam["FlightNumber"] = txtFlightNumber.text as AnyObject
        dictParam["Notes"] = txtNotes.text as AnyObject
        
        
        webserviceForSubmitBookLaterByDispatchJob(dictParam as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                
             
                let alert = UIAlertController(title: "Successfully", message: "Your dispatch job later request send", preferredStyle: .alert)
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
                    
                    if let isErrorMessage = resDict.object(forKey: "message") as? String {
                        
                        UtilityClass.showAlert(appName.kAPPName, message: isErrorMessage , vc: self)
                    }
                    else
                    {
                        UtilityClass.showAlert(appName.kAPPName, message: (resDict.object(forKey: "message") as! NSArray).object(at: 0) as! String, vc: self)

                    }
                }
                else if let resAry = result as? NSArray {
                    UtilityClass.showAlert(appName.kAPPName, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: "message") as! String, vc: self)
                }
            }
        }
       
    }
    
    
    
    func validationForDispathcJobsLater() -> Bool {
        
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
        else if (btnTimeAndDate.titleLabel?.text!.count == 0) {
            UtilityClass.showAlert(appName.kAPPName, message: "Enter Time and Date", vc: self)
            return false
        }
        else if (vehicleTypeData.Id == "") {
            UtilityClass.showAlert(appName.kAPPName, message: "Select Vehicle Type", vc: self)
            return false
        }
        
        
        return true
    }
    
    
    
    
}

