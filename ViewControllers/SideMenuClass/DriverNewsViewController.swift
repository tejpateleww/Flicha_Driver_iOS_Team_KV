//
//  DriverNewsViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 09/12/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import SDWebImage

class DriverNewsViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource {

    var aryNews = [[String:AnyObject]]()
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        
       GoogleNews()
        
        self.tableView.addSubview(self.refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

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
        return aryNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let News = aryNews[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverNewsTableViewCell") as! DriverNewsTableViewCell
        cell.selectionStyle = .none
        cell.viewNews.layer.cornerRadius = 10
        cell.viewNews.layer.masksToBounds = true
        
        cell.lblNewsTitle.text = News["title"] as? String
        cell.imgNews.sd_setShowActivityIndicatorView(true)
         cell.imgNews.sd_setIndicatorStyle(.gray)
        
        if let imgURL = News["urlToImage"] as? String {
             cell.imgNews.sd_setImage(with: URL(string: imgURL), completed: nil)
        }
        
        cell.lblNewsDescription.text = News["description"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let News = aryNews[indexPath.row]
//        
//        let next = self.storyboard?.instantiateViewController(withIdentifier: "webViewForNewsViewController") as! webViewForNewsViewController
//        next.strURL = News["url"] as! String
//        self.navigationController?.pushViewController(next, animated: true)
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        GoogleNews()
        
        tableView.reloadData()
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    func GoogleNews() {
        
        webserviceForGoogleNews("" as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                
              let dataOfNews = (result as! [String:AnyObject])
                
                self.aryNews = dataOfNews["articles"] as! [[String:AnyObject]]
                self.tableView.reloadData()
                 self.refreshControl.endRefreshing()
            }
            else {
                print(result)
            
            }
        }
        
        
        
    }

}
