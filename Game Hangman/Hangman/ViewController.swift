//
//  ViewController.swift
//  Hangman
//
//  Created by Alish Giri on 3/18/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

// UITextFieldDelegate IS NOT A CLASS, IT IS A PROTOCOL WHICH IS WHY ON THE viewDidLoad() ADDITIONAL STEPS SHOULD BE IMPLEMENTED FOR THE RESPECTIVE CLASS (self IN THIS EXAMPLE) THAT IN NEED TO BE USED IN
class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var hintLabel: UILabel!
    @IBOutlet var wordToGuessLabel: UILabel!
    @IBOutlet var remainingGuessLabel: UILabel!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var letterBankLabel: UILabel!
    @IBOutlet weak var btnNewWordOutlet: UIButton!
    
    let LIST_OF_WORDS = ["hello", "goodbye", "mammoth", "grapes", "coffee"]
    let LIST_OF_HINTS = ["Greeting", "Farewell", "Extinct mastadon", "Fruit vine", "A good start of the day"]
    var wordToGuess: String!
    var wordAsUnderscores: String = ""
    let MAX_NUMBER_OF_GUESSES = 5
    var guessesRemaining: Int!
    var oldRandomNumber: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NEED THE FOLLOWING LINE OF CODE TO IMPLEMENT UITextFieldDelegate TO inputTextField ABOVE
        // THIS TELLS THE VIEW CONTOLLER THAT ALL OF THE METHODS THAT ACCOMPANY THIS DELEGATE BE IMPLEMENTED IN OUT VIEW CONTROLLER
        inputTextField.delegate = self
        
        // THE CURSOR ON THE TEXTFIELD WILL BE ACTIVE AS USER STARTS THE APP
        // inputTextField.becomeFirstResponder()
        
        inputTextField.isEnabled = false
        
        if inputTextField.isEnabled == false {
            btnNewWordOutlet.setTitle("Click Here To Start", for: [])
            inputTextField.placeholder = "Click on top to start!"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if inputTextField.text != "" {
            self.inputTextField.resignFirstResponder()
        }
    }
    
    @IBAction func newWordBtn(_ sender: UIButton) {
        reset()
        btnNewWordOutlet.setTitle("New Word", for: [])
        inputTextField.placeholder = "Enter a letter"
        hintLabel.text = ""
        
        let index = chooseRandomNumber()
        wordToGuess = LIST_OF_WORDS[index]
        
        for _ in 1...wordToGuess.count {
            wordAsUnderscores.append("_")
        }
        wordToGuessLabel.text = wordAsUnderscores
        
        let hint = LIST_OF_HINTS[index]
        hintLabel.text = "Hint: \(hint), \(wordToGuess.count) letters"
        hintLabel.font = UIFont(name: "Gill Sans", size: 19)
    }
    
    func chooseRandomNumber() -> Int {
        var newRandomNumber: Int = Int(arc4random_uniform(UInt32(LIST_OF_WORDS.count)))
        if (newRandomNumber == oldRandomNumber) {
            newRandomNumber = chooseRandomNumber()
        } else {
            oldRandomNumber = newRandomNumber
        }
        return newRandomNumber
    }
    
    func reset() {
        guessesRemaining = MAX_NUMBER_OF_GUESSES
        remainingGuessLabel.text = "\(guessesRemaining!) guesses left."
        remainingGuessLabel.font = UIFont(name: "Gill Sans", size: 22)
        hintLabel.font = UIFont(name: "Gill Sans", size: 19)
        wordAsUnderscores = ""
        inputTextField.text?.removeAll()
        letterBankLabel.text?.removeAll()
        inputTextField.isEnabled = true
    }
    
    
    // THIS TELLS US WHETHER OR NOT TO ACCKNOWLEDGE THE PRESS ON THE return, ON THE KEYBOARD
    // AS THE USER PRESSES ENTER THE THE FIRST RESPONDER WILL BE RESIGNED AND textFieldDidEndEditing, ABOVE WILL BE ACTIVATED
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        /*
         THE IDEA BEING UI THE FIRST RESPONDER IS, IT CORRESPONDS WITH ELEMENT THAT WE ARE CURRENTLY INTERACTING WITH
         IF WE ARE NOT INTERACTING WITH THE UI THEN THERE IS NO FIRST RESPONDER
         IF WE ARE EDITING A TEXT FIELD THEN THIS TEXT FIELD WILL BE THE FIRST RESPONDER. IF WE PRESSED A BUTTON THEN IT WILL BE THE FIRST RESPONDER
         THE IDEA OF resigning THE FIRST RESPONSE BASCIALLY ENDS THE CURRENT EDITING FOR THE TEXT FIELD
         */
        if inputTextField.text != "" {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    
    /*
     USE TO RESTRICT THE TYPE OF CHARACTERS AND THE NUMBER OF CHARACTERS WE CAN ENTER IN THE TEXT FIELD
     THE BELOW CODE HAS TO DO WITH, RESTRICTING THE KIND OF INPUT THAT OUR TEXT FILED IS GONNA TAKE IN
     THIS CODE WILL RUN AUTOMATICALLY
     LIKE RESTRICT SIZE (ONE CHATACTER) AND KIND OF TEXT (ONLY LETTERS)
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /*
         shouldChangeCharactersIn: RANGE OF CHARACTERS THAT WE WANT TO REPLACE. IF SOME CHARACTERS WE DON'T WANT, IT WILL PROBABLY BE SPECIFIED IN THIS RANGE
         replacementString: WHAT DO YOU WANT TO REPLACE WITH
         */
        let allowedCharacters = NSCharacterSet.lowercaseLetters
        let startingLength = textField.text?.count ?? 0
        let lengthTOAdd = string.count
        let lengthToReplace = range.length
        let newLength = startingLength + lengthTOAdd - lengthToReplace
        
        if string.isEmpty {
            return true
        } else if newLength == 1 {
            if let _ = string.rangeOfCharacter(from: allowedCharacters, options: .caseInsensitive) {
                return true
            }
        }
        // RETURNING FALSE WILL RESTRICT USER TO TYPE ANYTHING IN THE TEXT FIELD
        return false
    }
    
    // KIND OF LIKE A LISTENER FUNCTION, THIS IS GOING TO GET TRIGGERED AS SOON AS USER STOP EDITING THE TEXT FIELD AND MOVES THE CURSOR AWAY FROM THE TEXT FIELD BY CLICKING SOMEWHERE ELSE
    // THIS FUNCTION WILL ACT LIKE A BUTTON HERE
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let letterGuessed = textField.text else { return }
        inputTextField.text?.removeAll()
        let currentLetterBank = letterBankLabel.text ?? ""
        if currentLetterBank.contains(letterGuessed) {
            showAlert(title: "Letter already guessed!", message: "Keep an eye in the letter bank below!")
            return
        } else {
            if wordToGuess.contains(letterGuessed) {
                processCorrectGuess(letterGuessed: letterGuessed)
            } else {
                processIncorrectGuess()
            }
            letterBankLabel.text?.append("\(letterGuessed), ")
        }
    }
    
    func processCorrectGuess(letterGuessed: String) {
        let characterGuessed = Character(letterGuessed)
        for index in wordToGuess.indices {
            if wordToGuess[index] == characterGuessed {
                let endIndex = wordToGuess.index(after: index)
                let characterRange = index..<endIndex
                wordAsUnderscores = wordAsUnderscores.replacingCharacters(in: characterRange, with: letterGuessed)
                wordToGuessLabel.text = wordAsUnderscores
            }
        }
        if (!wordAsUnderscores.contains("_")) {
            inputTextField.isEnabled = false
            remainingGuessLabel.text = "You win! :)"
            hintLabel.text = "WOOHOOO!!!"
            hintLabel.font = UIFont(name: "Gill Sans", size: 40)
            remainingGuessLabel.font = UIFont(name: "Gill Sans", size: 40)
        }
    }
    
    func processIncorrectGuess() {
        guessesRemaining! -= 1
        if guessesRemaining == 0 {
            inputTextField.isEnabled = false
            remainingGuessLabel.text = "You lose! :("
            hintLabel.text = "OPPSS!!"
            remainingGuessLabel.font = UIFont(name: "Gill Sans", size: 40)
            hintLabel.font = UIFont(name: "Gill Sans", size: 40)
        } else {
            remainingGuessLabel.text = "\(guessesRemaining!) guesses left"
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true, completion: nil)
    }
    
}

