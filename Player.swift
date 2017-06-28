//
//  Player.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 14/2/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let Player: UInt32 = 0;
    static let Cloud: UInt32 = 1;
    static let DarkCloudAndCollectables: UInt32 = 2;
}

class Player: SKSpriteNode {
    
    
    private var playerTextureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    
    func initPlayerAndAnimations() {
        self.playerTextureAtlas = SKTextureAtlas(named: "Player.atlas")
        for i in 2...playerTextureAtlas.textureNames.count {
            playerAnimation.append(SKTexture(imageNamed: "Player \(i)"))
        }
        
        self.animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 50, height: self.size.height - 30))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.Cloud
        self.physicsBody?.contactTestBitMask = ColliderType.DarkCloudAndCollectables
    }
    
    func animatePlayer(moveLeft: Bool) {
        if moveLeft {
            self.xScale = -fabs(self.xScale)
        } else{
            self.xScale = fabs(self.xScale)
        }
        
        self.run(SKAction.repeatForever(self.animatePlayerAction), withKey: "Animate")
    }
    
    func stopPlayerAnimation() {
        self.removeAction(forKey: "Animate")
        self.texture = SKTexture(imageNamed: "Player 1")
        self.size = self.texture!.size()
    }
    
    func movePlayer(moveLeft: Bool) {
        
        if moveLeft {
            self.position.x -= 7
        } else {
            self.position.x += 7
        }
    }
    
}
