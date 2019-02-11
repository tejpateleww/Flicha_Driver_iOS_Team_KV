//
//  FutureBookingVC.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 16/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class FutureBookingVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNodataFound: UILabel!
    
    
    var strNotAvailable: String = "N/A"
    
//    let hView = HeaderView()
    
    var dataPatam = [String:AnyObject]()
    var aryData = NSArray()
    var expandedCellPaths = Set<IndexPath>()
    var selectedCellIndexPath: IndexPath?
    
    let selectedCellHeight: CGFloat = 205
    let unselectedCellHeight: CGFloat = 105
    
    var drieverId = String()
    var bookingID = String()
    
//     var labelNoData = UILabel()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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
//        webserviceOFFurureBooking()
        
    }
    override func loadView() {
        super.loadView()
        
//        let activityData = ActivityData()
//        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
                
        webserviceOFFurureBooking()
        if self.aryData.count > 0 {
            self.lblNodataFound.isHidden = true
        } else {
            self.lblNodataFound.isHidden = false
        }
        tableView.reloadData()
       
    }

  
    
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
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "FutureBookingTableViewCell") as! FutureBookingTableViewCell
        
//        let cell2 = tableView.dequeueReusableCell(withIdentifier: "NoDataFound") as! FutureBookingTableViewCell
        
        cell.selectionStyle = .none
        cell.viewCell.layer.cornerRadius = 10
        cell.viewCell.clipsToBounds = true
//        cell2.selectionStyle = .none
  
//        if aryData.count != 0 {
        
//            if indexPath.section == 0 {
//
                 let data = aryData.object(at: indexPath.row) as! NSDictionary
               
                cell.lblPassengerName.text = data.object(forKey: "PassengerName") as? String
        

//            if let TimeAndDate = data.object(forKey: "PickupDateTime") as? String {
//                cell.lblTimeAndDateAtTop.text = setTimeStampToDate(timeStamp: TimeAndDate)
//            }
//            else {
//                cell.lblTimeAndDateAtTop.text = strNotAvailable
//            }
        
        cell.lblBookingId.text = "Booking ID: \(checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "Id", isNotHave: strNotAvailable))"
    
        
        cell.lblDate.text = (checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PickupDateTime", isNotHave: strNotAvailable)).components(separatedBy: " ")[0]
        
//         checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PaymentType", isNotHave: strNotAvailable)

                cell.lblDropOffLocationDesc.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PickupLocation", isNotHave: strNotAvailable) //data.object(forKey: "PickupLocation") as? String // DropoffLocation
                cell.lblDateAndTime.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PickupDateTime", isNotHave: strNotAvailable)
                cell.lblPickupTimeValue.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PickupDateTime", isNotHave: strNotAvailable)
                //data.object(forKey: "PickupDateTime") as? String
                cell.lblPickupLocation.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "DropoffLocation", isNotHave: strNotAvailable) // data.object(forKey: "DropoffLocation") as? String  // PickupLocation
                cell.lblPassengerNoDesc.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PassengerContact", isNotHave: strNotAvailable) //data.object(forKey: "PassengerContact") as? String
                cell.lblTripDestanceDesc.text = "\(checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "TripDistance", isNotHave: strNotAvailable)) km" //data.object(forKey: "TripDistance") as? String
                cell.lblCarModelDesc.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "Model", isNotHave: strNotAvailable) //data.object(forKey: "Model") as? String
                
                cell.btnAction.tag = Int((data.object(forKey: "Id") as? String)!)!
                cell.btnAction.addTarget(self, action: #selector(self.btnActionForSelectRecord(sender:)), for: .touchUpInside)
                cell.lblFlightNumber.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "FlightNumber", isNotHave: strNotAvailable) // data.object(forKey: "FlightNumber") as? String
                cell.lblNotes.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "Notes", isNotHave: strNotAvailable) //data.object(forKey: "Notes") as? String
                cell.lblPaymentType.text = checkDictionaryHaveValue(dictData: data as! [String : AnyObject], didHaveValue: "PaymentType", isNotHave: strNotAvailable) // data.object(forKey: "PaymentType") as? String
                cell.viewSecond.isHidden = !expandedCellPaths.contains(indexPath)
 
