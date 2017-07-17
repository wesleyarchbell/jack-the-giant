//
//  MainMenuScene.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 28/6/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        GameManager.instance.initGameData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = nodes(at: location)[0]
            if node.name == "StartGameButton" {
                GameManager.instance.gameStartedFromMainMenu = true
                showScene(scene: GameplayScene(fileNamed: "GameplayScene")!)
            } else if node.name == "HighScoreButton" {
                showScene(scene: HighScoreScene(fileNamed: "HighScoreScene")!)
            } else if node.name == "OptionsButton" {
                showScene(scene: OptionScene(fileNamed: "OptionScene")!)
            }
        }
    }
    
    func showScene(scene: SKScene) {
        scene.scaleMode = SKSceneScaleMode.aspectFill
        self.view?.presentScene(scene, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
    }
    
}

