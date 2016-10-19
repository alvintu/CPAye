//
//  MultipleChoice.swift
//  CPAye
//
//  Created by Jo Tu on 10/16/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//

import UIKit

class MultipleChoice: NSObject {
    
    var question  : String
    var a  : String
    var b  : String
    var c  : String
    var d  : String
    var correctAnswer : String
    var info : String

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
