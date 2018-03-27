//
//  ViewController.swift
//  Average Calculator
//
//  Created by Alish Giri on 3/27/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtEnterScoreField: UITextField!
    @IBOutlet weak var lblScores: UILabel!
    @IBOutlet weak var lblTotalAverage: UILabel!
    
    var arrStoredScores = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtEnterScoreField.resignFirstResponder()
    }

    @IBAction func btnAddAction(_ sender: UIButton) {
        storeScores()
    }
    
    @IBAction func btnSubtractAction(_ sender: UIButton) {
        if arrStoredScores.count != 0 {
            arrStoredScores.removeLast()
        }
        printScores()
    }
    
    func storeScores() {
        if let textData = txtEnterScoreField.text {
            arrStoredScores.append(Double(textData)!)
        }
        txtEnterScoreField.text = ""
        printScores()
    }
    
    func printScores() {
        var printString = String(describing: arrStoredScores)
        printString = printString.replacingOccurrences(of: "[", with: "")
        printString = printString.replacingOccurrences(of: "]", with: "")
        lblScores.text = printString
        
        addArray()
    }
    
    func addArray() {
        let arraySum = arrStoredScores.reduce(0, {$0 + $1})
        calculateAverage(sum: arraySum)
    }
    
    func calculateAverage(sum: Double) {
        let average = sum / Double(arrStoredScores.count)
        let averageWithTwoDecimalPlace = String(format: "%.2f", average)
        lblTotalAverage.text = averageWithTwoDecimalPlace
    }
    
}

