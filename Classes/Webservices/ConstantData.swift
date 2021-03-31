//
//  ConstantData.swift
//   TenTaxi-Driver
//
//  Created by Excellent Webworld on 17/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import Foundation

//let helpLineNumber = "1234567890"

struct WebSupport {
    static let HelplineNumber = "0777115054"
    static let SupportURL = "https://www.tantaxitanzania.com/page/support-tantaxi"
    static let TermsNConditionsURL = "https://www.tantaxitanzania.com/page/terms-conditions-drivers"
    static let PrivacyPolicyURL = "https://www.tantaxitanzania.com/page/privacy-policy"
}

struct WebserviceURLs {
    
    static let kBaseURL                                 = "https://flicha.com/web/Drvier_Api/"
    static let kImageBaseURL                            = "https://flicha.com/web/"
    static let kOTPForDriverRegister                    = "OtpForRegister"
    static let kVehicalModelList                        = "TaxiModel/"
    static let kDriverRegister                          = "Register"
    static let kDriverLogin                             = "Login"
    static let kDriverChangeDutyStatusOrShiftDutyStatus = "ChangeDriverShiftStatus/"
    static let kChangePassword                          = "ChangePassword"
    static let kUpdateProfile                           = "UpdateProfile"
    static let kForgotPassword                          = "ForgotPassword"
    static let kPastBooking                             = "PastJobs"
    static let kCompany                                 = "Company"
    static let KUpdateDriverBasicInfo                   = "UpdateDriverBasicInfo"
    static let KUpdateBankInfo                          = "UpdateBankInfo"
    static let kUpdateVehicleInfo                       = "UpdateVehicleInfo"
    static let kUpdateDocument                          = "UpdateDocs"
    static let kSubmitCompleteBooking                   = "SubmitCompleteBooking"
    static let kBookingHistory                          = "BookingHistory/"
    static let kDispatchJob                             = "DispatchJob/"
    static let kAcceptDispatchJobRequest                = "AcceptDispatchJobRequest/"
    static let kLogout                                  = "Logout/"
    static let kSubmitCompleteAdvancedBooking           = "SubmitCompleteAdvancedBooking"
    static let kSubmitBookNowByDispatchJob              = "SubmitBookNowByDispatchJob"
    static let kSubmitBookLaterByDispatchJob            = "SubmitBookLaterByDispatchJob"
    static let kFutureBooking                           = "FutureBooking/"
    static let kPendingBooking                          = "PendingJobs/"
    static let kMyDispatchJob                           = "MyDispatchJob/"
    static let kGetDriverProfile                        = "GetDriverProfile/"
    static let kGetDistaceFromBackend                   = "FindDistance/"
    static let kCurrentBooking                          = "CurrentBooking/"
    static let kAddNewCard                              = "AddNewCard"
    static let kCards                                   = "Cards/"
    static let kAddMoney                                = "AddMoney"
    static let kTransactionHistory                      = "TransactionHistory/"
    static let kSendMoney                               = "SendMoney"
    static let kQRCodeDetails                           = "QRCodeDetails"
    static let kRemoveCard                              = "RemoveCard/"
    static let kTickpay                                 = "Tickpay"
    static let kGetTickpayRate                          = "GetTickpayRate"
    static let kTickpayInvoice                          = "TickpayInvoice"
    static let kNEWSUrl                                 = "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey="
    static let kNEWSApiKey                              = "90727bb768584fd7b64b66c9190921e0"
    static let kReviewRating                            = "ReviewRating"
    static let kWeeklyEarnings                          = "WeeklyEaringIOS/"
    static let kTransferMoneyToBank                     = "TransferToBank"
    static let kInit                                    = "Init/"
    static let kGetEstimateFare                         = "GetEstimateFare"
    static let kGetTaxiModelPricing                     = "TaxiModelForPricing"
    static let kGetFareEstimateWithKM                   = "GetEstimateFareWithKM"
    static let kCancelTrip                              = "CancelTrip"
    static let kManageTripToDestination                 = "ManageTripToDestination"
    static let kManageShareRideFlag                     = "ManageShareRideFlag/"
    static let kShareRide                               = "ShareRide/"
    static let kTrackRunningTrip                        = "TrackRunningTrip/"
    static let kPrivateMeterBooking                     = "PrivateMeterBooking"
    static let kShowUserRating                          = "ShowUserRating"
    static let kNotificationList                        = "NotificationList/"
    static let kUpdateSettings                          = "UpdateNotificationSetting"
    static let kFaqList                                 = "FaqList"
    //    static let kGetEstimateFare                         = "GetEstimateFare"
    
    //    https://www.tantaxitanzania.com/Drvier_Api/FeedbackList/9
    static let kFeedbackList                            = "FeedbackList/"
}

struct OTPEmail {
    static let kEmail = "Email"
}

struct OTPCodeStruct {
    static let kOTPCode = "OTPCode"
    static let kCompanyList = "company"
}


