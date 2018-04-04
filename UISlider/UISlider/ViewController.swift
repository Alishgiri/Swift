//
//  ViewController.swift
//  UISlider
//
//  Created by Alish Giri on 3/26/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var label: UILabel!
    var alphaSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // IF FALSE ONLY GIVES ONE VALUE ONCE THE USER HAS LIFTED HIS/HER THUMB, REGARDLESS MOVING AROUND THE SILDER
        /*redSlider.isContinuous = true
        redSlider.frame = CGRect(x: 20, y: 40, width: 280, height: 62)
        redSlider.setValue(50, animated: true)
        redSlider.maximumValue = 100

        blueSlider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 1.5))*/
        
        alphaSlider = UISlider(frame: CGRect(x: 20, y: 350, width: 280, height: 31))
        alphaSlider.maximumValue = 1
        alphaSlider.minimumValue = 0
        alphaSlider.maximumValueImage = #imageLiteral(resourceName: "Sun")
        alphaSlider.minimumValueImage = #imageLiteral(resourceName: "Moon")
        alphaSlider.setThumbImage(#imageLiteral(resourceName: "Line"), for: .normal)
        alphaSlider.setValue(0.5, animated: true)
        alphaSlider.backgroundColor = UIColor.white
        alphaSlider.minimumTrackTintColor = UIColor.gray
        alphaSlider.isContinuous = true
        alphaSlider.addTarget(self, action: #selector(changeAnySlider(_:)), for: .valueChanged)
        self.view.addSubview(alphaSlider)
        
    }

    @IBAction func changeSlider1(_ sender: UISlider) {
        /*let value = sender.value
        // SLIDER VALUE INCREMENT BY TEN
        sender.setValue(Float(10 * round(Double(value) / 10)), animated: true)
        print(sender.value)*/
    }
    
    @IBAction func changeSlider2(_ sender: UISlider) {
        //print(sender.value)
    }
    
    @IBAction func changeSlider3(_ sender: UISlider) {
        // print(sender.value)
    }
    
    @IBAction func changeAnySlider(_ sender: UISlider) {
        switch sender {
        case redSlider:
            self.view.backgroundColor = UIColor.red
        case greenSlider:
            self.view.backgroundColor = UIColor.green
        case blueSlider:
            self.view.backgroundColor = UIColor.blue
        case alphaSlider:
            self.view.alpha = CGFloat(sender.value)
        default:
            self.view.backgroundColor = UIColor.red
        }
    }
    
}

