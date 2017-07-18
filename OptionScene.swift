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
        initVariables()
        setTickPosition()
    }
    
    private func initVariables() {
        self.easyButton = self.childNode(withName: "EasyButton") as? SKSpriteNode!
        self.mediumButton = self.childNode(withName: "MediumButton") as? SKSpriteNode!
        self.hardButton = self.childNode(withName: "HardButton") as? SKSpriteNode!
        self.tick = self.childNode(withName: "Tick") as? SKSpriteNode!
    }
    
    private func setTickPosition() {
        if (GameManager.instance.gameData?.easyDifficultySetting)! {
            self.tick?.position.y = (self.easyButton?.position.y)!
        } else if (GameManager.instance.gameData?.mediumDifficultySetting)! {
            self.tick?.position.y = (self.mediumButton?.position.y)!
        } else if (GameManager.instance.gameData?.hardDifficultySetting)! {
            self.tick?.position.y = (self.hardButton?.position.y)!
        }
    }
    
    private func setDifficulty(option: String) {
        switch option {
        case "easy" :
            GameManager.instance.gameData?.easyDifficultySetting = true
            GameManager.instance.gameData?.mediumDifficultySetting = false
            GameManager.instance.gameData?.hardDifficultySetting = false
            break
        case "medium" :
            GameManager.instance.gameData?.easyDifficultySetting = false
            GameManager.instance.gameData?.mediumDifficultySetting = true
            GameManager.instance.gameData?.hardDifficultySetting = false
            break
        case "hard" :
            GameManager.instance.gameData?.easyDifficultySetting = false
            GameManager.instance.gameData?.mediumDifficultySetting = false
            GameManager.instance.gameData?.hardDifficultySetting = true
            break
        default :
            break
        }
        GameManager.instance.saveData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = nodes(at: location)[0]
            
            if node == self.easyButton {
                self.tick?.position.y = (self.easyButton?.position.y)!
                self.setDifficulty(option: "easy")
            } else if node == self.mediumButton {
                self.tick?.position.y = (self.mediumButton?.position.y)!
                self.setDifficulty(option: "medium")
            } else if node == self.hardButton {
                self.tick?.position.y = (self.hardButton?.position.y)!
                self.setDifficulty(option: "hard")
            }
            
            if node.name == "BackButton" {
                let mainMenuScene = MainMenuScene(fileNamed: "MainMenuScene")
                mainMenuScene?.scaleMode = SKSceneScaleMode.aspectFill
                self.view?.presentScene(mainMenuScene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
            }
        }
    }
    
}
