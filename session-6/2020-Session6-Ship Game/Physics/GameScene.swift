//
//  GameScene.swift
//  Physics
//
//  Created by Todd Perkins on 11/9/16.
//  Copyright © 2016 Todd Perkins. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    var player:SKSpriteNode?
    var enemy:SKSpriteNode?
    var item:SKSpriteNode?
    var fireRate:TimeInterval = 0.5
    var timeSinceFire:TimeInterval = 0
    var lastTime:TimeInterval = 0
    let noCategory:UInt32 = 0
    let laserCategory:UInt32 = 0b1
    let playerCategory:UInt32 = 0b1 << 1
    let enemyCategory:UInt32 = 0b1 << 2
    let itemCategory:UInt32 = 0b1 << 3
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as? SKSpriteNode
        player?.physicsBody?.categoryBitMask = playerCategory
        player?.physicsBody?.collisionBitMask = noCategory
        player?.physicsBody?.contactTestBitMask = enemyCategory | itemCategory
        
        item = self.childNode(withName: "item") as? SKSpriteNode
        item?.physicsBody?.categoryBitMask = itemCategory
        item?.physicsBody?.collisionBitMask = noCategory
        item?.physicsBody?.contactTestBitMask = playerCategory
        
        enemy = self.childNode(withName: "enemy") as? SKSpriteNode
        enemy?.physicsBody?.categoryBitMask = enemyCategory
        enemy?.physicsBody?.collisionBitMask = noCategory
        enemy?.physicsBody?.contactTestBitMask = playerCategory | laserCategory
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let cA:UInt32 = contact.bodyA.categoryBitMask
        let cB:UInt32 = contact.bodyB.categoryBitMask
        
        if cA == playerCategory || cB == playerCategory {
            let otherNode:SKNode = (cA == playerCategory) ? contact.bodyB.node! : contact.bodyA.node!
            playerDidCollide(with: otherNode)
        }
        else {
            let explosion:SKEmitterNode = SKEmitterNode(fileNamed: "Explosion")!
            explosion.position = contact.bodyA.node!.position
            self.addChild(explosion)
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
        }
    }
    
    func playerDidCollide(with other:SKNode) {
        let otherCategory = other.physicsBody?.categoryBitMask
        if otherCategory == itemCategory {
            other.removeFromParent()
        }
        else if otherCategory == enemyCategory {
            other.removeFromParent()
            player?.removeFromParent()
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        player?.position = pos
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        player?.position = pos
    }
    
    func touchUp(atPoint pos : CGPoint) {
        player?.position = pos
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        checkLaser(currentTime - lastTime)
        lastTime = currentTime
    }
    
    func checkLaser(_ frameRate:TimeInterval) {
        // add time to timer
        timeSinceFire += frameRate
        
        // return if it hasn't been enough time to fire laser
        if timeSinceFire < fireRate {
            return
        }
        
        //spawn laser
        spawnLaser()
        
        // reset timer
        timeSinceFire = 0
    }
    
    func spawnLaser() {
        let scene:SKScene = SKScene(fileNamed: "Laser")!
        let laser = scene.childNode(withName: "laser")
        laser?.position = player!.position
        laser?.move(toParent: self)
        laser?.physicsBody?.categoryBitMask = laserCategory
        laser?.physicsBody?.collisionBitMask = noCategory
        laser?.physicsBody?.contactTestBitMask = enemyCategory
    }
}
