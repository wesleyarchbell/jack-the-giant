//
//  CloudController.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 28/2/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

class CloudController {
    
    func createClouds() -> [SKSpriteNode] {
        
        var clouds = [SKSpriteNode]()
        for i in 0..<2 {
            clouds.append(createCloud(imageName: "Cloud 1", name: "1"))
            clouds.append(createCloud(imageName: "Cloud 2", name: "2"))
            clouds.append(createCloud(imageName: "Cloud 3", name: "3"))
            clouds.append(createCloud(imageName: "Dark Cloud", name: "Dark Cloud"))
        }
        return clouds
        
    }
    
    func createCloud(imageName: String, name: String) -> SKSpriteNode {
        let cloud = SKSpriteNode(imageNamed: imageName)
        cloud.name = name
        cloud.xScale = 0.9
        cloud.yScale = 0.9
        return cloud
        
    }
}
