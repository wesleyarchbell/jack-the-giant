//
//  HighScoreScene.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 29/6/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

class HighScoreScene: SKScene {
    
    private var scoreLabel: SKLabelNode?
    private var coinLabel: SKLabelNode?
    
    override func didMove(to view: SKView) {
        self.scoreLabel = self.childNode(withName: "ScoreLabel") as? SKLabelNode!
        self.coinLabel = self.childNode(withName: "CoinLabel") as? SKLabelNode!
        setScore()
    }
    
    private func setScore() {
        if (GameManager.instance.gameData?.easyDifficultySetting)! {
            self.scoreLabel?.text = String(describing: GameManager.instance.gameData?.easyDifficultyScore)
            self.coinLabel?.text = String(describing: GameManager.instance.gameData?.easyDifficultyCoinScore)
        } else if (GameManager.instance.gameData?.mediumDifficultySetting)! {
            self.scoreLabel?.text = String(describing: GameManager.instance.gameData?.mediumDifficultyScore)
            self.coinLabel?.text = String(describing: GameManager.instance.gameData?.mediumDifficultyCoinScore)
        } else if (GameManager.instance.gameData?.hardDifficultySetting)! {
            self.scoreLabel?.text = String(describing: GameManager.instance.gameData?.hardDifficultyScore)
            self.coinLabel?.text = String(describing: GameManager.instance.gameData?.hardDifficultyCoinScore)
        }
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
