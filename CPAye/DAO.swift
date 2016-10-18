//
//  DAO.swift
//  CPAye
//
//  Created by Jo Tu on 10/18/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//
import Foundation

class DAO: NSObject{
    
    
    static let sharedInstance = DAO()
    
    var questions :[MultipleChoice] = []
    var currentQuestion : MultipleChoice = MultipleChoice(question: "", a: "", b: "", c: "", d: "", correctAnswer: "", info: "")
    
    
    
    override init(){
        super.init()
        
        let question1 = MultipleChoice(question: "which animal can swim?", a: "dog", b: "cat", c: "fish", d: "giraffe", correctAnswer: "c", info: "only the fish can swim! the other animals are land animals!")
        
        let question2 = MultipleChoice(question: "which animal can jump?", a: "dog", b: "turtle", c: "fish", d: "hippo", correctAnswer: "c", info: "only the dog can jump!")
        let question3 = MultipleChoice(question: "which animal can bark?", a: "dog", b: "cat", c: "fish", d: "giraffe", correctAnswer: "c", info: "only the dog can bark!")
        
        let question4 = MultipleChoice(question: "which animal is nocturnal?", a: "owl", b: "giraffe", c: "dog", d: "cat", correctAnswer: "c", info: "only the owl is nocturnal!")
        
        

        questions.append(question1)
        questions.append(question2)
        questions.append(question3)
        questions.append(question4)
        self.currentQuestion = questions[0]
}

}