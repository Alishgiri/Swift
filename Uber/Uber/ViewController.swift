//
//  ViewController.swift
//  Uber
//
//  Created by Alish Giri on 4/11/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleMobileAds

class ViewController: UIViewController {
    
    @IBOutlet weak var fldEmail: UITextField!
    @IBOutlet weak var fldPassword: UITextField!
    @IBOutlet weak var swtRiderDrriver: UISwitch!
    @IBOutlet weak var btnTopOutlet: UIButton!
    @IBOutlet weak var btnbottomOutlet: UIButton!
    @IBOutlet weak var lblRider: UILabel!
    @IBOutlet weak var lblDriver: UILabel!
    var interstitial: GADInterstitial! // GoogleAd
    
    var signUpMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // GoogleAd
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        interstitial.load(request)
    }
    
    @IBAction func btnTopAction(_ sender: UIButton) {
        if fldEmail.text == "" || fldPassword.text == "" {
            displayAlert(title: "Missing Information", message: "You must provide both email and password")
        } else {
            if let email = fldEmail.text {
                if let password = fldPassword.text {
                    if signUpMode {
                        // SIGN UP
                        
                        Auth.auth().createUser(withEmail: email, password: password) {
                            (user, error) in
                            if let error = error {
                                self.displayAlert(title: "Error", message: error.localizedDescription)
                            } else {
                                if self.swtRiderDrriver.isOn {
                                    // DRIVER
                                    let request = Auth.auth().currentUser?.createProfileChangeRequest()
                                    request?.displayName = "Driver"
                                    request?.commitChanges(completion: nil)
                                } else {
                                    // RIDER
                                    let request = Auth.auth().currentUser?.createProfileChangeRequest()
                                    request?.displayName = "Rider"
                                    request?.commitChanges(completion: nil)
                                    self.performSegue(withIdentifier: "riderSegue", sender: nil)
                                }
                            }
                        }
                        
                    } else {
                        // LOG IN
                        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                            if let error = error {
                                self.displayAlert(title: "Error", message: error.localizedDescription)
                            } else {
                                if user?.displayName == "Driver" {
                                    // DRIVER
                                    self.performSegue(withIdentifier: "driverSegue", sender: nil)
                                } else {
                                    // RIDER
                                    self.performSegue(withIdentifier: "riderSegue", sender: nil)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnBottomAction(_ sender: UIButton) {
        
        if interstitial.isReady { // GoogleAd
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        if signUpMode {
            btnTopOutlet.setTitle("Log In", for: [])
            btnbottomOutlet.setTitle("Switch to Sign Up", for: [])
            lblRider.isHidden = true
            lblDriver.isHidden = true
            swtRiderDrriver.isHidden = true
            signUpMode = false
        } else {
            btnTopOutlet.setTitle("Sign Up", for: [])
            btnbottomOutlet.setTitle("Switch to Sign In", for: [])
            lblRider.isHidden = false
            lblDriver.isHidden = false
            swtRiderDrriver.isHidden = false
            signUpMode = true
        }
    }
    
}

