//
//  CloudController.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 28/2/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

class CloudController {
    
    var lastCloudsPositionY = CGFloat()
    var collectableController = CollectableController()
    
    func createClouds() -> [SKSpriteNode] {
        
        var clouds = [SKSpriteNode]()
        for i in 0..<2 {
            clouds.append(createCloud(imageName: "Cloud 1", name: "1", categoryBitMask: ColliderType.Cloud))
            clouds.append(createCloud(imageName: "Cloud 2", name: "2", categoryBitMask: ColliderType.Cloud))
            clouds.append(createCloud(imageName: "Cloud 3", name: "3", categoryBitMask: ColliderType.Cloud))
            clouds.append(createCloud(imageName: "Dark Cloud", name: "Dark Cloud", categoryBitMask: ColliderType.DarkCloudAndCollectables))
        }
        clouds = shuffleClouds(clouds: clouds)
        return clouds
        
    }
    
    func createCloud(imageName: String, name: String, categoryBitMask: UInt32) -> SKSpriteNode {
        let cloud = SKSpriteNode(imageNamed: imageName)
        cloud.name = name
        cloud.xScale = 0.9
        cloud.yScale = 0.9
        
        cloud.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud.size.width - 15, height: cloud.size.height - 6))
        cloud.physicsBody?.affectedByGravity = false
        cloud.physicsBody?.restitution = 0
        cloud.physicsBody?.categoryBitMask = categoryBitMask
        cloud.physicsBody?.collisionBitMask = ColliderType.Player
        
        return cloud
        
    }
    
    func shuffleClouds(clouds: [SKSpriteNode]) -> [SKSpriteNode] {
        var clouds = clouds
        for i in stride(from: clouds.count - 1, to: 1, by: -1) {
            let newPosition = Int(arc4random_uniform(UInt32(i - 1)))
            swap(&clouds[i], &clouds[newPosition])
        }
        return clouds
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) - min(firstNum, secondNum)
    }
    
    func arrangeCloudsInScene(scene: SKScene, distanceBetweenClouds: CGFloat, centre: CGFloat, minX: CGFloat, maxX: CGFloat,
                              initialClouds: Bool) {
        
        var clouds = createClouds()
        var positionY = CGFloat()
        if initialClouds {
            while clouds[0].name == "Dark Cloud" {
                shuffleClouds(clouds: clouds)
            }
            positionY = centre - 100
        } else {
            positionY = lastCloudsPositionY
        }
        var random = 0
        for i in 0...clouds.count - 1 {
            
            var randomX = CGFloat()
            if random == 0 {
                randomX = randomBetweenNumbers(firstNum: centre + 90, secondNum: maxX - 20)
                random = 1
            } else if random == 1 {
                randomX = randomBetweenNumbers(firstNum: centre - 90, secondNum: minX + 20)
                random = 0
            }
            
            clouds[i].position = CGPoint(x: randomX, y: positionY)
            clouds[i].zPosition = 3
            
            
            //add collectable to cloud
            if !initialClouds && clouds[i].name != "Dark Cloud" {
                if Int(randomBetweenNumbers(firstNum: 0, secondNum: 7)) > 3 {
                    let collectable = collectableController.getCollectable()
                    if (collectable != nil) {
                        collectable?.position = CGPoint(x: clouds[i].position.x, y: clouds[i].position.y + 60)
                        scene.addChild(collectable!)
                    }
                }
            }
            
            scene.addChild(clouds[i])
            positionY -= distanceBetweenClouds // move cloud down to next posisition
            lastCloudsPositionY = positionY
            
            
        }
        
    }
}
