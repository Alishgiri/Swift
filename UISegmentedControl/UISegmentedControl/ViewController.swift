//
//  ViewController.swift
//  UISegmentedControl
//
//  Created by Alish Giri on 3/25/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl1: UISegmentedControl!
    var segmentedControl2: UISegmentedControl!
    var segmentedControl3: UISegmentedControl!
    
    enum Gear: String {
        case forwards = "Moving forwards"
        case park = "Parked and not moving"
        case reverse = "Moving Backwards"
    }
    var selectedGear: Gear = .park
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl2 = UISegmentedControl(items: ["Forwards", "Park", "Reverse"])
        segmentedControl2.backgroundColor = UIColor.lightGray
        segmentedControl2.tintColor = UIColor.white
        segmentedControl2.frame = CGRect(x: 20, y: 350, width: 280, height: 40)
        segmentedControl2.addTarget(self, action: #selector(changeGear(_:)), for: UIControlEvents.valueChanged )
        self.view.addSubview(segmentedControl2)
        
        segmentedControl3 = UISegmentedControl(frame: CGRect(x: 20, y: 150, width: 280, height: 40))
        segmentedControl3.insertSegment(withTitle: "a", at: 0, animated: true)
        segmentedControl3.insertSegment(withTitle: "b", at: 1, animated: true)
        segmentedControl3.insertSegment(withTitle: "c", at: 2, animated: true)
        segmentedControl3.setTitle("AA", forSegmentAt: 0)
        self.view.addSubview(segmentedControl3)
        
    }

    @IBAction func changeBackgroundColor(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.backgroundColor = UIColor.blue
        case 1:
            self.view.backgroundColor = UIColor.red
        case 2:
            self.view.backgroundColor = UIColor.green
        default:
            self.view.backgroundColor = UIColor.clear
        }
    }
    
    @objc func changeGear(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedGear = .forwards
        case 1:
            selectedGear = .park
        case 2:
            selectedGear = .reverse
        default:
            selectedGear = .park
        }
        print(selectedGear.rawValue)
    }
    
}

