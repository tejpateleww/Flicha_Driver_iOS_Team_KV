//
//  WalletCardsVC.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 23/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

@objc protocol AddCadsDelegate {
    
    func didAddCard(cards: NSArray)
}

class WalletCardsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, AddCadsDelegate {

    
    weak var delegateForTopUp: SelectCardDelegate!
    weak var delegateForTransferToBank: SelectBankCardDelegate!
    
    @IBOutlet weak var lblHelpDisk: UILabel!
    @IBOutlet weak var lblCards: UILabel!
    var aryData = [[String:AnyObject]]()
     var creditCardValidator: CreditCardValidator!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
   
    @IBAction func btnCall(_ sender: Any) {
        CallButtonClicked()
    }
    
    
    func CallButtonClicked()     //  Call Button
    {
        let contactNumber = WebSupport.HelplineNumber
        
        if contactNumber == "" {
            
            //            UtilityClass.showAlertWithCompletion(title: "\(appName)", message: "Contact number is not available") { (index, title) in
            //            }
            
            UtilityClass.showAlertWithCompletion(appName.kAPPName, message: "Contact number is not available", vc: self, completionHandler: {_ in
            })
        }
        else
        {
            callNumber(phoneNumber: contactNumber)
        }
    }
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func loadView() {
        super.loadView()
        
        if Singletons.sharedInstance.isCardsVCFirstTimeLoad {
//            webserviceOFGetAllCards()
            
            if Singletons.sharedInstance.CardsVCHaveAryData.count != 0 {
                aryData = Singletons.sharedInstance.CardsVCHaveAryData
            }
            else {
                
                webserviceOFGetAllCards()
                
                
                
            }
        }
        else {
            if Singletons.sharedInstance.CardsVCHaveAryData.count != 0 {
                aryData = Singletons.sharedInstance.CardsVCHaveAryData
            }
            else {
                let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletAddCardsViewController") as! WalletAddCardsViewController
                next.delegateAddCard = self
                self.navigationController?.pushViewController(next, animated: true)
            }
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
//         creditCardValidator = CreditCardValidator()
        self.tableView.addSubview(self.refreshControl)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func setImageColorOfImage(name: String) -> UIImage {
        
        var imageView = UIImageView()
        
        let img = UIImage(named: name)
        imageView.image = img?.maskWithColor(color: UIColor.white)
        
        
        return imageView.image!
    }
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddCards: UIButton!
    
    //-------------------------------------------------------------
    // MARK: - TableView Methods
    //-------------------------------------------------------------
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return aryData.count + 1//2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if section == 0 {
//            return aryData.count
//        }
//        else {
            return 1
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletCardsTableViewCell") as! WalletCardsTableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "AddCard") as! WalletCardsTableViewCell
        
        cell.selectionStyle = .none
        cell2.selectionStyle = .none
        
        if indexPath.section == 0
        {
             return cell2
        }
        else
        {
            
//            let dictData = aryData[indexPath.row] as [String:AnyObject]
//
////            cell.lblCardType.text = "Credit Card"
//
//            cell.viewCards.layer.cornerRadius = 10
//            cell.viewCards.layer.masksToBounds = true
//            let number = dictData["CardNum"] as! String
//             cell.imgCardIcon.image = detectCardNumberType(number: number)
            
//            let type = dictData["Type"] as! String
            
           
            
//            if (indexPath.row % 2) == 0
//            {
//                cell.viewCards.backgroundColor = UIColor.orange
////                cell.lblBankName.text = dictData["Alias"] as? String
//                cell.lblCardNumber.text = dictData["CardNum2"] as? String
////                cell.imgCardIcon.image = UIImage(named: "MasterCard")
//            }
//            else {
//                cell.viewCards.backgroundColor = UIColor.init(red: 0, green: 145/255, blue: 147/255, alpha: 1.0)
////                cell.lblBankName.text = dictData["Alias"] as? String
//                cell.lblCardNumber.text = dictData["CardNum2"] as? String
////                cell.imgCardIcon.image = UIImage(named: "Visa")
//            }
            
//            cell.viewCards.layoutIfNeeded()
//            cell.viewCards.dropShadowToCardView(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 5, scale: true)
//            cell.viewCards.layer.cornerRadius = 5
//            cell.viewCards.layer.masksToBounds = true
//
//            cell.lblMonth.text = dictData["Expiry"] as? String
////            cell.lblYear.text = dictData["Expiry"]?.components(separatedBy: "/").last
//            let type = dictData["Type"] as! String
//
//            var colorTop:UIColor = UIColor()
//            var colorMiddle:UIColor = UIColor()
//
//            if type == "visa" {
//                colorTop = UIColor(red: 253.0/255.0, green: 149.0/255.0, blue:47.0/255.0, alpha: 1.0)
//                colorMiddle =  UIColor(red: 251.0/255.0, green: 63.0/255.0, blue: 135.0/255.0, alpha: 1.0)
//            } else if type == "mastercard" {
//                colorTop = UIColor(red: 76.0/255.0, green: 210.0/255.0, blue:252.0/255.0, alpha: 1.0)
//                colorMiddle =  UIColor(red: 46.0/255.0, green: 167.0/255.0, blue: 252.0/255.0, alpha: 1.0)
//            } else if type == "discover" {
//                colorTop = UIColor(red: 199.0/255.0, green: 40.0/255.0, blue:135.0/255.0, alpha: 1.0)
//                colorMiddle =  UIColor(red: 237.0/255.0, green: 59.0/255.0, blue: 76.0/255.0, alpha: 1.0)
//            }
//            cell.imgCard.setGradientLayer(LeftColor: colorTop.cgColor, RightColor: colorMiddle.cgColor, BoundFrame: self.view.bounds)
//
//
            
            
         /*
          //   visa , mastercard , amex , diners , discover , jcb , other
             
            if (indexPath.row % 2) == 0 {
                cell.viewCards.backgroundColor = UIColor.orange
                cell.lblCardNumber.text = "**** **** **** 1081"
                cell.imgCardIcon.image = UIImage(named: "MasterCard")
            }
            else {
                cell.viewCards.backgroundColor = UIColor.init(red: 0, green: 145/255, blue: 147/255, alpha: 1.0)
                cell.lblCardNumber.text = "**** **** **** 9964"
                cell.imgCardIcon.image = UIImage(named: "Visa")
                
            }
          */
            
            /// Palak====
            
            
            let dictData = aryData[indexPath.section - 1] as [String:AnyObject]
            let expiryDate = (dictData["Expiry"] as! String).split(separator: "/")
            let month = expiryDate.first
            let year = expiryDate.last
            cell.lblMonth.text = "\(String(describing: month!)) / \(String(describing: year!))"
            
            cell.viewCards.layoutIfNeeded()
            cell.viewCards.dropShadowToCardView(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 5, scale: true)
            cell.viewCards.layer.cornerRadius = 5
            cell.viewCards.layer.masksToBounds = true
            
            let type = dictData["Type"] as! String
            
            cell.imgCardIcon.image = UIImage(named: setCreditCardImage(str: type))
            cell.lblCardNumber.text = dictData["CardNum2"] as? String
            
            var colorTop:UIColor = UIColor()
            var colorMiddle:UIColor = UIColor()
            
            if type == "visa" {
                colorTop = UIColor.init(hex: "ff954f")//UIColor(red: 253.0/255.0, green: 149.0/255.0, blue:47.0/255.0, alpha: 1.0)
                colorMiddle =  UIColor.init(hex: "fe3a86")//UIColor(red: 251.0/255.0, green: 63.0/255.0, blue: 135.0/255.0, alpha: 1.0)
            } else if type == "mastercard" {
                colorTop = UIColor.init(hex: "43d2fe")//UIColor(red: 76.0/255.0, green: 210.0/255.0, blue:252.0/255.0, alpha: 1.0)
                colorMiddle =  UIColor.init(hex: "22a5ff")//UIColor(red: 46.0/255.0, green: 167.0/255.0, blue: 252.0/255.0, alpha: 1.0)
            } else if type == "discover" {
                colorTop = UIColor.init(hex: "ca2188")//UIColor(red: 199.0/255.0, green: 40.0/255.0, blue:135.0/255.0, alpha: 1.0)
                colorMiddle =  UIColor.init(hex: "f13848")//UIColor(red: 237.0/255.0, green: 59.0/255.0, blue: 76.0/255.0, alpha: 1.0)
            }
            else{
                colorTop = UIColor.init(hex: "ff954f")//UIColor(red: 253.0/255.0, green: 149.0/255.0, blue:47.0/255.0, alpha: 1.0)
                colorMiddle =  UIColor.init(hex: "fe3a86")//UIColor(red: 251.0/255.0, green: 63.0/255.0, blue: 135.0/255.0, alpha: 1.0)
            }
            cell.imgCard.setGradientLayer(LeftColor: colorTop.cgColor, RightColor: colorMiddle.cgColor, BoundFrame: self.view.bounds)
            return cell
        }
//        else
//        {
//            cell2.imgArrow.image = UIImage.init(named: "iconArrowGrey")?.withRenderingMode(.alwaysTemplate)
//            cell2.imgArrow.tintColor = UIColor.white
//
//            return cell2
//        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 0 {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletAddCardsViewController") as! WalletAddCardsViewController
            next.delegateAddCard = self
            self.navigationController?.pushViewController(next, animated: true)
//            let selectedData = aryData[indexPath.row] as [String:AnyObject]
//
//            print("selectedData : \(selectedData)")
//
//            if Singletons.sharedInstance.isFromTopUP {
//                delegateForTopUp.didSelectCard(dictData: selectedData)
//                Singletons.sharedInstance.isFromTopUP = false
//                self.navigationController?.popViewController(animated: true)
//            }
//            else if Singletons.sharedInstance.isFromTransferToBank {
//                delegateForTransferToBank.didSelectBankCard(dictData: selectedData)
//                Singletons.sharedInstance.isFromTransferToBank = false
//                self.navigationController?.popViewController(animated: true)
//            }
            
        }
        else if indexPath.section == 1 {
            
//            let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletAddCardsViewController") as! WalletAddCardsViewController
//            next.delegateAddCard = self
//            self.navigationController?.pushViewController(next, animated: true)
            
            let selectedData = aryData[indexPath.section - 1] as [String:AnyObject]
            
            print("selectedData : \(selectedData)")
            
            if Singletons.sharedInstance.isFromTopUP {
                delegateForTopUp.didSelectCard(dictData: selectedData)
                Singletons.sharedInstance.isFromTopUP = false
                self.navigationController?.popViewController(animated: true)
            }
            else if Singletons.sharedInstance.isFromTransferToBank {
                delegateForTransferToBank.didSelectBankCard(dictData: selectedData)
                Singletons.sharedInstance.isFromTransferToBank = false
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if indexPath.section == 0 {
            return 50
        }
        else {
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let selectedData = aryData[indexPath.row] as [String:AnyObject]
        
        if editingStyle == .delete {
            
            let selectedID = selectedData["Id"] as? String
            webserviceForRemoveCard(cardId : selectedID!)
//            tableView.beginUpdates()
//            aryData.remove(at: indexPath.row)
//            webserviceForRemoveCard(cardId : selectedID!)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.endUpdates()
        }
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func btnBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }

    @IBAction func btnAddCards(_ sender: UIButton) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletAddCardsViewController") as! WalletAddCardsViewController
        
        next.delegateAddCard = self
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        webserviceOFGetAllCards()
        
        tableView.reloadData()
    }
    
    func setCreditCardImage(str: String) -> String
    {
        
        //   visa , mastercard , amex , diners , discover , jcb , other
        
        var strType = String()
        
        if str == "visa" {
            strType = "visa"
        }
        else if str == "mastercard" {
            strType = "mastercard"
        }
        else if str == "amex" {
            strType = "Amex"
        }
        else if str == "diners" {
            strType = "Diners Club"
        }
        else if str == "discover" {
            strType = "discover"
        }
        else if str == "jcb" {
            strType = "JCB"
        }
        else {
            strType = "iconDummyCard"
        }
        
        return strType
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Add Cads Delegate Methods
    //-------------------------------------------------------------
    
    func didAddCard(cards: NSArray) {
        
        aryData = cards as! [[String:AnyObject]]
        
        tableView.reloadData()
    }
    func giveGradientColor() {
        
        let colorTop =  UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        let colorMiddle =  UIColor(red: 36/255, green: 24/255, blue: 3/255, alpha: 0.5).cgColor
        let colorBottom = UIColor(red: 64/255, green: 43/255, blue: 6/255, alpha: 0.8).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorMiddle, colorBottom]
        gradientLayer.locations = [ 0.0, 0.5, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    //-------------------------------------------------------------
    // MARK: - Webservice Methods For All Cards
    //-------------------------------------------------------------
    
    func webserviceOFGetAllCards() {
        
        webserviceForCardListingInWallet(Singletons.sharedInstance.strDriverID as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                
                self.aryData = (result as! NSDictionary).object(forKey: "cards") as! [[String:AnyObject]]
                
                Singletons.sharedInstance.CardsVCHaveAryData = self.aryData
                
                Singletons.sharedInstance.isCardsVCFirstTimeLoad = false
                
                self.tableView.reloadData()
                
                if Singletons.sharedInstance.CardsVCHaveAryData.count == 0 {
                    let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletAddCardsViewController") as! WalletAddCardsViewController
                    next.delegateAddCard = self
                    self.navigationController?.pushViewController(next, animated: true)
                }
                
                self.refreshControl.endRefreshing()
            }
            else {
                
                print(result)
                if let res = result as? String {
                    UtilityClass.showAlert("App Name".localized, message: res, vc: self)
                }
                else if let resDict = result as? NSDictionary {
                    UtilityClass.showAlert("App Name".localized, message: resDict.object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }
                else if let resAry = result as? NSArray {
                    UtilityClass.showAlert("App Name".localized, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }
            }
        }
    }
    
    //-------------------------------------------------------------
    // MARK: - Webservice Methods Remove Cards
    //-------------------------------------------------------------
    
    
    
    func webserviceForRemoveCard(cardId : String) {
      
        
        var params = String()
        params = "\(Singletons.sharedInstance.strDriverID)/\(cardId)"

        webserviceForRemoveCardFromWallet(params as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                
                self.aryData = (result as! NSDictionary).object(forKey: "cards") as! [[String:AnyObject]]
                
                Singletons.sharedInstance.CardsVCHaveAryData = self.aryData
                
                Singletons.sharedInstance.isCardsVCFirstTimeLoad = false
                
                self.tableView.reloadData()
                
                UtilityClass.showAlert(appName.kAPPName, message: (result as! NSDictionary).object(forKey: "message") as! String, vc: self)
            }
            else {
                print(result)
                
                if let res = result as? String {
                    UtilityClass.showAlert("App Name".localized, message: res, vc: self)
                }
                else if let resDict = result as? NSDictionary {
                    UtilityClass.showAlert("App Name".localized, message: resDict.object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }
                else if let resAry = result as? NSArray {
                    UtilityClass.showAlert("App Name".localized, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }
            }
        }
    }
}
extension UIView {

    func dropShadowToCardView(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}
