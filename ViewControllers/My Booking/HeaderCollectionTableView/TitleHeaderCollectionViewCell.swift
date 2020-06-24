//
//  TabBarCollectionViewCell.swift
//  CabRideDriver
//
//  Created by EWW-iMac Old on 01/05/19.
//  Copyright © 2019 baps. All rights reserved.
//

import UIKit

class TitleHeaderCollectionViewCell: UICollectionViewCell {
    
    var headerTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    func setTitle(title: String,
                  textColor : UIColor,
                  font: UIFont){
        headerTitleLabel.text = title
        headerTitleLabel.font = font
        headerTitleLabel.textColor = textColor
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerTitleLabel)
        addVisualFormatConstraints(format: "H:|[v0]|", views: headerTitleLabel)
        addVisualFormatConstraints(format: "V:|[v0]|", views: headerTitleLabel)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
class ImagesHeaderCollectionViewCell: UICollectionViewCell {
    var selectedImage = ""
    var unselectedImage = ""
    
    var headerImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override var isSelected: Bool{
        didSet{
           // tintColor = isSelected ? themeColorYellow : .clear
            headerImageView.image = isSelected ? UIImage(named: selectedImage) : UIImage(named: unselectedImage)
        }
    }
    
    func setImage(selectedImage: String, unselectedImage : String){
       headerImageView.image = UIImage(named: unselectedImage)
        self.selectedImage = selectedImage
        self.unselectedImage = unselectedImage
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerImageView)
        backgroundColor = .clear
        addVisualFormatConstraints(format: "H:|-10-[v0]-10-|", views: headerImageView)
        addVisualFormatConstraints(format: "V:|-10-[v0]-10-|", views: headerImageView)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



//MARK:- UIView

extension UIView {
    
    //-------------------------------------
    // MARK:- Instantiate View
    //-------------------------------------
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    //-------------------------------------------
    // MARK:- identifier Variable for View, Cells
    //-------------------------------------------
    
    static var identifier: String{
        return String(describing: self)
    }
    
    //-------------------------------------
    // MARK:- Remove All Subviews
    //-------------------------------------
    
    func removeAllSubviews(){
        self.subviews.forEach({
            if(!$0.isKind(of: UIRefreshControl.self))
            {
                $0.removeFromSuperview()
            }
        })
    }
    
    func addVisualFormatConstraints(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        let constraint = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary)
        addConstraints(constraint)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func startRotating(duration: Double = 2) {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            animate.toValue = Double.pi * 2
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    func stopRotating() {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
    
    func hideShowViews(hide : Bool, views: [UIView]){
        for view in views{
            if view.isHidden != hide{
                view.isHidden = hide
            }
        }
    }
    
}
