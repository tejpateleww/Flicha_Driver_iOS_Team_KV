//
//  WebserviceClasses.swift
//   TenTaxi-Driver
//
//  Created by Excellent Webworld on 17/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import Foundation
import Alamofire
import NVActivityIndicatorView



//-------------------------------------------------------------
// MARK: - Global Declaration
//-------------------------------------------------------------

let BaseURL = WebserviceURLs.kBaseURL
var request : Request!

let header: [String:String] = ["key":"Flicha123*#*"]


//-------------------------------------------------------------
// MARK: - Webservice For PostData Method
//-------------------------------------------------------------

func postData(_ dictParams: AnyObject, nsURL: String, completion: @escaping (_ result: AnyObject, _ sucess: Bool) -> Void)
{
    let url = BaseURL + nsURL

    print("The webservice call is \(url) and the params are \(dictParams)")
    
    if Connectivity.isConnectedToInternet() == false {
         completion("Sorry! Not connected to internet".localized as AnyObject, false)
        return
    }
    
    
    DispatchQueue.main.async{
        UtilityClass.showACProgressHUD()
    }
    
    Alamofire.request(url, method: .post, parameters: dictParams as? [String : AnyObject], encoding: URLEncoding.default, headers: header)
        .validate()
        .responseJSON
        { (response) in
 
            if let JSON = response.result.value
            {
                
                if (JSON as AnyObject).object(forKey:("status")) as! Bool == false
                {
                    completion(JSON as AnyObject, false)
                    UtilityClass.hideACProgressHUD()
                }
                else
                {
                    completion(JSON as AnyObject, true)
                    UtilityClass.hideACProgressHUD()
                }
            }
            else
            {
                UtilityClass.hideACProgressHUD()

                completion(response.error?.localizedDescription as AnyObject, false)
            }

    }
}


//-------------------------------------------------------------
// MARK: - Webservice For GetData Method
//-------------------------------------------------------------

func getData(_ dictParams: AnyObject, nsURL: String,  completion: @escaping (_ result: AnyObject, _ success: Bool) -> Void)
{
    let url = BaseURL + nsURL
//    HUD.dimsBackground = false
//    HUD.allowsInteraction = false
//    HUD.show(.systemActivity)
    
    if Connectivity.isConnectedToInternet() == false {
        completion("Sorry! Not connected to internet".localized as AnyObject, false)
        return
    }
    
    UtilityClass.showACProgressHUD()
   
//    DispatchQueue.main.async {
//            let activityData = ActivityData()
//        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
//    }

    print("The webservice call is \(url) and the params are \(dictParams)")
    
    Alamofire.request(url, method: .get, parameters: dictParams as? [String : AnyObject], encoding: URLEncoding.default, headers: header)
        .validate()
        .responseJSON
        { (response) in
            
            if let JSON = response.result.value
            {
                if((JSON as AnyObject).object(forKey:("status")) != nil)
                {
                    if (JSON as AnyObject).object(forKey:("status")) as! Bool == false
                    {
                        completion(JSON as AnyObject, false)
                    }
                    else
                    {
                        completion(JSON as AnyObject, true)
                    }
                }
                else
                {
                    completion(JSON as AnyObject, true)
                }
            }
            else
            {
                completion(response.error?.localizedDescription as AnyObject, false)
            }
            
            UtilityClass.hideACProgressHUD()
    }
//    HUD.hide()
}

//-------------------------------------------------------------
// MARK: - Webservice For GetData Method
//-------------------------------------------------------------

func getDataOfHistory(_ dictParams: AnyObject, nsURL: String,  completion: @escaping (_ result: AnyObject, _ success: Bool) -> Void)
{
 
    let url = BaseURL + nsURL
    if Connectivity.isConnectedToInternet() == false {
        completion("Sorry! Not connected to internet".localized as AnyObject, false)
        return
    }
    
    DispatchQueue.main.async {
        UtilityClass.showACProgressHUD()
    }
   
    print("The webservice call is\(url) and the params are \(dictParams)")
    
    Alamofire.request(url, method: .get, parameters: dictParams as? [String : AnyObject], encoding: URLEncoding.default, headers: header)
        .validate()
        .responseJSON
        { (response) in
       
            UtilityClass.hideACProgressHUD()
        
            if let JSON = response.result.value
            {
                
                if (JSON as AnyObject).object(forKey:("status")) as! Bool == false
                {
                    completion(JSON as AnyObject, false)
                    //                    HUD.flash(HUDContentType.systemActivity, delay: 0.0)
                }
                else
                {
                    completion(JSON as AnyObject, true)
                    
                }
            }
            else
            {
                completion(response.error?.localizedDescription as AnyObject, false)
            }
            
    }
    //    HUD.hide()
}




//-------------------------------------------------------------
// MARK: - Webservice For Send Image Method
//-------------------------------------------------------------

