//
//  ViewController.swift
//  Multiple View Controller
//
//  Created by Alish Giri on 2/11/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // touchesBegan function hides the keyboard when user touches away from the keyboard and anywhere on the screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // textFieldShouldReturn function runs some code when user press return on the keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // The code below will make the keyboard disappear.
        textField.resignFirstResponder()
        return true
    }


}

