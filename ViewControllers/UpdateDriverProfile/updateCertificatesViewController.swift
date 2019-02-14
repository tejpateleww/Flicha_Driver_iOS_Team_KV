//
//  updateCertificatesViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 28/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class updateCertificatesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, WWCalendarTimeSelectorProtocol {

    
    let datePicker: UIDatePicker = UIDatePicker()
    
    var imagePicker = UIImagePickerController()
    var imagePicked = 0

    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        imgVehicleImage.layer.cornerRadius = imgVehicleImage.frame.width / 2
        imgVehicleImage.layer.masksToBounds = true
        
        imgVehicleImage.layer.borderWidth = 1.0
        imgVehicleImage.layer.borderColor = ThemeYellowColor.cgColor
        
        imgVehicleImage.image = UIImage.init(named: "iconCarPlaceholder")
        imgDriverLicence.image = UIImage.init(named: "iconEditProfile")
        imgCarRegistration.image = UIImage.init(named: "iconEditProfile")
        imgVehicleInsurance.image = UIImage.init(named: "iconEditProfile")
        imgAccreditationCerti.image = UIImage.init(named: "iconEditProfile")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imagePicker.delegate = self
        
        setData()
        setLocalizable()
    }
    func setLocalizable()
    {
        lblDriverLicence.text = "Driver Licence (Front only)".localized
        lblDriverLicenceExpiryDate.text = "Select driver licence expiry date".localized
        lblAccreditationCerti.text = "Revenue Licence".localized
        lblAccreditationCertiExpiryDate.text = "Select revenue licence expiry date".localized
        lblCarRegistration.text = "Vehicle Registration Document".localized
        lblCarRegistrationExpiryDate.text = "Select car registration expiry date".localized
        lblVehicleInsurance.text = "Vehicle Insurance Policy/Certificate".localized
        lblVehicleInsuranceExpiryDate.text = "Select vehicle insurance/policy expiry date".localized
        btnSave.setTitle("Save".localized, for: .normal)
    }

    @IBOutlet weak var btnSave: ThemeButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    
    @IBOutlet weak var imgVehicleImage: UIImageView!
    
    @IBOutlet weak var viewDriversLicence: UIView!
    @IBOutlet weak var viewAccreditationCertificate: UIView!
    @IBOutlet weak var viewCarRegistration: UIView!
    @IBOutlet weak var viewVehicleInsurance: UIView!
    
    @IBOutlet weak var imgDriverLicence: UIImageView!
    @IBOutlet weak var lblDriverLicence: UILabel!
    @IBOutlet weak var lblDriverLicenceExpiryDate: UILabel!
  
    @IBOutlet weak var imgAccreditationCerti: UIImageView!
    @IBOutlet weak var lblAccreditationCerti: UILabel!
    @IBOutlet weak var lblAccreditationCertiExpiryDate: UILabel!
    
    @IBOutlet weak var imgCarRegistration: UIImageView!
    @IBOutlet weak var lblCarRegistration: UILabel!
    @IBOutlet weak var lblCarRegistrationExpiryDate: UILabel!
    
    @IBOutlet weak var imgVehicleInsurance: UIImageView!
    @IBOutlet weak var lblVehicleInsurance: UILabel!
    @IBOutlet weak var lblVehicleInsuranceExpiryDate: UILabel!

    
    // MARK:- Driver Licence Expire
    
    @IBAction func btnDriverLicenceExpiryDate(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Choose Photo".localized, message: nil, preferredStyle: .alert)
        
        let Gallery = UIAlertAction(title: "Gallery", style: .default, handler: { ACTION in
            
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            
            self.imagePicked = sender.tag
            self.present(self.imagePicker, animated: true)
            
        })
        let Camera  = UIAlertAction(title: "Camera", style: .default, handler: { ACTION in
            
           DispatchQueue.main.async {
            
                self.imagePicked = sender.tag
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .camera
                self.imagePicker.cameraCaptureMode = .photo
            }
            self.present(self.imagePicker, animated: true)
            
            
        })
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        
        alert.addAction(Gallery)
        alert.addAction(Camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK:- Driver Accreditation Certificate
    
    @IBAction func btnAccreditationCerti(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Choose Photo".localized, message: nil, preferredStyle: .alert)
        
        let Gallery = UIAlertAction(title: "Gallery", style: .default, handler: { ACTION in
            
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            
            self.imagePicked = sender.tag
            self.present(self.imagePicker, animated: true)
            
        })
        let Camera  = UIAlertAction(title: "Camera", style: .default, handler: { ACTION in
            DispatchQueue.main.async {
                
                self.imagePicked = sender.tag
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .camera
                self.imagePicker.cameraCaptureMode = .photo
            }
            self.present(self.imagePicker, animated: true)
            
            
        })
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        
        alert.addAction(Gallery)
        alert.addAction(Camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK:- Driver Car Registration

    
    @IBAction func btnCarRegistration(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Choose Photo".localized ,message: nil, preferredStyle: .alert)
        
        let Gallery = UIAlertAction(title: "Gallery", style: .default, handler: { ACTION in
            
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            
            self.imagePicked = sender.tag
            self.present(self.imagePicker, animated: true)
            
        })
        let Camera  = UIAlertAction(title: "Camera", style: .default, handler: { ACTION in
            DispatchQueue.main.async {
                
                self.imagePicked = sender.tag
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .camera
                self.imagePicker.cameraCaptureMode = .photo
            }
            self.present(self.imagePicker, animated: true)
            
            
        })
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        
        alert.addAction(Gallery)
        alert.addAction(Camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func setData()
    {
        let vehicleImage = ((Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary).object(forKey: "Vehicle") as! NSDictionary).object(forKey: "VehicleImage") as! String
        
         let driverLicenceImage = (Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary).object(forKey: "DriverLicense") as! String
//
         let AccreditationCertificateImage = (Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary).object(forKey: "AccreditationCertificate") as! String
//
         let RegistrationCertificateImage = ((Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary).object(forKey: "Vehicle") as! NSDictionary).object(forKey: "RegistrationCertificate") as! String
   
        
        let strDriverLicenceExpireDate = (Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary).object(forKey: "DriverLicenseExpire") as! String
        let strAccreditationCertificateExpireDate = (Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary).object(forKey: "AccreditationCertificateExpire") as! String

          let strRegistrationCertificateExpire = ((Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary).object(forKey: "Vehicle") as! NSDictionary).object(forKey: "RegistrationCertificateExpire") as! String
        
          let strVehicleInsuranceCertificate = ((Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary).object(forKey: "Vehicle") as! NSDictionary).object(forKey: "VehicleInsuranceCertificateExpire") as! String

        
        let VehicleInsuranceCertificateImage = ((Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") as! NSDictionary).object(forKey: "Vehicle") as! NSDictionary).object(forKey: "VehicleInsuranceCertificate") as! String

        setImage(url: vehicleImage, imageView: self.imgVehicleImage)

        setImage(url: driverLicenceImage, imageView: self.imgDriverLicence)
        
        setImage(url: AccreditationCertificateImage, imageView: self.imgAccreditationCerti)

        setImage(url: RegistrationCertificateImage, imageView: self.imgCarRegistration)
        
        setImage(url: VehicleInsuranceCertificateImage, imageView: self.imgVehicleInsurance)
        
        

        lblDriverLicenceExpiryDate.text = strDriverLicenceExpireDate
        lblAccreditationCertiExpiryDate.text = strAccreditationCertificateExpireDate
//        lblCarRegistrationExpiryDate.text = strRegistrationCertificateExpire
        lblVehicleInsuranceExpiryDate.text = strVehicleInsuranceCertificate
    }
    
    func setImage(url : String, imageView : UIImageView)
    {
        imageView.sd_addActivityIndicator()
        imageView.sd_setShowActivityIndicatorView(true)
        imageView.sd_setIndicatorStyle(.gray)
        imageView.sd_setImage(with: URL(string: url)) { (image, error, cacheType, url) in
//        imageView.layer.cornerRadius = imageView.frame.size.width/2
//        imageView.layer.masksToBounds = true
            
        }
        
    }
    
    // MARK:- Driver Vehicle Insurance

    
    @IBAction func btnVehicleInsurance(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Choose Options".localized, message: nil, preferredStyle: .alert)
        
        let Gallery = UIAlertAction(title: "Gallery", style: .default, handler: { ACTION in
            
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            
            self.imagePicked = sender.tag
            self.present(self.imagePicker, animated: true)
            
        })
        let Camera  = UIAlertAction(title: "Camera", style: .default, handler: { ACTION in
            DispatchQueue.main.async {
                
                self.imagePicked = sender.tag
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .camera
                //                self.imagePicker.cameraCaptureMode = .photo
            }
            self.present(self.imagePicker, animated: true)
            
            
        })
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        
        alert.addAction(Gallery)
        alert.addAction(Camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK:- Go Back

    
    @IBAction func btnBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    var boolImgVehicle = Bool()
    
    @IBAction func btnSaveData(_ sender: Any) {
    }
    
    // MARK:- Upload Vehicle Image

    
    @IBAction func btnUploadVehicleImage(_ sender: Any) {
        
        let alert = UIAlertController(title:  "Choose Options".localized, message: nil, preferredStyle: .alert)
        
        let Gallery = UIAlertAction(title: "Gallery", style: .default, handler: { ACTION in
           
            self.boolImgVehicle = true
            
            self.PickingImageFromGallery()
        })
        let Camera  = UIAlertAction(title: "Camera", style: .default, handler: { ACTION in
            
            self.boolImgVehicle = true
            self.PickingImageFromCamera()
            
        })
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        
        alert.addAction(Gallery)
        alert.addAction(Camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    // MARK:- Pick Image

    // ------------------------------------------------------------
    
    func PickingImageFromGallery()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        
        // picker.stopVideoCapture()
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    func PickingImageFromCamera()
    {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        
        
        present(picker, animated: true, completion: nil)
    }
    
    // ------------------------------------------------------------
    // ------------------------------------------------------------
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        

        DispatchQueue.main.async {
             let pickedImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
                        if self.imagePicked == 1 {
                self.imgDriverLicence.contentMode = .scaleToFill
                self.imgDriverLicence.image = pickedImage
            } else if self.imagePicked == 2 {
                self.imgAccreditationCerti.contentMode = .scaleToFill
                self.imgAccreditationCerti.image = pickedImage
            } else if self.imagePicked == 3 {
                self.imgCarRegistration.contentMode = .scaleToFill
                self.imgCarRegistration.image = pickedImage
            } else if self.imagePicked == 4 {
                self.imgVehicleInsurance.contentMode = .scaleToFill
                self.imgVehicleInsurance.image = pickedImage
            }
        }
        dismiss(animated: true, completion: nil)

        if boolImgVehicle == true
        {
            if let pickedImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imgVehicleImage.contentMode = .scaleToFill
                imgVehicleImage.image = pickedImage
                webserviceCallToUploaDocs(imageToUpload: pickedImage, strParam: "VehicleImage", expireDate: "", expireDateKey: "")
                boolImgVehicle = false
            }
            
        }
        else
        {
//            dismiss(animated: true)
            
            let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                // Your code with delay
            
            
                let selector = WWCalendarTimeSelector.instantiate()
                
                
                // 2. You can then set delegate, and any customization options
                //        selector.delegate = self
                selector.optionTopPanelTitle = "Please add expiry date".localized
                
                // 3. Then you simply present it from your view controller when necessary!
                self.present(selector, animated: true, completion: nil)
                selector.delegate = self
                
            }
        }

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // ------------------------------------------------------------
    
    // MARK:- Calendar Delegate Methods

    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date)
    {
        let myDateFormatter: DateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy/MM/dd"
        
        let finalDate = myDateFormatter.string(from: date)
        
        // get the date string applied date format
        let mySelectedDate = String(describing: finalDate)
        
        
        if imagePicked == 1 {
            lblDriverLicenceExpiryDate.text = mySelectedDate as String
            webserviceCallToUploaDocs(imageToUpload: imgDriverLicence.image!, strParam: "DriverLicence", expireDate: mySelectedDate, expireDateKey: "DriverLicenseExpire")
            
        } else if imagePicked == 2 {
            lblAccreditationCertiExpiryDate.text = mySelectedDate as String
            webserviceCallToUploaDocs(imageToUpload: imgAccreditationCerti.image!, strParam: "AccreditationCertificate", expireDate: mySelectedDate, expireDateKey: "AccreditationCertificateExpire")

            
        } else if imagePicked == 3 {
            lblCarRegistrationExpiryDate.text = mySelectedDate as String
            webserviceCallToUploaDocs(imageToUpload: imgCarRegistration.image!, strParam: "CarRegistrationCertificate", expireDate: mySelectedDate, expireDateKey: "RegistrationCertificateExpire")

            
        } else if imagePicked == 4 {
            lblVehicleInsuranceExpiryDate.text = mySelectedDate as String
            webserviceCallToUploaDocs(imageToUpload: imgVehicleInsurance.image!, strParam: "VehicleInsuranceCertificate", expireDate: mySelectedDate, expireDateKey: "VehicleInsuranceCertificateExpire")

        }
    }
    
    
    // MARK:- Webservice Call To Update Doc
    
    func webserviceCallToUploaDocs(imageToUpload : UIImage , strParam : String, expireDate: String , expireDateKey : String)
    {
        let dictParam = NSMutableDictionary()
        dictParam.setObject(Singletons.sharedInstance.strDriverID, forKey: profileKeys.kDriverId as NSCopying)
        dictParam.setObject(expireDate, forKey: expireDateKey as NSCopying)
        
        webserviceForUpdateDocumentDetails(dictParam, image: imageToUpload, imageParamName: strParam) { (result, status) in
         
            print("The result is \(result)")
            
            
            if (status) {
                print(result)
                
                
                Singletons.sharedInstance.dictDriverProfile = NSMutableDictionary(dictionary: (result as! NSDictionary))
                Singletons.sharedInstance.isDriverLoggedIN = true
                
//                UserDefaults.standard.set(Singletons.sharedInstance.dictDriverProfile, forKey: driverProfileKeys.kKeyDriverProfile)
                Utilities.encodeDatafromDictionary(KEY: driverProfileKeys.kKeyDriverProfile, Param: Singletons.sharedInstance.dictDriverProfile)
                UserDefaults.standard.set(true, forKey: driverProfileKeys.kKeyIsDriverLoggedIN)
                
  
                let alert = UIAlertController(title: appName.kAPPName, message: "Updated successfully.".localized, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
                self.setData()
                
                //                Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile") = (result as! NSMutableDictionary)
                //
                //                UserDefaults.standard.set(Singletons.sharedInstance.dictDriverProfile.object(forKey: "profile"), forKey: driverProfileKeys.kKeyDriverProfile)
                
            } else {
                print(result)
                if let res = result as? String {
                    UtilityClass.showAlert(appName.kAPPName, message: res, vc: self)
                }
                else if let resDict = result as? NSDictionary {
                    UtilityClass.showAlert(appName.kAPPName, message: resDict.object(forKey: "message") as! String, vc: self)
                }
                else if let resAry = result as? NSArray {
                    UtilityClass.showAlert(appName.kAPPName, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: "message") as! String, vc: self)
                }
            }
            
        }
    }
    

}
