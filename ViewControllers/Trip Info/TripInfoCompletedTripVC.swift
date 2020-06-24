//
//  TripInfoCompletedTripVC.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 06/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import MarqueeLabel

class TripInfoCompletedTripVC: BaseViewController {
    var delegate: CompleterTripInfoDelegate!
    
    var dictData = NSDictionary()
    var dictDataPastJobs = [String: Any]()
    
    var isFromPastJobs = false
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet var lblBookingID: UILabel!
    
    
    //    @IBOutlet weak var lblDropOffLocationInFo: UILabel!
    //    @IBOutlet weak var lblPickUPLocationInFo: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var btnViewCompleteTripData: UIView!
    @IBOutlet weak var stackViewFlightNumber: UIStackView!
    @IBOutlet weak var stackViewNote: UIStackView!
    @IBOutlet weak var stackViewSpecialExtraCharge: UIStackView!
    
    @IBOutlet var lblPickUpTitle: UILabel! {
        didSet {
            lblPickUpTitle.font = UIFont.semiBold(ofSize: 13)
        }
    }
    @IBOutlet var lblDestinationTitle: UILabel! {
        didSet {
            lblDestinationTitle.font = UIFont.semiBold(ofSize: 13)
        }
    }
    
    @IBOutlet weak var lblPickupLocation: MarqueeLabel!{
        didSet {
            lblPickupLocation.font = UIFont.regular(ofSize: 13)
        }
    }
    
    @IBOutlet weak var lblDropOffLocation: MarqueeLabel!{
        didSet {
            lblDropOffLocation.font = UIFont.regular(ofSize: 13)
        }
    }
    
    @IBOutlet var lblPickupTimeTitle: UILabel!
    @IBOutlet var lblDropoffTimeTitle: UILabel!
    @IBOutlet var lblDistanceTravelledTitle: UILabel!
    @IBOutlet var lblPaymentTypeTitle: UILabel!
    @IBOutlet var lblBookingFeeTitle: UILabel!
    @IBOutlet var lblTripFareTitle: UILabel! {
        didSet {
            lblTripFareTitle.font = UIFont.regular(ofSize: 13)
        }
    } // base fare
    @IBOutlet weak var lblDistanceFareTitle: UILabel! {
        didSet {
            lblDistanceFareTitle.font = UIFont.regular(ofSize: 13)
        }
    }
    @IBOutlet var lblWaitingCostTitle: UILabel!{
        didSet {
            lblWaitingCostTitle.font = UIFont.regular(ofSize: 13)
        }
    }
    @IBOutlet var lblWaitingTimeTitle: UILabel!
    @IBOutlet var lblLessTitle: UILabel!
    @IBOutlet var lblPromoCodeTitle: UILabel!
    
    @IBOutlet var lblTripStatusTitle: UILabel!
    @IBOutlet weak var lblTipAmountTitle: UILabel!
    @IBOutlet weak var lblTaxTitle: UILabel!{
        didSet {
            lblTaxTitle.font = UIFont.regular(ofSize: 13)
        }
    }
    @IBOutlet var lblTotlaAmountTitle: UILabel! {
        didSet {
            lblTotlaAmountTitle.font = UIFont.regular(ofSize: 13)
        }
    }
    
    @IBOutlet weak var lblTollTitle: UILabel!{
        didSet {
            lblTollTitle.font = UIFont.regular(ofSize: 13)
        }
    }
    @IBOutlet weak var lblTollFee: UILabel!{
        didSet {
            lblTollFee.font = UIFont.semiBold(ofSize: 13)
        }
    }
    
