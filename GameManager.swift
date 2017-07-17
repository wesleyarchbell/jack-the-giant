//
//  GameManager.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 5/7/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import Foundation

class GameManager {
    
    static let instance = GameManager()
    
    public var gameData: GameData?
    
    private init() {}
    
    var gameStartedFromMainMenu = false
    var gameRestartedFromPlayerDying = false
    
    
    
}
