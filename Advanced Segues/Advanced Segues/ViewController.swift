//
//  ViewController.swift
//  Advanced Segues
//
//  Created by Alish Giri on 4/3/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

let globalVariable = "Iphone"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var activeRowFirstView = 0
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
    
    // INITIATE STH (A SEGUE in this case) WHEN A PARTICULAR ROW IN A TABLE IS TAPPED
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activeRowFirstView = indexPath.row
        performSegue(withIdentifier: "toSecondViewController", sender: nil)
    }
    
    
    // THE FOLLOWING CODE WILL RUN JUST BEFORE SEGUE HAPPENS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondViewController" {
            let secondViewController = segue.destination as! SecondViewController
            secondViewController.activeRowSecondView = activeRowFirstView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

