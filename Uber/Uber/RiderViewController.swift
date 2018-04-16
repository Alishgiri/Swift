//
//  RiderViewController.swift
//  Uber
//
//  Created by Alish Giri on 4/12/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import FirebaseAuth

class RiderViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var btnCallUberOutlet: UIButton!
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var uberHasBeenCalled = false
    var driverOnTheWay = false
    var driverLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if let email = Auth.auth().currentUser?.email {
            Database.database().reference().child("RideRequests").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childAdded) { (snapshot) in
                self.uberHasBeenCalled = true
                self.btnCallUberOutlet.setTitle("Cancel Uber", for: [])
                Database.database().reference().child("RideRequests").removeAllObservers()
                
                if let rideRequestDictionary = snapshot.value as? [String: AnyObject] {
                    if let driverLat = rideRequestDictionary["driverLat"] as? Double {
                        if let driverLon = rideRequestDictionary["driverLon"] as? Double {
                            self.driverLocation = CLLocationCoordinate2D(latitude: driverLat, longitude: driverLon)
                            self.driverOnTheWay = true
                            self.displayDriverAndRider()
                            
                            if let email = Auth.auth().currentUser?.email {
                                Database.database().reference().child("RideRequests").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childChanged) { (snapshot) in
                                    if let rideRequestDictionary = snapshot.value as? [String: AnyObject] {
                                        if let driverLat = rideRequestDictionary["driverLat"] as? Double {
                                            if let driverLon = rideRequestDictionary["driverLon"] as? Double {
                                                self.driverLocation = CLLocationCoordinate2D(latitude: driverLat, longitude: driverLon)
                                                self.driverOnTheWay = true
                                                self.displayDriverAndRider()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func displayDriverAndRider() {
        let driverCLLocation = CLLocation(latitude: driverLocation.latitude, longitude: driverLocation.longitude)
        let riderCLLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let distance = driverCLLocation.distance(from: riderCLLocation) / 1000
        let roundedDistance = round(distance * 100) / 100
        btnCallUberOutlet.setTitle("Your driver is \(roundedDistance) km away!", for: .normal)
        map.removeAnnotations(map.annotations)
        
        let latDelta = abs(driverLocation.latitude - userLocation.latitude) * 2 + 0.005
        let lonDelta = abs(driverLocation.longitude - userLocation.longitude) * 2 + 0.005
        let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta))
        map.setRegion(region, animated: true)
        
        let riderAnno = MKPointAnnotation()
        riderAnno.coordinate = userLocation
        riderAnno.title = "Your Location"
        map.addAnnotation(riderAnno)
        
        let driverAnno = MKPointAnnotation()
        driverAnno.coordinate = driverLocation
        driverAnno.title = "Your Driver"
        map.addAnnotation(driverAnno)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinates = manager.location?.coordinate {
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let coordinates = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
            userLocation = coordinates
            
            if uberHasBeenCalled {
                displayDriverAndRider()

            } else {
                let region = MKCoordinateRegion(center: coordinates, span: span)
                map.setRegion(region, animated: true)
                
                // GET RIDE OF ALL THE PREVIOUS ANNOTATION LEAVING ONE LATEST ANNOTATION
                map.removeAnnotations(map.annotations)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinates
                annotation.title = "Your Location"
                map.addAnnotation(annotation)
            }
        }
        
    }
    
    @IBAction func btnLogout(_ sender: UIBarButtonItem) {
        try? Auth.auth().signOut()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCallUberAction(_ sender: UIButton) {
        if !driverOnTheWay {
            if let email = Auth.auth().currentUser?.email {
                if uberHasBeenCalled {
                    uberHasBeenCalled = false
                    btnCallUberOutlet.setTitle("Call an Uber", for: [])
                    Database.database().reference().child("RideRequests").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childAdded) { (snapshot) in
                        snapshot.ref.removeValue()
                        Database.database().reference().child("RideRequests").removeAllObservers()
                    }
                } else {
                    let rideRequestsDictionary: [String: Any] = ["email": email, "lat": userLocation.latitude, "lon": userLocation.longitude]
                    Database.database().reference().child("RideRequests").childByAutoId().setValue(rideRequestsDictionary)
                    uberHasBeenCalled = true
                    btnCallUberOutlet.setTitle("Cancel Uber", for: [])
                }
            }
        }
    }
}
