//
//  ViewController.swift
//  Savings Calculator
//
//  Created by Alish Giri on 3/27/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var weeklySavingsLabel: UILabel!
    @IBOutlet weak var monthlySavingsLabel: UILabel!
    @IBOutlet weak var yearlySavingsLabel: UILabel!
    @IBOutlet weak var salaryTextField: UITextField!
    
    var percentage = 0.0
    var salary = 0.0
    var weeklySavings = 0.0
    var monthlySavings = 0.0
    var yearlySavings = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        salaryTextField.resignFirstResponder()
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        setSalayAndPercent()
    }
    
    @IBAction func salaryFieldAction(_ sender: UITextField) {
        setSalayAndPercent()
    }
    
    func setSalayAndPercent() {
        let sliderValue = round(Double(sliderOutlet.value)) / 100
        percentage = sliderValue
        if salaryTextField.text == "" {
            salaryTextField.text = "0"
        } else if let salaryField = salaryTextField.text {
            salary = Double(salaryField)!
        }
        calculateSaving()
    }
    
    func calculateSaving() {
        yearlySavings = salary * percentage
        monthlySavings = yearlySavings / 12
        weeklySavings = yearlySavings / 52
        
        printLabels()
    }
    
    func printLabels() {
        let formattedWeeklySavings = String(format: "%.2f", weeklySavings)
        let formattedMonthlySavings = String(format: "%.2f", monthlySavings)
        let formattedYearlySavings = String(format: "%.2f", yearlySavings)
        let percentageAdjust = percentage * 100
        let formattedPercentLabel = String(format: "%.0f", percentageAdjust)
        
        weeklySavingsLabel.text = "$\(formattedWeeklySavings)"
        monthlySavingsLabel.text = "$\(formattedMonthlySavings)"
        yearlySavingsLabel.text = "$\(formattedYearlySavings)"
        
        percentLabel.text = formattedPercentLabel + "%"
    }
}

