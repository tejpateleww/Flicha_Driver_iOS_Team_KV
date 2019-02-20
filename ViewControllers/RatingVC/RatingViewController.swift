//
//  RatingViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 22/12/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import FloatRatingView

protocol delegateRatingIsSubmitSuccessfully {
    
    func didRatingIsSubmitSuccessfully()
}

class RatingViewController: UIViewController,FloatRatingViewDelegate {

    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var txtFeedback: UITextField!
    @IBOutlet var viewRating: UIView!
    @IBOutlet var lblDetail: UILabel!

    @IBOutlet var viewStarsRating: HCSStarRatingView!
    
    
    var delegate: delegateRatingIsSubmitSuccessfully?
    
    var ratingToDriver = Float()
    var commentToDriver = String()
    var strBookingType = String()
    var strBookingID = String()
    var dictData : NSDictionary!
    var dictPassengerInfo : NSDictionary!
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewStarsRating.rating = 0.0
        viewStarsRating.value = 0.0
//        viewStarsRating.delegate = self
        strBookingID = (dictData["details"]! as! [String : AnyObject])["Id"] as! String
        lblDetail.text = "\("How was your Ride with".localized) \((dictPassengerInfo!.object(forKey: "Fullname") as! String))?"// (dictPassengerInfo!.object(forKey: "Fullname") as! String)
        // Do any additional setup after loading the view.
//
//        btnSubmit.layer.cornerRadius = 5
//        btnSubmit.layer.masksToBounds = true
        
        Utilities.setCornerRadiusButton(button: btnSubmit, borderColor: ThemeYellowColor, bgColor: ThemeYellowColor, textColor: UIColor.white)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        lblDetail.text = "".localized
//        txtFeedback.placeholder = "".localized
          self.setLocalization()
    }
 
    func setLocalization() {
        self.txtFeedback.placeholder = "Write a comment".localized
        btnSubmit.setTitle("Submit".localized, for: .normal)
    }
    
    @IBAction func btnGiveRating(_ sender: Any)
    {
        webserviceCallToGiveRating()
    }
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
//    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double){
//
//        viewStarsRating.rating = Double(rating)
//        ratingToDriver = Float(viewStarsRating.rating)
//
//    }
    
    
    func webserviceCallToGiveRating() {
        
        var param = [String:AnyObject]()
        
        ratingToDriver = Float(viewStarsRating.value)
        param["BookingId"] = strBookingID as AnyObject
        param["Rating"] = ratingToDriver as AnyObject
        param["Comment"] = txtFeedback.text as AnyObject
        param["BookingType"] = strBookingType as AnyObject
        
        
        webserviceForGiveRating(param as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                //needToCheck
                self.ratingToDriver = 0
                    UtilityClass.showAlertWithCompletion("App Name".localized, message: "Thanks for feedback.".localized, vc: self) { (status) in
                }
                
                self.delegate?.didRatingIsSubmitSuccessfully()
                
                self.dismiss(animated: true, completion: nil)
                
            }
            else {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
