//
//  OptionScene.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 29/6/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

class OptionScene: SKScene {
    
    private var easyButton: SKSpriteNode?
    private var mediumButton: SKSpriteNode?
    private var hardButton: SKSpriteNode?
    private var tick: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
    }
    
    private func initVariables() {
        self.easyButton = self.childNode(withName: "EasyButton") as? SKSpriteNode!
        self.mediumButton = self.childNode(withName: "MediumButton") as? SKSpriteNode!
        self.hardButton = self.childNode(withName: "HardButton") as? SKSpriteNode!
        self.tick = self.childNode(withName: "Tick") as? SKSpriteNode!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if nodes(at: location)[0].name == "BackButton" {
                let mainMenuScene = MainMenuScene(fileNamed: "MainMenuScene")
                mainMenuScene?.scaleMode = SKSceneScaleMode.aspectFill
                self.view?.presentScene(mainMenuScene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
            }
        }
    }
    
}
