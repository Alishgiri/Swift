//
//  ViewController.swift
//  Animations
//
//  Created by Alish Giri on 4/1/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var buttonOutlet: UIButton!

    var counter = 0
    var isAnimating = false
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func fadeIn(_ sender: UIButton) {
        image.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.image.alpha = 1
        })
    }
    @IBAction func slideIn(_ sender: UIButton) {
        image.center = CGPoint(x: image.center.x - 500, y: image.center.y)
        UIView.animate(withDuration: 2) {
            self.image.center = CGPoint(x: self.image.center.x + 500, y: self.image.center.y)
        }
    }
    @IBAction func fadeOut(_ sender: UIButton) {
        image.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        UIView.animate(withDuration: 1) {
            self.image.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        }
    }
    
    @IBAction func next(_ sender: UIButton) {
        if isAnimating {
            timer.invalidate()
            buttonOutlet.setTitle("Start", for: []) // for: default state
            isAnimating = false
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.animate), userInfo: nil, repeats: true)
            buttonOutlet.setTitle("Stop", for: []) // for: default state
            isAnimating = true
        }
    }
    
    @objc func animate() {
        image.image = UIImage(named: "\(counter).gif")
        counter += 1
        if counter == 2 {
            counter = 0
        }
    }
    
}

