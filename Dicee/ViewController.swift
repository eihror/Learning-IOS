//
//  ViewController.swift
//  Dicee
//
//  Created by Igor Melo on 20/08/19.
//  Copyright © 2019 Igor Melo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dices: Array = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    var dice_one_index: Int = 0
    var dice_two_index: Int = 0

    @IBOutlet weak var diceOne: UIImageView!
    @IBOutlet weak var diceTwo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDices()
    }

    @IBAction func rollDices(_ sender: UIButton) {
        updateDices()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDices()
    }

    private func updateDices(){
        dice_one_index = Int.random(in: 0 ... 5)
        dice_two_index = Int.random(in: 0 ... 5)
        
        diceOne.image = UIImage(named: dices[dice_one_index])
        diceTwo.image = UIImage(named: dices[dice_two_index])
    }
    
}

