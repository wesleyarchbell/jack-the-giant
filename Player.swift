//
//  Player.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 14/2/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

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
