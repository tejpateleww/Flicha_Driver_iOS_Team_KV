//
//  PesapalWebViewViewController.swift
//  TanTaxi-Driver
//
//  Created by Apple on 10/04/19.
//  Copyright © 2019 Excellent Webworld. All rights reserved.
//

import UIKit
import WebKit

protocol delegatePesapalWebView {
    
    func didOrderPesapalStatus(status: Bool)
//    @objc optional func didOrderFailed()
}

class PesapalWebViewViewController: UIViewController {
    

    // ----------------------------------------------------
    // MARK: - Outlets
    // ----------------------------------------------------
    @IBOutlet weak var viewForWebView: UIView!
    
    // ----------------------------------------------------
    // MARK: - Globle Declaration Methods
    // ----------------------------------------------------
    var webView: WKWebView!
    var strUrl = String()
    var delegate: delegatePesapalWebView?
    
    let progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .default)
        view.progressTintColor = ThemeYellowColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    deinit {
        webView?.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    // ----------------------------------------------------
    // MARK: - Base Methods
    // ----------------------------------------------------
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.backgroundColor = UIColor.blue
        self.view = webView!
        self.viewForWebView = webView!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
        self.viewForWebView = webView!
        
        let url = URL(string: strUrl)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        setProgressView()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float((webView?.estimatedProgress)!)
        }
    }
    
    // ----------------------------------------------------
    // MARK: - Custom Methods
    // ----------------------------------------------------
    func setProgressView() {
        [progressView].forEach { self.view.addSubview($0) }
        progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        if #available(iOS 11.0, *) {
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        progressView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func showProgressView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 1
        }, completion: nil)
    }
    
    func hideProgressView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 0
        }, completion: nil)
    }
}

extension PesapalWebViewViewController: WKUIDelegate, WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UtilityClass.showHUD()
        
       self.showProgressView()
        print("didStartProvisionalNavigation: \(String(describing: webView.url?.absoluteString))")
        if (webView.url?.absoluteString == "https://www.tantaxitanzania.com/pesapal/add_money_success") {
           
            let alert = UIAlertController(title: appName.kAPPName.localize(), message: "Payment Success", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                self.dismiss(animated: true) {
        //                self.delegate?.PayPalPaymentSuccess(paymentID: "\(self.paymentid)")
                    self.delegate?.didOrderPesapalStatus(status: true)
                }
            }
            alert.addAction(ok)
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindow.Level.alert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
        else if webView.url?.absoluteString == "https://www.tantaxitanzania.com/pesapal/add_money_failed" {
            
            let alert = UIAlertController(title: appName.kAPPName.localize(), message: "Payment failed", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                self.delegate?.didOrderPesapalStatus(status: false)
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindow.Level.alert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        UtilityClass.hideHUD()
        self.hideProgressView()
        print("didFailProvisionalNavigation: \(String(describing: webView.url?.absoluteString))")
        
        //        self.dismissPayPalWebViewController()
        
        //        let next = self.storyboard?.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        //        next.delegateOfAlertView = self
        //        next.btnCancelisHidden = true
        //        next.strMessage = error.localizedDescription
        //        self.present(next, animated: true, completion: nil)
        
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        UtilityClass.hideHUD()
        self.hideProgressView()
        print("didFinish: \(String(describing: webView.url?.absoluteString))")
        
        if (webView.url?.absoluteString == "https://www.tantaxitanzania.com/pesapal/add_money_success") {
            
            let alert = UIAlertController(title: appName.kAPPName.localize(), message: "Payment Success", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                self.dismiss(animated: true) {
                    //                self.delegate?.PayPalPaymentSuccess(paymentID: "\(self.paymentid)")
                    self.delegate?.didOrderPesapalStatus(status: true)
                }
            }
            alert.addAction(ok)
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindow.Level.alert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
        if webView.url?.absoluteString == "https://www.tantaxitanzania.com/pesapal/add_money_failed" {
           
            let alert = UIAlertController(title: appName.kAPPName.localize(), message: "Payment failed", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                self.delegate?.didOrderPesapalStatus(status: false)
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindow.Level.alert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UtilityClass.hideHUD()
        self.hideProgressView()
        print("didFail: \(String(describing: webView.url?.absoluteString))")
    }
   
}
