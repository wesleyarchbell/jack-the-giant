//
//  Background.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 28/2/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

class Background: SKSpriteNode {
    
    func moveBG(camera: SKCameraNode) {
        if (self.position.y - self.size.height - 10 > camera.position.y) {
            self.position.y -= self.size.height * 3
        }
    }
    
}
