//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber: Int = 0
    var actualQuestion: Question? = nil
    var score : Int = 0
    var countQuestion: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countQuestion = allQuestions.list.count
        updateUI()
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        pickedAnswer = sender.tag == 1 ? true : false
        checkAnswer()
    }
    
    func updateUI() {
        if questionNumber <= 12 {
            actualQuestion = allQuestions.list[questionNumber]
            questionLabel.text = actualQuestion!.questionText
        } else {
            showAlert(title: "Awesome", message: "You've finished all the questions, do you want to start over?")
        }
        
        if questionNumber < countQuestion {
            scoreLabel.text = "Score: \(score)"
            progressLabel.text = "\(questionNumber+1)/\(countQuestion)"
        }
        
        let viewSize = view.frame.size.width
        progressBar.frame.size.width = (viewSize / CGFloat(countQuestion)) * CGFloat(questionNumber+1)
    }
    

    func nextQuestion() {
        questionNumber += 1
        updateUI()
    }
    
    
    func checkAnswer() {
        let correctAnswer = actualQuestion!.answer
        score = pickedAnswer == correctAnswer ? score + 1 : score - 1
        nextQuestion()
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        updateUI()
    }
    
    private func showAlert(title titleOfAlert: String, message messageOfAlert: String){
        let alert = UIAlertController(title: titleOfAlert, message: messageOfAlert, preferredStyle: .alert)
        
        let restartAction = UIAlertAction(
            title: "Restart",
            style: .default,
            handler: { (UIAlertAction) in
                self.startOver()
        }
        )
        
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }
    
}
