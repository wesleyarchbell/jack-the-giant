//
//  GameplayController.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 5/7/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import Foundation
import SpriteKit

class GameplayController {
    
    static let instance = GameplayController()
    private init() {}
    
    var lifeLabel: SKLabelNode?
    var coinLabel: SKLabelNode?
    var scoreLabel: SKLabelNode?
    
    var life: Int?
    var coins: Int?
    var score: Int?
    
    func initGameplayController() {
        
        if GameManager.instance.gameStartedFromMainMenu {
            GameManager.instance.gameStartedFromMainMenu = false
            life = 2
            coins = 0
            score = 0
            updateLabels()
        } else if GameManager.instance.gameRestartedFromPlayerDying {
            GameManager.instance.gameRestartedFromPlayerDying = false
            updateLabels()
        }
        
    }
    
    func updateLabels() {
        lifeLabel!.text = "x\(life!)"
        coinLabel!.text = "x\(coins!)"
        scoreLabel!.text = "\(score!)"
    }
    
}