func sendImage(_ dictParams: [String:AnyObject], image1: UIImage, image2: UIImage, image3: UIImage, image4: UIImage, image5: UIImage, image6: UIImage, nsURL: String, completion: @escaping (_ result: AnyObject, _ success: Bool) -> Void) {
    
    let url = BaseURL + nsURL
    
    if Connectivity.isConnectedToInternet() == false {
        completion("Sorry! Not connected to internet".localized as AnyObject, false)
        return
    }
    
//    print("The webservice call is\(url) and the params are \(dictParams)")

//    let headers: HTTPHeaders = ["key": headers]
//    let aryImagesName = ["DriverLicence","CarRegistration","AccreditationCertificate","VehicleInsuranceCertificate"]

//    let activityData = ActivityData()
//    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    
    UtilityClass.showACProgressHUD()
    
    Alamofire.upload(multipartFormData: { (multipartFormData) in
        if let imageData1 = image1.jpegData(compressionQuality: 0.6)
        {
            multipartFormData.append(imageData1, withName: RegistrationFinalKeys.kDriverLicence, fileName: "image.jpeg", mimeType: "image/jpeg")
        }
        if let imageData2 = image2.jpegData(compressionQuality: 0.6)
        {
            multipartFormData.append(imageData2, withName: RegistrationFinalKeys.kCarRegistrationCertificate, fileName: "image.jpeg", mimeType: "image/jpeg")
        }
        
        if let imageData3 = image3.jpegData(compressionQuality: 0.6) {
            
            multipartFormData.append(imageData3, withName: RegistrationFinalKeys.kAccreditationCertificate, fileName: "image.jpeg", mimeType: "image/jpeg")
        }
        
        if let imageData4 = image4.jpegData(compressionQuality: 0.6) {
            
            multipartFormData.append(imageData4, withName: RegistrationFinalKeys.kVehicleInsuranceCertificate, fileName: "image.jpeg", mimeType: "image/jpeg")
        }
        
        if let imageData5 = image5.jpegData(compressionQuality: 0.6) {
            
            multipartFormData.append(imageData5, withName: RegistrationFinalKeys.kDriverImage, fileName: "image.jpeg", mimeType: "image/jpeg")
        }
        
        if let imageData6 = image6.jpegData(compressionQuality: 0.6) {
            
            multipartFormData.append(imageData6, withName: RegistrationFinalKeys.kVehicleImage, fileName: "image.jpeg", mimeType: "image/jpeg")
        }
        
        for (key, value) in dictParams
        {
            if JSONSerialization.isValidJSONObject(value) {
                let array = value as! [String]
                
                for string in array {
                    if let stringData = string.data(using: .utf8) {
                        multipartFormData.append(stringData, withName: key+"[]")
                    }
                }
            } else {
                multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
            }
        }
    }, usingThreshold: 10 * 1024 * 1024, to: url, method: .post, headers: header) { (encodingResult) in
        switch encodingResult
        {
        case .success(let upload, _, _):
            request =  upload.responseJSON {
                response in
                
                if let JSON = response.result.value {
                    
                    if ((JSON as AnyObject).object(forKey: "status") as! Bool) == true
                    {
                        completion(JSON as AnyObject, true)
                        print("If JSON")
                        
                    }
                    else
                    {
                        completion(JSON as AnyObject, false)
                        print("else JSON")
                    }
                }
                else
                {
                    print("ERROR")
                }
                
                 UtilityClass.hideACProgressHUD()
                
//                 NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//                HUD.flash(HUDContentType.systemActivity, delay: 0.0)
                
            }
        case .failure( _):
            print("failure")
            
             UtilityClass.hideACProgressHUD()
            
//             NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//            HUD.hide()
            break
        }
    }
}

//-------------------------------------------------------------
// MARK: - Update Driver Info
//-------------------------------------------------------------

func DeiverInfo(_ dictParams: [String:AnyObject], image1: UIImage, nsURL: String, completion: @escaping (_ result: AnyObject, _ success: Bool) -> Void) {
    
    let url = BaseURL + nsURL
    if Connectivity.isConnectedToInternet() == false {
        completion("Sorry! Not connected to internet".localized as AnyObject, false)
        return
    }
    
//    let headers: HTTPHeaders = ["key": "TicktocApp123*"]
    //    let aryImagesName = ["DriverLicence","CarRegistration","AccreditationCertificate","VehicleInsuranceCertificate"]
    
    //    HUD.dimsBackground = false
    //    HUD.allowsInteraction = false
    //    HUD.show(.systemActivity)
    
//    let activityData = ActivityData()
//    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    
    UtilityClass.showACProgressHUD()
    
//    print("The webservice call is \(url) and the params are \(dictParams)")

    Alamofire.upload(multipartFormData: { (multipartFormData) in
        
//        let imageFileName = ""
        
        if let imageData1 = image1.jpegData(compressionQuality: 0.6) {
            
            multipartFormData.append(imageData1, withName: "DriverImage", fileName: "image1003.png", mimeType: "image/png")
        }
        
        for (key, value) in dictParams
        {
        
                multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
        
        }
    }, usingThreshold: 10 * 1024 * 1024, to: url, method: .post, headers: header) { (encodingResult) in
        switch encodingResult
        {
        case .success(let upload, _, _):
            request =  upload.responseJSON {
                response in
                
                if let JSON = response.result.value {
                    
                    if ((JSON as AnyObject).object(forKey: "status") as! Bool) == true
                    {
                        completion(JSON as AnyObject, true)
                        print("If JSON")

                    }
                    else
                    {
                        completion(JSON as AnyObject, false)
                        print("else JSON")
                    }
                }
                else
                {
                    print("ERROR")
                }
//                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                //                HUD.flash(HUDContentType.systemActivity, delay: 0.0)
                
                UtilityClass.hideACProgressHUD()
                
            }
        case .failure( _):
            print("failure")
//            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            //            HUD.hide()
            UtilityClass.hideACProgressHUD()
            break
        }
    }
}

