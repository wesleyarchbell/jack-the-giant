//
//  CollectableController.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 6/7/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

class CollectableController {
        
    func getCollectable() -> SKSpriteNode? {
        var collectable: SKSpriteNode?
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 7)) >= 4 {
            if (GameplayController.instance.life! < 2) {
                collectable? = SKSpriteNode(imageNamed: "Life")
                collectable?.name = "Life"
                collectable?.physicsBody = SKPhysicsBody(rectangleOf: (collectable?.size)!)
                addCommon(collectable: collectable!)
            }
        } else {
            collectable = SKSpriteNode(imageNamed: "Coin")
            collectable?.name = "Coin"
            collectable?.physicsBody = SKPhysicsBody(circleOfRadius: (collectable?.size.height)! / 2)
            addCommon(collectable: collectable!)
        }
        return collectable
    }
    
    func addCommon(collectable: SKSpriteNode) {
        collectable.physicsBody?.affectedByGravity = false
        collectable.physicsBody?.categoryBitMask = ColliderType.DarkCloudAndCollectables
        collectable.physicsBody?.collisionBitMask = ColliderType.Player
        collectable.zPosition = 3
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) - min(firstNum, secondNum)
    }

    
}
