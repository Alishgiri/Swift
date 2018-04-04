//
//  ViewController.swift
//  Weather Finder
//
//  Created by Alish Giri on 4/1/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextField.delegate = self
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getWeatherData()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.cityTextField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = NSCharacterSet.letters
        let spaceCharacter = NSCharacterSet(charactersIn: " ")
        if string.rangeOfCharacter(from: allowedCharacters) != nil {
            return true
        } else if string.rangeOfCharacter(from: spaceCharacter as CharacterSet) != nil {
            return true
        }
        return false
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
        if cityTextField.text == "" {
            weatherInfoLabel.text = "Please enter a city name!"
            return
        } else {
            getWeatherData()
        }
    }
    
    func getWeatherData() {
        if let url = URL(string: "https://www.weather-forecast.com/locations/\(cityTextField.text!.replacingOccurrences(of: " ", with: "-"))/forecasts/latest") {
        let request = NSMutableURLRequest(url: url)
        var message = ""
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if let error = error {
                print(error)
            } else {
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    var stringSeparator = "</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        if contentArray.count > 1 {
                            stringSeparator = "</span>"
                            print(contentArray)
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                        } else {
                            message = "Weather could not be found for the city entered. Please check your spelling!"
                        }
                    }
                }
            }
            if message == "" {
                message = "The Weather could not be found. Please try again!"
            }
            // DISPATCH THE QUEUE AND DISPLAY THE RESULT WHEN ITS READY
            DispatchQueue.main.sync {
                self.weatherInfoLabel.text = "\(self.cityTextField.text!)\n\(message)"
            }
        }
        task.resume()
        cityTextField.resignFirstResponder()
            cityTextField.text?.removeAll()
        } else {
            weatherInfoLabel.text = ""
        }
        
    }
}
