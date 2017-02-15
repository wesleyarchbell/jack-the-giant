//
//  GameplayScene.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 14/2/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var player: Player?
    var canMove = false
    var moveLeft = false
    var centre: CGFloat?
    
    override func didMove(to view: SKView) {
        print("did not to view")
        centre = (scene?.size.width)! / (scene?.size.height)!
        player = childNode(withName: "Player") as? Player
        player?.initPlayerAndAnimations()
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if (location.x > centre!) {
                moveLeft = false
                player?.animatePlayer(moveLeft: moveLeft)
            } else {
                moveLeft = true
                player?.animatePlayer(moveLeft: moveLeft)
            }
        }
        canMove = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation() 
    }
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
        
    }
    
}
