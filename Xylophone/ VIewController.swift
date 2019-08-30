//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate{
    
    let notesArray: Array = ["note1", "note2", "note3", "note4", "note5", "note6", "note7"]
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func notePressed(_ sender: UIButton) {
        let sound = notesArray[sender.tag - 1]
        playSound(soundToBePlayed: sound)
    }
    
    func playSound(soundToBePlayed sound: String) {
        let soundUrl = Bundle.main.url(forResource: sound, withExtension: "wav")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl!)
        } catch {
            print(error)
        }
        
        audioPlayer.play()
    }
}
