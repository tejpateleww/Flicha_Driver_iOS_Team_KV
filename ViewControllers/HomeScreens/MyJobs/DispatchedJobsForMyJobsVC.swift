//
//  DispatchedJobsForMyJobsVC.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 14/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class DispatchedJobsForMyJobsVC: ParentViewController, UITableViewDataSource, UITableViewDelegate {


    var aryData = NSArray()
    var expandedCellPaths = Set<IndexPath>()
    
    var labelNoData = UILabel()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    override func viewWillAppear(_ animated: Bool) {
        self.viewWillAppear(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView?.btnBack.addTarget(self, action: #selector(self.dismissSelf), for: .touchUpInside)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
            
        labelNoData = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.labelNoData.text = "Loading..."
        labelNoData.textAlignment = .center
        self.view.addSubview(labelNoData)
        self.tableView.isHidden = true

        webserviceOfDispatchJobs()
        
         self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        self.tableView.addSubview(self.refreshControl)
    }
    
    override func loadView() {
        super.loadView()
        
//        let activityData = ActivityData()
//        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
    }

    
    @objc func dismissSelf() {
        
        self.navigationController?.popViewController(animated: true)
        
//        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        webserviceOfDispatchJobs()
        
        tableView.reloadData()
        
       
    }

    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet var tableView: UITableView!
    
    
    //-------------------------------------------------------------
    // MARK: - Table View Methods
    //-------------------------------------------------------------
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if section == 0 {
//
//            if aryData.count == 0 {
//                return 0
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
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchedJobsForMyJobsTableViewCell") as! DispatchedJobsForMyJobsTableViewCell
//        let cell2 = tableView.dequeueReusableCell(withIdentifier: "NoDataFound") as! DispatchedJobsForMyJobsTableViewCell
        
        cell.selectionStyle = .none
//        cell2.selectionStyle = .none
        cell.lblPickUpLocationInFo.text = "Current Location".localized
        cell.lblDropLocationInFo.text = "Drop off location".localized
//        cell.lblPassengerEmail.text = "".localized
        cell.lblPassengerNumber.text = "Number Of Passenger".localized
        cell.lblPassengerFlightNo.text = "".localized
        
//        if indexPath.section == 0 {
//
            if aryData.count != 0 {

                let dictData = aryData.object(at: indexPath.row) as! NSDictionary
                
                cell.lblDriversNames.text = dictData.object(forKey: "PassengerName") as? String
                cell.lblDropLocationDescription.text = dictData.object(forKey: "PickupLocation") as? String // DropoffLocation
                cell.lblDateAndTime.text = dictData.object(forKey: "CreatedDate") as? String
                
                cell.lblPickUpLocationDescription.text = dictData.object(forKey: "DropoffLocation") as? String  // PickupLocation
                cell.lblPassengerEmail.text = dictData.object(forKey: "PassengerEmail") as? String
                cell.lblPassengerNumber.text = dictData.object(forKey: "PassengerContact") as? String
                
                cell.lblPassengerFlightNo.text = dictData.object(forKey: "FlightNumber") as? String
                cell.lblPassengerNotes.text = dictData.object(forKey: "Notes") as? String
                
                
                cell.lblCarModel.text = dictData.object(forKey: "Model") as? String
                cell.lblTripDistance.text = dictData.object(forKey: "TripDistance") as? String
                cell.lblTripFare.text = dictData.object(forKey: "TripFare") as? String
                cell.lblTax.text = dictData.object(forKey: "Tax") as? String
                cell.lblSubTotal.text = dictData.object(forKey: "SubTotal") as? String
                cell.lblGrandTotal.text = dictData.object(forKey: "GrandTotal") as? String
                cell.lblPaymentType.text = dictData.object(forKey: "PaymentType") as? String
                
                cell.viewDetails.isHidden = !expandedCellPaths.contains(indexPath)
                
                
                cell.lblDispatcherName.text = ""
                cell.lblDispatcherEmail.text = ""
                cell.lblDispatcherNumber.text = ""
                cell.lblDispatcherNameTitle.text = ""
                cell.lblDispatcherEmailTitle.text = ""
                cell.lblDispatcherNumberTitle.text = ""
                
                
                cell.stackViewEmail.isHidden = true
                cell.stackViewName.isHidden = true
                cell.stackViewNumber.isHidden = true
                
                if((dictData.object(forKey: "DispatcherDriverInfo")) != nil)
                {
                    print("There is driver info and passengger name is \(String(describing: cell.lblDriversNames.text))")
                    
                    cell.lblDispatcherName.text = (dictData.object(forKey: "DispatcherDriverInfo") as? [String:AnyObject])!["Email"] as? String
                    cell.lblDispatcherEmail.text = (dictData.object(forKey: "DispatcherDriverInfo") as? [String:AnyObject])!["Fullname"] as? String
                    cell.lblDispatcherNumber.text = (dictData.object(forKey: "DispatcherDriverInfo") as? [String:AnyObject])!["MobileNo"] as? String
                    cell.lblDispatcherNameTitle.text = "DISPACTHER NAME"
                    cell.lblDispatcherEmailTitle.text = "DISPATCHER EMAIL"
                    cell.lblDispatcherNumberTitle.text = "DISPATCHER TITLE"
                    
                    cell.stackViewEmail.isHidden = false
                    cell.stackViewName.isHidden = false
                    cell.stackViewNumber.isHidden = false
                }
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
        
//        if indexPath.section == 0 {
//
//            if aryData.count != 0 {
//
                if let cell = tableView.cellForRow(at: indexPath) as? DispatchedJobsForMyJobsTableViewCell {
                    cell.viewDetails.isHidden = !cell.viewDetails.isHidden
                    if cell.viewDetails.isHidden {
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
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    func nevigateToBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
   
    //-------------------------------------------------------------
    // MARK: - Webservice Methods
    //-------------------------------------------------------------
    
    func webserviceOfDispatchJobs() {
        
        let driverId = Singletons.sharedInstance.strDriverID
        
        webserviceForMyDispatchJobsList(driverId as AnyObject) { (result, status) in
            
            if (status) {
                
                print(result)
                
                self.aryData = (result as! NSDictionary).object(forKey: "history") as! NSArray
                
                
                if(self.aryData.count == 0)
                {
                    self.labelNoData.text = "Please check back later"
                    self.tableView.isHidden = true
                }
                else {
                    self.labelNoData.removeFromSuperview()
                    self.tableView.isHidden = false
                }

                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
            else {
                print(result)
            }
        }
        
    }
 
    
    
}
