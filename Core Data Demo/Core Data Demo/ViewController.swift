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
        
        // SAVING/ADDING DATA THROUGH .xcdatamodeld TO THE IPHONE
        /*let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        newUser.setValue("Tommy", forKey: "username")
        newUser.setValue("password", forKey: "password")
        newUser.setValue(7 , forKey: "age")
        do {
            try context.save()
            print("Saved")
        } catch {
            print("There was an error saving data!")
        }*/
        
        // ALLOWS US TO GET DATA BACK FROM DATABASE
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //predicate-INSTRUCTION TO ONLY LOOK FOR CERTAIN DATA WITH CERTAIN PROPERTIES
        //request.predicate = NSPredicate(format: "username == %@", "Hermaini") // %@ MEANS ANY (Object) VARIABLES
        //request.predicate = NSPredicate(format: "username = %@", "Tully")
        request.returnsObjectsAsFaults = false // THIS IS IMPORTANT LINE TO RETRIVE DATA
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let username = result.value(forKey: "username") as? String {
                        /* EDITING/UPDATING NAME
                        result.setValue("Tully", forKey: "username")
                        
                        do {
                            try context.save()
                        } catch {
                            print("Faild to change username!")
                        }*/
                        
                        /*DELETING
                        context.delete(result)
                        do {
                            try context.save()
                        } catch {
                            print("Faild to delete username!")
                        }*/
                        
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


}

