//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Alish Giri on 4/5/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIApplication MEANS THE WHOLE APPLICATION
        let appDelegate = UIApplication.shared.delegate as! AppDelegate//AppDelegate REFERS TO AppDelegate.swift
        let context = appDelegate.persistentContainer.viewContext //context REFERS/GIVESACCESS TO DATABASE/persistentContainer
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        newUser.setValue("Hermaini", forKey: "username")
        newUser.setValue("password", forKey: "password")
        newUser.setValue(24, forKey: "age")
        
        do {
            try context.save()
            print("Saved")
        } catch {
            print("There was an error saving data!")
        }
        
        // ALLOWS US TO GET DATA BACK FROM DATABASE
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false // THIS IS IMPORTANT LINE TO RETRIVE DATA
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let username = result.value(forKey: "username") as? String {
                        print(username)
                    }
                }
            } else {
                print("No Results")
            }
        } catch {
            print("Could not fetch data!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

