//
//  ViewController.swift
//  Facebook Login
//
//  Created by Alish Giri on 4/23/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

/*
 GOTO developer.facebook.com AND DOWNLOAD THE FACEBOOK SDK AND FOLLOW THE INSTRUCTION,
 THE RESULT WILL BE AS BELOW.
*/

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginBtn = FBSDKLoginButton()
        loginBtn.center = view.center
        loginBtn.readPermissions = ["public_profile", "email"]
        loginBtn.delegate = self
        view.addSubview(loginBtn)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
        } else if result.isCancelled {
            print("User has cancelled login!")
        } else {
            if result.grantedPermissions.contains("email") {
                if let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"]) {
                    graphRequest.start { (connection, result, error) in
                        if let error = error {
                            print(error)
                        } else {
                            if let userDeets = result {
                                print(userDeets)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out!")
    }
    
}

