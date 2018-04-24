//
//  ViewSnapViewController.swift
//  Snapchat
//
//  Created by Alish Giri on 4/24/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class ViewSnapViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    
    var imageName = ""
    var snap: DataSnapshot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let snapDictionary = snap?.value as? NSDictionary {
            if let description = snapDictionary["description"] as? String {
                if let imageURL = snapDictionary["imageURL"] as? String {
                    lblMessage.text = description
                    if let url = URL(string: imageURL) {
                        imageView.sd_setImage(with: url, completed: nil)
                    }
                    if let imageName = snapDictionary["imageName"] as? String {
                        self.imageName = imageName
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let currentUserUid = Auth.auth().currentUser?.uid {
            if let key = snap?.key { Database.database().reference().child("users").child(currentUserUid).child("snaps").child(key).removeValue()
            Storage.storage().reference().child("images").child(imageName).delete(completion: nil)
            }
        }
    }
    
}
