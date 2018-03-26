//
//  ViewController.swift
//  UITextField
//
//  Created by Alish Giri on 3/25/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var labelTop: UILabel!
    var shouldEditTextField = false
    let displayLabel = UILabel(frame: CGRect(x: 20, y: 250, width: 280, height: 40))
    let textfield2 = UITextField(frame: CGRect(x: 20, y: 300, width: 280, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // BRINGS UP THE OPTION TO select, BIU (Bold Italic and underline), paste, etc
        textField1.allowsEditingTextAttributes = true
        
        // BRING UP THE CARET IN THE TEXTFIELD AND MAKES IT THE FIRST RESPONDER AS THE SCREEN APPEARS
        // textField1.becomeFirstResponder()
        
        // NECESSARY STEP TO SET THIS TO USE extension below (THE TEXTFIELD DELEGATE METHODS)
            textField1.delegate = self
        
        textfield2.backgroundColor = UIColor.lightGray
        textfield2.textAlignment = .center
        textfield2.placeholder = "Enter text here"
        textfield2.clearButtonMode = .whileEditing
        textfield2.enablesReturnKeyAutomatically = true
        textfield2.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
         shouldEditTextField = !shouldEditTextField
    }
    @IBAction func addTextfieldBtn(_ sender: UIButton) {
        if !self.view.subviews.contains(textfield2) {
            self.view.addSubview(textfield2)
        }
    }
    
    
    @IBAction func beginEditing(_ sender: UITextField) {
        self.view.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func changeEditing(_ sender: UITextField) {
        if let fieldText = textField1.text {
            displayLabel.text = fieldText
        }
        self.view.addSubview(displayLabel)
    }
    
    @IBAction func endEditing(_ sender: UITextField) {
        if let fieldText = textField1.text {
            labelTop.text = fieldText
        }
        displayLabel.removeFromSuperview()
    }
    
    @IBAction func exitAfterEditing(_ sender: UITextField) {
        self.view.backgroundColor = UIColor.white
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    // ENABLING CLEAR BUTTON ON THE KEYBOARD
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    // ENABLING RETURN KEY ON THE KEYBOARD
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // THIS IS CALLED RIGHT BEFORE START EDITING THE TEXT FIELD, THIS ALTERS BETWEEN ACCESS PERMISSION TO THE TEXTFI
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return shouldEditTextField
    }
    
    
     // RESTRICT TYPE OF CHARACTER IN A TEXTFILED AND REPLACE STRING DEPENDING ON THE CONDITION PROVIDED
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacterSet = NSCharacterSet.letters
        let spaceCharacter = NSCharacterSet(charactersIn: " ")
        
        let existingTextCount = textField.text?.count ?? 0
        let replacedTextCount = range.length // LENGTH OF THE CHARACTER THAT WE WANT TO REPLACE
        let replacementStringCount = string.count
        let newTextCount = existingTextCount + replacementStringCount - replacedTextCount
        
        if newTextCount > 6 {
            return false
        }
            if string.rangeOfCharacter(from: allowedCharacterSet) != nil {
                return true
            } else if string.rangeOfCharacter(from: spaceCharacter as CharacterSet) != nil {
                // THE spaceCharacter IS OF TYPE NSCharacter SO IT HAS TO BE CAST AS CharacterSet
                return true
            } else if string.isEmpty {
                // ENABLING BACKSPACE KEY
                return true
            }
        return false
     }
 
    
     // RIGHT BEFORE WE END EDITING THE TEXT FIELD
     // TRUE - IF WE ARE ENABLING THE TEXT FIELD TO END EDITING
     // FALSE - IF WE DO NOT WANT USER TO END EDITING [password min length 6 but user entered 4]
     func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        /*guard let text = textField.text else { return false }
        if text != "" {
            return true
        } else {
            return false
        }*/
        return true
     }
    
     // THIS IS CALLED AS SOON AS WE START EDITING
     // SAME AS beginEditing ACTION
     func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.backgroundColor = UIColor.red
     }
     
     // THIS IS CALLED AS SOON AS WE FINISH EDITING
     // SAME AS endEditing ACTION
     func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.backgroundColor = UIColor.white
        
        if textField == textField1 {
            if let text = textField.text {
                labelTop.text = text
            }
        } else  if textField == textfield2 {
            if let text = textField.text {
                if text != "" {
                    labelTop.text = text
                }

            }
        }
        

        textField.text?.removeAll()
     }
     
     // EXTENSION OF textFieldDidEndEditing ABOVE
//     func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
//
//     }

}