    @IBOutlet var lblPickupTime: UILabel!
    @IBOutlet var lblDropoffTime: UILabel!
    @IBOutlet var lblDistanceTravelled: UILabel!
    @IBOutlet var lblPaymentType: UILabel!
    @IBOutlet var lblBookingFee: UILabel!
    @IBOutlet var lblTripFare: UILabel! {
        didSet {
            lblTripFare.font = UIFont.semiBold(ofSize: 13)
        }
    }
    @IBOutlet weak var lblDistanceFare: UILabel! {
        didSet {
            lblDistanceFare.font = UIFont.semiBold(ofSize: 13)
        }
    }
    @IBOutlet var lblWaitingCost: UILabel! {
        didSet {
            lblWaitingCost.font = UIFont.semiBold(ofSize: 13)
        }
    }
    @IBOutlet var lblTax: UILabel! {
        didSet {
            lblTax.font = UIFont.semiBold(ofSize: 13)
        }
    }
    @IBOutlet var lblTotlaAmount: UILabel!{
        didSet {
            lblTotlaAmount.font = UIFont.semiBold(ofSize: 13)
        }
    }
    @IBOutlet var lblWaitingTime: UILabel!
    @IBOutlet var lblPromoCode: UILabel!
    
    
    @IBOutlet var lblTripStatus: UILabel!
    @IBOutlet weak var lblTipAmount: UILabel!
    
    
    
    
    @IBOutlet weak var PickupTimeStack: UIStackView!
    @IBOutlet weak var DropoffTimeStack: UIStackView!
    @IBOutlet weak var PaymentTypeStack: UIStackView!
    @IBOutlet weak var DistanceTravelledStack: UIStackView!
    @IBOutlet weak var BookingFeeStack: UIStackView!
    @IBOutlet weak var TripFareStack: UIStackView!
    @IBOutlet weak var TipStack: UIStackView!
    @IBOutlet weak var WaitingCostStack: UIStackView!
    @IBOutlet weak var WaitingTimeStack: UIStackView!
    @IBOutlet weak var PromoCodeStack: UIStackView!
    @IBOutlet weak var TotalAmountStack: UIStackView!
    @IBOutlet weak var TripStatusStack: UIStackView!
    
    @IBOutlet weak var DistanceFareStack: UIStackView!
    
    
    
    //    @IBOutlet weak var lblTripDistanceInfo: UILabel!
    //    @IBOutlet weak var lblBaseFareInFo: UILabel!
    //    @IBOutlet weak var lblDistanceFare: UILabel!
    //    @IBOutlet weak var lblWaitingTimeInFo: UILabel!
    //
    //    @IBOutlet weak var lblBookingChargeDetail: UILabel!
    //    @IBOutlet weak var lblWaitingTimecostDetails: UILabel!
    //    @IBOutlet weak var lblWaitinfTimeDetails: UILabel!
    //    @IBOutlet weak var lblWaitingTimeCost: UILabel!
    //    @IBOutlet weak var lblDistanceFareInFo: UILabel!
    //    @IBOutlet weak var lblNightFare: UILabel!
    //    @IBOutlet weak var lblTollFree: UILabel!
    //
    //
    //    @IBOutlet weak var txtSpecialExtraCharge: UILabel!
    //    @IBOutlet weak var lblSubTotal: UILabel!
    //
    //
    //
    //    @IBOutlet weak var lblTaxInfo: UILabel!
    //    @IBOutlet weak var lblBookingChargeInfo: UILabel!
    //    @IBOutlet weak var lblDiscount: UILabel!
    //    @IBOutlet weak var lblTax: UILabel!
    //    @IBOutlet weak var lblGrandTotal: UILabel!
    //
    //    @IBOutlet weak var lblGrandTotalINfo: UILabel!
    //    @IBOutlet weak var lblFlightNumber: UILabel!
    //    @IBOutlet weak var lblNote: UILabel!
    
    
    //    @IBOutlet weak var lblNoteInFo: UILabel!
    //    @IBOutlet weak var lblBaseFare: UILabel!
    //    @IBOutlet weak var lblTripDistance: UILabel!
    //    @IBOutlet weak var lblDiatnceFare: UILabel!
    //    @IBOutlet weak var lblSpecialExtraCharge: UILabel!
    
    @IBOutlet weak var lblNavTitle: UILabel! {
        didSet {
            lblNavTitle.text = "Trip Detail".localized
            lblNavTitle.font = UIFont.bold(ofSize: 18)
        }
    }
    
    @IBOutlet weak var lblTripDetail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Singletons.sharedInstance.pasengerFlightNumber == "" {
            stackViewFlightNumber.isHidden = true
        }
        else {
            //            lblFlightNumber.text = Singletons.sharedInstance.pasengerFlightNumber
            //            stackViewFlightNumber.isHidden = false
        }
        
