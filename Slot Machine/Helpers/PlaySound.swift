//
//  PlaySound.swift
//  Slot Machine
//
//  Created by Ivan Romero on 19/02/2024.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(soundName: String, type: String) {
    if let path = Bundle.main.path(forResource: soundName, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:  URL(filePath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}
