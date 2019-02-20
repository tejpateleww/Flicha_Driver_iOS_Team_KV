//
//  MyRatingViewController.swift
//  TanTaxi-Driver
//
//  Created by excellent Mac Mini on 01/11/18.
//  Copyright © 2018 Excellent Webworld. All rights reserved.
//

import UIKit
import FloatRatingView


class MyRatingViewController : ParentViewController,UITableViewDataSource, UITableViewDelegate
{
    var aryData = NSArray()
    //    var labelNoData = UILabel()
    
    @IBOutlet var tblview: UITableView!
    @IBOutlet weak var lblNodataFound: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tblview.dataSource = self
        self.tblview.delegate = self
        
        self.tblview.tableFooterView = UIView()
        
//
        //        labelNoData = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        //        self.labelNoData.text = "Loading..."
        //        labelNoData.textAlignment = .center
        //        self.view.addSubview(labelNoData)
        //        self.tblview.isHidden = true
        //
        //        self.tblview.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        //
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.webserviceForMyFeedbackList()
        self.setLocalizable()
    }
    
    func setLocalizable() {
        
        self.headerView?.lblTitle.text = "My Ratings".localized
        self.lblNodataFound.text = "No data found.".localized
        
    }
    
    override func didReceiveMemoryWarning()
    {
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
    
    //-------------------------------------------------------------
    // MARK: - TableView Methods
    //-------------------------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        if section == 0 {
        //
        //            if aryData.count == 0 {
        //                return 1
        //            }
        //            else {
        //                return aryData.count
        //            }
        //        }
        //        else {
        //            return 1
        //        }
        
        return aryData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRatingViewCell") as! MyRatingViewCell
        //        let cell2 = tableView.dequeueReusableCell(withIdentifier: "NoDataFound") as! FutureBookingTableViewCell
        
        cell.selectionStyle = .none
       
        cell.lblPickUpAddress.text = "Pick Up Time".localized
        cell.lblDropUpAddress.text = "Drop off location".localized
        
        cell.viewCell.layer.cornerRadius = 10
//        cell.viewCell.clipsToBounds = true
        cell.viewCell.layer.shadowRadius = 3.0
        cell.viewCell.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        cell.viewCell.layer.shadowOffset = CGSize (width: 1.0, height: 1.0)
        cell.viewCell.layer.shadowOpacity = 1.0
        
//        let data = aryData.object(at: indexPath.row) as! NSDictionary
//        //
//        cell.lblPassengerName.text = data.object(forKey: "Username") as? String
//        //
//        //
//        //
//        cell.lblDropUpAddress.text = (!Utilities.isEmpty(str: (data.object(forKey: "DropoffLocation") as? String))) ? (data.object(forKey: "DropoffLocation") as? String) : "-" // DropoffLocation
//        //
//        let strDate = data.object(forKey: "Date") as! String
//        let arrDate = strDate.components(separatedBy: " ")
//        
//        cell.lblDateTime.text = arrDate[0]//(!Utilities.isEmpty(str: (data.object(forKey: "PickupDateTime") as? String))) ? (data.object(forKey: "PickupDateTime") as? String) : "-"//
//        //let f
//        var intRating = CGFloat()
//        let str = data["Rating"] as? String
//        if let n = NumberFormatter().number(from: str!)
//        {
//            intRating = CGFloat(n)
//        }
//        
//        
//        cell.lblComments.text = (!Utilities.isEmpty(str: (data.object(forKey: "Comment") as? String))) ? (data.object(forKey: "Comment") as? String) : "N/A"
////        cell.viewRatings.value = intRating//CGFloat((data.object(forKey: "Rating") as? String)!)
//        cell.lblPickUpAddress.text = (!Utilities.isEmpty(str: (data.object(forKey: "PickupLocation") as? String))) ? (data.object(forKey: "PickupLocation") as? String) : "-"  // PickupLocation
        
        cell.imgProfile.layer.cornerRadius = cell.imgProfile.frame.width / 2
        cell.imgProfile.clipsToBounds = true
        cell.imgProfile.layer.borderColor = ThemeYellowColor.cgColor
        cell.imgProfile.layer.borderWidth = 1.0
        
        let data = aryData.object(at: indexPath.row) as! NSDictionary
        //

        let strURL = "\(WebserviceURLs.kImageBaseURL)\(data.object(forKey: "PassengerImage") as! String)"

        cell.imgProfile.sd_setImage(with: URL(string: strURL), completed: nil)

        cell.lblPassengerName.text = data.object(forKey: "PassengerName") as? String
        //
        //
        ////
        cell.lblDropUpAddress.text = (data.object(forKey: "DropoffLocation") as? String)
        ////
        let strDate = data.object(forKey: "Date") as! String
        let arrDate = strDate.components(separatedBy: " ")

        cell.lblDateTime.text = arrDate[0]
        var intRating = Float()
        let str = data["Rating"] as? String
        if let n = NumberFormatter().number(from: str!)
        {
            intRating = Float(n)
        }
        //
        //
        let strComment  =  (data.object(forKey: "Comment") as? String)

        if Utilities.isEmpty(str: strComment)
        {
            cell.lblComments.text = ""
            cell.lblCommentTitle.text = ""
        }
        else
        {
            cell.lblComments.text = strComment
             cell.lblCommentTitle.text = "Comment".localized
        }
        cell.viewRating.value = CGFloat(intRating)//CGFloat((data.object(forKey: "Rating") as? String)!)
        cell.lblPickUpAddress.text = (data.object(forKey: "PickupLocation") as? String)  // PickupLocation
        //
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func webserviceForMyFeedbackList()
    {
        
//        webserviceForFeedbackList(SingletonClass.sharedInstance.strDriverID as AnyObject, feedbackType: kDriverType as AnyObject, showHUD: true) { (result, status) in
//            if status
//            {
//                print(result)
//                self.aryData = ((result as! NSDictionary).object(forKey: "feedback") as! NSArray)
//
//
//                if(self.aryData.count == 0)
//                {
//                    self.labelNoData.text = "Please check back later"
//                    self.tblview.isHidden = true
//                }
//                else
//                {
//                    self.labelNoData.removeFromSuperview()
//                    self.tblview.isHidden = false
//                }
//                self.tblview.reloadData()
//            }
//            else
//            {
//                print(result)
//
//
//                if let res = result as? String {
//                    Utilities.showAlert(appName, message: res, vc: self)
//                }
//                else if let resDict = result as? NSDictionary {
//                    Utilities.showAlert(appName, message: resDict.object(forKey: "message") as! String, vc: self)
//                }
//                else if let resAry = result as? NSArray {
//                    Utilities.showAlert(appName, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: "message") as! String, vc: self)
//                }
//
//            }
//        }
//
        webserviceForFeedbackList(Singletons.sharedInstance.strDriverID as AnyObject) { (result, status) in
            if status
            {
                print(result)
                self.aryData = ((result as! NSDictionary).object(forKey: "feedback") as! NSArray)
                
                
//                if(self.aryData.count == 0)
//                {
//                    self.labelNoData.text = "Please check back later"
//                    self.tblview.isHidden = true
//                }
//                else
//                {
//                    self.labelNoData.removeFromSuperview()
//                    self.tblview.isHidden = false
//                }
                if self.aryData.count > 0 {
                    self.lblNodataFound.isHidden = true
                } else {
                    self.lblNodataFound.isHidden = false
                }
                
                self.tblview.reloadData()

            }
            else
            {
                print(result)
                
                
                if let res = result as? String {
                    Utilities.showAlert("App Name".localized, message: res, vc: self)
                }
                else if let resDict = result as? NSDictionary {
                    Utilities.showAlert("App Name".localized, message: resDict.object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }
                else if let resAry = result as? NSArray {
                    Utilities.showAlert("App Name".localized, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }
            }
        }
    }
}
