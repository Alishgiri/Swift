//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Alish Giri on 3/27/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mealCostTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    
    var mealCost = 0.0
    var tip = 0.0
    var totalMealCost = 0.0
    var tipPercentage = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func sliderTipValueAction(_ sender: UISlider) {
        if mealCostTextField.text != "" {
            calculateTip()
        }
    }
    
    func calculateTip() {
        mealCost = Double(mealCostTextField.text!)!
        
        tipPercentage = Double(sliderOutlet.value)
        tip = mealCost * tipPercentage
        totalMealCost = mealCost + tip
        
        printUIElements()
    }
    
    func printUIElements() {
        let printPercentage = tipPercentage * 100
        
        // FORMAT NUMBER TO 0, 2 and 2 DECIMAL PLACES
        let stringPercentage = String(format: "%.0f", printPercentage)
        let stringTip = String(format: "%0.2f", tip)
        let stringTotalCost = String(format: "%0.2", totalMealCost)
        
        tipPercentageLabel.text  = "\(stringPercentage)%"
        tipLabel.text = "Tip: $\(stringTip)"
        totalCostLabel.text = "Total cost: $\(stringTotalCost)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         mealCostTextField.resignFirstResponder()
    }
    
}

