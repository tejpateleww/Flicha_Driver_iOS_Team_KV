//
//  Utilities.swift
//  SwiftFirstDemoLoginSignUp
//
//  Created by Elite on 23/06/17.
//  Copyright © 2017 Palak. All rights reserved.
//

import UIKit
import BFKit
import QuartzCore

class Utilities: NSObject
{
    class func isInternetConnectionAvailable() -> Bool
    {
        let networkReachability = Reachability.forInternetConnection()
        let networkStatus : NetworkStatus = (networkReachability?.currentReachabilityStatus())!
        
        if networkStatus != .NotReachable
        {
            return true
        }
        else
        {
            return false
        }
    }
    class func showActivityIndicator()
    {
        SVProgressHUD.show()
    }
    class func hideActivityIndicator()
    {
        SVProgressHUD.dismiss()
    }
    
    class func showAlertWithCompletion(_ title: String, message: String, vc: UIViewController,completionHandler: @escaping CompletionHandler) -> Void
    {
        //        title = "TickToc"
        let alert = UIAlertController(title: appName.kAPPName,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        //vc will be the view controller on which you will present your alert as you cannot use self because this method is static.
        vc.present(alert, animated: true, completion: nil)
        
    }
    class func checkEmptyString(str: String?) -> String
    {
        var newString : String?
        newString = (str)
        
        if (newString as? NSNull) == NSNull()
        {
            return ""
        }
        if (newString == "(null)")
        {
            return ""
        }
        if (newString == "<null>")
        {
            return ""
        }
        if newString == nil
        {
            return ""
        }
        else if (newString?.count ?? 0) == 0 {
            return ""
        }
        else
        {
            newString = newString?.trimmingCharacters(in: .whitespacesAndNewlines)
            if ((str)!.count ?? 0) == 0 {
                return ""
                
            }
        }
        if ((str)! == "<null>")
        {
            return ""
        }
        return newString!
    }
    
    class func isEmpty(str: String?) -> Bool
    {
        var newString : String?
        newString = (str)
        
        if (newString as? NSNull) == NSNull()
        {
            return true
        }
        if (newString == "(null)")
        {
            return true
        }
        if (newString == "<null>")
        {
            return true
        }
        if (newString == "null")
        {
            return true
        }
        if newString == nil
        {
            return true
        }
        else if (newString?.count ?? 0) == 0 {
            return true
        }
        else
        {
            newString = newString?.trimmingCharacters(in: .whitespacesAndNewlines)
            if ((str)!.count ?? 0) == 0 {
                return true
                
            }
        }
        if ((str)! == "<null>")
        {
            return true
        }
        return false
    }
    class func isEmail(testStr:String) -> Bool
    {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func SetLeftSIDEImage(TextField: UITextField, ImageName: String)
    {
        
        let leftImageView = UIImageView()
        leftImageView.contentMode = .scaleAspectFit
        
        let leftView = UIView()
        
        leftView.frame = CGRect(x: 10, y: 0, width: 30, height: 20)
        leftImageView.frame = CGRect(x: 13, y: 3, width: 15, height: 20)
        TextField.leftViewMode = .always
        TextField.leftView = leftView
        leftView.backgroundColor = UIColor.gray
        let image = UIImage(named: ImageName)?.withRenderingMode(.alwaysTemplate)
        leftImageView.image = image
        leftImageView.tintColor = UIColor.white
        leftImageView.tintColorDidChange()
        
        leftView.addSubview(leftImageView)
    }


    
    
    class func setStatusBarColor(color: UIColor)
    {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = UIColor.clear
    }
  
    
   
