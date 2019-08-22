//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Igor Melo on 21/08/19.
//  Copyright © 2019 Igor Melo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let ballArray: Array = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    var randomBall: Int = 0

    @IBOutlet weak var image_ball: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateAnswers()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        generateAnswers()
    }
    
    @IBAction func button_ask(_ sender: UIButton) {
        generateAnswers()
    }
    
    private func generateAnswers() {
        randomBall = Int.random(in: 0...4)
        image_ball.image = UIImage(named: ballArray[randomBall])
    }
    
}

