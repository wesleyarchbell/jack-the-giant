//
//  HighScoreScene.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 29/6/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

class HighScoreScene: SKScene {
    
    override func didMove(to view: SKView) {
        
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
