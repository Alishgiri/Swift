//
//  GameScene.swift
//  Coin Man
//
//  Created by Alish Giri on 4/10/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // contactTestBitMask WHEN TWO OBJECT ARE TOUCHING EACH OTHER
    // collisionBitMask BOUNCE OFF OF EACH OTHER
    
    var coinMan: SKSpriteNode?
    var timerCoin: Timer?
    var timerBomb: Timer?
    var celling: SKSpriteNode?
    var lblScore: SKLabelNode?
    var lblYourScore: SKLabelNode?
    var lblFinalScore: SKLabelNode?
    
    let coinManCategory: UInt32 = 0x1 << 1
    let coinCategory: UInt32 = 0x1 << 2
    let bombCategory: UInt32 = 0x1 << 3
    let groundAndCellingCategory: UInt32 = 0x1 << 4
    
    var score = 0
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        runningCoinMan()
        
        celling = childNode(withName: "celling") as? SKSpriteNode
        celling?.physicsBody?.categoryBitMask = groundAndCellingCategory
        celling?.physicsBody?.collisionBitMask = coinManCategory
        
        lblScore = childNode(withName: "lblScore") as? SKLabelNode
        timerStart()
        createGrass()
    }
    
    func runningCoinMan() {
        coinMan = childNode(withName: "coinMan") as? SKSpriteNode
        coinMan?.physicsBody?.categoryBitMask = coinManCategory
        coinMan?.physicsBody?.contactTestBitMask = coinCategory | bombCategory
        coinMan?.physicsBody?.collisionBitMask = groundAndCellingCategory
        
        var coinManRun: [SKTexture] = []
        for number in 1...2 {
            coinManRun.append(SKTexture(imageNamed: "frame-\(number)"))
        }
        coinMan?.run(SKAction.repeatForever(SKAction.animate(with: coinManRun, timePerFrame: 0.1)))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if scene?.isPaused == false {
            coinMan?.physicsBody?.applyForce(CGVector(dx:  0, dy: 49000))
        }
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let theNodes = nodes(at: location)
            
            for node in theNodes {
                if node.name == "play" {
                    node.removeFromParent()
                    restartGame()
                }
            }
        }
    }
    
    func timerStart() {
        timerCoin = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: {
            (timer) in
            self.createCoin()
        })
        timerBomb = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: {
            (timer) in
            self.createBomb()
        })
    }
    
    func createGrass() {
        let sizingGrass = SKSpriteNode(imageNamed: "grass")
        let numberOfGrass = Int(size.width / sizingGrass.size.width) + 1
        for number in 0...numberOfGrass {
            let grass = SKSpriteNode(imageNamed: "grass")
            grass.physicsBody = SKPhysicsBody(rectangleOf: grass.size)
            grass.physicsBody?.categoryBitMask = groundAndCellingCategory
            grass.physicsBody?.collisionBitMask = coinManCategory
            grass.physicsBody?.affectedByGravity = false
            grass.physicsBody?.isDynamic = false
            addChild(grass)
            
            let grassX = -size.width / 2 + grass.size.width / 2 + grass.size.width * CGFloat(number)
            grass.position = CGPoint(x: grassX, y: -size.height / 2 + grass.size.height / 2 - 29)
            
            let speed = 100.0
            let firstMoveLeft = SKAction.moveBy(x: -grass.size.width - grass.size.width * CGFloat(number), y: 0, duration: TimeInterval(grass.size.width + grass.size.width * CGFloat(number)) / speed)
            let grassFullMove = SKAction.moveBy(x: -size.width - grass.size.width, y: 0, duration: TimeInterval(size.width + grass.size.width) / speed)
            let resetGrass = SKAction.moveBy(x: size.width + grass.size.width, y: 0, duration: 0)
            let grassMoveForever = SKAction.repeatForever(SKAction.sequence([grassFullMove, resetGrass]))
            grass.run(SKAction.sequence([firstMoveLeft, resetGrass, grassMoveForever]))
        }
    }
    
    func createCoin() {
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.categoryBitMask = coinCategory
        coin.physicsBody?.contactTestBitMask = coinManCategory
        coin.physicsBody?.affectedByGravity = false
        coin.physicsBody?.collisionBitMask = 0 // Do not react to collide
        addChild(coin)
        
        let sizingGrass = SKSpriteNode(imageNamed: "grass")
        
        let maxY = size.height / 2 - coin.size.height / 2
        let minY = -size.height / 2 + coin.size.height / 2 + sizingGrass.size.height
        
        let range = maxY - minY
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        coin.position = CGPoint(x: size.width/2 + coin.size.width/2, y: coinY)
        
        let moveLeft = SKAction.moveBy(x: -size.width - coin.size.width, y: 0, duration: 4)
        coin.run(SKAction.sequence([moveLeft, SKAction.removeFromParent()]))
    }
    
    func createBomb() {
        let bomb = SKSpriteNode(imageNamed: "bomb")
        bomb.physicsBody = SKPhysicsBody(texture: SKTexture(image: UIImage(named: "bomb")!), size: bomb.size)
        bomb.physicsBody?.categoryBitMask = bombCategory
        bomb.physicsBody?.contactTestBitMask = coinManCategory
        bomb.physicsBody?.affectedByGravity = false
        bomb.physicsBody?.collisionBitMask = 0 // Do not react to collide
        addChild(bomb)
        
        let sizingGrass = SKSpriteNode(imageNamed: "grass")
        
        let maxY = size.height / 2 - bomb.size.height / 2
        let minY = -size.height / 2 + bomb.size.height / 2 + sizingGrass.size.height
        
        let range = maxY - minY
        let bombY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        bomb.position = CGPoint(x: size.width/2 + bomb.size.width/2, y: bombY)
        
        let moveLeft = SKAction.moveBy(x: -size.width - bomb.size.width, y: 0, duration: 4)
        bomb.run(SKAction.sequence([moveLeft, SKAction.removeFromParent()]))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == coinCategory {
            contact.bodyA.node?.removeFromParent()
            score += 1
            lblScore?.text = "Score: \(score)"
        }
        if contact.bodyB.categoryBitMask == coinCategory {
            contact.bodyB.node?.removeFromParent()
            score += 1
            lblScore?.text = "Score: \(score)"
        }
        if contact.bodyA.categoryBitMask == bombCategory {
            contact.bodyA.node?.removeFromParent()
            gameOver()
        }
        if contact.bodyB.categoryBitMask == bombCategory {
            gameOver()
        }
    }
    
    func gameOver() {
        scene?.isPaused = true
        timerBomb?.invalidate()
        timerCoin?.invalidate()
        
        lblYourScore = SKLabelNode(text: "Your score:")
        lblYourScore?.position = CGPoint(x: 0, y: 200)
        lblYourScore?.fontSize = 90
        lblFinalScore?.zPosition = 1
        if lblYourScore != nil {
            addChild(lblYourScore!)
        }
        
        lblFinalScore = SKLabelNode(text: "\(score)")
        lblFinalScore?.position = CGPoint(x: 0, y: 0)
        lblFinalScore?.fontSize = 150
        lblFinalScore?.zPosition = 1
        if lblFinalScore != nil {
            addChild(lblFinalScore!)
        }
        
        let btnPlay = SKSpriteNode(imageNamed: "play")
        btnPlay.position = CGPoint(x: 0, y: -200)
        btnPlay.zPosition = 1
        btnPlay.name = "play"
        addChild(btnPlay)
    }
    
    func restartGame() {
        score = 0
        lblYourScore?.removeFromParent()
        lblFinalScore?.removeFromParent()
        scene?.isPaused = false
        lblScore?.text = "Score: \(score)"
        timerStart()
        runningCoinMan()
    }
    
}
