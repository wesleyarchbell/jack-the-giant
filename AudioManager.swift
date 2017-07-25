//
//  AudioManager.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 25/7/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import AVFoundation

class AudioManager {
    
    static let instance = AudioManager()
    private init() {}
    
    private var audioPlayer: AVAudioPlayer?
    
    func playMusic() {
        
        if audioPlayer != nil {
            audioPlayer?.play()
        } else {
            
            let url = Bundle.main.url(forResource: "Background music", withExtension: "mp3")
            
            do {
                
                try audioPlayer = AVAudioPlayer(contentsOf: url!)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                
            } catch let err as NSError {
                print("Failed to play bg muisc: \(err.description)")
            }
        }
        
    }
    
    func stopMusic() {
        if (audioPlayer?.isPlaying)! {
            audioPlayer?.stop()
        }
    }
    
}
