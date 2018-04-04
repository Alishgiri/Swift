//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Alish Giri on 4/2/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playAgainOutlet: UIButton!
    var activePlayer = 1 // 0 is empty, 1 is noughts and 2 is crosses
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    let winningCombinations = [(0, 1, 2), (3, 4, 5), (6, 7, 8), (0, 3, 6), (1, 4, 7), (2, 5, 8), (0, 4, 8), (2, 4 ,6)]
    var activeGame = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        playAgainOutlet.center = CGPoint(x: playAgainOutlet.center.x - 500, y: playAgainOutlet.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
            let activePosition = sender.tag - 1
            if gameState[activePosition] == 0 && activeGame {
                gameState[activePosition] = activePlayer
                if activePlayer == 1 {
                    sender.setImage(#imageLiteral(resourceName: "nought.png"), for: [])
                    activePlayer = 2
                } else {
                    sender.setImage(#imageLiteral(resourceName: "cross.png"), for: [])
                    activePlayer = 1
                }
                
                for combination in winningCombinations {
                    if gameState[combination.0] != 0 && gameState[combination.0] == gameState[combination.1] && gameState[combination.1] == gameState[combination.2] {
                        winnerLabel.isHidden = false
                        playAgainOutlet.isHidden = false
                        view.alpha = 0.9
                        winnerLabel.alpha = 1
                        UIView.animate(withDuration: 1.5) {
                            self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
                            self.playAgainOutlet.center = CGPoint(x: self.playAgainOutlet.center.x + 500, y: self.playAgainOutlet.center.y)
                        }
                        if gameState[combination.0] == 1 {
                            winnerLabel.text = "Noughts has won!!!"
                        } else {
                            winnerLabel.text = "Crosses has won!!!"
                        }
                        activeGame = false
                    }
                }
            }
        }
    
    @IBAction func playAgain(_ sender: UIButton) {
        activePlayer = 1 // 0 is empty, 1 is noughts and 2 is crosses
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        winnerLabel.isHidden = true
        playAgainOutlet.isHidden = true
        winnerLabel.text?.removeAll()
        activeGame = true
        for i in 1..<10 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: []) // EMPTY ARRAY IS NORMAL STATE
            }
        }
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        playAgainOutlet.center = CGPoint(x: playAgainOutlet.center.x - 500, y: playAgainOutlet.center.y)
    }
}

