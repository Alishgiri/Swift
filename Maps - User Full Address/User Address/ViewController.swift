//
//  ViewController.swift
//  User Address
//
//  Created by Alish Giri on 4/3/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var currentLatitude: UILabel!
    @IBOutlet weak var currentLongitude: UILabel!
    @IBOutlet weak var currentCourse: UILabel!
    @IBOutlet weak var currentSpeed: UILabel!
    @IBOutlet weak var currentAltitude: UILabel!
    @IBOutlet weak var nearestAddress: UILabel!
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        // MAKE SURE TO ADD CoreLocation.framework IN Build Phase/Link Binary ON THE MAIN PROJECT SETUP SCREEN
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        // CLGeocoder() IS THE PROCESS OF GOING FROM AN ADDRESS TO A LOCATION (latitude and longitude) BUT WE NEED REVERSE SO,
        CLGeocoder().reverseGeocodeLocation(userLocation) {
            placemarks, error in
            if let errorFound = error {
                print(errorFound)
            } else {
                if let addressDetails = placemarks?[0] {
                    //addressDetails.subThoroughfare IS THE STATE
                    var subThroughfare = ""
                    if addressDetails.subThoroughfare != nil {
                        subThroughfare = addressDetails.subThoroughfare!
                    }
                    
                    var throughfare = ""
                    if addressDetails.thoroughfare != nil {
                        throughfare = addressDetails.thoroughfare!
                    }
                    
                    var subLocality = ""
                    if addressDetails.subLocality != nil {
                        subLocality = addressDetails.subLocality!
                    }
                    
                    var subAdministrativeArea = ""
                    if addressDetails.subAdministrativeArea != nil {
                        subAdministrativeArea = addressDetails.subAdministrativeArea!
                    }
                    
                    var postalCode = ""
                    if addressDetails.postalCode != nil {
                        postalCode = addressDetails.postalCode!
                    }
                    
                    var country = ""
                    if addressDetails.country != nil {
                        country = addressDetails.country!
                    }
                    
                    print(subThroughfare + throughfare + "\n" + subLocality + "\n" + subAdministrativeArea + "\n" + postalCode + "\n" + country)
                    
                    self.currentLatitude.text = "\(userLocation.coordinate.latitude)"
                    self.currentLongitude.text = "\(userLocation.coordinate.longitude)"
                    self.currentSpeed.text = "\(userLocation.speed)"
                    self.currentCourse.text = "\(userLocation.course)"
                    self.currentAltitude.text = "\(userLocation.altitude)"
                    self.nearestAddress.text = subThroughfare + throughfare + "\n" + subLocality + subAdministrativeArea + "\n" + postalCode + "\n" + country 
                }
            }
        }
    }

}

