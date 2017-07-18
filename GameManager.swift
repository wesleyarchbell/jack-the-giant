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
    
    public func initGameData() {
        if !FileManager.default.fileExists(atPath: getFilePath()) {
            self.gameData = GameData()
            self.gameData?.easyDifficultyScore = 0
            self.gameData?.mediumDifficultyScore = 0
            self.gameData?.hardDifficultyScore = 0
            self.gameData?.easyDifficultyCoinScore = 0
            self.gameData?.mediumDifficultyCoinScore = 0
            self.gameData?.hardDifficultyCoinScore = 0
            self.gameData?.easyDifficultySetting = false
            self.gameData?.mediumDifficultySetting = true
            self.gameData?.hardDifficultySetting = false
            self.gameData?.musicOn = true
            saveData()
        }
        loadData()
    }
    
    public func loadData() {
        self.gameData = NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath()) as? GameData
    }
    
    public func saveData() {
        if let gameDataObj = self.gameData {
            NSKeyedArchiver.archiveRootObject(gameDataObj, toFile: getFilePath())
        }
    }
    
    private func getFilePath() -> String {
        let url = FileManager.default.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first as URL!
        let gameDataPath = url!.appendingPathComponent("Game Data").path
        print("Game data path: \(gameDataPath)")
        return gameDataPath
    }
    
    var gameStartedFromMainMenu = false
    var gameRestartedFromPlayerDying = false
    
    
    
}
