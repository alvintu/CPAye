//
//  DAO.swift
//  CPAye
//
//  Created by Jo Tu on 10/18/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//
import Foundation
import GameplayKit


class DAO: NSObject{
    
    
    
    static let sharedInstance = DAO()
    let prefs = UserDefaults.standard

    
    var questions :[MultipleChoice] = []
    var currentQuestion : MultipleChoice = MultipleChoice(question: "", a: "", b: "", c: "", d: "", correctAnswer: "", info: "")
    
    
    var flashCards : [FlashCardClass] = []
    var currentFlashCard : FlashCardClass = FlashCardClass.init(concept: "",definition: "")
    
    
    
    
    override init(){
        super.init()
        
        
        self.loadQuestions()
        self.currentQuestion = questions[0]
        
        
        self.loadFlashCards()
        self.currentFlashCard = flashCards[0]

        
        
        
}
    
    
    func loadFlashCards(){
        
        let flashCard1 = FlashCardClass.init(concept: "IFRS Qualitative characteristics of Financial Statement", definition:"1)Understandability2) Relevance3) Reliability4) Comparability")
        
        let flashCard2 = FlashCardClass.init(concept: "accounting defintion 2", definition: "accounting definition 2")
        
        let flashCard3 = FlashCardClass.init(concept: "10 Basic Elements of Financial Statement", definition: "1) Assets; 2) Liabilities; 3) Equity; 4) Revenues; 5) Expenses 6) Gains (losses); 7) Accrual accounting; 8) Investments by owners; 9) Distributions to owners; 10) Comprehensiveincome")
        
        
        
        let flashCard4 = FlashCardClass.init(concept: "Characteristics of Useful Information", definition: "Relevance, Reliability")
        
        
        
        let flashCard5 = FlashCardClass.init(concept: "Pervasive Constraint", definition: "Cost/Benefit constraint")
        
        
        

        
    
        
        flashCards.append(flashCard1)
        flashCards.append(flashCard2)
        flashCards.append(flashCard3)
        flashCards.append(flashCard4)
        flashCards.append(flashCard5)


        
    }


    
    func loadQuestions(){
        let question1 = MultipleChoice(question: "The enhancing qualitative characteristics of financial reporting are", a: "Relevance, reliability, and faithful representation", b: "Cost-Benefit and Materiality", c: "Comparability,Understandability, Timeliness, and Verifibiilty", d: "Completeness, neutrality, and free from error", correctAnswer: "c", info: "The enhancing qualitative characteristics of financial reporting are copmarability, timeliness, understandability, and verifibility.")
        
        let question2 = MultipleChoice(question: "According to Statements of Financial Accounting Concepts, neutrality is an ingredient of ", a: "Faithful Representation- YES, Relevance- YES", b: "Faithful Representation- YES, Relevance- NO", c: "Faithful Representation- NO, Relevance- YES", d: "Faithful Representation- NO, Relevance- NO", correctAnswer: "b", info: "Faithful represntation consists of Free from Error,Neutrality, and Completeness.")
        
        let question3 = MultipleChoice(question: "According to the FASB conceptual framework, which of the following is an enhancing quality that relates to both relevance and faith representation",a:"Comparability",b:"Confirmatory Value", c: "Predicative Value", d: "Neutrality", correctAnswer: "a", info: "The enhancing qualitative characteristics of financial reporting are comparability, timeliness, understandability, and verifibility.")
        
        let question4 = MultipleChoice(question: "According to the FASB conceptual framework, the process of reporting an item in the financial statements of an entity is ", a:"Allocation", b: "Matching", c: "Realization", d: "Recognition", correctAnswer: "d", info: "Recognition is the process of reporting an item on the financial statements")
        
        let question5 = MultipleChoice(question: "According to the FASB conceptual framework, which of the following is an essential characteristic of an asset?", a: "The asset is tangible", b: "An asset is obtained at a cost", c: "The claims to an asset's benefit are legally enforceable", d: "An asset provides a future benefit", correctAnswer: "d", info: "Recognition is the process of reporting an item on the financial statements")
        
        let question6 = MultipleChoice(question: "Which of the following is not a valuation technique used to measure or estimate fair value?", a: "Income approach", b: "Asset Creation Approach", c: "Market Approach", d: "Cost Approach", correctAnswer: "b", info: "There are 3 approaches to measure fair value, the market approach, income approach, and cost approach.")
        
        let question7 = MultipleChoice(question: "According to the IASB Framework, the qualitative characteristic of relevance includes:", a: "Comfirmatory Value, Predictive Value, and Comparability", b: "Free from error,Neutrality, and Completeness", c: "Predictive Value, Confirmatory Value, and Materiality", d: "Neutrality, Copmleteness, and Comparability", correctAnswer: "c", info: "The qualitative charactertics for Relevance under IASB Framework are Predictive Value, Confirmatory Value, and Materiality, which is very similar under the FASB Conceptual framework.")
        
        let question8 = MultipleChoice(question: "According to the IASB Framework, the financial statement element that is defined as \"a present obligation of the entity arising from past events, the settlement of which is expected to result in an outflow form the entity\", is which of the following", a: "Equity", b: "Liability", c: "Expense", d: "Cost", correctAnswer: "b", info: "According to the IASB Framework, there are 5 elements that make up the financial statements, they include: asset, liability, equity, income, and expense.")
        
        
        questions.append(question1)
        questions.append(question2)
        questions.append(question3)
        questions.append(question4)
        questions.append(question5)
        questions.append(question6)
        questions.append(question7)
        questions.append(question8)


        

    }
    
    
    func shuffleQuestons() {
        questions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: questions) as! [MultipleChoice]
        
        //this method is not being used
        //it properly shuffles but because nsuserdefaults cannot store custom objects like an array full of custom objects
        //implemented is still possible just takes some work with nscoding
    }
    

}
