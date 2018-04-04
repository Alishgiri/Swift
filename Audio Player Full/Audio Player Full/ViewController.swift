//
//  ViewController.swift
//  Audio Player Full
//
//  Created by Alish Giri on 4/4/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    let audioPath = Bundle.main.path(forResource: "Call On Me", ofType: "mp3")
    var timer = Timer()
    
    @IBOutlet weak var songTimerSliderOutlet: UISlider!
    @IBOutlet weak var volumeSliderOutlet: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            songTimerSliderOutlet.value = Float(player.currentTime)
            songTimerSliderOutlet.maximumValue = Float(player.duration)
        } catch let error {
                print("Error while playing!\n\(error)")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func songTimerControllerAction(_ sender: UISlider) {
        player.currentTime = TimeInterval(songTimerSliderOutlet.value)
    }
    
    @IBAction func volumeSliderAction(_ sender: UISlider) {
        player.volume = volumeSliderOutlet.value
    }
    
    @IBAction func play(_ sender: UIBarButtonItem) {
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateScrubber), userInfo: nil, repeats: true)
    }
    @objc func updateScrubber() {
        songTimerSliderOutlet.value = Float(player.currentTime)
    }
    
    @IBAction func pause(_ sender: UIBarButtonItem) {
        player.pause()
        timer.invalidate()
    }
    
    @IBAction func stop(_ sender: UIBarButtonItem) {
        player.stop()
        songTimerSliderOutlet.value = 0.0
        timer.invalidate()
        
        // This or the following
        player.currentTime = 0.0
        
//        do {
//            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
//            songTimerSliderOutlet.value = Float(player.currentTime)
//            songTimerSliderOutlet.maximumValue = Float(player.duration)
//        } catch let error {
//            print("Error while playing!\n\(error)")
//        }
    }
    
}

