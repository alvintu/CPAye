//
//  MultipleChoice.swift
//  CPAye
//
//  Created by Jo Tu on 10/16/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//

import UIKit

class MultipleChoice: NSObject {
    
    let question  : String
    let a  : String
    let b  : String
    let c  : String
    let d  : String
    let correctAnswer : String
    let info : String


    
    init(question:String,a:String,b:String,c:String,d:String,correctAnswer:String,info:String) {
        
        self.question = question
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.correctAnswer = correctAnswer
        self.info = info

    }

}