struct savedDataForRegistration {
    static let kKeyEmail                             = "Email"
    static let kKeyOTP                               = "OTP"
    static let kKeyAllUserDetails                    = "CompleteUserDetails"
    static let kModelDetails                         = "CompleteModelDetails"
    static let kPageNumber                           = "PageNumber"
}

struct profileKeys {
    static let kDriverId = "DriverId"
    static let kCarModel = "CarModel"
    static let kCarCompany = "CarCompany"
    static let kCompanyID = "CompanyId"
    
}

struct RegistrationProfileKeys {
    static let kKeyEmail = "email"
    static let kKeyFullName = "fullName"
    static let kKeyDOB = "DOB"
    static let kKeyMobileNumber = "mobileNumber"
    static let kKeyPassword = "password"
    static let kKeyAddress = "address"
    static let kKeyPostCode = "postCode"
    static let kKeyState = "state"
    static let kKeyCountry = "country"
    static let kKeyInviteCode = "inviteCode"
}

struct driverProfileKeys
{
    static let kKeyDriverProfile = "driverProfile"
    static let kKeyIsDriverLoggedIN = "isDriverLoggedIN"
    static let kKeyShowTickPayRegistrationScreen = "showTickPayRegistrationKey"
    
}
//struct driverTripToDestinationKeys
//{
//    static let kKeyFirstDestination = "FirstDestination"
//    static let kKeySecondDestination = "SecondDestination"
//    static let kKeyIsBothDestinationSelected = "isBothDestinationSelected"
//    static let kKeyIsFirstDestinationSelected = "isFirstDestinationSelected"
//    static let kKeyIsSecondDestinationSelected = "isSecondDestinationSelected"
//}

struct RegistrationFinalKeys {
    
    static let kPageNo = "1"
    static let kEmail = "Email"                          // Done
    
    static let kCompanyID = "CompanyId" // Done
    // ------------------------------------------------------------
    static let kKeyDOB = "DOB"
    
    static let kMobileNo = "MobileNo"// Done
    static let kFullname = "Fullname"// Done
    static let kSMSKey = "SMSKey"
    static let kGender = "Gender"// Done
    static let kPassword = "Password"// Done
    static let kAddress = "Address"// Done
    
    static let kSuburb = "Suburb"// Done
    
    static let kBankBranch = "BankBranch"// Done
    static let kCity = "City"// Done
    static let kState = "State"// Done
    static let kCountry = "Country"// Done
    static let kZipcode = "Zipcode"
    static let kDriverImage = "DriverImage" //Done
    static let kDriverLicence = "DriverLicence" //Done
    static let kAccreditationCertificate = "AccreditationCertificate" //Done
    static let kDriverLicenceExpiryDate = "DriverLicenseExpire" //Done
    static let kAccreditationCertificateExpiryDate = "AccreditationCertificateExpire" //Done
    static let kbankHolderName = "AccountHolderName"
    static let kBankName = "BankName"// Done
    static let kBankAccountNo = "BankAcNo"// Done
    static let kABN = "ABN"// Done
    static let kBSB = "BSB"// Done
    static let kServiceDescription = "Description"
    static let kVehicleColor = "VehicleColor" //Done
    static let kCarRegistrationCertificate = "CarRegistrationCertificate" //Done
    static let kVehicleInsuranceCertificate = "VehicleInsuranceCertificate" //Done
    static let kCarRegistrationExpiryDate = "RegistrationCertificateExpire" //Done
    static let kVehicleInsuranceCertificateExpiryDate = "VehicleInsuranceCertificateExpire" //Done
    static let kProxy = "Proxy"
    static let kReferralCode = "ReferralCode" //Done
    static let kLat = "Lat"//Done
    static let kLng = "Lng"//Done
    static let kCarThreeTypeName = "CarTypeName"
    
    
    //         String DRIVER_REGISTER_PARAM_VEHICLE_IMAGE = "VehicleImage";
    //        String DRIVER_REGISTER_PARAM_VEHICLE_RIGISTRATION_NO = "VehicleRegistrationNo";
    //        String DRIVER_REGISTER_PARAM_VEHICLE_MODEL_NAME = "VehicleModelName";
    //        String DRIVER_REGISTER_PARAM_VEHICLE_MAKE = "CompanyModel";
    //        String DRIVER_REGISTER_PARAM_VEHICLE_TYPE = "VehicleClass";
    //        String DRIVER_REGISTER_PARAM_NO_OF_PASSENGER = "NoOfPassenger";
    
    
    static let kVehicleRegistrationNo = "VehicleRegistrationNo" //Done
    static let kVehicleImage = "VehicleImage" //Done
    static let kCompanyModel = "CompanyModel" //Done
    static let kVehicleModelName = "VehicleModelName" //Done
    static let kNumberOfPasssenger = "NoOfPassenger" //Done
    static let kVehicleClass = "VehicleClass" //Done
    
    
}

struct socketApiKeys {
    
