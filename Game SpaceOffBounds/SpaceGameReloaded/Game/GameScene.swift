//
//  GameScene.swift
//  SpaceGameReloaded
//
//  Created by Alish Giri on 4/17/18.
//  Copyright © 2018 Alish Giri. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var gameTimer: Timer!
    var possibleAliens = ["alien", "alien2", "alien3"]
    let alienCategory: UInt32 = 0x1 << 1
    let photonTorpedoCategory: UInt32 = 0x1 << 2
    let playerCategory: UInt32 = 0x1 << 3
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    
    var livesArray: [SKSpriteNode]!
    
    
    override func didMove(to view: SKView) {
        
        addLives()
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = borderBody
        
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        //starfield.advanceSimulationTime(2)
        addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "shuttle")
        player.position = CGPoint(x: 0, y: -size.height / 3 - 20)
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = alienCategory
        player.physicsBody?.collisionBitMask = 0
        addChild(player)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        scoreLabel = self.childNode(withName: "lblScore") as! SKLabelNode
        scoreLabel.position = CGPoint(x: -size.width / 2 + player.size.width * 1.5, y: size.height / 2 - player.size.height)
        //scoreLabel.fontName = "AmericanTypewriter-Bold"
        //scoreLabel.fontSize = 28
        scoreLabel.fontColor = UIColor.white
        score = 0
        //addChild(scoreLabel)
        
        var timerInterval = 0.5
        
        if UserDefaults.standard.bool(forKey: "hard") {
            timerInterval = 0.2
        }
        
        gameTimer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
        
        motionManager.accelerometerUpdateInterval = 0
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data: CMAccelerometerData?, error: Error?) in
            if let accelerometerData = data {
                let accelaration = accelerometerData.acceleration
                self.xAcceleration = CGFloat(accelaration.x) * 0.75 + self.xAcceleration * 0.25
            }
        }
    }
    
    func addLives() {
        livesArray = [SKSpriteNode]()
        
        for live in 1...4 {
            let liveNode = SKSpriteNode(imageNamed: "shuttle")
            liveNode.position = CGPoint(x: size.width / 2 - CGFloat(5 - live) * liveNode.size.width , y: size.height / 2 - liveNode.size.height / 2)
            addChild(liveNode)
            livesArray.append(liveNode)
        }
    }
    
    @objc func addAlien() {
        let randomAlien = Int(arc4random_uniform(2))
        let alien = SKSpriteNode(imageNamed:  possibleAliens[randomAlien])
        
        let maxX = size.width / 2 - alien.size.width / 2
        let minX = -size.width / 2 + alien.size.width / 2
        let range = maxX - minX
        let alienXposition = maxX - CGFloat(arc4random_uniform(UInt32(range)))
        
        alien.position = CGPoint(x: alienXposition, y: size.height / 2 + alien.size.height / 2)
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        alien.physicsBody?.categoryBitMask = alienCategory
        alien.physicsBody?.contactTestBitMask = photonTorpedoCategory
        alien.physicsBody?.collisionBitMask = 0
        addChild(alien)
        
        let moveDown = SKAction.moveBy(x: 0, y: -size.height - alien.size.height, duration: 7)
        let livesLost = SKAction.run {
            self.run(SKAction.playSoundFileNamed("lose.mp3", waitForCompletion: false))
            if self.livesArray.count > 0 {
                let liveNode = self.livesArray.first
                liveNode?.removeFromParent()
                self.livesArray.removeFirst()
            }
            
            if self.livesArray.count == 0 {
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let gameOver = SKScene(fileNamed: "GameOverScene") as! GameOverScene
                gameOver.score = self.score
                self.view?.presentScene(gameOver, transition: transition)
            }
        }
        alien.run(SKAction.sequence([moveDown, livesLost, SKAction.removeFromParent()]))
    }
    
    func fireTorpedo() {
        self.run(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false))
        
        let torpedoNode = SKSpriteNode(imageNamed: "torpedo")
        torpedoNode.position = player.position
        torpedoNode.position.y += 5
        
        torpedoNode.physicsBody = SKPhysicsBody(circleOfRadius: torpedoNode.size.width / 2)
        torpedoNode.physicsBody?.isDynamic = true
        torpedoNode.physicsBody?.categoryBitMask = photonTorpedoCategory
        torpedoNode.physicsBody?.contactTestBitMask = alienCategory
        torpedoNode.physicsBody?.usesPreciseCollisionDetection = true
        addChild(torpedoNode)
        
        let moveUp = SKAction.moveBy(x: 0, y: size.height + torpedoNode.size.height, duration: 0.7)
        torpedoNode.run(SKAction.sequence([moveUp, SKAction.removeFromParent()]))
    }
    
    func torpedoDidCollideWithAlien(torpedoNode: SKSpriteNode, alienNode: SKSpriteNode) {
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = alienNode.position
        addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        torpedoNode.removeFromParent()
        alienNode.removeFromParent()
        
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
        
        score += 2
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == alienCategory {
            torpedoDidCollideWithAlien(torpedoNode: contact.bodyA.node as! SKSpriteNode, alienNode: contact.bodyB.node as! SKSpriteNode)
        }
    }
    override func didSimulatePhysics() {
        player.position.x = xAcceleration * size.width
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireTorpedo()
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    /*
 let RedBallCategory  : UInt32 = 0x1 << 1
 let GreenBallCategory: UInt32 = 0x1 << 2
 let RedBarCategory : UInt32 = 0x1 << 3
 let GreenBarCategory : UInt32 = 0x1 << 4
 let WallCategory : UInt32 = 0x1 << 5
 
 greenBall.physicsBody?.categoryBitMask = GreenBallCategory //Category is GreenBall
//Contact will be detected when GreenBall make a contact with RedBar or a Wall (assuming that redBar's masks are already properly set)
 greenBall.physicsBody?.contactTestBitMask = RedBarCategory | WallCategory
    greenBall.physicsBody?.collisionBitMask = GreenBallCategory | RedBallCategory | WallCategory //Collision will occur when GreenBall hits GreenBall, RedBall or hits a Wall
 
 redBall.physicsBody?.categoryBitMask = RedBallCategory //Category is RedBall
 redBall.physicsBody?.contactTestBitMask = GreenBarCategory | GreenBallCategory | WallCategory //Contact will be detected when RedBall make a contact with GreenBar , GreenBall or a Wall
 redBall.physicsBody?.collisionBitMask = RedBallCategory | GreenBallCategory | WallCategory //Collision will occur when RedBall meets RedBall, GreenBall or hits a Wall
 
 let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
 self.physicsBody = borderBody
 self.physicsBody?.friction = 0
 borderBody.contactTestBitMask = RedBallCategory | GreenBallCategory //Contact will be detected when red or green ball hit the wall
 borderBody.categoryBitMask = WallCategory
 borderBody.collisionBitMask = RedBallCategory | GreenBallCategory // Collisions between RedBall GreenBall and a Wall will be detected
*/
    
}
