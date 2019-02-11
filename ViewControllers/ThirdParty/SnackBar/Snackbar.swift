//
//  Snackbar.swift
//  snackbar
//
//  Created by Нейкович Сергей on 30.11.16.
//  Copyright © 2016 CubInCup. All rights reserved.
//

import UIKit

enum SBAnimationLength {
    case shot
    case long
}

class Snackbar: NSObject {
    
    // settings snackbar
    var snackbarHeight: CGFloat     = 50
    var backgroundColor: UIColor    = .black
    var textColor: UIColor          = ThemeYellowColor //UIColor(red: 204/255, green: 3/255, blue: 0/255, alpha: 1.0)
    var buttonColor:UIColor         = ThemeYellowColor //UIColor(red: 204/255, green: 3/255, blue: 0/255, alpha: 1.0)
    var buttonColorPressed:UIColor  = .gray
    var sbLenght: SBAnimationLength = .shot
    
    //private variables
    private let window = UIApplication.shared.keyWindow!
    private let snackbarView = UIView(frame: .zero)
    
    private let txt: UILabel = UILabel()
    private let btn: UIButton = UIButton()
    
    private var action: (() -> Void)? = nil
    
    
    override init(){
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(rotate), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    /// Show simple text notification
    open func createWithText(_ text: String) {
        
        setupSnackbarView()
        
        txt.text = text
        txt.textColor = textColor
        txt.frame = CGRect(x: window.frame.width * 5/100, y: 0, width: window.frame.width * 95/100, height: snackbarHeight)
        snackbarView.addSubview(txt)
        
        show()
    }
    
    
    /// Show snackbar with text and button
    open func createWithAction( text: String, actionTitle: String, action: @escaping () -> Void){
        self.action = action
        
        setupSnackbarView()
        
        txt.text = text
        txt.textColor = textColor
        txt.frame = CGRect(x: window.frame.width * 5/100, y: 0, width: window.frame.width * 75/100, height: snackbarHeight)
        snackbarView.addSubview(txt)
        
        btn.setTitleColor(buttonColor,  for: .normal)
        btn.setTitleColor(.gray, for: .highlighted)
        btn.setTitle(actionTitle, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(actionButtonPress), for: .touchUpInside)
        btn.frame = CGRect(x: window.frame.width * 73/100, y: 0, width: window.frame.width * 25/100, height: snackbarHeight)
        snackbarView.addSubview(btn)
        
        show()
    }
    
    
    
    open func show(){
        switch sbLenght {
        case .shot:
            animateBar(2)
            
        case .long:
            animateBar(3)
            
        }
    }
    
    
    private func setupSnackbarView(){
        window.addSubview(snackbarView)
        
        snackbarView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: snackbarHeight)
        snackbarView.backgroundColor = self.backgroundColor
    }
    
    
    
    fileprivate func animateBar(_ timerLength: Float){
        
        UIView.animate(withDuration: 0.4, animations: {
            self.snackbarView.frame = CGRect(x: 0, y: self.window.frame.height - self.snackbarHeight, width: self.window.frame.width, height: self.snackbarHeight)
            
            Timer.scheduledTimer(timeInterval: TimeInterval(timerLength), target: self, selector: #selector(self.hide), userInfo: nil, repeats: false)
        })
    }
    
    
    // MARK: Selectors
    
    @objc private func actionButtonPress(){
        action!()
        hide()
    }
    
    @objc private func hide(){
        UIView.animate(withDuration: 0.4, animations: {
            self.snackbarView.frame = CGRect(x: 0, y: self.window.frame.height, width: self.window.frame.width, height: self.snackbarHeight)
         })
    }
    
    @objc private func rotate(){
        self.snackbarView.frame = CGRect(x: 0, y: self.window.frame.height - self.snackbarHeight, width: self.window.frame.width, height: self.snackbarHeight)
        btn.frame = CGRect(x: window.frame.width * 73/100, y: 0, width: window.frame.width * 25/100, height: snackbarHeight)
    }
    
}


