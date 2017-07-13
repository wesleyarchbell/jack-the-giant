//
//  GameData.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 13/7/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import Foundation

func ==(lhs: DifficultyType, rhs: DifficultyType) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

struct DifficultyType: Hashable {
    static let Easy: UInt32 = 0
    static let Medium: UInt32 = 1
    static let Hard: UInt32 = 2
    public var hashValue: Int {
        return self.hashValue
    }
}


class GameData {
    
    public var difficultyScores: [DifficultyType:Int] = [:]
    public var difficultyCoinScores: [DifficultyType:Int] = [:]
    public var difficultySetting: [DifficultyType:Bool] = [:]
    public var musicOn = false
    
    func getScore(difficulty: DifficultyType) -> Int {
        return self.difficultyScores[difficulty]!
    }
    
    func setScore(difficulty: DifficultyType, score: Int) {
        self.difficultyScores[difficulty] = score
    }
    
    func getCoinScore(difficulty: DifficultyType) -> Int {
        return self.difficultyCoinScores[difficulty]!
    }
    
    func setCoinScore(difficulty: DifficultyType, score: Int) {
        self.difficultyCoinScores[difficulty] = score
    }
    
    func isDifficultySet(difficulty: DifficultyType) -> Bool {
        return self.difficultySetting[difficulty]!
    }
    
    func setDifficulty(difficulty: DifficultyType, on: Bool) {
        self.difficultySetting[difficulty] = on
    }
    
    func isMusicOn() -> Bool {
        return self.musicOn
    }
    
    func setMusicOn(on: Bool) {
        self.musicOn = on
    }
}

