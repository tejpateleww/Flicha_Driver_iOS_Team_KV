//
//  webViewVC.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 02/12/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class webViewVC: ParentViewController, UIWebViewDelegate {

    var headerName = String()
    var strURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         UtilityClass.showACProgressHUD()
//
//         strURL = "https://www.tantaxitanzania.com/web/front/privacypolicy"

        let requestURL = URL(string: strURL)!
        let request = URLRequest(url: requestURL as URL)
        webView.loadRequest(request)
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
    
    // MARK: - web view delegate method
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    // MARK: - web view delegate method
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        UtilityClass.hideACProgressHUD()
    }
    

}
