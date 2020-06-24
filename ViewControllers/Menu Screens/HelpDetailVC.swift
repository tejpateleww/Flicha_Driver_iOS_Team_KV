//
//  HelpDetailVC.swift
//  Flicha-Driver
//
//  Created by Apple on 22/05/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class HelpDetailVC: BaseViewController {
    var dict = [String: Any]()
    @IBOutlet weak var lblQuestion: UILabel! {
        didSet {
            lblQuestion.font = UIFont.regular(ofSize: 12)
        }
    }
    @IBOutlet weak var lblAnswer: UILabel! {
        didSet {
            lblAnswer.font = UIFont.regular(ofSize: 12)
        }
    }
    @IBOutlet weak var lblQuestionTitle: UILabel! {
        didSet {
            lblQuestionTitle.font = UIFont.bold(ofSize: 12)
        }
    }
    @IBOutlet weak var lblAnswerTitle: UILabel! {
        didSet {
            lblAnswerTitle.font = UIFont.bold(ofSize: 12)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarInViewController(controller: self, naviTitle: "Help".localized, leftImage: iconBack, rightImages: [], isTranslucent: false)
        self.lblQuestion.text = dict["Question"] as? String ?? ""
        self.lblAnswer.text = dict["Answer"] as? String ?? ""
        // Do any additional setup after loading the view.
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
