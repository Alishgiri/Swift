//
//  ViewController.swift
//  Maps
//
//  Created by Alish Giri on 4/2/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let latitude: CLLocationDegrees = 27.1755244
        let longitude: CLLocationDegrees = 78.0399773
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinates, span: span) 
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Taj Mahal"
        annotation.subtitle = "One I will see it"
        annotation.coordinate = coordinates
        map.addAnnotation(annotation)
        
        let uilongPressGR = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(gestureRecognizer:))) // COLON AT THE END OF THE longPress: sends where the long press is
        uilongPressGR.minimumPressDuration = 2
        map.addGestureRecognizer(uilongPressGR)
    }
    
    @objc func longPress(gestureRecognizer: UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: self.map)
        let coordinates = map.convert(touchPoint, toCoordinateFrom: self.map)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "New place"
        annotation.subtitle = "Maybe, I will see this as well"
        
        map.addAnnotation(annotation)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

