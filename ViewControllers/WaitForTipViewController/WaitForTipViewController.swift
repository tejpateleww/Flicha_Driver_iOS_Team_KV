//
//  WaitForTipViewController.swift
//  TEXLUXE-DRIVER
//
//  Created by Excellent WebWorld on 14/09/18.
//  Copyright © 2018 Excellent WebWorld. All rights reserved.
//

import UIKit
import SRCountdownTimer

protocol delegateWaitforTip
{
    func delegateResultTip()
    
}

class WaitForTipViewController: UIViewController,SRCountdownTimerDelegate
{
    
    @IBOutlet weak var lblWaitForTip: UILabel!
    @IBOutlet var ViewClockCountDown: SRCountdownTimer!// BRCircularProgressView!
    var delegateWaitingTimeTip : delegateWaitforTip?
    
    @IBOutlet weak var viewWhiteBG: UIView!
    
    let completeProgress: CGFloat = 30
    var progressCompleted: CGFloat = 1
    var isAccept : Bool!
    var boolTimeEnd = Bool()
    var timerOfRequest : Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boolTimeEnd = false
        isAccept = false
        
        showTimerProgressViaInstance()
        self.viewWhiteBG.layer.cornerRadius = 10
        self.viewWhiteBG.clipsToBounds = true
        
        progressCompleted = 1
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setLocalization()
//        lblWaitForTip.text = "".localized
    }
    
    func setLocalization() {
     
        self.lblWaitForTip.text = "Please wait for 30 seconds".localized
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func timerDidEnd()
//    {
//
//
//        if (boolTimeEnd)
//        {
//            self.delegateWaitingTimeTip?.delegateResultTip()
//            timerOfRequest.invalidate()
//            self.dismiss(animated: true, completion: nil)
//        }
//        else
//        {
//            self.delegateWaitingTimeTip?.delegateResultTip()
//            timerOfRequest.invalidate()
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
    func showTimerProgressViaInstance()
    {
        
        //                    self.timerView.timerFinishingText = "End"
        ViewClockCountDown.lineWidth = 4
        ViewClockCountDown.lineColor = UIColor.black
        ViewClockCountDown.trailLineColor = ThemeYellowColor
        ViewClockCountDown.labelTextColor = UIColor.black
        ViewClockCountDown.delegate = self
        ViewClockCountDown.start(beginingValue: 30, interval: 1)
        
//        ViewClockCountDown.setCircleStrokeWidth(1)
//        ViewClockCountDown.setCircleStrokeColor(ThemeClearColor, circleFillColor: UIColor.white, progressCircleStrokeColor: ThemeRedColor, progressCircleFillColor: ThemeRedColor)

        ViewClockCountDown.clipsToBounds = true


//        if timerOfRequest == nil {
//            timerOfRequest = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(showTimer), userInfo: nil, repeats: true)
//        }
        
    }
    func timerDidEnd() {
        
//        if (isAccept == false)
//        {
            if (boolTimeEnd) {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print(#function)
//                self.delegate.didRejectedRequest()
                self.dismiss(animated: true, completion: nil)
            }
//        }
    }
    
//    @objc func showTimer()
//    {
//        progressCompleted += 1
//        self.ViewClockCountDown.progress = progressCompleted / completeProgress
//
////        print("counter progress: \(self.ViewClockCountDown.progress)")
//        if progressCompleted >= 30
//        {
//            self.boolTimeEnd = true
//            self.timerDidEnd()
//            timerOfRequest.invalidate()
//            //                timer = nil
//        }
//    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
