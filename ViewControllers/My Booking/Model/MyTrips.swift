//
//  MyTrips.swift
//  Pappea Driver
//
//  Created by EWW-iMac Old on 05/07/19.
//  Copyright © 2019 baps. All rights reserved.
//

import Foundation

enum MyTrips: String, CaseIterable{
    
    case future = "Future Jobs"
    case pending = "Pending Jobs"
    case past = "Past Jobs"
    
//    case past = "Complete"
//    case live = "Live"
//    case upcoming = "Upcoming"
    
  
    func getDescription(pastBookingHistory : PastBookingHistoryResponse) -> [(String, String)]{
        switch self {
        case .future:
            return setPastDescription(pastBookingHistory: pastBookingHistory)
        case .pending:
            return setUpcomingDescription(pastBookingHistory: pastBookingHistory)
        case .past:
            return setUpcomingDescription(pastBookingHistory: pastBookingHistory)
        }
    }
    static var titles = MyTrips.allCases.map({$0.rawValue})
    
    fileprivate func setPastDescription(pastBookingHistory : PastBookingHistoryResponse) -> [(String, String)]{

        if pastBookingHistory.status == "canceled" {
            let tempArray = [("Status" , pastBookingHistory.status)]  as! [(String,String)]
            
            return tempArray
        } else {
            var tempArray = [("Pick Up Time" , "12-04-2020" ),
                             ("Drop Off Time" , "12-04-2020" ),  //UtilityClass.convertTimeStampToFormat(unixtimeInterval: pastBookingHistory.dropoffTime, dateFormat: "dd-MM-YYYY HH:mm:ss")
                             ("Booking Fee" , pastBookingHistory.bookingFee),
                             ("Base Fare" , pastBookingHistory.baseFare),
                             //                ("Time Cost :" , pastBookingHistory.id),
                ("Subtotal" , pastBookingHistory.subTotal),
                //                ("Other Charges" , pastBookingHistory.subTotal),
                //                ("Cancellation Charges" , pastBookingHistory.cancellationCharge),
                //                ("Promocode" , pastBookingHistory.promocode),
                ("Total Paid To Driver" , pastBookingHistory.grandTotal)
                
                ] as! [(String,String)]
            
            
            if(pastBookingHistory.promocode.count != 0)
            {
                tempArray.insert( ("Promocode" , pastBookingHistory.promocode), at: tempArray.count-1)
            }
            
            return tempArray
        }
        
    }

    


//    fileprivate func setPastDescriptionIfCancelled(pastBookingHistory : PastBookingHistoryResponse?) -> [(title : String, description : Any)]{
//        guard obj != nil else { return []}
//        return [("Vehicle Type" , obj?["Model"] ?? ""),
//                ("Waiting Time" , obj?["WaitingTime"] ?? ""),
//                ("Payment Type" , obj?["PaymentType"] ?? ""),
//                ("Trip Status" , obj?["Status"] ?? "")]
//
//    }


    fileprivate func setFutureDescription(section: Int){
    }
    
    fileprivate func setUpcomingDescription(pastBookingHistory : PastBookingHistoryResponse) -> [(String, String)]{
        
        
        let inter = TimeInterval("\(pastBookingHistory.pickupDateTime!)") ?? 0
        
        let date = Date(timeIntervalSince1970: inter)
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale.currentf
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss" //Specify your format that you want
        var strDate = dateFormatter.string(from: date)
        
        if pastBookingHistory.pickupDateTime == "" {
            strDate = "N/A"
        }
        
        return [("Title" ,"Upcoming"),
                ("PickupLocation" , pastBookingHistory.pickupLocation),
                ("DropoffLocation" , pastBookingHistory.dropoffLocation),
                ("Date" , strDate),
                ("Payment Type" , pastBookingHistory.paymentType)]
    }
}
