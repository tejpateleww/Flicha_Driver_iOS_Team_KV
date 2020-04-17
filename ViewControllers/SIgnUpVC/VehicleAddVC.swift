//
//  VehicleAddVC.swift
//  Flicha-Driver
//
//  Created by EWW073 on 15/04/20.
//  Copyright © 2020 Excellent Webworld. All rights reserved.
//

import UIKit

class VehicleAddVC: UIViewController {

    // ----------------------------------------------------
    // MARK: - --------- Outlets ---------
    // ----------------------------------------------------
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // ----------------------------------------------------
    // MARK: - --------- Global Variables ---------
    // ----------------------------------------------------
    
    
    
    // ----------------------------------------------------
    // MARK: - --------- Lifecycle Methods ---------
    // ----------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // ----------------------------------------------------
    // MARK: - --------- IBAction Methods ---------
    // ----------------------------------------------------
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// ----------------------------------------------------
//MARK:- --------- CollectionView Methods ---------
// ----------------------------------------------------

extension VehicleAddVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCollectionViewCell", for: indexPath) as! CarCollectionViewCell
        
        return cell
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: thisWidth, height: collectionView.frame.height)
//    }
    
}