        if Singletons.sharedInstance.passengerNote == "" {
            stackViewNote.isHidden = true
        }
        else {
            //            lblNote.text = Singletons.sharedInstance.passengerNote
            //            stackViewNote.isHidden = false
        }
        if isFromPastJobs {
            setDataForPastJobs()
        }else {
            setData()
        }
        
        //        self.setNavigationBarInViewController(controller: self, naviTitle: "Trip Detail".localized, leftImage: iconBack, rightImages: [], isTranslucent: false)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setLocalization()
    }
    func setLocalization()
    {
        lblTripDetail.text = "Trip Info".localized
        //        lblPickupLocation.text =  "Address".localized
        //        lblDropOffLocation.text = "Address".localized
        
        lblTripFareTitle.text = "Base Fare".localized
        lblDistanceTravelledTitle.text = "Trip Distance".localized
        lblDistanceFareTitle.text  = "Distance Fare".localized
        lblWaitingCostTitle.text  = "Waiting Cost :".localized
        lblWaitingTimeTitle.text  = "Waiting Time :".localized
        lblTipAmountTitle.text  = "Tip by Passenger".localized
        lblBookingFeeTitle.text  = "Booking Charge".localized
        lblPromoCodeTitle.text  = "Discount :".localized
        lblTaxTitle.text  = "Tax" .localized
        lblTotlaAmountTitle.text  = "Grand Total :".localized
        lblLessTitle.text  = "(incl tax)".localized
        btnOK.setTitle("OK".localized, for: .normal) 
        lblTollTitle.text = "Toll Fee".localized
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnViewCompleteTripData.layer.cornerRadius = 10
        btnViewCompleteTripData.layer.masksToBounds = true
        
        btnOK.layer.cornerRadius = 10
        btnOK.layer.masksToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // ------------------------------------------------------------
    
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    func setData() {
        
        dictData = NSMutableDictionary(dictionary: (dictData.object(forKey: "details") as! NSDictionary))
        print(dictData)
        
        lblPickupLocation.text = dictData.object(forKey: "PickupLocation") as? String
        lblDropOffLocation.text = dictData.object(forKey: "DropoffLocation") as? String
        
        /*
         let PickTime = Double(dictData.object(forKey: "PickupTime") as! String)
         let dropoffTime = Double(dictData.object(forKey: "DropTime") as! String)
         let unixTimestamp = PickTime //as Double//as! Double//dictData.object(forKey: "PickupTime")
         let unixTimestampDrop = dropoffTime
         let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp!))
         let dateDrop = Date(timeIntervalSince1970: TimeInterval(unixTimestampDrop!))
         let dateFormatter = DateFormatter()
         //        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
         //        dateFormatter.locale = NSLocale.current
         dateFormatter.dateFormat = "yyyy/MM/dd HH:mm" //Specify your format that you want
         let strDate = dateFormatter.string(from: date)
         let strDateDrop = dateFormatter.string(from: dateDrop)
         
         lblPickupTime.text = strDate//dictData.object(forKey: "PickupDateTime") as? String
         
         lblDropoffTime.text = strDateDrop //dictData.object(forKey: "PickupDateTime") as? String
         //        lblTollFree.text = dictData.object(forKey: "TollFee") as? String
         
         if let BookingID = dictData.object(forKey: "Id") as? String {
         lblBookingID.text = "Booking Id : \(BookingID)"
         }
         
         dateFormatter.dateFormat = "yyyy/MM/dd"
         let strTripDate = dateFormatter.string(from: dateDrop)
         lblDate.text = strTripDate
         
         
         if let PaymentType = dictData.object(forKey: "PaymentType") as? String {
         lblPaymentType.text = PaymentType
         }
         
         let strdate1 = dictData.object(forKey: "CreatedDate") as? String
         let arrdate = strdate1?.components(separatedBy: " ")
         let finalDate = arrdate![0].replacingOccurrences(of: "-", with: "/")
         lblDate.text = finalDate//dictData.object(forKey: "PickupDate") as? String
         
         
         var strSpecial = String()
         
         if let special = dictData.object(forKey: "Special") as? String {
         strSpecial = special
         } else if let special = dictData.object(forKey: "Special") as? Int {
         strSpecial = String(special)
         }
         lblTripStatus.text = dictData.object(forKey: "Status") as? String
         stackViewSpecialExtraCharge.isHidden = true
         
         if strSpecial == "1" {
         stackViewSpecialExtraCharge.isHidden = false
         
         //            if let SpecialExtraCharge = dictData.object(forKey: "SpecialExtraCharge") as? String {
         //                lblSpecialExtraCharge.text = SpecialExtraCharge
         //            } else if let SpecialExtraCharge = dictData.object(forKey: "SpecialExtraCharge") as? Double {
         //                lblSpecialExtraCharge.text = String(SpecialExtraCharge)
         //            }
         }
         
         */
        
        if let TripFare = dictData.object(forKey: "TripFare") as? String {
            lblTripFare.text = "\(currency)\(String(format: "%.2f", Double(TripFare)!))"
        }
        
        if let TripDistance = dictData.object(forKey: "TripDistance") as? String {
            lblDistanceTravelled.text = "\(String(format: "%.2f", Double(TripDistance)!)) km"
        }
        
        if let DistanceFare = dictData.object(forKey: "DistanceFare") as? String {
            lblDistanceFare.text = " \(currency)\(String(format: "%.2f", Double(DistanceFare)!))"
        }
        
        if let WaitingTime = dictData.object(forKey: "WaitingTime") as? String {
            let (h,m,s) = secondsToHoursMinutesSeconds(seconds: Int(WaitingTime) ?? 0)
            lblWaitingTime.text = "\(getStringFrom(seconds: h)):\(getStringFrom(seconds: m)):\(getStringFrom(seconds: s))"
        }
        
        if let WaitingCost = dictData.object(forKey: "WaitingTimeCost") as? String {
            lblWaitingCost.text = "\(currency)\(WaitingCost)"
            //            "\(String(format: "%.2f", Double(WaitingCost)!)) \(currency)"
        }
        
        if let Tip = dictData.object(forKey: "TollFee") as? String {
            lblTollFee.text = (Tip != "" && Tip != "0") ? "\(currency)\(String(format: "%.2f", Double(Tip)!))" : " \(currency)0"
        }
        
        if let BookingFee = dictData.object(forKey: "BookingCharge") as? String {
            lblBookingFee.text = (BookingFee != "" && BookingFee != "0") ? "\(currency)\(String(format: "%.2f", Double(BookingFee)!))" : "\(currency)0"
        }
        
        if let discount = dictData.object(forKey: "Discount") as? String {
            lblPromoCode.text = (discount != "" && discount != "0") ? "\(currency)\(String(format: "%.2f", Double(discount)!))" : "\(currency)0"
        }
        
        if let Tax = dictData.object(forKey: "Tax") as? String {
            lblTax.text = (Tax != "" && Tax != "0") ? "\(currency)\(Tax)" : "\(currency)0"
        }
        
        if let GrandTotal = dictData.object(forKey: "GrandTotal") as? String {
            lblTotlaAmount.text = (GrandTotal != "" && GrandTotal != "0") ? "\(currency)\(GrandTotal)" : "\(currency)0"
        }
        
    }
    
    func setDataForPastJobs() {
        
        /* ["DropoffLocation": Adarsh Rd, Nikol, Ahmedabad, Gujarat 382350, India, "PassengerMobileNo": , "PickupLocation": Adarsh Rd, Nikol, Ahmedabad, Gujarat 382350, India, "PassengerId": 964, "Id": 964, "MapUrl": https://maps.googleapis.com/maps/api/staticmap?zoom=9&size=250x150&maptype=roadmap&markers=color:blue|label:S|23.037431416440267,72.6716345921159&markers=color:red|label:D|23.0386956,72.6307533&path=color:0x0000ff|weight:5|23.037431416440267,72.6716345921159|23.0386956,72.6307533&key=AIzaSyB8BAH4CgnptmVp50tevNwjytJnSqkVcEI, "Notes": , "TripDistance": 0.00, "WaitingTimeCost": 0, "PickupDateTime": 2020-05-22 11:04:44, "DriverName": First Name, "TransactionId": , "PaymentType": cash, "NoOfPassenger": 1, "HistoryType": Past, "PromoCode": , "Reason": , "CancelBy": , "Special": 0, "BookingType": Book Now, "TripFare": 500, "SubTotal": 500, "PickupLat": 23.037431416440267, "Status": completed, "PassengerEmail": developer.eww4@gmail.com, "DropOffLon": 72.6307533, "CompanyAmount": 500, "Discount": 0, "EstimatedFare": 4455.00, "ByDriverId": 0, "TipStatus": 0, "CardId": 0, "swahili_PaymentType": Taslimu, "NightFare": 0, "PickupTime": 1590145496, "PickupLng": 72.6716345921159, "BookingCharge": 0, "TollFee": 0, "Timestamp": 1590145484, "Trash": 0, "Tax": 90, "AdminAmount": 0, "ModelId": 1, "WaitingTime": 0, "FlightNumber": , "PassengerName": mayur patel, "Model": 1, "PaidToDriver": 0, "CreatedDate": 2020-05-22 11:04:44, "PassengerContact": , "TripDuration": 8, "DropTime": 1590145504, "GrandTotal": 500, "SpecialExtraCharge": 0, "DropOffLat": 23.0386956, "DriverId": 6, "ByDriverAmount": , "DistanceFare": 0, "ShareRide": 0, "swahili_BookingStatus": Imekamilika, "PaymentStatus": , "CompanyId": 1, "NightFareApplicable": 0] */
        lblPickupLocation.text = dictDataPastJobs["PickupLocation"] as? String
        lblDropOffLocation.text = dictDataPastJobs["DropoffLocation"] as? String
        
        
        
        if let TripFare = dictDataPastJobs["TripFare"] as? String,!TripFare.isEmpty {
            lblTripFare.text = "\(currency)\(String(format: "%.2f", Double(TripFare)!))"
        }
        
        if let TripDistance = dictDataPastJobs["TripDistance"] as? String,!TripDistance.isEmpty {
            lblDistanceTravelled.text = "\(String(format: "%.2f", Double(TripDistance)!)) km"
        }
        
        if let DistanceFare = dictDataPastJobs["DistanceFare"] as? String,!DistanceFare.isEmpty {
            lblDistanceFare.text = " \(currency)\(String(format: "%.2f", Double(DistanceFare)!))"
        }
        
        if let WaitingTime = dictDataPastJobs["WaitingTime"] as? String {
            let (h,m,s) = secondsToHoursMinutesSeconds(seconds: Int(WaitingTime) ?? 0)
            lblWaitingTime.text = "\(getStringFrom(seconds: h)):\(getStringFrom(seconds: m)):\(getStringFrom(seconds: s))"
        }
        
        if let WaitingCost = dictDataPastJobs["WaitingTimeCost"] as? String {
            lblWaitingCost.text = "\(currency)\(WaitingCost)"
            //            "\(String(format: "%.2f", Double(WaitingCost)!)) \(currency)"
        }
        
        if let Tip = dictDataPastJobs["TollFee"] as? String {
            lblTollFee.text = (Tip != "" && Tip != "0") ? "\(currency)\(String(format: "%.2f", Double(Tip)!))" : " \(currency)0"
        }
        
        if let BookingFee = dictDataPastJobs["BookingCharge"] as? String {
            lblBookingFee.text = (BookingFee != "" && BookingFee != "0") ? "\(currency)\(String(format: "%.2f", Double(BookingFee)!))" : "\(currency)0"
        }
        
        if let discount = dictDataPastJobs["Discount"] as? String {
            lblPromoCode.text = (discount != "" && discount != "0") ? "\(currency)\(String(format: "%.2f", Double(discount)!))" : "\(currency)0"
        }
        
        if let Tax = dictDataPastJobs["Tax"] as? String {
            lblTax.text = (Tax != "" && Tax != "0") ? "\(currency)\(Tax)" : "\(currency)0"
        }
        
        if let GrandTotal = dictDataPastJobs["GrandTotal"] as? String {
            lblTotlaAmount.text = (GrandTotal != "" && GrandTotal != "0") ? "\(currency)\(GrandTotal)" : "\(currency)0"
        }
        
    }
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func getStringFrom(seconds: Int) -> String {
        
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    @IBOutlet weak var btnOK: UIButton!
    
    @IBAction func btnOK(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        if !isFromPastJobs {
            if Singletons.sharedInstance.passengerType == "other" || Singletons.sharedInstance.passengerType == "others"
            {
                //            self.completeTripInfo()
            }
            else
            {
                self.delegate.didRatingCompleted()
            }
            Singletons.sharedInstance.passengerType = ""
        }
     
    }
    
}
