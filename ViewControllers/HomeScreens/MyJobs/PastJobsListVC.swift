//
//  PastJobsListVC.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 14/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import NVActivityIndicatorView



class PastJobsListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lblNodataFound: UILabel!
    
    override func loadView() {
        super.loadView()
        
        //        let activityData = ActivityData()
        //        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Global Declaration
    //-------------------------------------------------------------
    
    var aryData = NSMutableArray()
    var aryPastJobs = NSMutableArray()
    
    var strNotAvailable: String = "N/A"
    
    var selectedCellIndexPath: IndexPath?
    let selectedCellHeight: CGFloat = 350.5
    let unselectedCellHeight: CGFloat = 86.5
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    
    func dismissSelf() {
        
        self.navigationController?.popViewController(animated: true)
        
        //        self.dismiss(animated: true, completion: nil)
    }
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
//        self.labelNoData = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
//        self.labelNoData.text = "Loading..."
//        self.labelNoData.textAlignment = .center
//        self.view.addSubview(self.labelNoData)
//        self.tableView.isHidden = true
        
        self.tableView.tableFooterView = UIView()
        
        
        self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        self.tableView.addSubview(self.refreshControl)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.webserviceOfPastbookingpagination(index: 1)
    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        //        aryPastJobs.removeAllObjects()
        
        self.webserviceOfPastbookingpagination(index: 1)
        if self.aryPastJobs.count > 0 {
            self.lblNodataFound.isHidden = true
            self.tableView.isHidden = false
        } else {
            self.lblNodataFound.isHidden = false
        }
        tableView.reloadData()
        
        
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //-------------------------------------------------------------
    // MARK: - TableView Methods
    //-------------------------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        if section == 0 {
        //
        //            if aryPastJobs.count == 0 {
        //                 return 1
        //            }
        //            else {
        //                return aryPastJobs.count
        //            }
        //        }
        //        else {
        //            return 1
        //        }
        
        return aryPastJobs.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PastJobsListTableViewCell") as! PastJobsListTableViewCell
        //        let cell2 = tableView.dequeueReusableCell(withIdentifier: "NoDataFound") as! PastJobsListTableViewCell
        
        cell.selectionStyle = .none
        //        cell2.selectionStyle = .none
        
        //        if aryPastJobs.count != 0 {
        //
        //            if indexPath.section == 0 {
        
        let data = aryPastJobs.object(at: indexPath.row) as! NSDictionary
        
        //        cell.viewAllDetails.isHidden = true
        //                cell.selectionStyle = .none
        
        cell.selectionStyle = .none
        cell.viewCell.layer.cornerRadius = 10
        cell.viewCell.clipsToBounds = true
        
        cell.lblPassengerName.text = data.object(forKey: "PassengerName") as? String
//        cell.lblDateTime.text = (checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PickupTime", isNotHave: strNotAvailable)).components(separatedBy: " ")[0]
//            data.object(forKey: "CreatedDate") as? String
        //        cell.lblDropoffLocation.text = data.object(forKey: "PassengerName") as? String
        
        cell.lblPickupLocationDesc.text = data.object(forKey: "PickupLocation") as? String // DropoffLocation
        
        cell.lblBooingId.text = "Booking ID: \(data.object(forKey: "Id") as? String ?? strNotAvailable)"
        
        cell.lblDropoffLocation.text = data.object(forKey: "DropoffLocation") as? String // PickupLocation
        cell.lblpassengerEmail.text = data.object(forKey: "PassengerEmail") as? String
        cell.lblPassengerNo.text = data.object(forKey: "PassengerMobileNo") as? String
        //                cell.lblPickupTime.text = data.object(forKey: "PickupTime") as? String
        
        
        let pickupTime = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PickupDateTime", isNotHave: strNotAvailable)
        let strDropoffTime = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "DropTime", isNotHave: strNotAvailable)
        
        
        if pickupTime == strNotAvailable {
            cell.lblPickupTime.text = pickupTime
            cell.lblDateTime.text = pickupTime
        } else {
            cell.lblPickupTime.text = pickupTime
//                setTimeStampToDate(timeStamp: pickupTime)
            cell.lblDateTime.text = pickupTime.components(separatedBy: " ")[0]
//                setTimeStampToOnlyDate(timeStamp: pickupTime)
        }
        
        if strDropoffTime == strNotAvailable {
            cell.lblDropOffTimeDesc.text = strDropoffTime
        } else {
            cell.lblDropOffTimeDesc.text = setTimeStampToDate(timeStamp: strDropoffTime)
        }
        
        //                if let pickupTime = data.object(forKey: "PickupTime") as? String {
        //                    if pickupTime == "" {
        //                        cell.lblPickupTime.isHidden = true
        ////                        cell.stackViewPickupTime.isHidden = true
        //                    }
        //                    else {
        //                        cell.lblPickupTime.text = setTimeStampToDate(timeStamp: pickupTime)
        //                    }
        //                }
        ////                cell.lblDropOffTimeDesc.text = data.object(forKey: "DropTime") as? String
        //                if let DropoffTime = data.object(forKey: "DropTime") as? String {
        //                    if DropoffTime == "" {
        //                        cell.lblDropOffTimeDesc.isHidden = true
        //        //                cell.stackViewDropoffTime.isHidden = true
        //                    }
        //                    else {
        //                        cell.lblDropOffTimeDesc.text = setTimeStampToDate(timeStamp: DropoffTime)
        //                    }
        //                }
        
        var strTripDistance = String()
        if let TripDistance = data.object(forKey: "TripDistance") as? String {
            strTripDistance = TripDistance
        } else if let TripDistance = data.object(forKey: "TripDistance") as? Int {
            strTripDistance = "\(TripDistance)"
        } else if let TripDistance = data.object(forKey: "TripDistance") as? Double {
            strTripDistance = "\(TripDistance)"
        }
        
        if strTripDistance == "" {
            strTripDistance = "0"
//            strNotAvailable
        }
        
        
        let duration = convertAnyToStringFromDictionary(dictData: data as! [String : AnyObject], shouldConvert: "TripDuration")
        
        var strTripDuration: String = "00:00:00"
        if duration != "" {
            let intDuration = Int(duration)
            let durationIs = ConvertSecondsToHoursMinutesSeconds(seconds: intDuration!)
            if durationIs.0 == 0 {
                if durationIs.1 == 0 {
                    strTripDuration = "00:00:\(durationIs.2)"
                } else {
                    strTripDuration = "00:\(durationIs.1):\(durationIs.2)"
                }
            } else {
                strTripDuration = "\(durationIs.0):\(durationIs.1):\(durationIs.2)"
            }
        }
        
        let waitingTime = convertAnyToStringFromDictionary(dictData: data as! [String : AnyObject], shouldConvert: "WaitingTime")
        
        var strWaitingTime: String = "00:00:00"
        if waitingTime != "" {
            let intWaitingTime = Int(waitingTime)
            let WaitingTimeIs = ConvertSecondsToHoursMinutesSeconds(seconds: intWaitingTime!)
            if WaitingTimeIs.0 == 0 {
                if WaitingTimeIs.1 == 0 {
                    strWaitingTime = "00:00:\(WaitingTimeIs.2)"
                } else {
                    strWaitingTime = "00:\(WaitingTimeIs.1):\(WaitingTimeIs.2)"
                }
            } else {
                strWaitingTime = "\(WaitingTimeIs.0):\(WaitingTimeIs.1):\(WaitingTimeIs.2)"
            }
        }
        
        cell.lblTripDistanceDesc.text =  "\(strTripDistance) km" // data.object(forKey: "TripDistance") as? String
        cell.lbltripDurationDesc.text = strTripDuration // data.object(forKey: "TripDuration") as? String
        cell.lblCarModelDesc.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "Model", isNotHave: strNotAvailable) //  data.object(forKey: "Model") as? String
        cell.lblNightFareDesc.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "NightFare", isNotHave: strNotAvailable) //  data.object(forKey: "NightFare") as? String
        
        let strTripFare = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "TripFare", isNotHave: strNotAvailable)
        cell.lblTripFareDesc.text = "\(strTripFare) \(currency)" //  data.object(forKey: "TripFare") as? String
        
        let strWaitingTimeCost = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "WaitingTimeCost", isNotHave: strNotAvailable)
        cell.lblWaitingTimeCostDesc.text = "\(strWaitingTimeCost) \(currency)"//  data.object(forKey: "WaitingTimeCost") as? String
        
        let strTip = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "TollFee", isNotHave: strNotAvailable)
        
        if strTip != "N/A" {
            cell.TollFeesStackView.isHidden = false
            cell.lblTollFeeDesc.text = "\(strTip) \(currency)" // data.object(forKey: "TollFee") as? String
        } else {
            cell.TollFeesStackView.isHidden = true
        }
        
        let strBookingCharges = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "BookingCharge", isNotHave: strNotAvailable)
        cell.lblBokingChargeDesc.text = "\(strBookingCharges) \(currency)" // data.object(forKey: "BookingCharge") as? String
        
        let strTax = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "Tax", isNotHave: strNotAvailable)
        cell.lblTaxDesc.text = "\(strTax) \(currency)" // data.object(forKey: "Tax") as? String
        
        let strDiscount = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "Discount", isNotHave: strNotAvailable)
        cell.lblDiscountDesc.text = "\(strDiscount) \(currency)" // data.object(forKey: "Discount") as? String
        
        let strSubTotal = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "SubTotal", isNotHave: strNotAvailable)
        cell.lblSubTotalDesc.text = "\(strSubTotal) \(currency)"  // data.object(forKey: "SubTotal") as? String
        
        let strGrandTotal = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "GrandTotal", isNotHave: strNotAvailable)
        cell.lblGrandTotalDesc.text = "\(strGrandTotal) \(currency)" // data.object(forKey: "GrandTotal") as? String
        
        
        cell.lblPaymentType.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PaymentType", isNotHave: strNotAvailable) // data.object(forKey: "PaymentType") as? String
        
        
        cell.lblTripStatusInfo.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "Status", isNotHave: strNotAvailable) // (data.object(forKey: "Status") as? String)?.uppercased()
        cell.lblFlightNumber.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "FlightNumber", isNotHave: strNotAvailable) // data.object(forKey: "FlightNumber") as? String
        cell.lblNotes.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "Notes", isNotHave: strNotAvailable) //data.object(forKey: "Notes") as? String
