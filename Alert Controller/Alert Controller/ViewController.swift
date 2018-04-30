//
//  ViewController.swift
//  Alert Controller
//
//  Created by Alish Giri on 3/22/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    var alertController = UIAlertController()
    var listOfUsers = ["Alish"]
    var listOfPasswords = ["password"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonOne(_ sender: UIButton) {
        alertController = UIAlertController(title: "Alert 1", message: "This is s normal alert.", preferredStyle: .alert)
        present(alertController, animated: true, completion: {() -> Void in
            print("Alert is being displayed.")
        })
        
        let delay = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {() -> Void in
            self.alertController.dismiss(animated: true, completion: {() -> Void in
                print("Dismissed alert")
            })
        })
        
        alertController.view.backgroundColor = UIColor.red
    }
    
    @IBAction func buttonTwo(_ sender: UIButton) {
        alertController = UIAlertController(title: "You request has been processed!", message: "Do you want to dismiss?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: {(ACTION: UIAlertAction) -> Void in
            print("Alert has been dismissed!")
        })
        let lightGrayAction = UIAlertAction(title: "Light Gray", style: .default, handler: {(ACTION: UIAlertAction) -> Void in
            self.view.backgroundColor = UIColor.lightGray
        })
        let darkGreyAction = UIAlertAction(title: "Dark Grey", style: .default, handler: {(ACTION: UIAlertAction) -> Void in
            self.view.backgroundColor = UIColor.darkGray
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(lightGrayAction)
        alertController.addAction(darkGreyAction)
        
        // TO GIVE TEXT A BOLD APPEARANCE ON THE ALERT
        alertController.preferredAction = darkGreyAction
        
        present(alertController, animated: true, completion: {() -> Void in
            print("Alert action is being displayed")
        })
    }
    
    @IBAction func buttonThree(_ sender: UIButton) {
        alertController = UIAlertController(title: "Login", message: "Please type in your details.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(ACTION: UIAlertAction) -> Void in
            print("login has been canceled")
        })
        let loginAction = UIAlertAction(title: "Login", style: .default, handler: {(ACTION: UIAlertAction) -> Void in
            guard let textfields = self.alertController.textFields else {
                print("No values entered")
                return }
            guard let nameText = textfields[0].text else {
                print("No name detected")
                return
            }
            guard let passwordText = textfields[1].text else {
                print("No password detected")
                return
            }
            if nameText == self.listOfUsers[0] && passwordText == self.listOfPasswords[0] {
                self.label1.text = "Welcome \(nameText)"
                self.label2.text = "Current password: \(passwordText)"
            } else {
                self.label1.text = "User not found"
                self.label2.text = "Incorrect password: \(passwordText)"
                self.alertController.dismiss(animated: true, completion: nil)
            }
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(loginAction)

        alertController.addTextField(configurationHandler: {(TEXTFIELD: UITextField) -> Void in
            TEXTFIELD.placeholder = "Name"
            TEXTFIELD.accessibilityIdentifier = "name"
            // FIRST LETTER IN THE SENTENCE/WORD WILL BE CAPITALIZED
            TEXTFIELD.autocapitalizationType = .sentences
        })
        alertController.addTextField(configurationHandler: {(TEXTFIELD: UITextField) -> Void in
            TEXTFIELD.placeholder = "Password"
            TEXTFIELD.accessibilityIdentifier = "password"
            // FOR SECURE ENTRY OF PASSWORD/ HIDING PASSWORD BEHIND DOTS
            TEXTFIELD.isSecureTextEntry = true
        })
        
        alertController.view.backgroundColor = UIColor.blue   
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func buttonFour(_ sender: UIButton) {
        alertController = UIAlertController(title: "Alert 2", message: "This is an action sheet.", preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: {(ACTION: UIAlertAction) -> Void in
            print("Alert has been dismissed!")
        })
        let lightGrayAction = UIAlertAction(title: "Light Gray", style: .default, handler: {(ACTION: UIAlertAction) -> Void in
            self.view.backgroundColor = UIColor.lightGray
        })
        let darkGreyAction = UIAlertAction(title: "Dark Grey", style: .default, handler: {(ACTION: UIAlertAction) -> Void in
            self.view.backgroundColor = UIColor.darkGray
        })
        
        alertController.addAction(lightGrayAction)
        alertController.addAction(darkGreyAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: {() -> Void in
            print("Action sheet is being displayed")
        })
        
        
//        THE BELOW CODE IS LIKE setTimeout IN ANGULAR
        let delay = DispatchTime.now() + 3 // THIS 3 IS ADD 3 SECOND TO THE NOW TIME
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {() -> Void in
//            self.alertController.dismiss(animated: true, completion: {() -> Void in
//                print("Action sheet dismissed")
//            })
        })
    }
    
}

