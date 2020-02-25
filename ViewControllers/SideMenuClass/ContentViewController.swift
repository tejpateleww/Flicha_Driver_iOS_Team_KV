//
//  ContentViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 11/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import SideMenuController
import GooglePlaces
import GooglePlacePicker
import GoogleMaps
import CoreLocation

class ContentViewController: ParentViewController, CLLocationManagerDelegate,ARCarMovementDelegate {
    func ARCarMovementMoved(_ Marker: GMSMarker) {
        
    }
    

    var placesClient: GMSPlacesClient!
    
    let manager = CLLocationManager()

    var mapView : GMSMapView!
 var driverMarker: GMSMarker!

    @IBOutlet var lblLocationOnMap: UILabel!
    @IBOutlet var subMapView: UIView!
    @IBOutlet var viewLocationDetails: UIView!
    var currentLocation = CLLocation()
    var oldCoordinate: CLLocationCoordinate2D!
    var timer: Timer! = nil
    var counter: NSInteger!
    var coordinateArr = NSArray()
  var moveMent: ARCarMovement!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        

       
        viewLocationDetails.dropShadow(color: .gray, offSet: CGSize(width: -1, height: 1))
        
        placesClient = GMSPlacesClient.shared()

    
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){

            if manager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization))
            {
                if manager.location != nil
                {
                    currentLocation = manager.location!
                }
        
                manager.startUpdatingLocation()
            }
        }
        
        
        //creating a marker view

        let camera = GMSCameraPosition.camera(withLatitude: 40.7416627, longitude: -74.0049708, zoom: 50)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self as? GMSMapViewDelegate
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
//        marker.appearAnimation = .pop
        marker.icon = UIImage(named: "iconActiveDriver")
        marker.map = mapView
        
        oldCoordinate = CLLocationCoordinate2DMake(40.7416627, -74.0049708)
        driverMarker = GMSMarker()
        driverMarker.position = oldCoordinate
        driverMarker.icon = UIImage(named: "iconActiveDriver")
        driverMarker.map = mapView
        
        
        subMapView.addSubview(mapView)
   
        //alloc
        //
        moveMent = ARCarMovement()
        moveMent.delegate = self
        
        //alloc array and load coordinate from json file
        //
        do {
            if let file = Bundle.main.url(forResource: "coordinates", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    print(object)
                } else if let object = json as? [Any] {
                    // json is an array
                    coordinateArr = NSArray(array: object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        //set counter value 0
        //
        counter = 0
        
        //start the timer, change the interval based on your requirement
        //
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ContentViewController.timerTriggered), userInfo: nil, repeats: true)
        
        
        getCurrentPlace()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(#function) -- \(self)")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(#function) -- \(self)")
    }
    

    // ------------------------------------------------------------
    
    var randomColor: UIColor {
        let colors = [UIColor(hue:0.65, saturation:0.33, brightness:0.82, alpha:1.00),
                      UIColor(hue:0.57, saturation:0.04, brightness:0.89, alpha:1.00),
                      UIColor(hue:0.55, saturation:0.35, brightness:1.00, alpha:1.00),
                      UIColor(hue:0.38, saturation:0.09, brightness:0.84, alpha:1.00)]
        
        let index = Int(arc4random_uniform(UInt32(colors.count)))
        return colors[index]
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
    
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error)
        
    }
    

    // ------------------------------------------------------------
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    var nameLabel = String()
    var addressLabel = String()
    
    
    func getCurrentPlace()
    {
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            self.nameLabel = "No current place"
            self.addressLabel = ""
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    self.nameLabel = place.name ?? ""
                    self.addressLabel = (place.formattedAddress?.components(separatedBy: ", ").joined(separator: "\n"))!
                }
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                for likelihood in placeLikelihoodList.likelihoods {
                    let place = likelihood.place
                 //   print("Current Place name \(place.name) at likelihood \(likelihood.likelihood)")
                  //  print("Current Place address \(String(describing: place.formattedAddress))")
                   // print("Current Place attributions \(String(describing: place.attributions))")
                    //print("Current PlaceID \(place.placeID)")
                    
                    self.lblLocationOnMap.text = place.formattedAddress
                }
            }
  
        })
        
        
        print("nameLabel: \(nameLabel)")
        print("addressLabel: \(addressLabel)")
    }
    // MARK: - scheduledTimerWithTimeInterval Action
    @objc func timerTriggered() {
        if counter < coordinateArr.count {
            
            let dict = coordinateArr[counter] as? Dictionary<String,AnyObject>
            
            let newCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(dict!["lat"] as! Float), CLLocationDegrees(dict!["long"] as! Float))
            /**
             *  You need to pass the created/updating marker, old & new coordinate, mapView and bearing value from driver
             *  device/backend to turn properly. Here coordinates json files is used without new bearing value. So that
             *  bearing won't work as expected.
             */
//            moveMent.arCarMovement(driverMarker, withOldCoordinate: oldCoordinate, andNewCoordinate: newCoordinate, inMapview: mapView, withBearing: 0)
            moveMent.ARCarMovement(marker: driverMarker, oldCoordinate: oldCoordinate, newCoordinate: newCoordinate, mapView: mapView, bearing: 0)
            oldCoordinate = newCoordinate
            counter = counter + 1
            //increase the value to get all index position from array
        }
        else {
            timer.invalidate()
            timer = nil
        }
    }
    
    
    // MARK: - ARCarMovementDelegate
    func arCarMovement(_ movedMarker: GMSMarker) {
        driverMarker = movedMarker
        driverMarker.map = mapView
        
        //animation to make car icon in center of the mapview
        //
        let updatedCamera = GMSCameraUpdate.setTarget(driverMarker.position, zoom: 15.0)
        mapView.animate(with: updatedCamera)
    }
    
//    func pickPlace()
//    {
//        let center = CLLocationCoordinate2D(latitude: 37.788204, longitude: -122.411937)
//        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
//        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
//        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
//        let config = GMSPlacePickerConfig(viewport: viewport)
//        let placePicker = GMSPlacePicker(config: config)
//
//        placePicker.pickPlace(callback: {(place, error) -> Void in
//            if let error = error {
//                print("Pick Place error: \(error.localizedDescription)")
//                return
//            }
//
//            if let place = place {
//                self.nameLabel = place.name
//                self.addressLabel = (place.formattedAddress?.components(separatedBy: ", ").joined(separator: "\n"))!
//            } else {
//                self.nameLabel = "No place selected"
//                self.addressLabel = ""
//            }
//        })
//        print("nameLabel: \(nameLabel)")
//        print("addressLabel: \(addressLabel)")
//    }
    
    
    
    
    
    
    
    
}
