//
//  MyBookingVC.swift
//  HJM
//
//  Created by Raj iMac on 23/08/19.
//  Copyright © 2019 Raj iMac. All rights reserved.
//

import UIKit

class MyBookingVC: BaseViewController {
    
    // MARK:- IBOutlets
    
    @IBOutlet var CollectionTableView: HeaderTableViewController!
    @IBOutlet var lblNoDataFound: UILabel! {
        didSet {
            lblNoDataFound.font = UIFont.regular(ofSize: 12)
        }
    }
    // MARK:- Variables
    var arrPastJobs = [[String: Any]]()
    var tripType = MyTrips.future
    var data = [(String, String)]()
    var pageNoPastBooking: Int = 1
    var pageNoPastUpcoming: Int = 1
    private let refreshControl = UIRefreshControl()
    var isRefresh = Bool()
    
    var isDataLoading:Bool=false
    var didEndReached:Bool=false
    var selectedCell : Int = -1
    
    var NeedToReload:Bool = false
    var PageLimit = 10
    var PageNumber = 1
    
    //    var pastBookingHistoryModelDetails = [(String,String,String,String,String,String)]()
    //    {
    //        didSet
    //        {`
    //            self.CollectionTableView.tableView.reloadData()
    //        }
    //    }
    var pastBookingHistoryModelDetails = [MyJobsObject]()
    {
        didSet
        {
            self.CollectionTableView.tableView.reloadData()
        }
    }
    // MARK:- ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionTableView()
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            CollectionTableView.tableView.refreshControl = refreshControl
        } else {
            CollectionTableView.tableView.addSubview(refreshControl)
        }
        self.tripType = MyTrips.allCases.first!
        refreshControl.addTarget(self, action: #selector(self.refreshWeatherData(_:)), for: .valueChanged)
        refreshControl.tintColor = ThemeYellowColor
        
        self.setNavigationBarInViewController(controller: self, naviTitle: "My Jobs".localized, leftImage: iconBack, rightImages: [], isTranslucent: false)
        // UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //        self.setNavBarWithBack(Title: "My Booking", IsNeedRightButton: false)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let indexPath = IndexPath.init(row: 1, section: 1)
   
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


//MARK:- Custom Methods

extension MyBookingVC {
    
    @objc private func refreshWeatherData(_ sender: Any) {
        self.LoadNewData()
        isRefresh = true
        
    }
    
    func LoadMoreData() {
        
        self.PageNumber += 1
        if self.tripType.rawValue.lowercased() == "past jobs" {
            
            //            self.webserviceCallForGettingPastHistory(pageNo: self.PageNumber)
            
            self.webserviceCallForGettingPastHistory(pageNo: self.PageNumber)
        } else{
            
            //            self.webserviceForUpcommingBooking(pageNo: self.PageNumber)
        }
        
    }
    
    func LoadNewData() {
        self.PageNumber = 1
        self.pastBookingHistoryModelDetails.removeAll()
        self.arrPastJobs.removeAll()
        self.CollectionTableView.tableView.reloadData()
        
        if self.tripType == .past {
            //            for _ in 0...10 {
            //                let singleObject = ("66987","Cargo Truck", "10-07-2019 - 06:30PM","Saudi Arabian Airlines, Opp Clock Tower", "Saudi German Hospital, Dubai", "Thomas Joi")
            //                self.pastBookingHistoryModelDetails.append(singleObject)
            //            }
            self.webserviceCallForGettingPastHistory(pageNo: self.PageNumber)
        } else if  self.tripType == .future {
            
            self.webserviceCallForGettingPastHistory(pageNo: self.PageNumber, jobsType: .Future)
        }else if self.tripType == .pending {
            self.webserviceCallForGettingPastHistory(pageNo: self.PageNumber, jobsType: .Pending)
        }
        
        self.CollectionTableView.tableView.removeAllSubviews()
        
        self.CollectionTableView.tableView.reloadData()
        
    }
    
    
    private func setCollectionTableView() {
        self.view.layoutIfNeeded()
        CollectionTableView.isSizeToFitCellNeeded = true
        CollectionTableView.indicatorColor = ThemeYellowColor
        CollectionTableView.titles = MyTrips.titles
        CollectionTableView.parentVC = self
        CollectionTableView.textColor = .black
        CollectionTableView.textFont = UIFont.regular(ofSize: 12)
        CollectionTableView.registerNibs = [MyTripTableViewCell.identifier,
                                            MyTripDescriptionTableViewCell.identifier,
                                            FooterTableViewCell.identifier]
        CollectionTableView.cellInset = UIEdgeInsets.zero
        CollectionTableView.spacing = 0
        
        CollectionTableView.didSelectItemAt = {
            indexpaths in
            if indexpaths.indexPath != indexpaths.previousIndexPath {
                self.tripType = MyTrips.allCases[indexpaths.indexPath.item]
                //                self.setData()
                self.selectedCell = -1
                self.LoadNewData()
                
                //                if indexpaths.indexPath.item == 1 {
                //                    self.LoadNewData()
                //                    //                    self.webserviceForUpcommingBooking(pageNo: 1)
                //                } else {
                //                    self.LoadNewData()
                //                    //                    self.webserviceCallForGettingPastHistory(pageNo: 1)
                //                }
                //                self.CollectionTableView.tableView.removeAllSubviews()
                //                self.CollectionTableView.tableView.reloadData()
            }
        }
        LoadNewData()
    }
    @objc func strtTrip(sender: UIButton)
    {
        if self.tripType.rawValue == "Future Jobs" {
            return
        }
        //        if (Singletons.sharedInstance.isRequestAccepted == true)
        //        {
        //            UtilityClass.showAlert(appName.kAPPName, message: "Please complete your current trip first", vc: self)
        //        }
        //        else
        //        {
        if Connectivity.isConnectedToInternet() == false {
            UtilityClass.showAlert("App Name".localized, message: "Sorry! Not connected to internet".localized, vc: self)
            return
        }
        
        if(Singletons.sharedInstance.driverDuty != "1") {
            UtilityClass.showAlert("App Name".localized, message: "Get online First.".localized, vc: self)
            return
        }
        let data = arrPastJobs[sender.tag]
        let bookingID = String((data["Id"] as! String))
        
        Singletons.sharedInstance.strPendinfTripData = bookingID
        
        //            let alert = UIAlertController(title: nil, message: "Your trip is on there way.", preferredStyle: .alert)
        //            let OK = UIAlertAction(title: "OK", style: .default, handler: { ACTION in
        //
        //                let myJobs = (self.navigationController?.childViewControllers[0] as! TabbarController).childViewControllers.last as! MyJobsViewController
        //
        //                myJobs.callSocket()
        //
        //                self.tabBarController?.selectedIndex = 0
        
        
//        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MyJobsViewController") as? MyJobsViewController
//        viewController?.callSocket()
        self.callSocket()
        Singletons.sharedInstance.isRequestAccepted = true
        
        
//        self.webserviceofPendingJobs()
        
        self.navigationController?.popViewController(animated: true)
        
        //            })
        //
        //            alert.addAction(OK)
        //
        //            self.present(alert, animated: true, completion: nil)
        //        }
        
    }
    func callSocket() {
        
        //        let socket = (((self.navigationController?.childViewControllers[0] as! TabbarController).childViewControllers)[0] as! ContentViewController).socket
        
        
        let socket = (UIApplication.shared.delegate as! AppDelegate).Socket
        //
        //        var isAdvance = (((self.navigationController?.childViewControllers[0] as! TabbarController).childViewControllers)[0] as! HomeViewController).isAdvanceBooking
        //        isAdvance = true
        
        
        //        let ttabbar = (self.navigationController?.childViewControllers[0] as! TabbarController)
        //        ttabbar.selectedIndex = 0
        
        //        Singletons.sharedInstance.isPending
        //        let  homeVC = self.navigationController?.viewControllers[0].children[0] as? HomeViewController
        
       /*
         let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? HomeViewController
        var isAdvance = viewController?.isAdvanceBooking
        
        isAdvance = true
        */
        let myJSON = ["DriverId" : Singletons.sharedInstance.strDriverID, "BookingId" : Singletons.sharedInstance.strPendinfTripData] as [String : Any]
        socket!.emit("NotifyPassengerForAdvancedTrip", with: [myJSON])
        Singletons.sharedInstance.strBookingType = "BookLater"
        print("Start Trip : \(myJSON)")
            
    }
    @objc func btnActionForSelectRecord(sender: UIButton) {
        if self.tripType.rawValue == "Pending Jobs" {
            return
        }
        if Connectivity.isConnectedToInternet() == false {
            UtilityClass.showAlert("App Name".localized, message: "Sorry! Not connected to internet".localized, vc: self)
            return
        }
        
//        bookingID = String((sender.tag))
        let data = arrPastJobs[sender.tag]
        let bookingID = String((data["Id"] as! String))
        webserviceOfFutureAcceptDispatchJobRequest(bookingID: bookingID)
        
    }
    func webserviceOfFutureAcceptDispatchJobRequest(bookingID: String) {
        
        let drieverId = Singletons.sharedInstance.strDriverID
        
        let sendParam = drieverId + "/" + bookingID
        
        webserviceForFutureAcceptDispatchJobRequest(sendParam as AnyObject) { (result, status) in
            
            if (status) {
                //                print(result)
                //needToCheck
                let alert = UIAlertController(title: "App Name".localized , message: ((result as! [String:AnyObject])[GetResponseMessageKey()] as! String), preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK".localized, style: .default, handler: { ACTION in
                    //                    let myJobs = (self.navigationController?.children[0] as! TabbarController).childViewControllers.last as! MyJobsViewController
//                    self.webserviceOFFurureBooking()
                    //                    myJobs.btnPendingJobsClicked(myJobs.btnPendingJobs)
                  /*  if let VC = self.parent as? MyJobsViewController
                    {
                        if let VCPending = self.parent?.children[0] as? PendingJobsListVC
                        {
                            VCPending.webserviceofPendingJobs()
                        }
                        VC.btnPendingJobsClicked(VC.btnPendingJobs)
                    } */
                    
                    delay(1.0) {
                        self.CollectionTableView.SelectIndex = 1
                    }
//                    self.CollectionTableView.didSelectItemAt
                })
                alert.addAction(OK)
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                //                print(result)
                
                
                if let res = result as? String {
                    UtilityClass.showAlert("App Name".localized, message: res, vc: self)
                }else if let resDict = result as? NSDictionary {
                    UtilityClass.showAlert("App Name".localized, message: resDict.object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }else if let resAry = result as? NSArray {
                    UtilityClass.showAlert("App Name".localized, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }
            }
        }
        
    }
}


// MARK:- TableView Delegate Methods


extension MyBookingVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        lblNoDataFound.isHidden = (self.arrPastJobs.count != 0)
        return arrPastJobs.count//self.pastBookingHistoryModelDetails.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedCell == section {
            return 1 + self.data.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
        //            tableView.dequeueReusableCell(withIdentifier: FooterTableViewCell.identifier)
    }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return (self.tripType == MyTrips.past) ? 179 :  209
    //    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MyTripTableViewCell.identifier, for: indexPath) as! MyTripTableViewCell
            
            //            let dataResponseHeader = self.pastBookingHistoryModelDetails[indexPath.section]
            //            cell.lblName.text = "\(dataResponseHeader.driverFirstName ?? "") \(dataResponseHeader.driverLastName ?? "")"
            //            cell.lblBookin.text = "Booking Id : \(dataResponseHeader.id ?? "")"
            //            cell.lblPickup.text = dataResponseHeader.pickupLocation
            //            cell.lblDropoff.text = dataResponseHeader.dropoffLocation
            //            cell.lblKM.isHidden = true
            //
            /*
             let CurrentData = self.pastBookingHistoryModelDetails[indexPath.section]
             
             cell.lblBookingId.text = "Booking Id : ".localized + (CurrentData.id ?? "0")
             cell.lblDriverName.text = "Passenger Name : ".localized +  CurrentData.customer.fullName
             cell.lblBookingDate.text = CurrentData.truckInfo.locations.first!.dateDescription
             cell.lblPickup.text = CurrentData.truckInfo.locations.first!.pickupLocation
             cell.lblDropoff.text = CurrentData.truckInfo.locations.first!.dropoffLocation
             */
            
            let data = arrPastJobs[indexPath.section]
            cell.lblPickup.text = data["PickupLocation"] as? String ?? ""
            cell.lblBookingDate.text = data["PickupDateTime"] as? String ?? ""
            cell.lblPrice.text = currency + (data["GrandTotal"] as? String ?? "")
            if let strUrl = data["MapUrl"] as? String {
                if let url = URL.init(string: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
                    cell.imgVW.sd_setImage(with: url)
                }
            }
            //            cell.lblModelName.text = CurrentData.1
            //            cell.lblBookingDate.text = CurrentData.2
            //            cell.lblPickup.text = CurrentData.3
            //            cell.lblDropoff.text = CurrentData.4
            //            cell.lblDriverName.text =  "Passenger Name : " +  CurrentData.5
            cell.conVwAcceptWidth.constant = 100
            cell.btnSendReceipt.isHidden = true
            
            if self.tripType.rawValue == "Future Jobs" {
                cell.btnSendReceipt.isHidden = false
                cell.btnSendReceipt.setTitle("Accept".localized, for: .normal)
                cell.btnSendReceipt.tag = indexPath.section
                cell.hideAcceptRequestButton(isHide: false)
                cell.lblCancel.isHidden = true
                
                cell.btnSendReceipt.addTarget(self, action: #selector(btnActionForSelectRecord(sender:)), for: .touchUpInside)
                cell.lblPrice.isHidden = true
                cell.lblPriceTitle.isHidden = true
                //                cell.btnSendReceipt.addTarget(self, action: #selector(self.cancelTrip(_:)), for: .touchUpInside)
                //
                //                UtilityClass.viewCornerRadius(view: cell.btnSendReceipt, borderWidth: 1, borderColor: .white)
                
                //                cell.btnSendReceipt.layer.cornerRadius = view.frame.height/2
                //                cell.btnSendReceipt.layer.masksToBounds = true
                //                cell.btnSendReceipt.layer.borderWidth = borderWidth
                //                cell.btnSendReceipt.layer.borderColor = borderColor.cgColor
                
            }else if self.tripType.rawValue == "Pending Jobs" {
                cell.lblPrice.isHidden = true
                cell.lblPriceTitle.isHidden = true
                cell.btnSendReceipt.isHidden = false
                cell.btnSendReceipt.setTitle("On The Way".localized, for: .normal)
                cell.btnSendReceipt.tag = indexPath.section
                cell.conVwAcceptWidth.constant = 120
                cell.lblCancel.isHidden = true
                cell.hideAcceptRequestButton(isHide: false)
                cell.btnSendReceipt.addTarget(self, action: #selector(strtTrip(sender:)), for: .touchUpInside)
            }else {
                cell.hideAcceptRequestButton(isHide: true)
                
              /* let data = arrPastJobs[indexPath.section]
                cell.lblPickup.text = data["PickupLocation"] as? String ?? ""
                cell.lblBookingDate.text = data["PickupDateTime"] as? String ?? ""
                cell.lblPrice.text = currency + (data["GrandTotal"] as? String ?? "")
                if let strUrl = data["MapUrl"] as? String {
                    if let url = URL.init(string: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
                        cell.imgVW.sd_setImage(with: url)
                    }
                } */
                if let status = data["Status"] as? String {
                    if status == "canceled" {
                        cell.lblCancel.text = "Cancelled".localized
                        cell.lblCancel.isHidden = false
                        cell.lblPrice.isHidden = true
                        cell.lblPriceTitle.isHidden = true
                    }else {
                        cell.lblCancel.isHidden = true
                        cell.lblPrice.isHidden = false
                        cell.lblPriceTitle.isHidden = false
                    }
                }
                    print(data["Status"])
            }
            
            cell.setup()
            //            if self.NeedToReload == true && indexPath.section == self.pastBookingHistoryModelDetails.count - 1 {
            //                self.LoadMoreData()
            //            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MyTripDescriptionTableViewCell.identifier, for: indexPath) as! MyTripDescriptionTableViewCell
            
            cell.lblTitle.text = data[indexPath.row - 1].0 + ":"
            cell.lblDescription.text = data[indexPath.row - 1].1
            let color = indexPath.row == data.count ? UIColor.orange : UIColor.white
            cell.lblDescription.textColor = color
            cell.lblTitle.textColor = color
            cell.setup()
            
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.NeedToReload == true && indexPath.section == self.arrPastJobs.count - 1 {
            self.LoadMoreData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tripType == MyTrips.past  {
            let bookingDetailVC:TripInfoCompletedTripVC = UIViewController.viewControllerInstance(storyBoard: .Main)
//            bookingDetailVC.dictData
            let data = self.arrPastJobs[indexPath.section]
            bookingDetailVC.dictDataPastJobs = data
            bookingDetailVC.isFromPastJobs = true
            print(data)
            self.present(bookingDetailVC, animated: true, completion:nil)
            
        }
        
    }
    /*
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     if selectedCell == indexPath.section {
     selectedCell = -1
     self.data = self.tripType.getDescription(pastBookingHistory: self.pastBookingHistoryModelDetails[indexPath.section])
     tableView.reloadData()
     }
     else{
     self.data = self.tripType.getDescription(pastBookingHistory: self.pastBookingHistoryModelDetails[indexPath.section])
     selectedCell = indexPath.section
     tableView.reloadData()
     }
     //        if indexPath.section == 9{
     //            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
     //        }
     
     }
     
     */
}


//MARK:- Webservice methods


extension MyBookingVC {
    enum JobsType : String {
        case Past
        case Future
        case Pending
    }
    func webserviceCallForGettingPastHistory(pageNo: Int, jobsType: JobsType = .Past) {
        if jobsType == .Past {
            self.pastJobs(pageNo: pageNo)
        }else if jobsType == .Future {
            self.futureJobs()
        }else if jobsType == .Pending {
            self.pendingJobs()
        }
        /*
         let model = PastBookingHistory()
         model.customer_id = SingletonClass.sharedInstance.loginData.id
         model.page = "\(pageNo)"
         */
        //===============Raj381=================
        /*
         guard let driverId = Singleton.shared().loginUserData?.driverDetails.id else {
         return
         }
         let strURL = "/" + driverId + "/" + jobsType.rawValue.lowercased() + "/" + "\(pageNo)"
         
         if(!isRefresh)
         {
         //            UtilityClass.showHUD(with: UIApplication.shared.keyWindow)
         }
         
         UserWebserviceSubclass.getPastJobsList(strURL: strURL) { (response, status) in
         self.isRefresh = false
         if(status) {
         var arrResponseData = [MyJobsObject]()
         
         if let arrayResponse = response.dictionary?["data"]?.array {
         arrResponseData = arrayResponse.map({ (item) -> MyJobsObject in
         return MyJobsObject.init(fromJson: item)
         })
         }
         
         if arrResponseData.count == self.PageLimit {
         self.NeedToReload = true
         } else {
         self.NeedToReload = false
         }
         
         if self.PageNumber == 1 {
         self.pastBookingHistoryModelDetails = arrResponseData
         } else {
         for BookingObj in arrResponseData {
         self.pastBookingHistoryModelDetails.append(BookingObj)
         }
         }
         //                self.pastBookingHistoryModelDetails = self.pastBookingHistoryModelDetails.filter({$0.driverId != "0"})
         self.CollectionTableView.tableView.reloadData()
         self.refreshControl.endRefreshing()
         }
         else {
         UtilityClass.hideHUD()
         AlertMessage.showMessageForError(response["message"].stringValue)
         }
         }
         */
    }
    func pastJobs(pageNo: Int) {
        let driverId = Singletons.sharedInstance.strDriverID //+ "/" + "\(index)"
             
             webserviceForPastBookingList(driverId as AnyObject, PageNumber: pageNo as AnyObject) { (result, status) in
                 if (status) {
                     DispatchQueue.main.async {
                         
                         //                    let tempPastData = ((result as! NSDictionary).object(forKey: "history") as! NSArray)
                         if let tempData = result["history"] as? [[String: Any]] {
                             
                             if pageNo == 1 {
                                 self.arrPastJobs = []
                                 self.arrPastJobs = tempData
                             }else {
                                 for obj in tempData {
                                     self.arrPastJobs.append(obj)
                                 }
                             }
                             
                             if tempData.count == 10 {
                                 self.NeedToReload = true
                             }else{
                                 self.NeedToReload = false
                             }
                         }
                         
                         
                         /* if self.aryData.count == 0 {
                          self.aryData.addObjects(from: tempPastData as! [Any])
                          } else {
                          self.aryData.addObjects(from: tempPastData as! [Any])
                          } */
                         
                         //                    for i in 0..<tempPastData.count {
                         //
                         //                        let dataOfAry = (tempPastData.object(at: i) as! NSDictionary)
                         //
                         //                        let strHistoryType = dataOfAry.object(forKey: "HistoryType") as? String
                         //
                         //                        if strHistoryType == "Past" {
                         //                            self.aryData.add(dataOfAry)
                         //                        }
                         //                    }
                         
                         //                    if(self.aryData.count == 0) {
                         //                        self.labelNoData.text = "No data found."
                         //                        self.tableView.isHidden = true
                         //                    }
                         //                    else {
                         //                        self.labelNoData.removeFromSuperview()
                         //                        self.tableView.isHidden = false
                         //                    }
                         
                         //                    self.getPostJobs()
                         
                         self.refreshControl.endRefreshing()
                         if self.arrPastJobs.count > 0 {
                             self.lblNoDataFound.isHidden = true
                             //self.tableView.isHidden = false
                         } else {
                             self.lblNoDataFound.isHidden = false
                         }
                         self.CollectionTableView.tableView.reloadData()
                         
                         UtilityClass.hideACProgressHUD()
                     }
                 }
                 else {
                     DispatchQueue.main.async {
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
                     
                     //                UtilityClass.showAlertOfAPIResponse(param: result, vc: self)
                 }
                 
             }
    }
    func pendingJobs() {
         let driverId = Singletons.sharedInstance.strDriverID
        webserviceForPendingJobs(driverId as AnyObject) { (result, status) in
            if (status) {
                DispatchQueue.main.async {
                    print(#function)
                    print(result)
                    //                    let tempPastData = ((result as! NSDictionary).object(forKey: "history") as! NSArray)
                    if let tempData = result["history"] as? [[String: Any]] {
                        
                       /* if pageNo == 1 {
                            self.arrPastJobs = []
                            self.arrPastJobs = tempData
                        }else {
                            for obj in tempData {
                                self.arrPastJobs.append(obj)
                            }
                        }
                        
                        if tempData.count == 10 {
                            self.NeedToReload = true
                        }else{
                            self.NeedToReload = false
                        } */
                        
                         self.arrPastJobs = tempData
                    }
                    
        
                    
                    self.refreshControl.endRefreshing()
                    if self.arrPastJobs.count > 0 {
                        self.lblNoDataFound.isHidden = true
                        //self.tableView.isHidden = false
                    } else {
                        self.lblNoDataFound.isHidden = false
                    }
                    self.CollectionTableView.tableView.reloadData()
                    
                    UtilityClass.hideACProgressHUD()
                }
            }
            else {
                DispatchQueue.main.async {
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
                
                //                UtilityClass.showAlertOfAPIResponse(param: result, vc: self)
            }

        }
    }
    func futureJobs() {
        let driverId = Singletons.sharedInstance.strDriverID
        webserviceForFutureBooking(driverId as AnyObject) { (result, status) in
            if (status) {
                DispatchQueue.main.async {
                    print(result)
                    print(#function)
                    
                    //                    let tempPastData = ((result as! NSDictionary).object(forKey: "history") as! NSArray)
                           if let tempData = result["dispath_job"] as? [[String: Any]] {
                        
//                        if pageNo == 1 {
//                            self.arrPastJobs = []
//                            self.arrPastJobs = tempData
//                        }else {
//                            for obj in tempData {
//                                self.arrPastJobs.append(obj)
//                            }
//                        }
                         self.arrPastJobs = tempData
                      /*  if tempData.count == 10 {
                            self.NeedToReload = true
                        }else{
                            self.NeedToReload = false
                        } */
                    }
                                                        
                    self.refreshControl.endRefreshing()
                    if self.arrPastJobs.count > 0 {
                        self.lblNoDataFound.isHidden = true
                        //self.tableView.isHidden = false
                    } else {
                        self.lblNoDataFound.isHidden = false
                    }
                    self.CollectionTableView.tableView.reloadData()
                    
                    UtilityClass.hideACProgressHUD()
                }
            }
            else {
                DispatchQueue.main.async {
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
                
                //                UtilityClass.showAlertOfAPIResponse(param: result, vc: self)
            }

        }
    }
    /*  func webserviceOfPastbookingpagination(index: Int)
     {
     
     let driverId = Singletons.sharedInstance.strDriverID //+ "/" + "\(index)"
     
     webserviceForPastBookingList(driverId as AnyObject, PageNumber: index as AnyObject) { (result, status) in
     if (status) {
     DispatchQueue.main.async {
     
     let tempPastData = ((result as! NSDictionary).object(forKey: "history") as! NSArray)
     
     if tempPastData.count == 10 {
     self.NeedToReload = true
     } else {
     self.NeedToReload = false
     }
     
     if self.aryData.count == 0 {
     self.aryData.addObjects(from: tempPastData as! [Any])
     } else {
     self.aryData.addObjects(from: tempPastData as! [Any])
     }
     
     //                    for i in 0..<tempPastData.count {
     //
     //                        let dataOfAry = (tempPastData.object(at: i) as! NSDictionary)
     //
     //                        let strHistoryType = dataOfAry.object(forKey: "HistoryType") as? String
     //
     //                        if strHistoryType == "Past" {
     //                            self.aryData.add(dataOfAry)
     //                        }
     //                    }
     
     //                    if(self.aryData.count == 0) {
     //                        self.labelNoData.text = "No data found."
     //                        self.tableView.isHidden = true
     //                    }
     //                    else {
     //                        self.labelNoData.removeFromSuperview()
     //                        self.tableView.isHidden = false
     //                    }
     
     //                    self.getPostJobs()
     
     self.refreshControl.endRefreshing()
     if self.aryData.count > 0 {
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
     DispatchQueue.main.async {
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
     
     //                UtilityClass.showAlertOfAPIResponse(param: result, vc: self)
     }
     
     }
     } */
    /*
     UserWebserviceSubclass.pastBookingHistory(strURL: strURL) { (response, status) in
     UtilityClass.hideHUD()
     self.isRefresh = false
     if(status) {
     var arrResponseData = [PastBookingHistoryResponse]()
     
     if let arrayResponse = response.dictionary?["data"]?.array {
     arrResponseData = arrayResponse.map({ (item) -> PastBookingHistoryResponse in
     return PastBookingHistoryResponse.init(fromJson: item)
     })
     }
     
     if arrResponseData.count == self.PageLimit {
     self.NeedToReload = true
     } else {
     self.NeedToReload = false
     }
     
     if self.PageNumber == 1 {
     self.pastBookingHistoryModelDetails = arrResponseData
     } else {
     for BookingObj in arrResponseData {
     self.pastBookingHistoryModelDetails.append(BookingObj)
     }
     }
     //                self.pastBookingHistoryModelDetails = self.pastBookingHistoryModelDetails.filter({$0.driverId != "0"})
     self.CollectionTableView.tableView.reloadData()
     self.refreshControl.endRefreshing()
     }
     else {
     UtilityClass.hideHUD()
     AlertMessage.showMessageForError(response["message"].stringValue)
     }
     }
     */
}
/*
 func webserviceForUpcommingBooking(pageNo: Int) {
 
 let param = SingletonClass.sharedInstance.loginData.id + "/" + "\(pageNo)"
 UserWebserviceSubclass.upcomingBookingHistory(strURL: param) { (response, status) in
 print(response)
 UtilityClass.hideHUD()
 self.isRefresh = false
 if(status) {
 var arrResponseData = [PastBookingHistoryResponse]()
 
 if let arrayResponse = response.dictionary?["data"]?.array {
 arrResponseData = arrayResponse.map({ (item) -> PastBookingHistoryResponse in
 return PastBookingHistoryResponse.init(fromJson: item)
 })
 }
 
 if arrResponseData.count == self.PageLimit {
 self.NeedToReload = true
 } else {
 self.NeedToReload = false
 }
 
 if self.PageNumber == 1 {
 self.pastBookingHistoryModelDetails = arrResponseData
 } else {
 for BookingObj in arrResponseData {
 self.pastBookingHistoryModelDetails.append(BookingObj)
 }
 }
 //                self.pastBookingHistoryModelDetails = self.pastBookingHistoryModelDetails.filter({$0.driverId != "0"})
 self.CollectionTableView.tableView.reloadData()
 self.refreshControl.endRefreshing()
 }
 else {
 UtilityClass.hideHUD()
 AlertMessage.showMessageForError(response["message"].stringValue)
 }
 }
 }
 
 @objc func cancelTrip(_ sender: UIButton) {
 let dataResponseHeader = self.pastBookingHistoryModelDetails[sender.tag]
 //        (self.parent?.children.first as! HomeViewController).booingInfo = dataResponseHeader
 
 webserviceForCancelTrip(bookingId: dataResponseHeader.id)
 
 //        ((self.parent?.children.first as! HomeViewController).children[1] as! DriverInfoPageViewController).webserviceForCancelTrip()
 }
 
 func webserviceForCancelTrip(bookingId: String) {
 
 let homeVC = self.parent?.children.first as? HomeViewController
 
 let model = CancelTripRequestModel()
 model.booking_id = bookingId
 UserWebserviceSubclass.CancelTripBookingRequest(bookingRequestModel: model) { (response, status) in
 
 if status {
 homeVC?.setupAfterComplete()
 self.webserviceForUpcommingBooking(pageNo: 1)
 } else {
 AlertMessage.showMessageForError(response.dictionary?["message"]?.stringValue ?? "Something went wrong")
 }
 }
 }
 
 }
 
 */
