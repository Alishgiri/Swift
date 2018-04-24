//
//  SelectPictureViewController.swift
//  Snapchat
//
//  Created by Alish Giri on 4/24/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit
import FirebaseStorage

class SelectPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fldMessage: UITextField!
    
    var imagePicker: UIImagePickerController?
    var imageAdded = false
    var imageName = "\(NSUUID().uuidString).jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
    }
    
    @IBAction func selectExistingPicture(_ sender: UIBarButtonItem) {
        imagePicker?.sourceType = .photoLibrary
        if imagePicker != nil {
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    @IBAction func useCamera(_ sender: UIBarButtonItem) {
        imagePicker?.sourceType = .camera
        if imagePicker != nil {
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            imageAdded = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        
        if let message = fldMessage.text {
            if imageAdded && message != "" {
                let imageFolder = Storage.storage().reference().child("images")
                if let image = imageView.image {
                    if let imageData = UIImageJPEGRepresentation(image, 0.1)  { // 0.1 is compression size
                    
                    // CREATING UNIQUE ID TO THAT IMAGE
                        imageFolder.child(imageName).putData(imageData, metadata: nil) { (metadata, error) in
                            if let error = error {
                                self.preasentAlert(alertMessage: error.localizedDescription)
                            } else {
                                if let downloadURL = metadata?.downloadURL()?.absoluteString {
                                    self.performSegue(withIdentifier: "selectContact", sender: downloadURL)
                                }
                            }
                        }
                    }
                }
            } else {
                 self.preasentAlert(alertMessage: "You must provide an image and a message for your snap.")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let downloadURL = sender as? String {
            if let selectVC = segue.destination as? SelectRecipientTableViewController {
                selectVC.downloadURL = downloadURL
                selectVC.snapDescription = fldMessage.text!
                selectVC.imageName = imageName
            }
        }
    }
    
    func preasentAlert(alertMessage: String) {
        let alertVC = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}
