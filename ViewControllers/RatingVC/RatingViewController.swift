//
//  RatingViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 22/12/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import FloatRatingView
import MarqueeLabel
import SwiftyJSON
protocol delegateRatingIsSubmitSuccessfully {
    
    func didRatingIsSubmitSuccessfully()
}

class RatingViewController: UIViewController,FloatRatingViewDelegate {

    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var txtFeedback: UITextField!
    @IBOutlet var viewRating: UIView!
    @IBOutlet var lblDetail: UILabel!

    @IBOutlet var viewStarsRating: HCSStarRatingView!
    @IBOutlet weak var lblNavTitle: UILabel! {
           didSet {
               lblNavTitle.text = "Rating & Review".localized
               lblNavTitle.font = UIFont.bold(ofSize: 18)
           }
       }
    @IBOutlet weak var vwComment: UIView! {
        didSet {
            vwComment.layer.cornerRadius = 8
            vwComment.layer.borderWidth = 1.0
            vwComment.layer.borderColor = themeLineColor.cgColor
        }
    }
    
    @IBOutlet weak var lblPassengerName: UILabel!
    @IBOutlet weak var vwPassengerRating: HCSStarRatingView!
    @IBOutlet weak var imgvwProfile : UIImageView! {
        didSet {
            imgvwProfile.layer.cornerRadius = imgvwProfile.frame.height/2
            imgvwProfile.layer.masksToBounds = true
        }
    }
    
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
    
    @IBOutlet weak var howsTrip: UILabel!{
        didSet {
            howsTrip.font = UIFont.regular(ofSize: 15)
        }
    }
    
    @IBOutlet weak var feedbackDesc: UILabel!{
        didSet {
            feedbackDesc.font = UIFont.regular(ofSize: 13)
        }
    }
    @IBOutlet weak var txtVwFeedback: UITextView!
    var delegate: delegateRatingIsSubmitSuccessfully?
    
    var ratingToDriver = Float()
    var commentToDriver = String()
    var strBookingType = String()
    var strBookingID = String()
    var dictData : NSDictionary!
    var dictPassengerInfo : NSDictionary!
    var dictAllPassengerInfo: [String: Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewStarsRating.rating = 0.0
        
        viewStarsRating.value = 0.0
//        viewStarsRating.delegate = self
        strBookingID = (dictData["details"]! as! [String : AnyObject])["Id"] as! String
        lblDetail.text = "\("How was your Ride with".localized) \((dictPassengerInfo!.object(forKey: "Fullname") as! String))?"// (dictPassengerInfo!.object(forKey: "Fullname") as! String)
        lblPassengerName.text = (dictPassengerInfo["Fullname"] as? String) ?? ""
        
        let strPickupLocation = (dictData["details"]! as! [String : AnyObject])["PickupLocation"] as? String ?? ""
        let strDropLocation = (dictData["details"]! as! [String : AnyObject])["DropoffLocation"] as? String ?? ""
        lblPickupLocation.text = strPickupLocation
        lblDropOffLocation.text = strDropLocation
        let strImage = dictPassengerInfo["Image"] as? String ?? ""
        imgvwProfile.sd_setImage(with: URL.init(string: WebserviceURLs.kImageBaseURL + strImage), completed: nil)
        vwPassengerRating.value = CGFloat((self.dictPassengerInfo["passenger_rating"] as? NSString)?.doubleValue ?? 0.0)
      
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
    
    @IBAction func backClick(_ sender: Any) {
        self.delegate?.didRatingIsSubmitSuccessfully()
                      
        self.dismiss(animated: true, completion: nil)
    }
    
    func webserviceCallToGiveRating() {
        
        var param = [String:AnyObject]()
        
        ratingToDriver = Float(viewStarsRating.value)
        param["BookingId"] = strBookingID as AnyObject
        param["Rating"] = ratingToDriver as AnyObject
        param["Comment"] = txtVwFeedback.text as AnyObject
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
