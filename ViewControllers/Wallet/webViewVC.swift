//
//  webViewVC.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 02/12/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import WebKit

class webViewVC: ParentViewController, WKNavigationDelegate {
    
    var strURL = String()
    var WebView:WKWebView!
    var headerName = String()
    
    // MARK: - Outlets
    @IBOutlet weak var webView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UtilityClass.showACProgressHUD()
        
        
        WebView = WKWebView()
        WebView.navigationDelegate = self
        webView = WebView
        
        
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
        WebView.load(request)
        
    }
    
    
    /* Start the network activity indicator when the web view is loading */
    func webView(_ webView: WKWebView,didStartProvisionalNavigation navigation: WKNavigation){
        UtilityClass.hideACProgressHUD()
        
    }
  
    
    
}
