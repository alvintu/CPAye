//
//  QuizViewController.swift
//  CPAye
//
//  Created by Jo Tu on 10/18/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//

import UIKit
import Foundation

class QuizViewController: UIViewController {
    
    let dao = DAO.sharedInstance;

    
    @IBOutlet weak var currentQuestionLabel: UILabel!

    @IBOutlet weak var answerDLabel: UILabel!
    @IBOutlet weak var answerCLabel: UILabel!
    @IBOutlet weak var answerBLabel: UILabel!
    @IBOutlet weak var answerALabel: UILabel!
    override func viewDidLoad() {
        
        print("quiz");
        print("\(dao.questions.count) is the number of questions")
        

        currentQuestionLabel.text = dao.currentQuestion.question
        answerALabel.text = dao.currentQuestion.a
        answerBLabel.text = dao.currentQuestion.b
        answerCLabel.text = dao.currentQuestion.c
        answerDLabel.text = dao.currentQuestion.d

        
    }

    
    override func didReceiveMemoryWarning() {
        
    }
    
    
    @IBAction func answerAClicked(sender: AnyObject) {
        
        if(dao.currentQuestion.correctAnswer == "a"){
        
        print("correct")
        }
        else{
            print("incorrect")
        }
    }
    
    
    @IBAction func answerBClicked(sender: AnyObject) {
        
        if(dao.currentQuestion.correctAnswer == "b"){
            
            print("correct")
        }
        else{
            print("incorrect")
        }

    }
    
    @IBAction func answerCClicked(sender: AnyObject) {
        
        if(dao.currentQuestion.correctAnswer == "c"){
            
            print("correct")
        }
        else{
            print("incorrect")
        }

    }
    
    @IBAction func answerDClicked(sender: AnyObject) {
        
        if(dao.currentQuestion.correctAnswer == "d"){
            
            print("correct")
        }
        else{
            print("incorrect")
        }
    }
    
    
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        
        let currentQuestionIndex = dao.questions.indexOf(dao.currentQuestion)
        let nextQuestionIndex = currentQuestionIndex! + 1
        
        let lastObject = dao.questions.last
        let lastQuestionIndex = dao.questions.indexOf(lastObject!)
        
        if(currentQuestionIndex < lastQuestionIndex){
        
        dao.currentQuestion = dao.questions[nextQuestionIndex]
        
        
        currentQuestionLabel.text = dao.currentQuestion.question
        answerALabel.text = dao.currentQuestion.a
        answerBLabel.text = dao.currentQuestion.b
        answerCLabel.text = dao.currentQuestion.c
        answerDLabel.text = dao.currentQuestion.d
        }
        else{
            view.backgroundColor = UIColor.blackColor()
            
            currentQuestionLabel.text = "End of Quiz!"
            currentQuestionLabel.textColor = UIColor.whiteColor()

            answerALabel.removeFromSuperview()
            answerBLabel.removeFromSuperview()
            answerALabel.removeFromSuperview()
            answerALabel.removeFromSuperview()

        }
        
        
    }
    
    func quizLogic(){
        //question1
        //wenderlich once
    }
    
}
