//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by Alish Giri on 4/22/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    @objc func pikachuTapped() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("PIKA PIKA")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pikachuBtn = UIButton(type: .system)
        pikachuBtn.setBackgroundImage(UIImage(named: "pikachu"), for: [])
        pikachuBtn.frame = CGRect(x: 150, y: 40, width: 100, height: 130)
        pikachuBtn.addTarget(self, action: #selector(KeyboardViewController.pikachuTapped), for: .touchUpInside)
        view.addSubview(pikachuBtn)
        
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