    func hexStringToUIColor (hex:String) -> UIColor
    {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func isEmail(testStr:String) -> Bool
    {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func setLeftPaddingInTextfield(textfield:UITextField , padding:(CGFloat))
    {
        let view:UIView = UIView (frame: CGRect (x: 0, y: 0, width: padding, height: textfield.frame.size.height) )
        textfield.leftView = view
        textfield.leftViewMode = UITextField.ViewMode.always
    }
    
    class func setRightPaddingInTextfield(textfield:UITextField, padding:(CGFloat))
    {
        
        let view:UIView = UIView (frame: CGRect (x: 0, y: 0, width: padding, height: textfield.frame.size.height) )
        textfield.rightView = view
        textfield.rightViewMode = UITextField.ViewMode.always
    }
    class func setCornerRadiusTextField(textField : UITextField)
    {
        textField.layer.cornerRadius = textField.frame.size.height / 2
        textField.clipsToBounds = true
    }
    
    class func setCornerRadiusButton(button : UIButton , borderColor : UIColor , bgColor : UIColor, textColor : UIColor)
    {
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.backgroundColor = bgColor
        button.setTitleColor(textColor, for: .normal)
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = 1.0
    }
    
    class func showToastMSG(MSG: String)
    {
        CSToastManager.setQueueEnabled(false)
        Appdelegate.window?.makeToast(MSG)
    }
    
    
    func sizeForText(text : String , font : UIFont, width : CGFloat) -> CGSize
    {
        let constraint : CGSize = CGSize.init(width: width, height: 20000.0)
        var size  = CGSize()
        let boundingBox : CGSize = text.boundingRect(with: constraint,
                                                options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                attributes: [NSAttributedString.Key.font: font],
                                                context: nil).size
        size = CGSize.init(width: ceil(boundingBox.width), height: ceil(boundingBox.height))
        return size
        
    }
    func getAspectSizeOfImage(imageSize : CGSize , widthTofit: CGFloat) -> CGSize
    {
        var imageWidth : CGFloat = imageSize.width
        var imageHeight : CGFloat = imageSize.height
         var imgRatio : CGFloat = imageWidth/imageHeight
        
        
         let width_1 : CGFloat = widthTofit
         let height_1 : CGFloat = CGFloat(MAXFLOAT)
        let maxRatio
            : CGFloat = width_1/height_1;
        
        if(imgRatio != maxRatio)
        {
            if(imgRatio < maxRatio)
            {
                imgRatio = height_1 / imageHeight;
                imageWidth = imgRatio * imageWidth;
                imageHeight = height_1;
            }
            else
            {
                imgRatio = width_1 / imageWidth;
                imageHeight = imgRatio * imageHeight;
                imageWidth = width_1;
            }
        }
        return CGSize.init(width: imageWidth, height: imageHeight)
    }
    func formatStringForDBUse(strValue : String) -> String
    {
        let strFinalString : String = strValue .replacingOccurrences(of: "'", with: "''")
        
        return strFinalString;
    }
    
    func imageWithImage(image : UIImage  ,newSize :CGSize  ) -> UIImage
    {
        UIGraphicsBeginImageContext( newSize );
        image .draw(in: CGRect (x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    func setFraction(StrAmount : String) -> String
    {
        let inputNumber : NSNumber = NSNumber.init(value: Double(StrAmount)!)
        let formatterInput : NumberFormatter = NumberFormatter.init()
        formatterInput.numberStyle = NumberFormatter.Style.decimal
        formatterInput.maximumFractionDigits = 2
        var formattedInputString : String = formatterInput .string(from: inputNumber)!
        formattedInputString = formattedInputString .replacingOccurrences(of: ",", with: "")
        
        if formattedInputString == "0"
        {
            formattedInputString = "0.0"
        }
        else
        {
            formattedInputString = formattedInputString .appending(".0")
        }
        return formattedInputString
    }

//     func showActivitiyIndicator()
//    {
//        SVProgressHUD .show()
//    }
//    func hideActivitiyIndicator()
//    {
//        SVProgressHUD.dismiss()
//    }
    class func removeUserDefaultsValue()
    {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            if (key != "Token")
            {
                UserDefaults.standard.removeObject(forKey: key.description)
            }
        }
    }
    class func showAlert(_ title: String, message: String, vc: UIViewController) -> Void
    {
        let alert = UIAlertController(title: appName.kAPPName,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        if(vc.presentedViewController != nil)
        {
            vc.dismiss(animated: true, completion: nil)
        }
        //vc will be the view controller on which you will present your alert as you cannot use self because this method is static.
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func showAlertAnother(_ title: String, message: String, vc: UIViewController) -> Void
    {
        let alert = UIAlertController(title: appName.kAPPName,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        if(vc.presentedViewController != nil)
        {
            vc.dismiss(animated: true, completion: {
                vc.present(alert, animated: true, completion: nil)
                
            })
        }
        //vc will be the view controller on which you will present your alert as you cannot use self because this method is static.
    }
    class func encodeDatafromDictionary(KEY:String , Param:Any) -> Void
    {
//        let encodedData = NSKeyedArchiver.archivedData(withRootObject: Param)
//        UserDefaults.standard.set(encodedData, forKey: KEY)
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: Param)
        let dataExample: Data = NSKeyedArchiver.archivedData(withRootObject: Param)

        UserDefaults.standard.set(encodedData, forKey: KEY)

        
//        UserDefaults.standard.synchronize()
    }
    class func decodeDictionaryfromData(KEY:String) -> NSMutableDictionary
    {
//        let dataExample : Data  = UserDefaults.standard.object(forKey: KEY) as! Data
//        let dictionary: Dictionary? = NSKeyedUnarchiver.unarchiveObject(with: dataExample) as! [String : Any]

//        let decoded  = UserDefaults.standard.object(forKey: KEY) //as! Data
//        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data) as! NSDictionary
//        return decodedTeams
        
//        if let data = UserDefaults.standard.data(forKey: KEY),
//            let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSMutableDictionary
////        {
//////            myPeopleList.forEach({print( $0.name, $0.age)})  // Joe 10
////        }
//        else {
//            print("There is an issue")
//        }
        var myDictData = NSMutableDictionary()
        
        if let data = UserDefaults.standard.data(forKey: KEY)
        {
            let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSMutableDictionary
            myDictData = myPeopleList!
        }
        else{
            print("There is an issue")
        }
        return myDictData
    }
    
    class func setNavigationBarInViewController (controller : UIViewController,naviColor : UIColor, naviTitle : String, leftImage : String , rightImage : String)
    {
        UIApplication.shared.statusBarStyle = .lightContent
        controller.navigationController?.isNavigationBarHidden = false
        controller.navigationController?.navigationBar.isOpaque = false;
        controller.navigationController?.navigationBar.isTranslucent = false
        
        controller.navigationController?.navigationBar.barTintColor = naviColor;
        controller.navigationController?.navigationBar.tintColor = UIColor.white;
        
        controller.navigationItem.title = naviTitle
        
        controller.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationController?.navigationBar.shadowImage = UIImage()
        
        let btnLeft = UIButton.init()
        btnLeft.setImage(UIImage.init(named: leftImage), for: .normal)
        btnLeft.layer .setValue(controller, forKey: "controller")
        
        if leftImage == kMenuIcon
        {
            btnLeft.addTarget(self, action: #selector(OpenMenuViewController(_:)), for: .touchUpInside)
        }
        else
        {
            btnLeft.addTarget(self, action: #selector(poptoViewController(_:)), for: .touchUpInside)
        }
        
        let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: btnLeft)
        btnLeftBar.style = .plain
        controller.navigationItem.leftBarButtonItem = btnLeftBar
        
        
    }
    
    
    @objc class func poptoViewController (_ sender: UIButton?)
    {
        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
        controller?.navigationController?.popViewController(animated: true)
    }
    @objc class func OpenMenuViewController (_ sender: UIButton?)
    {
        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
        
//        controller?.sideMenuViewController?._presentLeftMenuViewController()
    }
    class func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        //        2018-08-01 17:34:32
        if let date = inputFormatter.date(from: dateString)
        {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            let str = outputFormatter.string(from: date)
            return str
        }
        
        return nil
    }
    
    class  func ConvertSecondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    class func presentPopupOverScreen(_ alertController : UIViewController)
    {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    class func findtopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            
            return findtopViewController(controller: navigationController.visibleViewController)
            
        }
        
        if let tabController = controller as? UITabBarController {
            
            if let selected = tabController.selectedViewController {
                
                return findtopViewController(controller: selected)
                
            }
            
        }
        
        if let presented = controller?.presentedViewController {
            
            return findtopViewController(controller: presented)
            
        }
        
        return controller
        
    }
  
}
