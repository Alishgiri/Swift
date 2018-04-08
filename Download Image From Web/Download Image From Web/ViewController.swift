//
//  ViewController.swift
//  Download Image From Web
//
//  Created by Alish Giri on 4/8/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // RETRIEVE LOCALLY STORED DATA
        /*
        diretory - directory within the app itself
        domainMask - where we are looking/searching for our files
        expandTilde - TILDE (~) MEANS HOME DIRECTORY. REPLACING '~' WITH FULL LINK IF TRUE
         */
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if documentsPath.count > 0 {
            let documentsDirectory = documentsPath[0]
            let restorePath = documentsDirectory + "/car.jpg"

            imgView.image = UIImage(contentsOfFile: restorePath)
        }
        
        // GET FROM THE URL AND SAVE IMAGE
        /*let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsOQOhDY_mwxgecsm3Uwcw4bULnVO_nr7RFRxvFYFedMQxV99O")!
        let request = NSMutableURLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if let foundError = error {
                print(foundError)
            } else {
                if let data = data {
                    if let carImage = UIImage(data: data) {
                        self.imgView.image = carImage
                        
                        // diretory - directory within the app itself
                        // domainMask - where we are looking/searching for our files
                        // expandTilde - TILDE (~) MEANS HOME DIRECTORY. REPLACING '~' WITH FULL LINK IF TRUE
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                        if documentsPath.count > 0 {
                            let documentsDirectory = documentsPath[0]
                            let savePath = documentsDirectory + "/car.jpg"
                            do {
                                try UIImageJPEGRepresentation(carImage, 1)?.write(to: URL(fileURLWithPath: savePath))
                            } catch {
                                print("Unsucceful to save image")
                            }
                        }
                    }
                }
            }
        }
        task.resume()*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

