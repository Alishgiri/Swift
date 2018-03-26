//
//  ViewController.swift
//  UIViews
//
//  Created by Alish Giri on 3/24/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var middleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let outerWidth = self.view.frame.width
        self.view.backgroundColor = UIColor.purple
        
        // FRAME CHANGES SIZE AND POSITION TO FIT ITS PARENT
        // middleView.frame = CGRect(x: 0, y: 0, width: outerWidth, height: outerWidth)
        
        // BOUNDS CHANGES THE SIZE AND POSITION OF THE CHILD VIEW (SUBVIEW) IT BEARS
        middleView.bounds = CGRect(x: 0, y: -outerWidth/2, width: outerWidth, height: outerWidth)
        
        let subView1 = UIView(frame: CGRect(x: 5, y: 5, width: innerView.frame.width - 10, height: innerView.frame.width - 10))
        innerView.addSubview(subView1)
        subView1.backgroundColor = UIColor.red
        
        let subView2 = UIView(frame: CGRect(x: 10, y: 10, width: innerView.frame.width - 20, height: innerView.frame.width - 20))
        innerView.addSubview(subView2)
        subView2.backgroundColor = UIColor.green
        
        innerView.bringSubview(toFront: subView1)
        innerView.sendSubview(toBack: subView1)
        subView1.removeFromSuperview()
        
        /*subView2.transform = CGAffineTransform(translationX: 100, y: 100)
        innerView.clipsToBounds = true*/
        
        innerView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
        subView2.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeBackground(_:)))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func changeBackground(_ sender: UITapGestureRecognizer) {
        if self.view.backgroundColor == UIColor.purple {
            self.view.backgroundColor = UIColor.white
        } else if self.view.backgroundColor == UIColor.white {
            self.view.backgroundColor = UIColor.purple
        }
    }

}

