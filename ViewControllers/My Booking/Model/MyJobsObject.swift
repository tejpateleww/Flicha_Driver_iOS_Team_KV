//
//  MyJobsObject.swift
//  HJM Carrier
//
//  Created by Apple on 09/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import SwiftyJSON


class MyJobsObject : Codable {
    
    var autoId : String!
    var bookingStatus : String!
    var bookingType : String!
    var cash : String!
    var chargeToShipper : String!
    var container : Int!
    var customer : MyJobsCustomer!
    var customerId : Int!
    var distance : String!
    var documents : String!
    var hjmCommission : String!
    var id : String!
    var otpVerify : Int!
    var paidToDriver : String!
    var paymentType : String!
    var qty : Int!
    var status : String!
    var subTotal : String!
    var total : String!
    var truckInfo : MyJobsTruckInfo!
    var truckType : Int!
    var truckTypeData : MyJobsTruckTypeDatum!
    var type : String!
    var vat : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty{
            return
        }
        autoId = json["auto_id"].stringValue
        bookingStatus = json["booking_status"].stringValue
        bookingType = json["booking_type"].stringValue
        cash = json["cash"].stringValue
        chargeToShipper = json["charge_to_shipper"].stringValue
        container = json["container"].intValue
        let customerJson = json["customer"]
        if !customerJson.isEmpty{
            customer = MyJobsCustomer(fromJson: customerJson)
        }
        customerId = json["customer_id"].intValue
        distance = json["distance"].stringValue
        documents = json["documents"].stringValue
        hjmCommission = json["hjm_commission"].stringValue
        id = json["id"].stringValue
        otpVerify = json["otp_verify"].intValue
        paidToDriver = json["paid_to_driver"].stringValue
        paymentType = json["payment_type"].stringValue
        qty = json["qty"].intValue
        status = json["status"].stringValue
        subTotal = json["sub_total"].stringValue
        total = json["total"].stringValue
        let truckInfoJson = json["truck_info"]
        if !truckInfoJson.isEmpty {
            truckInfo = MyJobsTruckInfo(fromJson: truckInfoJson)
        }
        truckType = json["truck_type"].intValue
        let truckTypeDataJson = json["truck_type_data"]
        if !truckTypeDataJson.isEmpty {
            truckTypeData = MyJobsTruckTypeDatum(fromJson: truckTypeDataJson)
        }
        type = json["type"].stringValue
        vat = json["vat"].stringValue
    }
    
}

class MyJobsTruckTypeDatum : Codable {
    
    var code : String!
    var freeLoadingWaitingHours : String!
    var freeOffloadingWaitingHours : String!
    var icon : String!
    var iconSelected : String!
    var id : String!
    var loadingWaitFee : String!
    var name : String!
    var offloadingWaitFee : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        code = json["code"].stringValue
        freeLoadingWaitingHours = json["free_loading_waiting_hours"].stringValue
        freeOffloadingWaitingHours = json["free_offloading_waiting_hours"].stringValue
        icon = json["icon"].stringValue
        iconSelected = json["icon_selected"].stringValue
        id = json["id"].stringValue
        loadingWaitFee = json["loading_wait_fee"].stringValue
        name = json["name"].stringValue
        offloadingWaitFee = json["offloading_wait_fee"].stringValue
    }
    
}
class MyJobsTruckInfo : Codable {
    
