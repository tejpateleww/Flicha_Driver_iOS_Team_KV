//
//  PendingJobsListVC.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 14/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SocketIO

class PendingJobsListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //    let socket = UtilityClass.socketManager()
    var strNotAvailable: String = "N/A"
    
    @IBOutlet weak var lblNodataFound: UILabel!
    
    //-------------------------------------------------------------
    // MARK: - Global Declaration
    //-------------------------------------------------------------
    //    let activityData = ActivityData()
    @IBOutlet weak var tableView: UITableView!
    
    
    var aryData = NSArray()
    var aryPendingJobs = NSMutableArray()
    
    var isSelectedIndex = Int()
    
    var selectedCellIndexPath: IndexPath?
    let selectedCellHeight: CGFloat = 158.5
    let unselectedCellHeight: CGFloat = 81
    
    var isVisible: Bool = true
    var labelNoData = UILabel()
    
    
    lazy var refreshControl: UIRefreshControl =
        {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                #selector(self.handleRefresh(_:)),
                                     for: UIControl.Event.valueChanged)
            refreshControl.tintColor = ThemeYellowColor
            
            return refreshControl
    }()
    
    func dismissSelf() {
        
        self.navigationController?.popViewController(animated: true)
        
        
        //        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // UtilityClass.showACProgressHUD()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
//        labelNoData = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
//        self.labelNoData.text = "Loading..."
//        labelNoData.textAlignment = .center
//        self.view.addSubview(labelNoData)
//        self.tableView.isHidden = true
 
        self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        self.tableView.addSubview(self.refreshControl)
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
//        webserviceofPendingJobs()
        setLocalizable()
         self.title = "My Job".localized
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        if Connectivity.isConnectedToInternet() == false {
            self.refreshControl.endRefreshing()
            return
        }
        webserviceofPendingJobs()
        if self.aryPendingJobs.count > 0 {
            self.lblNodataFound.isHidden = true
            self.tableView.isHidden = false
        } else {
            self.lblNodataFound.isHidden = false
        }
        tableView.reloadData()
        
    }
    func setLocalizable()
    {
        self.lblNodataFound.text = "No data found.".localized
        
    }
    
    
    //-------------------------------------------------------------
    // MARK: - TableView Methods
    //-------------------------------------------------------------
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return aryPendingJobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingJobsListTableViewCell") as! PendingJobsListTableViewCell
        //        let cell2 = tableView.dequeueReusableCell(withIdentifier: "NoDataFound") as! PendingJobsListTableViewCell
        
        cell.selectionStyle = .none
        cell.lblPickupTimeTitle.text = "Pick Up Time :".localized
        cell.lblTripDetailsTitle.text = "Distance Travel :".localized
        cell.lblPaymentTypeTitle.text = "Payment Type :".localized
        cell.btnStartTrip.setTitle("Start Trip".localized, for: .normal)
       
        cell.viewCell.layer.cornerRadius = 10
        cell.viewCell.clipsToBounds = true
        
        let data = aryPendingJobs.object(at: indexPath.row) as! NSDictionary
        
        cell.lblPassengerName.text = data.object(forKey: "PassengerName") as? String
        cell.lblDateTime.text = (checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PickupDateTime", isNotHave: strNotAvailable)).components(separatedBy: " ")[0]
//            data.object(forKey: "CreatedDate") as? String
        
        if let TimeAndDate: String = data.object(forKey: "PickupDateTime") as? String {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//this your string date format
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
            let date = dateFormatter.date(from: TimeAndDate)
            
            
            dateFormatter.dateFormat = "HH:mm dd/MM/YYYY"///this is what you want to convert format
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
            let timeStamp = dateFormatter.string(from: date!)
            
            //            cell.lblTimeAndDateAtTop.text = "\(timeStamp)"
        }
        
        cell.lblBookingId.text = "\("Booking Id".localized): \(checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "Id", isNotHave: strNotAvailable))"
        
        
        //        checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PickupLocation", isNotHave: strNotAvailable) //
        
        //        cell.lblDropoffLocation.text = ""
        cell.lblDropoffLocationDescription.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "DropoffLocation", isNotHave: strNotAvailable) // data.object(forKey: "PickupLocation") as? String // DropoffLocation
        cell.lblDateAndTime.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "CreatedDate", isNotHave: strNotAvailable) //data.object(forKey: "CreatedDate") as? String
        
        cell.lblPickUpLocation.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PickupLocation", isNotHave: strNotAvailable)
        // data.object(forKey: "DropoffLocation") as? String // PickupLocation
        cell.lblpassengerEmailDesc.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PassengerEmail", isNotHave: strNotAvailable) // data.object(forKey: "PassengerEmail") as? String
        cell.lblPassengerNoDesc.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PassengerContact", isNotHave: strNotAvailable) // data.object(forKey: "PassengerContact") as? String
        cell.lblPickupTimeDesc.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PickupDateTime", isNotHave: strNotAvailable) // data.object(forKey: "PickupDateTime") as? String
        cell.lblCarModelDesc.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "Model", isNotHave: strNotAvailable) // data.object(forKey: "Model") as? String
        cell.lblFlightNumber.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "FlightNumber", isNotHave: strNotAvailable) //data.object(forKey: "FlightNumber") as? String
        cell.lblNotes.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "Notes", isNotHave: strNotAvailable) //data.object(forKey: "Notes") as? String
        
        cell.lblPaymentType.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: GetPaymentTypeKey(), isNotHave: strNotAvailable)
        
        cell.btnStartTrip.tag = Int((data.object(forKey: "Id") as? String)!)!
        cell.btnStartTrip.addTarget(self, action: #selector(self.strtTrip(sender:)), for: .touchUpInside)
        
        cell.viewAllDetails.isHidden = !expandedCellPaths.contains(indexPath)
        
        var tripDistance = String()
        if let strTripDistance = data.object(forKey: "TripDistance") as? String {
            tripDistance = strTripDistance
        } else if let intTripDistance = data.object(forKey: "TripDistance") as? Int {
            tripDistance = "\(intTripDistance)"
        }
        
        let strStatus = data.object(forKey: "Status") as! String
        Singletons.sharedInstance.DriverTripCurrentStatus = strStatus
        let strBookingStatus = data.object(forKey: "BookingType") as! String
        let strOntheWay = data.object(forKey: "OnTheWay") as? String
        if strBookingStatus == "Book Now"
        {
            cell.btnStartTrip.isHidden = true
        }
        else
        {
            
            if strStatus == kAcceptTripStatus && strOntheWay! == "1"
            {
                cell.btnStartTrip.isHidden = true
            }
            else //if strStatus == kAcceptTripStatus && strOntheWay! == 0 //|| strStatus == kPendingTripStatus //kPendingJob
            {
                cell.btnStartTrip.isHidden = false
                cell.btnStartTrip.tag = Int((data.object(forKey: "Id") as? String)!)!
                cell.btnStartTrip.addTarget(self, action: #selector(self.strtTrip(sender:)), for: .touchUpInside)
            }
            //            else
            //            {
            //                cell.btnStartTrip.isHidden = true
            //            }
        }
        
        cell.lblTripDetails.text = "\("N/A" != checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "TripDistance", isNotHave: strNotAvailable) ? checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "TripDistance", isNotHave: strNotAvailable) : "0") km" //
        
        cell.lblDispatcherName.text = ""
        cell.lblDispatcherEmail.text = ""
        cell.lblDispatcherNumber.text = ""
        cell.lblDispatcherName.text = ""
        cell.lblDispatcherEmailTitle.text = ""
        cell.lblDispatcherNumber.text = ""
        
        cell.stackViewEmail.isHidden = true
        cell.stackViewName.isHidden = true
        cell.stackViewNumber.isHidden = true
        
        if((data.object(forKey: "DispatcherDriverInfo")) != nil)
        {
            print("There is driver info and passengger name is \(String(describing: cell.lblPassengerName.text))")
            
            cell.lblDispatcherName.text = (data.object(forKey: "DispatcherDriverInfo") as? [String:AnyObject])!["Email"] as? String
            cell.lblDispatcherEmail.text = (data.object(forKey: "DispatcherDriverInfo") as? [String:AnyObject])!["Fullname"] as? String
            cell.lblDispatcherNumber.text = (data.object(forKey: "DispatcherDriverInfo") as? [String:AnyObject])!["MobileNo"] as? String
            cell.lblDispatcherName.text = "DISPACTHER NAME"
            cell.lblDispatcherEmailTitle.text = "DISPATCHER EMAIL"
            cell.lblDispatcherNumber.text = "DISPATCHER TITLE"
            
            cell.stackViewEmail.isHidden = false
            cell.stackViewName.isHidden = false
            cell.stackViewNumber.isHidden = false
        }
        
        return cell
    }
    
    
    var expandedCellPaths = Set<IndexPath>()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? PendingJobsListTableViewCell {
            cell.viewAllDetails.isHidden = !cell.viewAllDetails.isHidden
            if cell.viewAllDetails.isHidden {
                expandedCellPaths.remove(indexPath)
            } else {
                expandedCellPaths.insert(indexPath)
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    
    func webserviceofPendingJobs() {
        
        let driverID = Singletons.sharedInstance.strDriverID
        
        webserviceForBookingHistry(driverID as AnyObject) { (result, status) in
            
            if (status)
            {
                //                print(result)
                
                self.aryData = ((result as! NSDictionary).object(forKey: "history") as! NSArray)
                self.getPendingJobs()
                
//                if(self.aryPendingJobs.count == 0)
//                {
//                    self.labelNoData.text = "Please check back later"
//                    self.tableView.isHidden = true
//                }
//                else
//                {
//                    self.labelNoData.removeFromSuperview()
//
//                    if self.tableView != nil
//                    {
//                        self.tableView.isHidden = false
//                    }
//                    else
//                    {
//                        self.tableView.delegate = self
//                        self.tableView.dataSource = self
//                        self.tableView.isHidden = false
//                    }
//                }
                
                if self.aryPendingJobs.count > 0 {
                    self.lblNodataFound.isHidden = true
                    self.tableView.isHidden = false
                } else {
                    self.lblNodataFound.isHidden = false
                }
                
                self.tableView.reloadData()
                
            }
            else {
                //                print(result)
                self.refreshControl.endRefreshing()
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
    
    func getPendingJobs() {
        
        aryPendingJobs.removeAllObjects()
        refreshControl.endRefreshing()
        for i in 0..<aryData.count {
            
            let dataOfAry = (aryData.object(at: i) as! NSDictionary)
            
            let strHistoryType = dataOfAry.object(forKey: "HistoryType") as? String
            
            if strHistoryType == "onGoing" {
                self.aryPendingJobs.add(dataOfAry)
                
            }
        }
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Socket: Notify Passenger For Advance Trip
    //-------------------------------------------------------------
    
    @objc func strtTrip(sender: UIButton)
    {
        //        if (Singletons.sharedInstance.isRequestAccepted == true)
        //        {
        //            UtilityClass.showAlert(appName.kAPPName, message: "Please complete your current trip first", vc: self)
        //        }
        //        else
        //        {
        if(Singletons.sharedInstance.driverDuty != "1") {
            UtilityClass.showAlert("App Name".localized, message: "Get online First.".localized, vc: self)
            return
        }
        let bookingID = String((sender.tag))
        
        Singletons.sharedInstance.strPendinfTripData = bookingID
        
        //            let alert = UIAlertController(title: nil, message: "Your trip is on there way.", preferredStyle: .alert)
        //            let OK = UIAlertAction(title: "OK", style: .default, handler: { ACTION in
        //
        //                let myJobs = (self.navigationController?.childViewControllers[0] as! TabbarController).childViewControllers.last as! MyJobsViewController
        //
        //                myJobs.callSocket()
        //
        //                self.tabBarController?.selectedIndex = 0
        
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MyJobsViewController") as? MyJobsViewController
        viewController?.callSocket()
        Singletons.sharedInstance.isRequestAccepted = true
        self.webserviceofPendingJobs()
        
        self.navigationController?.popViewController(animated: true)
        
        //            })
        //
        //            alert.addAction(OK)
        //
        //            self.present(alert, animated: true, completion: nil)
        //        }
        
    }
    
}


