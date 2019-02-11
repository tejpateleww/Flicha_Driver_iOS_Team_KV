//
//  Extension+UIViewController.swift
//   TenTaxi-Driver
//
//  Created by Excelent iMac on 17/07/18.
//  Copyright © 2018 Excellent Webworld. All rights reserved.
//

import Foundation

extension UIViewController {
    
    /// Convert Any data to String From Dictionary
    func convertAnyToStringFromDictionary(dictData: [String:AnyObject], shouldConvert paramString: String) -> String {
        
        var currentData = dictData
        
        if currentData[paramString] == nil {
            return ""
        }
        
        if ((currentData[paramString] as? String) != nil) {
            return String(currentData[paramString] as! String)
        } else if ((currentData[paramString] as? Int) != nil) {
            return String((currentData[paramString] as! Int))
        } else if ((currentData[paramString] as? Double) != nil) {
            return String(currentData[paramString] as! Double)
        } else if ((currentData[paramString] as? Float) != nil){
            return String(currentData[paramString] as! Float)
        }
        else {
            return ""
        }
    }
    
    /// Convert Any data to String From Dictionary
    func checkDictionaryHaveValue(dictData: [String:AnyObject], didHaveValue paramString: String, isNotHave: String) -> String {
        
        var currentData = dictData
        
        if currentData[paramString] == nil {
            return isNotHave
        }
        
        if ((currentData[paramString] as? String) != nil) {
            if String(currentData[paramString] as! String) == "" {
                return isNotHave
            }
            return String(currentData[paramString] as! String)
            
        } else if ((currentData[paramString] as? Int) != nil) {
            if String(currentData[paramString] as! Int) == "" {
                return isNotHave
            }
            return String((currentData[paramString] as! Int))
            
        } else if ((currentData[paramString] as? Double) != nil) {
            if String(currentData[paramString] as! Double) == "" {
                return isNotHave
            }
            return String(currentData[paramString] as! Double)
            
        } else if ((currentData[paramString] as? Float) != nil){
            if String(currentData[paramString] as! Float) == "" {
                return isNotHave
            }
            return String(currentData[paramString] as! Float)
        }
        else {
            return isNotHave
        }
    }
    
    
    /// Convert Seconds to Hours, Minutes and Seconds
    func ConvertSecondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}

