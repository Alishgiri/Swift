//
//  MenuScene.swift
//  SpaceGameReloaded
//
//  Created by Alish Giri on 4/18/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene  {
    
    var starfield: SKEmitterNode!
    var newGameBtnNode: SKSpriteNode!
    var difficultyLblNode: SKLabelNode!
    var difficultyBtnNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        starfield = self.childNode(withName: "starfield") as! SKEmitterNode
        
        newGameBtnNode = self.childNode(withName: "btnNewGame") as! SKSpriteNode
        difficultyBtnNode = self.childNode(withName: "btnDifficulty") as! SKSpriteNode
        
        //difficultyBtnNode.texture = SKTexture(imageNamed: "difficulty")
        difficultyLblNode = self.childNode(withName: "lblDifficulty") as! SKLabelNode
        
        
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "hard") {
            difficultyLblNode.text = "Hard"
        } else {
            difficultyLblNode.text = "Easy"
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let nodesArray  = self.nodes(at: location)
            
            if nodesArray.first?.name == "btnNewGame" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameScene(fileNamed: "GameScene")
                self.view?.presentScene(gameScene!, transition: transition)
            } else if nodesArray.first?.name == "btnDifficulty" {
                changeDifficulty()
            }
        }
    }
    
    func changeDifficulty() {
        let userDefaults = UserDefaults.standard
        
        if difficultyLblNode.text == "Easy" {
            difficultyLblNode.text = "Hard"
            userDefaults.set(true, forKey: "hard")
        } else {
            difficultyLblNode.text = "Easy"
            userDefaults.set(false, forKey: "hard")
        }
    }

}
