//
//  GameOverScene.swift
//  SpaceGameReloaded
//
//  Created by Alish Giri on 4/19/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    var score: Int = 0
    
    var scoreLabel: SKLabelNode!
    var newGameBtnNode: SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        scoreLabel = childNode(withName: "lblScore") as! SKLabelNode
        scoreLabel.text = "\(score)"
        
        newGameBtnNode = childNode(withName: "btnNewGame") as! SKSpriteNode
        newGameBtnNode.texture = SKTexture(imageNamed: "newGame")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            
            if node[0].name == "btnNewGame" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = SKScene(fileNamed: "MenuScene") as! MenuScene
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }

}
