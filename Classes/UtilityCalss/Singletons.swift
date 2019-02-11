//
//  Singletons.swift
//   TenTaxi-Driver
//
//  Created by Excellent Webworld on 28/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class Singletons: NSObject {
    
    static let sharedInstance = Singletons()

//    var isOnTabbarView = Bool()
    var dictDriverProfile : NSMutableDictionary!
    var arrVehicleClass: NSMutableArray!
 
    var AryVehicleClass: [Int]!
    
    var isFirstTimeDidupdateLocation = true
    var aryPassengerInfo = NSArray()
    var strPassengerID = String()
    var CardsVCHaveAryData = [[String:AnyObject]]()
    var walletHistoryData = [[String:AnyObject]]()
    var DriverTripCurrentStatus = String()
    var strQRCodeForSendMoney = String()
    var strIsFirstTimeTickPay = String()
    var strTickPayId = String()
    var strAmoutOFTickPay = String()
    var deviceToken = String()
    var setPasscode = String()
    var strSetCar = String()
    var passengerType = String()
    var pasengerFlightNumber = String()
    var passengerNote = String()
    var strBookingType = String()
    var passengerPaymentType = String()
    var strDriverID = String()
    var strPromocode = String()
    var strPaymentType = String()
    var strRating = String()
    var vehicleClass: String!
    var strTickPayAmt: String!
    var driverDuty: String!
    var strPendinfTripData = String()
    
    var startedTripLatitude = Double()
    var startedTripLongitude = Double()
    var endedTripLatitude = Double()
    var endedTripLongitude = Double()
    var strCurrentBalance = Double()
    var floatBearing:Double = 0.0
    var currentLatitude: Double!
    var currentLongitude: Double!
    var latitude : Double!
    var longitude : Double!
    var distanceTravelledThroughMeter = Double()
    
    var isDriverLoggedIN : Bool!
    var isPasscodeON = Bool()
    var isFromRegistration = Bool()
    var boolTaxiModel = Bool() // if True { cars_and_taxi } if False { delivery_services }
    var isPresentVC = Bool()
    var isBackFromPending = Bool()
    var isFromNotification = Bool()
    var isTripContinue = Bool()
    var isRequestAccepted = Bool()
    var isTiCKPayFromSideMenu = Bool()
    var isTripHolding = Bool()
    var isBookNowORNot = Bool()
    var showTickPayRegistrationSceeen = Bool()
    var isFromTopUP = Bool()
    var isFromTransferToBank = Bool()
    var isSendMoneySuccessFully = Bool()
    var firstRequestIsAccepted = Bool()
    var isfirstTimeTickPay = Bool()
    // For Registration
    var isDriverVehicleTypesViewControllerFilled = Bool()
    var passwordFirstTime = Bool()
    var MeterStatus = String()
    var isCardsVCFirstTimeLoad: Bool = true
    var dictTripDestinationLocation = [String:AnyObject]()
    
    var isBookNowOrBookLater = Bool()
    
    /// if isPending 1 than Another trip is Accepted otherwise 0 than not accepted
    var isPending = Int()
    
    var bookingId = String()
    var advanceBookingId = String()
    var bookingIdTemp = String()
    var advanceBookingIdTemp = String()
    
    var oldBookingType = (isBookNow: false, isBookLater: false)
    
    /// if isShareRideOn 1 than ON else OFF
    var isShareRideOn = Bool()
    
    /// if RideType = ShareRide Than request from shareRide otherwise Normal Booking
    var strRideTypeFromAcceptRequest = String()
    
    /// isPickUPPasenger = true than Start Trip else only accepted
    var isPickUPPasenger: Bool!
    
}



class SingletonsForMeter: NSObject {
    
    static let sharedInstance = SingletonsForMeter()
    
    
    var strVehicleName = String()
    var baseFare = Double()
    var minKM = Double()
    var perKMCharge = Double()
    var waitingChargePerMinute = Double()
    var bookingFee = Double()
    var total = Double()
    var waitingMinutes = String()
    var strSpeed = String()
    var arrCarModels = [[String:AnyObject]]()
    var arrMeterCarModels = [[String:AnyObject]]()
    var vehicleModelID = Int()
    var isMeterOnHold = Bool()
}

class SingletonsForTripToDestination: NSObject
{
    
    static let sharedInstance = SingletonsForTripToDestination()
    
    var strFirstDestination = String()
    var strSecondDestination = String()
    var isFirstDestinationSelected = Bool()
    var isSecondDestinationSelected = Bool()
    var isTripDestinationHide = Bool()
    
//    var baseFare = Double()
//    var minKM = Double()
//    var perKMCharge = Double()
//    var waitingChargePerMinute = Double()
//    var bookingFee = Double()
//    var total = Double()
//    var waitingMinutes = String()
//    var strSpeed = String()
//    var arrCarModels = [[String:AnyObject]]()
//    var vehicleModelID = Int()

}

/*
if let passengerType = BookingInfo.object(forKey: "PassengerType") as? String {
    Singletons.sharedInstance.passengerType = passengerType
}
if let pasengerFlightNumber = BookingInfo.object(forKey: "FlightNumber") as? String {
    Singletons.sharedInstance.pasengerFlightNumber = pasengerFlightNumber
}
if let passengerNote = BookingInfo.object(forKey: "Notes") as? String {
    Singletons.sharedInstance.passengerNote = passengerNote
}
*/
