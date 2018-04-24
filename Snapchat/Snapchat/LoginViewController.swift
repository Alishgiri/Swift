//
//  ViewController.swift
//  Snapchat
//
//  Created by Alish Giri on 4/24/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var fldEmail: UITextField!
    @IBOutlet weak var fldPassword: UITextField!
    @IBOutlet weak var btnTopOutlet: UIButton!
    @IBOutlet weak var btnBottomOutlet: UIButton!
    
    var signupMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btnTopAction(_ sender: UIButton) {
        if let email = fldEmail.text {
            if let password = fldPassword.text {
                if !signupMode {
                    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                        if let error = error {
                            self.presentAlert(alert: error.localizedDescription)
                        } else {
                            
                            self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                        }
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                        if let error = error {
                            self.presentAlert(alert: error.localizedDescription)
                        } else {
                            if let user = user {
                                Database.database().reference().child("users").child(user.uid).child("email").setValue(user.email)
                                self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func presentAlert(alert: String) {
        let alertController = UIAlertController(title: "Error!", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil )
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnBottomAction(_ sender: UIButton) {
        if signupMode {
            signupMode = false
            btnTopOutlet.setTitle("Log In", for: [])
            btnBottomOutlet.setTitle("Switch to Sign Up", for: [])
        } else {
            signupMode = true
            btnTopOutlet.setTitle("Sign Up", for: [])
            btnBottomOutlet.setTitle("Switch to Log In", for: [])
        }
    }
    
}

