//
//  GameplayScene.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 14/2/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var mainCamera: SKCameraNode?
    var bg1: Background?
    var bg2: Background?
    var bg3: Background?
    
    var player: Player?
    
    var canMove = false
    var moveLeft = false
    var centre: CGFloat?
    
    override func didMove(to view: SKView) {
        initVariables()
    }

    func initVariables() {
        centre = (scene?.size.width)! / (scene?.size.height)!
        player = childNode(withName: "Player") as? Player
        player?.initPlayerAndAnimations()

        mainCamera = childNode(withName: "Main Camera") as? SKCameraNode
        bg1 = childNode(withName: "BG1") as? Background!
        bg2 = childNode(withName: "BG2") as? Background!
        bg3 = childNode(withName: "BG3") as? Background!
    }

    override func update(_ currentTime: TimeInterval) {
        moveCameraDown()
        managePlayer()
        manageBackgrounds()
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
    
    func moveCameraDown() {
        self.mainCamera?.position.y -= 3
    }
    
    func manageBackgrounds() {
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
    }
    
}
