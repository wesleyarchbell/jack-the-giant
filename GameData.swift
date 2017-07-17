//
//  GameData.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 13/7/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import Foundation

class GameData: NSCoder {
    
    private var _easyDifficultyScore: Int32?
    private var _mediumDifficultyScore: Int32?
    private var _hardDifficultyScore: Int32?
    
    private var _easyDifficultyCoinScore: Int32?
    private var _mediumDifficultyCoinScore: Int32?
    private var _hardDifficultyCoinScore: Int32?
    
    private var _easyDifficultySetting: Bool?
    private var _mediumDifficultySetting: Bool?
    private var _hardDifficultySetting: Bool?
    
    private var _musicOn = false
    
    override init() {}
    
    convenience init?(coder aDecoder: NSCoder) {
       self.init()
       print("Decoding game data...")
    }
    
    func encode(with aCoder: NSCoder) {
        print("Encoding values...")
        
    }
    
    var easyDifficultyScore: Int32 {
        get {
            return _easyDifficultyScore!
        }
        set {
            _easyDifficultyScore = newValue
        }
    }
    
    var mediumDifficultyScore: Int32 {
        get {
            return _mediumDifficultyScore!
        }
        set {
            _mediumDifficultyScore = newValue
        }
    }

    var hardDifficultyScore: Int32 {
        get {
            return _hardDifficultyScore!
        }
        set {
            _hardDifficultyScore = newValue
        }
    }
    
    var easyDifficultyCoinScore: Int32 {
        get {
            return _easyDifficultyCoinScore!
        }
        set {
            _easyDifficultyCoinScore = newValue
        }
    }
    
    var mediumDifficultyCoinScore: Int32 {
        get {
            return _mediumDifficultyCoinScore!
        }
        set {
            _mediumDifficultyCoinScore = newValue
        }
    }
    
    var hardDifficultyCoinScore: Int32 {
        get {
            return _hardDifficultyCoinScore!
        }
        set {
            _hardDifficultyCoinScore = newValue
        }
    }
    
    var easyDifficultySetting: Bool {
        get {
            return _easyDifficultySetting!
        }
        set {
            _easyDifficultySetting = newValue
        }
    }
    
    var mediumDifficultySetting: Bool {
        get {
            return _mediumDifficultySetting!
        }
        set {
            _mediumDifficultySetting = newValue
        }
    }
    
    var hardDifficultySetting: Bool {
        get {
            return _hardDifficultySetting!
        }
        set {
            _hardDifficultySetting = newValue
        }
    }
    
    var musicSetting: Bool {
        get {
            return _musicOn
        }
        set {
            _musicOn = newValue
        }
    }
    
    
}

