//
//  MainMenuScene.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 28/6/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    fileprivate var musicButton: SKSpriteNode?
    fileprivate var musicOn = SKTexture(imageNamed: "Music On Button")
    fileprivate var musicOff = SKTexture(imageNamed: "Music Off Button")
    
    override func didMove(to view: SKView) {
        GameManager.instance.initGameData()
        AudioManager.instance.playMusic()
        
        self.musicButton = childNode(withName: "MusicButton") as! SKSpriteNode!
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
            } else if node.name == "MusicButton" {
                handleMusicToggle()
            }
        }
    }
    
    func handleMusicToggle() {
        if (GameManager.instance.gameData?.musicOn)! {
            GameManager.instance.gameData?.musicOn = false
            self.musicButton?.texture = self.musicOff
            AudioManager.instance.stopMusic()
        } else {
            GameManager.instance.gameData?.musicOn = true
            self.musicButton?.texture = self.musicOn
            AudioManager.instance.playMusic()
        }
        GameManager.instance.saveData()
    }
    
    func showScene(scene: SKScene) {
        scene.scaleMode = SKSceneScaleMode.aspectFill
        view?.presentScene(scene, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
    }
    
}
