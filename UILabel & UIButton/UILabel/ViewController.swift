//
//  ViewController.swift
//  UILabel
//
//  Created by Alish Giri on 3/24/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let label = UILabel(frame: CGRect(x: 20, y: 20, width: 280, height: 200))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ADDING A LABEL PROGRAMATICALLY
        label.text = "This is cool stuff, making a Label from lines of codes"
        label.font = UIFont(name: "verdana", size: 20)
        label.numberOfLines = 5
        label.backgroundColor = UIColor.gray
        label.textColor = UIColor.black
        label.textAlignment = .center
        self.view.addSubview(label)
        
        // ADDING BUTTON PROGRAMATICALLY
        let button = UIButton(frame: CGRect(x: 20, y: 500, width: 200, height: 100))
        button.setTitle("Press me", for: .normal)
        button.backgroundColor = UIColor.lightGray
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    }
    
    @objc func buttonAction(_ sender: UIButton) {
         label.text = "Button successfully connected!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

