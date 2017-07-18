//
//  GameData.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 13/7/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import Foundation

class GameData: NSObject, NSCoding {
    
    struct Keys {
        static let EasyDifficultyScore = "EasyDifficultyScore";
        static let MediumDifficultyScore = "MediumDifficultyScore";
        static let HardDifficultyScore = "HardDifficultyScore";
        
        static let EasyDifficultyCoinScore = "EasyDifficultyCoinScore";
        static let MediumDifficultyCoinScore = "MediumDifficultyCoinScore";
        static let HardDifficultyCoinScore = "HardDifficultyCoinScore";
        
        static let EasyDifficulty = "EasyDifficulty";
        static let MediumDifficulty = "MediumDifficulty";
        static let HardDifficulty = "HardDifficulty";
        
        static let Music = "Music";
    }
    
    public var easyDifficultyScore = Int32()
    public var mediumDifficultyScore = Int32()
    public var hardDifficultyScore = Int32()
    
    public var easyDifficultyCoinScore = Int32()
    public var mediumDifficultyCoinScore = Int32()
    public var hardDifficultyCoinScore = Int32()
    
    public var easyDifficultySetting = false
    public var mediumDifficultySetting = true
    public var hardDifficultySetting = false
    
    public var musicOn = false
    
    override init() {}
    
    
    required init?(coder aDecoder: NSCoder) {
        print("Decoding game data...")
        
        self.easyDifficultyScore = aDecoder.decodeInt32(forKey: Keys.EasyDifficultyScore)
        self.mediumDifficultyScore = aDecoder.decodeInt32(forKey: Keys.MediumDifficultyScore)
        self.hardDifficultyScore = aDecoder.decodeInt32(forKey: Keys.HardDifficultyScore)
        self.easyDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.EasyDifficultyCoinScore)
        self.mediumDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.MediumDifficultyCoinScore)
        self.hardDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.HardDifficultyCoinScore)
        self.easyDifficultySetting = aDecoder.decodeBool(forKey: Keys.EasyDifficulty)
        self.mediumDifficultySetting = aDecoder.decodeBool(forKey: Keys.MediumDifficulty)
        self.hardDifficultySetting = aDecoder.decodeBool(forKey: Keys.HardDifficulty)
        self.musicOn = aDecoder.decodeBool(forKey: Keys.Music)
    }
    
    func encode(with aCoder: NSCoder) {
        print("Encoding game data...")
        aCoder.encode(self.easyDifficultyScore, forKey: Keys.EasyDifficultyScore)
        aCoder.encode(self.mediumDifficultyScore, forKey: Keys.MediumDifficultyScore)
        aCoder.encode(self.hardDifficultyScore, forKey: Keys.HardDifficultyScore)
        aCoder.encode(self.easyDifficultyCoinScore, forKey: Keys.EasyDifficultyCoinScore)
        aCoder.encode(self.mediumDifficultyCoinScore, forKey: Keys.MediumDifficultyCoinScore)
        aCoder.encode(self.hardDifficultyCoinScore, forKey: Keys.HardDifficultyCoinScore)
        aCoder.encode(self.easyDifficultySetting, forKey: Keys.EasyDifficulty)
        aCoder.encode(self.mediumDifficultySetting, forKey: Keys.MediumDifficulty)
        aCoder.encode(self.hardDifficultySetting, forKey: Keys.HardDifficulty)
        aCoder.encode(self.musicOn, forKey: Keys.Music)
    }
}