//            }
        
        
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
        
            return cell
//        }
//        else {
//
//            cell2.frame.size.height = self.tableView.frame.size.height
//
//            return cell2
//        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//
//        if aryData.count != 0 {
//
//            if indexPath.section == 0 {
//
                if let cell = tableView.cellForRow(at: indexPath) as? FutureBookingTableViewCell {
                    cell.viewSecond.isHidden = !cell.viewSecond.isHidden
                    if cell.viewSecond.isHidden {
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
    

    @objc func btnActionForSelectRecord(sender: UIButton) {
        
        bookingID = String((sender.tag))
        
        webserviceOfFutureAcceptDispatchJobRequest()
        
    }
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    func setTimeStampToDate(timeStamp: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        let date = dateFormatter.date(from: timeStamp) //according to date format your date string
        print(date ?? "")

        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "HH:mm dd/MM/yyyy" //Specify your format that you want
        let strDate: String = dateFormatter.string(from: date!)
        
        return strDate
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    
    func webserviceOFFurureBooking()
    {
        
        let id = Singletons.sharedInstance.strDriverID
        
        webserviceForFutureBooking(id as AnyObject) { (result, status) in
            
            if (status) {
//                print(result)
                
                self.aryData = ((result as! NSDictionary).object(forKey: "dispath_job") as! NSArray)
//                if(self.aryData.count == 0)
//                {
//                    self.labelNoData.text = "Please check back later"
//                    self.tableView.isHidden = true
//                }
//                else {
//                    self.labelNoData.removeFromSuperview()
//                    self.tableView.isHidden = false
//                }
                
                self.refreshControl.endRefreshing()
                if self.aryData.count > 0 {
                    self.lblNodataFound.isHidden = true
                } else {
                    self.lblNodataFound.isHidden = false
                }
                self.tableView.reloadData()
                
            }
            else {
                print(result)
            
            }
        }
    }
    
    var audioPlayer:AVAudioPlayer!
    
    func playSound(strName : String) {
        
//        guard let url = Bundle.main.url(forResource: strName, withExtension: "mp3") else { return }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer.numberOfLoops = 1
//            audioPlayer.play()
//        }
//        catch let error {
//            print(error.localizedDescription)
//        }
    }
    
    func stopSound() {
        
//        guard let url = Bundle.main.url(forResource: "\(RingToneSound)", withExtension: "mp3") else { return }
//        
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            try AVAudioSession.sharedInstance().setActive(true)
//            
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer.stop()
//        }
//        catch let error {
//            print(error.localizedDescription)
//        }
    }
    
    
    
    func webserviceOfFutureAcceptDispatchJobRequest() {
        
        drieverId = Singletons.sharedInstance.strDriverID

        let sendParam = drieverId + "/" + bookingID
     
        webserviceForFutureAcceptDispatchJobRequest(sendParam as AnyObject) { (result, status) in

            if (status) {
//                print(result)
                let alert = UIAlertController(title: "Booking Accepted", message: "", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default, handler: { ACTION in
//                    let myJobs = (self.navigationController?.children[0] as! TabbarController).childViewControllers.last as! MyJobsViewController
                    self.webserviceOFFurureBooking()
//                    myJobs.btnPendingJobsClicked(myJobs.btnPendingJobs)
                    if let VC = self.parent as? MyJobsViewController
                    {
                        if let VCPending = self.parent?.children[0] as? PendingJobsListVC
                        {
                            VCPending.webserviceofPendingJobs()
                        }
                        VC.btnPendingJobsClicked(VC.btnPendingJobs)
                    }
                 })
                alert.addAction(OK)
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
//                print(result)
                
        
                if let res = result as? String {
                    UtilityClass.showAlert(appName.kAPPName, message: res, vc: self)
                }
                else if let resDict = result as? NSDictionary {
                    UtilityClass.showAlert(appName.kAPPName, message: resDict.object(forKey: "message") as! String, vc: self)
                }
                else if let resAry = result as? NSArray {
                    UtilityClass.showAlert(appName.kAPPName, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: "message") as! String, vc: self)
                }
            }
        }
        
    }
    
    
 
}