//        cell.lblPaymentType.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PaymentType", isNotHave: strNotAvailable) //data.object(forKey: "PaymentType") as? String
        
        cell.lblWaitingTime.text = strWaitingTime // data.object(forKey: "WaitingTime") as? String
        
        cell.viewAllDetails.isHidden = !expandedCellPaths.contains(indexPath)
        
        
        cell.lblDispatcherName.text = ""
        cell.lblDispatcherEmail.text = ""
        cell.lblDispatcherNumber.text = ""
        cell.lblDispatcherNameTitle.text = ""
        cell.lblDispatcherEmailTitle.text = ""
        cell.lblDispatcherNumberTitle.text = ""
        
        
        cell.stackViewEmail.isHidden = true
        cell.stackViewName.isHidden = true
        cell.stackViewNumber.isHidden = true
        
        if((data.object(forKey: "DispatcherDriverInfo")) != nil)
        {
            print("There is driver info and passengger name is \(String(describing: cell.lblPassengerName.text))")
            
            cell.lblDispatcherName.text = (data.object(forKey: "DispatcherDriverInfo") as? [String:AnyObject])!["Email"] as? String
            cell.lblDispatcherEmail.text = (data.object(forKey: "DispatcherDriverInfo") as? [String:AnyObject])!["Fullname"] as? String
            cell.lblDispatcherNumber.text = (data.object(forKey: "DispatcherDriverInfo") as? [String:AnyObject])!["MobileNo"] as? String
            cell.lblDispatcherNameTitle.text = "DISPACTHER NAME"
            cell.lblDispatcherEmailTitle.text = "DISPATCHER EMAIL"
            cell.lblDispatcherNumberTitle.text = "DISPATCHER TITLE"
            cell.stackViewEmail.isHidden = false
            cell.stackViewName.isHidden = false
            cell.stackViewNumber.isHidden = false
        }
        
        //            }
        //        else {
        //
        //            cell.textLabel?.text = "No Data Found"
        //        }
        if self.checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "Status", isNotHave: strNotAvailable) == "canceled" {
            cell.PickupTimeStackView.isHidden = true
            cell.DropOffTimeStackView.isHidden = true
            cell.WaitingTimeStackView.isHidden = true
            cell.WaitingTimeCostStackView.isHidden = true
            cell.DiscountStackView.isHidden = true
            cell.BookingFareStackView.isHidden = true
            cell.TripFareStackView.isHidden = true
            cell.SubTotalStackView.isHidden = true
            cell.TaxStackView.isHidden = true
            cell.TotalStackView.isHidden = true
        } else {
            cell.PickupTimeStackView.isHidden = false
            cell.DropOffTimeStackView.isHidden = false
            cell.WaitingTimeStackView.isHidden = false
            cell.WaitingTimeCostStackView.isHidden = false
            cell.DiscountStackView.isHidden = false
            cell.BookingFareStackView.isHidden = false
            cell.TripFareStackView.isHidden = false
            cell.SubTotalStackView.isHidden = false
            cell.TaxStackView.isHidden = false
            cell.TotalStackView.isHidden = false
        }
      
        
        return cell
        //        }
        //        else {
        //
        //            cell2.frame.size.height = self.tableView.frame.size.height
        //
        ////            return cell2
        //        }
        
    }
    
    
    func setTimeStampToDate(timeStamp: String) -> String {
        
        let unixTimestamp = Double(timeStamp)
        //        let date = Date(timeIntervalSince1970: unixTimestamp)
        
        let date = Date(timeIntervalSince1970: unixTimestamp!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm dd/MM/yyyy" //Specify your format that you want
        let strDate: String = dateFormatter.string(from: date)
        
        return strDate
    }
    var thereIsCellTapped = false
    var selectedRowIndex = -1
    
    
    func setTimeStampToOnlyDate(timeStamp: String) -> String {
        
        let unixTimestamp = Double(timeStamp)
        //        let date = Date(timeIntervalSince1970: unixTimestamp)
        
        let date = Date(timeIntervalSince1970: unixTimestamp!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd" //Specify your format that you want
        let strDate: String = dateFormatter.string(from: date)
        
        return strDate
    }
    
    var expandedCellPaths = Set<IndexPath>()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        if indexPath.section == 0 {
        //
        //            if aryPastJobs.count != 0 {
        //
        if let cell = tableView.cellForRow(at: indexPath) as? PastJobsListTableViewCell {
            cell.viewAllDetails.isHidden = !cell.viewAllDetails.isHidden
            if cell.viewAllDetails.isHidden {
                expandedCellPaths.remove(indexPath)
            } else {
                expandedCellPaths.insert(indexPath)
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            //            tableView.deselectRow(at: indexPath, animated: true)
        }
        //            }
        //        }
    }
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    
//    var labelNoData = UILabel()
    func webserviceOfPastbookingpagination(index: Int)
    {
        
        let driverId = Singletons.sharedInstance.strDriverID //+ "/" + "\(index)"
        
        webserviceForPastBookingList(driverId as AnyObject, PageNumber: index as AnyObject) { (result, status) in
            if (status) {
                DispatchQueue.main.async {
                    
                    let tempPastData = ((result as! NSDictionary).object(forKey: "history") as! NSArray)
                    
                    for i in 0..<tempPastData.count {
                        
                        let dataOfAry = (tempPastData.object(at: i) as! NSDictionary)
                        
                        let strHistoryType = dataOfAry.object(forKey: "HistoryType") as? String
                        
                        if strHistoryType == "Past" {
                            self.aryData.add(dataOfAry)
                        }
                    }
                    
//                    if(self.aryData.count == 0) {
//                        self.labelNoData.text = "No data found."
//                        self.tableView.isHidden = true
//                    }
//                    else {
//                        self.labelNoData.removeFromSuperview()
//                        self.tableView.isHidden = false
//                    }
                    
                    self.getPostJobs()
                    self.refreshControl.endRefreshing()
                    if self.aryPastJobs.count > 0 {
                        self.lblNodataFound.isHidden = true
                        self.tableView.isHidden = false
                    } else {
                        self.lblNodataFound.isHidden = false
                    }
                    self.tableView.reloadData()
                    
                    UtilityClass.hideACProgressHUD()
                }
            }
            else {
                //                UtilityClass.showAlertOfAPIResponse(param: result, vc: self)
            }
            
        }
    }
    
    func getPostJobs() {
        
        aryPastJobs.removeAllObjects()
        
        refreshControl.endRefreshing()
        for i in 0..<aryData.count {
            
            let dataOfAry = (aryData.object(at: i) as! NSDictionary)
            
            let strHistoryType = dataOfAry.object(forKey: "HistoryType") as? String
            
            if strHistoryType == "Past" {
                self.aryPastJobs.add(dataOfAry)
            }
        }
    }
    
    var isDataLoading:Bool=false
    var pageNo:Int = 0
    var didEndReached:Bool=false
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        print("scrollViewWillBeginDragging")
        isDataLoading = false
    }
    
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging")
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height) {
            //            if !isDataLoading{
            //                isDataLoading = true
            //                self.pageNo = self.pageNo + 1
            //                webserviceOfPastbookingpagination(index: self.pageNo)
            //            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == (self.aryData.count - 5) {
            if !isDataLoading{
                isDataLoading = true
                self.pageNo = self.pageNo + 1
                webserviceOfPastbookingpagination(index: self.pageNo)
            }
        }
    }
}
