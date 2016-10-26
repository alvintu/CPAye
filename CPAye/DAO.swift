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
    
    var review :[ReviewSection] = []
    var currentReviewSection : ReviewSection = ReviewSection.init(title: "", info: [])
    
    var flashCards : [FlashCardClass] = []
    var currentFlashCard : FlashCardClass = FlashCardClass.init(concept: "",definition: "")
    
    
    
    
    override init(){
        super.init()
        
        self.loadQuestions()
        self.currentQuestion = questions[0]
        
        self.loadReview()
        self.currentReviewSection = review[0]
        
        self.loadFlashCards()
        self.currentFlashCard = flashCards[0]

        
        
        
}
    
    
    func loadFlashCards(){
        
        let flashCard1 = FlashCardClass.init(concept: "accounting concept 1", definition: "accounting definition 1")
        
        let flashCard2 = FlashCardClass.init(concept: "accounting defintion 2", definition: "accounting definition 2")
    
        
        flashCards.append(flashCard1)
        flashCards.append(flashCard2)

        
    }

    
    func loadReview(){
        let review1 = ReviewSection.init(title: "Individual Taxation", info: ["can a nigga get more than two lines, can a nigga get more than 3, can a nigga get more than 4 lines?,can a nigga get more than two lines, can a nigga get more than 3, can a nigga get more than 4 lines?,can a nigga get more than two lines, can a nigga get more than 3, can a nigga get more than 4 lines?","wiasdfads hello there my name is mjr johnsonll","be","tasdkjhaskl  kdashflkashfdlha s lkfhaslf  sdalfhasljkfhaslkfjdhdalsdkfh x"])
        let review2 = ReviewSection.init(title: "Corporation Taxation", info: ["you","will","be","corporate"])
        let review3 = ReviewSection.init(title: "Estate Taxation", info: ["you","will","be","estated"])
        
        review.append(review1)

        review.append(review2)

        review.append(review3)


    }
    
    
    func loadQuestions(){
        let question1 = MultipleChoice(question: "A government makes a contribution to its pension plan in the amount of $10,000 for year 1. The actuarially-determined annual required contribution for year 1 was $13,500. The pension plan paid benefits of $8,200 and refunded employee contributions of $800 for year 1. What is the pension expenditure for the general fund for year 1?", a: "8,200", b: "9,000", c: "10,000", d: "13,500", correctAnswer: "c", info: "Because the question is about the General Fund, which uses the modified accrual basis of accounting, only the $10,000 contribution to the pension plan, which is a use of financial resources in year 1, is recognized as pension expenditure. The Pension Trust Fund would report the $10,000 received from the General Fund as an “Addition” and not as revenue.")
        
        let question2 = MultipleChoice(question: "The City of Macon maintains a defined contribution pension plan for its employees. During the year, the city contributed $5,000,000 to the plan, which represented 100% of its required contribution for the year. City employees contributed $1,800,000 to the plan. In addition, plan assets earned $4,500,000. What amount should the City report as Additions in its Pension Trust Fund?", a: "$11,300,000", b: "$9,500,000", c: "$6,800,000", d: "$4,500,000", correctAnswer: "d", info: " In addition to the actual earnings on plan assets, both employer and employee contributions are recognized as Additions in the Pension Trust Fund.")
        
        let question3 = MultipleChoice(question: "The $500,000 is to be used to create an endowment that will be invested and retained in perpetuity and the earnings used to provide college scholarships to outstanding local high school graduates selected by the Rotary Club. The City has agreed to manage the investment and disbursement of these monies on behalf of the Rotary Club. The City should account for the $500,000 corpus of the endowment in a(n):", a: "Agency Fund", b: "Private-Purpose Trust Fund", c: "Permanent Fund.", d: "Special Revenue Fund.", correctAnswer: "b", info: "A Private-Purpose Trust Fund is used to account for resources, both expendable and non-expendable, which either must be used for a non-governmental purpose or the earnings from which have to be used for a non-governmental purpose. As in this case, Private-Purpose Trust Funds usually disburse monies to individuals or organizations outside the governmental entity.")
        
        let question4 = MultipleChoice(question: "In 2005, a state government collected income taxes of $8,000,000 for the benefit of one of its cities that imposes an income tax on its residents. The state remitted these collections periodically to the city. The state should account for the $8,000,000 in the:", a: "General Fund.", b: "Agency Funds.", c: "Internal Service Funds.", d: "Special Assessment Funds", correctAnswer: "b", info: "An Agency Fund accounts for assets held by a government unit acting as an agent for individuals, private organizations, other governmental units, and/or other funds. The state government is simply acting as a collection agent for the city. It has no right to the monies collected, and simply passes the taxes collected along to the city.")
        
        
        questions.append(question1)
        questions.append(question2)
        questions.append(question3)
        questions.append(question4)

        

    }
}