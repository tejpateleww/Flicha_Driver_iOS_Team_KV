//
//  TickPayRegistrationViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 20/12/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class TickPayRegistrationViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var txtExpireDate: UITextField!
    @IBOutlet var txtCompanyName: UITextField!
    @IBOutlet var txtAbn: UITextField!
    @IBOutlet var txtCardNumber: UITextField!
    @IBOutlet var txtCVV: UITextField!
    @IBOutlet var txtAlias: UITextField!
    @IBOutlet var btnImgCamera: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- IBActions
    
    @IBAction func btnSignUP(_ sender: UIButton) {
        if(validations())
        {
            
        }
    }
    
    @IBAction func btnScanCard(_ sender: UIButton) {
    }
    
    @IBAction func btnUploadDrivingLicence(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose photo".localized, message: nil, preferredStyle: .alert)
        
        let Gallery = UIAlertAction(title: "Select photo from gallery".localized, style: .default, handler: { ACTION in
            self.PickingImageFromGallery()
        })
        let Camera  = UIAlertAction(title: "Select photo from camera".localized, style: .default, handler: { ACTION in
            self.PickingImageFromCamera()
        })
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        
        alert.addAction(Gallery)
        alert.addAction(Camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func validations() -> Bool {
        
        if(txtCompanyName.text?.count == 0)
        {
            UtilityClass.showAlert("App Name".localized, message: "Please insert Company Name", vc: self)
            return false
        }
        else if(txtAbn.text?.count == 0)
        {
            UtilityClass.showAlert("App Name".localized, message: "Please insert Company Name", vc: self)
            return false
        }
        
        
        
        return true
    }
    
    
    //MARK:- Image picker Delegate
    
    
    func PickingImageFromGallery()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        
        // picker.stopVideoCapture()
        picker.mediaTypes = [kUTTypeImage as String]
//            UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
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
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            self.btnImgCamera.setImage(pickedImage, for: .normal)
            self.btnImgCamera.imageView?.contentMode = .scaleAspectFit
//            imgVehicle.contentMode = .scaleToFill
//            imgVehicle.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
