//
//  webViewForNewsViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 09/12/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class webViewForNewsViewController: ParentViewController, UIWebViewDelegate
{

    var strURL = String()
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webViewObj.delegate = self
        
        let url = strURL
        
        let requestURL = URL(string: url)
        let request = URLRequest(url: requestURL! as URL)
        webViewObj.loadRequest(request)
        UtilityClass.showACProgressHUD()
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    

    @IBOutlet weak var webViewObj: UIWebView!
    

    // MARK: - web view delegate method
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        UtilityClass.hideACProgressHUD()
    }
    
}