    static let kSocketBaseURL = "https://flicha.com:8080"
    static let kUpdateDriverLocation = "UpdateDriverLatLong"
    static let kReceiveBookingRequest = "AriveBookingRequest"
    static let kRejectBookingRequest = "ForwardBookingRequestToAnother"
    static let kAcceptBookingRequest = "AcceptBookingRequest"
    
    static let kLat = "Lat"
    static let kLong = "Long"
    static let kBookingId = "BookingId"
    
    static let kAdvanceBookingID = "BookingId"
    
    static let kGetBookingDetailsAfterBookingRequestAccepted = "BookingInfo"
    static let kPickupPassengerByDriver = "PickupPassenger"
    
    static let kStartHoldTrip = "StartHoldTrip"
    static let kEndHoldTrip = "EndHoldTrip"
    
    static let kDriverCancelTripNotification = "DriverCancelTripNotification"
    static let kSendDriverLocationRequestByPassenger        = "DriverLocation"
    
    static let kAriveAdvancedBookingRequest = "AriveAdvancedBookingRequest"
    static let kForwardAdvancedBookingRequestToAnother = "ForwardAdvancedBookingRequestToAnother"
    static let kAcceptAdvancedBookingRequest = "AcceptAdvancedBookingRequest"
    static let kAdvancedBookingPickupPassenger = "AdvancedBookingPickupPassenger"
    static let kAdvancedBookingStartHoldTrip = "AdvancedBookingStartHoldTrip"
    static let kAdvancedBookingEndHoldTrip = "AdvancedBookingEndHoldTrip"
    static let kAdvancedBookingCompleteTrip = "AdvancedBookingCompleteTrip"
    static let kAdvancedBookingDriverCancelTripNotification = "AdvancedBookingDriverCancelTripNotification"
    static let kAdvancedBookingInfo = "AdvancedBookingInfo"
    static let kAdvancedBookingPickupPassengerNotification = "AdvancedBookingPickupPassengerNotification"
    
    static let kBookLaterDriverNotify = "BookLaterDriverNotify"
    static let kReceiveMoneyNotify = "ReceiveMoneyNotify"
    
    static let kStartTripTimeError = "StartTripTimeError"
    
    static let kAskForTips = "AskForTips"
    static let kReceiveTipsToDriver = "ReceiveTipsToDriver"
    
    static let kAskForTipsForBookLater = "AskForTipsForBookLater"
    static let kReceiveTipsToDriverForBookLater = "ReceiveTipsToDriverForBookLater"
    
}

struct appName {
    static let kAPPName = "App Name".localized
    //    "TanTaxi Driver"
    static let kAPPUrl = "itms-apps://itunes.apple.com/app/id1445179587"
    
}

//Email,MobileNo,Fullname,Gender,Password,Address,ReferralCode,Lat,Lng,
//CarModel,
//DriverLicence,CarRegistration,AccreditationCertificate,VehicleInsuranceCertificate


struct nsNotificationKeys {
    
    static let kBookingTypeBookNow = "BookingTypeBookNow"
    static let kBookingTypeBookLater = "BookingTypeBookLater"
}

struct tripStatus {
    static let kisTripContinue = "isTripContinue"
    static let kisRequestAccepted = "isRequestAccepted"
}

struct holdTripStatus {
    static let kIsTripisHolding = "IsTripisHolding"
    
}

struct meterStatus {
    static let kIsMeterOnHolding = "meterOnHold"
    static let kIsMeterStart = "meterOnStart"
    static let kIsMeterStop = "meterOnStop"
}

struct walletAddCards {
    // DriverId,CardNo,Cvv,Expiry,Alias (CarNo : 4444555511115555,Expiry:09/20)
    static let kCardNo = "CardNo"
    static let kCVV = "Cvv"
    static let kExpiry = "Expiry"
    static let kAlias = "Alias"
    
}

struct walletAddMoney {
    // DriverId,Amount,CardId
    static let kAmount = "Amount"
    static let kCardId = "CardId"
}

struct  walletSendMoney {
    // QRCode,SenderId,Amount
    
    static let kQRCode = "QRCode"
    static let kAmount = "Amount"
    static let kSenderId = "SenderId"
}

struct passengerData {
    static let kPassengerMobileNunber = "PassengerMobileNunber"
}



//-------------------------------------------------------------
// MARK: - Device Types
//-------------------------------------------------------------


struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6_7        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P_7P      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

struct Version
{
    static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7 = (Version.SYS_VERSION_FLOAT < 8.0 && Version.SYS_VERSION_FLOAT >= 7.0)
    static let iOS8 = (Version.SYS_VERSION_FLOAT >= 8.0 && Version.SYS_VERSION_FLOAT < 9.0)
    static let iOS9 = (Version.SYS_VERSION_FLOAT >= 9.0 && Version.SYS_VERSION_FLOAT < 10.0)
    static let iOS10 = (Version.SYS_VERSION_FLOAT >= 10.0 && Version.SYS_VERSION_FLOAT < 11.0)
    static let iOS11 = (Version.SYS_VERSION_FLOAT >= 11.0 && Version.SYS_VERSION_FLOAT < 12.0)
}