//-------------------------------------------------------------
// MARK: - Webservice For Update Driver Document
//-------------------------------------------------------------

func sendUpdateDriverDocument(_ dictParams: [String:AnyObject], image: UIImage, imageParamName: String, nsURL: String, completion: @escaping (_ result: AnyObject, _ success: Bool) -> Void) {
    
    let url = BaseURL + nsURL
    
    if Connectivity.isConnectedToInternet() == false {
        completion("Sorry! Not connected to internet".localized as AnyObject, false)
        return
    }
//    let headers: HTTPHeaders = ["key": "TicktocApp123*"]
    //    let aryImagesName = ["DriverLicence","CarRegistration","AccreditationCertificate","VehicleInsuranceCertificate"]
    
    //    HUD.dimsBackground = false
    //    HUD.allowsInteraction = false
    //    HUD.show(.systemActivity)
    
//    let activityData = ActivityData()
//    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
//    print("The webservice call is\(url) and the params are \(dictParams)")

    UtilityClass.showACProgressHUD()
    
    
    Alamofire.upload(multipartFormData: { (multipartFormData) in
        
        if let imageData = image.jpegData(compressionQuality: 0.6) {
            
            multipartFormData.append(imageData, withName: imageParamName, fileName: "image.jpeg", mimeType: "image/jpeg")
        }
        
        for (key, value) in dictParams
        {
            if JSONSerialization.isValidJSONObject(value) {
                let array = value as! [String]
                
                for string in array {
                    if let stringData = string.data(using: .utf8) {
                        multipartFormData.append(stringData, withName: key+"[]")
                    }
                }
            } else {
                multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
            }
        }
    }, usingThreshold: 10 * 1024 * 1024, to: url, method: .post, headers: header) { (encodingResult) in
        switch encodingResult
        {
        case .success(let upload, _, _):
            request =  upload.responseJSON {
                response in
                
                if let JSON = response.result.value {
                    
                    if ((JSON as AnyObject).object(forKey: "status") as! Bool) == true
                    {
                        completion(JSON as AnyObject, true)
                        print("If JSON")
                        
                    }
                    else
                    {
                        completion(JSON as AnyObject, false)
                        print("else JSON")
                    }
                }
                else
                {
                    print("ERROR")
                }
//                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                //                HUD.flash(HUDContentType.systemActivity, delay: 0.0)
                
                UtilityClass.hideACProgressHUD()
                
            }
        case .failure( _):
            print("failure")
//            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            //            HUD.hide()
            
            UtilityClass.hideACProgressHUD()
            break
        }
    }
}

//-------------------------------------------------------------
// MARK: - Webservice For GetData Method
//-------------------------------------------------------------

func getDataGoogle(_ dictParams: AnyObject, nsURL: String,  completion: @escaping (_ result: NSDictionary, _ success: Bool) -> Void)
{
    let url = nsURL
    //    HUD.dimsBackground = false
    //    HUD.allowsInteraction = false
    //    HUD.show(.systemActivity)
    
    
    UtilityClass.showACProgressHUD()
    
    //    DispatchQueue.main.async {
    //            let activityData = ActivityData()
    //        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    //    }
    
    print("The webservice call is\(url) and the params are \(dictParams)")
    
    Alamofire.request(url, method: .get, parameters: dictParams as? [String : AnyObject], encoding: URLEncoding.default, headers: header)
        .validate()
        .responseJSON
        { (response) in
            
            
            if let JSON = response.result.value
            {
                
                if ((JSON as! NSDictionary).object(forKey:("status"))) as! String == "ok"
                {
                    completion(JSON as! NSDictionary, true)
                    
                }
                else
                {
                    completion(JSON as! NSDictionary, false)
                    
                }
            }
            else
            {
                completion((response.error?.localizedDescription as AnyObject) as! NSDictionary, false)
            }
            
            UtilityClass.hideACProgressHUD()
    }
    //    HUD.hide()
}



