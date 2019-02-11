//
//  LegalWebView.swift
//  TanTaxi-Driver
//
//  Created by excellent Mac Mini on 30/10/18.
//  Copyright © 2018 Excellent Webworld. All rights reserved.
//

import UIKit

class LegalWebView: ParentViewController, UIWebViewDelegate  {

    
    var headerName = String()
    var strURL = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UtilityClass.showACProgressHUD()
        //
//        strURL = "https://www.tantaxitanzania.com/web/front/termsconditions"
        
        //        let requestURL = URL(string: url)
        //        let request = URLRequest(url: requestURL! as URL)
        //        webView.loadRequest(request)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if headerName != "" {
            headerView?.lblTitle.text = headerName
        }
        
        let url = strURL
        
        let requestURL = URL(string: url)
        let request = URLRequest(url: requestURL! as URL)
        webView.loadRequest(request)
        
    }
    
    // MARK: - Outlets
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func btnBack(_ sender: UIButton) {
//        self.navigationController?.popToViewController(LegalViewController, animated: true)
    }
    // MARK: - web view delegate method
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        UtilityClass.hideACProgressHUD()
    }
    
    
}
class termsConditionWebviewVc: ParentViewController, UIWebViewDelegate  {
    
    
    var headerName = String()
    var strURL = String()
    
    // MARK: - Outlets
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UtilityClass.showACProgressHUD()
        //
        strURL = "https://www.tantaxitanzania.com/web/front/termsconditions"
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
       

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if headerName != "" {
            headerView?.lblTitle.text = headerName
        }
        
        let url = strURL
        
        let requestURL = URL(string: url)
        let request = URLRequest(url: requestURL! as URL)
        webView.loadRequest(request)
        
    }
    
    
    // MARK: - web view delegate method
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        UtilityClass.hideACProgressHUD()
    }
    
    
}