    var acceptTime : String!
    var arrivedTime : String!
    var bookingId : Int!
    var driverId : Int!
    var driverInfo : MyJobsDriverInfo!
    var id : Int!
    var info: String!
    var loadType : String!
    var loadTypeCharge : String!
    var loadingCash : String!
    var loadingExtraHours : String!
    var loadingPaymentStatus : Int!
    var locations : [MyJobsLocation]!
    var otp : String!
    var otpVerify : Int!
    var paidToDriver : String!
    var payloadCharge : String!
    var payloadHeight : String!
    var payloadHeightFee : String!
    var payloadSize : String!
    var paymentType : String!
    var startLoadingTime : String!
    var status : String!
    var stopLoadingTime : String!
    var tripStatus : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        acceptTime = json["accept_time"].stringValue
        arrivedTime = json["arrived_time"].stringValue
        bookingId = json["booking_id"].intValue
        driverId = json["driver_id"].intValue
        let driverInfoJson = json["driver_info"]
        if !driverInfoJson.isEmpty{
            driverInfo = MyJobsDriverInfo(fromJson: driverInfoJson)
        }
        id = json["id"].intValue
        info = json["info"].stringValue
        loadType = json["load_type"].stringValue
        loadTypeCharge = json["load_type_charge"].stringValue
        loadingCash = json["loading_cash"].stringValue
        loadingExtraHours = json["loading_extra_hours"].stringValue
        loadingPaymentStatus = json["loading_payment_status"].intValue
        locations = [MyJobsLocation]()
        let locationsArray = json["locations"].arrayValue
        for locationsJson in locationsArray{
            let value = MyJobsLocation(fromJson: locationsJson)
            locations.append(value)
        }
        otp = json["otp"].stringValue
        otpVerify = json["otp_verify"].intValue
        paidToDriver = json["paid_to_driver"].stringValue
        payloadCharge = json["payload_charge"].stringValue
        payloadHeight = json["payload_height"].stringValue
        payloadHeightFee = json["payload_height_fee"].stringValue
        payloadSize = json["payload_size"].stringValue
        paymentType = json["payment_type"].stringValue
        startLoadingTime = json["start_loading_time"].stringValue
        status = json["status"].stringValue
        stopLoadingTime = json["stop_loading_time"].stringValue
        tripStatus = json["trip_status"].stringValue
    }
    
}
class MyJobsLocation : Codable {
    
    var bookingId : String!
    var distance : String!
    var dropDate : String!
    var dropTime : String!
    var dropoffLat : String!
    var dropoffLng : String!
    var dropoffLocation : String!
    var id : String!
    var offLoadingExtraHours : String!
    var offloadingCash : String!
    var otp : String!
    var otpVerify : String!
    var pickupDate : String!
    var pickupLat : String!
    var pickupLng : String!
    var pickupLocation : String!
    var pickupTime : String!
    var receiverName : String!
    var receiverPhone : String!
    var startOffloadingTime : String!
    var stopOffloadingTime : String!
    var truckId : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        bookingId = json["booking_id"].stringValue
        distance = json["distance"].stringValue
        dropDate = json["drop_date"].stringValue
        dropTime = json["drop_time"].stringValue
        dropoffLat = json["dropoff_lat"].stringValue
        dropoffLng = json["dropoff_lng"].stringValue
        dropoffLocation = json["dropoff_location"].stringValue
        id = json["id"].stringValue
        offLoadingExtraHours = json["off_loading_extra_hours"].stringValue
        offloadingCash = json["offloading_cash"].stringValue
        otp = json["otp"].stringValue
        otpVerify = json["otp_verify"].stringValue
        pickupDate = json["pickup_date"].stringValue
        pickupLat = json["pickup_lat"].stringValue
        pickupLng = json["pickup_lng"].stringValue
        pickupLocation = json["pickup_location"].stringValue
        pickupTime = json["pickup_time"].stringValue
        receiverName = json["receiver_name"].stringValue
        receiverPhone = json["receiver_phone"].stringValue
        startOffloadingTime = json["start_offloading_time"].stringValue
        stopOffloadingTime = json["stop_offloading_time"].stringValue
        truckId = json["truck_id"].stringValue
    }
    var dateDescription: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            //            formatter.amSymbol = "as"
            //            formatter.pmSymbol = "ds"
            let date = formatter.date(from: pickupTime)
            formatter.dateFormat = "hh:mm a"
            if date != nil {
                let strPickupTime = formatter.string(from: date!)
                 return pickupDate + " - " + strPickupTime
            }
            
             return pickupDate
           
        }
    }
}
class MyJobsDriverInfo : Codable {
    
    var altPhone : String!
    var email : String!
    var firstName : String!
    var id : String!
    var image : String!
    var lastName : String!
    var phone : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty{
            return
        }
        altPhone = json["alt_phone"].stringValue
        email = json["email"].stringValue
        firstName = json["first_name"].stringValue
        id = json["id"].stringValue
        image = json["image"].stringValue
        lastName = json["last_name"].stringValue
        phone = json["phone"].stringValue
    }
}

class MyJobsCustomer : Codable {
    
    var email : String!
    var firstName : String!
    var id : String!
    var image : String!
    var lastName : String!
    var phone : String!
    var rating : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        email = json["email"].stringValue
        firstName = json["first_name"].stringValue
        id = json["id"].stringValue
        image = json["image"].stringValue
        lastName = json["last_name"].stringValue
        phone = json["phone"].stringValue
        rating = json["rating"].stringValue
    }
    var fullName: String {
        get {
            return firstName + " " + lastName
        }
    }
    
}

class PastBookingHistoryResponse : Codable {

    var acceptTime : String!
    var arrivedTime : String!
    var baseFare : String!
    var bookingFee : String!
    var bookingTime : String!
    var bookingType : String!
    var cancelBy : String!
    var cancellationCharge : String!
    var cardId : String!
    var companyAmount : String!
    var customerId : String!
    var discount : String!
    var distance : String!
    var distanceFare : String!
    var driverAmount : String!
    var driverFirstName : String!
    var driverId : String!
    var driverLastName : String!
    var dropoffLat : String!
    var dropoffLng : String!
    var dropoffLocation : String!
    var dropoffTime : String!
    var durationFare : String!
    var estimatedFare : String!
    var grandTotal : String!
    var id : String!
    var noOfPassenger : String!
    var onTheWay : String!
    var paymentStatus : String!
    var paymentType : String!
    var pickupDateTime : String!
    var pickupLat : String!
    var pickupLng : String!
    var pickupLocation : String!
    var pickupTime : String!
    var promocode : String!
    var referenceId : String!
    var status : String!
    var subTotal : String!
    var tax : String!
    var tripDuration : String!
    var vehicleName : String!
    var vehicleTypeId : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */


    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        acceptTime = json["accept_time"].stringValue
        arrivedTime = json["arrived_time"].stringValue
        baseFare = json["base_fare"].stringValue
        bookingFee = json["booking_fee"].stringValue
        bookingTime = json["booking_time"].stringValue
        bookingType = json["booking_type"].stringValue
        cancelBy = json["cancel_by"].stringValue
        cancellationCharge = json["cancellation_charge"].stringValue
        cardId = json["card_id"].stringValue
        companyAmount = json["company_amount"].stringValue
        customerId = json["customer_id"].stringValue
        discount = json["discount"].stringValue
        distance = json["distance"].stringValue
        distanceFare = json["distance_fare"].stringValue
        driverAmount = json["driver_amount"].stringValue
        driverFirstName = json["driver_first_name"].stringValue
        driverId = json["driver_id"].stringValue
        driverLastName = json["driver_last_name"].stringValue
        dropoffLat = json["dropoff_lat"].stringValue
        dropoffLng = json["dropoff_lng"].stringValue
        dropoffLocation = json["dropoff_location"].stringValue
        dropoffTime = json["dropoff_time"].stringValue
        durationFare = json["duration_fare"].stringValue
        estimatedFare = json["estimated_fare"].stringValue
        grandTotal = json["grand_total"].stringValue
        id = json["id"].stringValue
        noOfPassenger = json["no_of_passenger"].stringValue
        onTheWay = json["on_the_way"].stringValue
        paymentStatus = json["payment_status"].stringValue
        paymentType = json["payment_type"].stringValue
        pickupDateTime = json["pickup_date_time"].stringValue
        pickupLat = json["pickup_lat"].stringValue
        pickupLng = json["pickup_lng"].stringValue
        pickupLocation = json["pickup_location"].stringValue
        pickupTime = json["pickup_time"].stringValue
        promocode = json["promocode"].stringValue
        referenceId = json["reference_id"].stringValue
        status = json["status"].stringValue
        subTotal = json["sub_total"].stringValue
        tax = json["tax"].stringValue
        tripDuration = json["trip_duration"].stringValue
        vehicleName = json["vehicle_name"].stringValue
        vehicleTypeId = json["vehicle_type_id"].stringValue
    }

}
