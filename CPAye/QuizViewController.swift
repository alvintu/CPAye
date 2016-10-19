//
//  QuizViewController.swift
//  CPAye
//
//  Created by Jo Tu on 10/18/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//

import UIKit
import Foundation

class QuizViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    let dao = DAO.sharedInstance;

    
    override func viewDidLoad() {
        
        print("quiz");
        print("\(dao.questions.count) is the number of questions")
        

//        currentQuestionLabel.text = dao.currentQuestion.question
//        answerALabel.text = dao.currentQuestion.a
//        answerBLabel.text = dao.currentQuestion.b
//        answerCLabel.text = dao.currentQuestion.c
//        answerDLabel.text = dao.currentQuestion.d
//
        
    }
    
    //tableview delegate methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("quizCell", forIndexPath: indexPath) as! QuizCell
        cell.selectionStyle = UITableViewCellSelectionStyle.Default
        
        switch indexPath {
        case NSIndexPath(forRow: 0, inSection: 0) :
            //cell.titleLabel.text = "\(currentShop.categoryDeal) - 09/12/2016 - Hunter College" //specifics later

            cell.questionInfoLabel.text = dao.currentQuestion.question
            
        case NSIndexPath(forRow: 1, inSection: 0) :
            cell.questionInfoLabel.text = dao.currentQuestion.a
    
        case NSIndexPath(forRow: 2, inSection: 0) :
            
            cell.questionInfoLabel.text = dao.currentQuestion.b
        case NSIndexPath(forRow: 3, inSection: 0) :
            
            cell.questionInfoLabel.text = dao.currentQuestion.c
            
        case NSIndexPath(forRow: 4, inSection: 0) :
            
            cell.questionInfoLabel.text = dao.currentQuestion.d
            
        default:

            cell.questionInfoLabel.text = ""
            
        }
            return cell
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        var rowHeight :CGFloat = 0.0
        
        switch indexPath {

        case NSIndexPath(forRow: 0, inSection: 0) :
        //cell.titleLabel.text = "\(currentShop.categoryDeal) - 09/12/2016 - Hunter College" //specifics later
        rowHeight = self.view.frame.height/4
        case NSIndexPath(forRow: 1, inSection: 0) :
        rowHeight = self.view.frame.height/8

        
        case NSIndexPath(forRow: 2, inSection: 0) :
        
            rowHeight = self.view.frame.height/8
        case NSIndexPath(forRow: 3, inSection: 0) :
        
            rowHeight = self.view.frame.height/8
        
        case NSIndexPath(forRow: 4, inSection: 0) :
        
            rowHeight = self.view.frame.height/8
        
        default:
        
            rowHeight = self.view.frame.height/8
        
    }
    
        return rowHeight
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.redColor()


        switch indexPath {
            //cell.titleLabel.text = "\(currentShop.categoryDeal) - 09/12/2016 - Hunter College" //specifics later
            
            
        case NSIndexPath(forRow: 1, inSection: 0) :

            
            
                    if(dao.currentQuestion.correctAnswer == "a"){
                        UIView.animateWithDuration(0.5, animations: {
                            selectedCell.contentView.backgroundColor = UIColor.whiteColor()

                        selectedCell.contentView.backgroundColor = UIColor.greenColor()
                        })


                    print("correct")
                    
                    }
                    else{
                        print("incorrect")
                        UIView.animateWithDuration(0.5, animations: {
                            selectedCell.contentView.backgroundColor = UIColor.whiteColor()

                            selectedCell.contentView.backgroundColor = UIColor.redColor()
                        })
                    }
            
            
        case NSIndexPath(forRow: 2, inSection: 0) :
        
                if(dao.currentQuestion.correctAnswer == "b"){
                    UIView.animateWithDuration(0.5, animations: {
                        selectedCell.contentView.backgroundColor = UIColor.whiteColor()
                        
                        selectedCell.contentView.backgroundColor = UIColor.greenColor()
                    })
                    
                    
                    print("correct")
                    
                }
                else{
                    print("incorrect")
                    UIView.animateWithDuration(0.5, animations: {
                        selectedCell.contentView.backgroundColor = UIColor.whiteColor()
                        
                        selectedCell.contentView.backgroundColor = UIColor.redColor()
                    })
            }
            
    
            
        case NSIndexPath(forRow: 3, inSection: 0) :
            
            if(dao.currentQuestion.correctAnswer == "c"){
                UIView.animateWithDuration(0.5, animations: {
                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
                    
                    selectedCell.contentView.backgroundColor = UIColor.greenColor()
                })
                
                
                print("correct")
                
            }
            else{
                print("incorrect")
                UIView.animateWithDuration(0.5, animations: {
                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
                    
                    selectedCell.contentView.backgroundColor = UIColor.greenColor()
                })
                
                
                print("correct")
                
                
            }
        case NSIndexPath(forRow: 4, inSection: 0) :
            
            if(dao.currentQuestion.correctAnswer == "d"){
                UIView.animateWithDuration(0.5, animations: {
                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
                    
                    selectedCell.contentView.backgroundColor = UIColor.greenColor()
                })
                
                
                print("correct")
                
            }
            else{
                print("incorrect")
                UIView.animateWithDuration(0.5, animations: {
                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
                    
                    selectedCell.contentView.backgroundColor = UIColor.greenColor()
                })
                
                
            }
            
            
        default:
            
            selectedCell.contentView.backgroundColor = UIColor.whiteColor()
            
        }

    }
    
     func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cellToDeSelect:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        cellToDeSelect.contentView.backgroundColor = UIColor.whiteColor()
    }

    
    override func didReceiveMemoryWarning() {
        
    }
    
    
    //when a wrong answer is clicked, indicate it is wrong
    //and open up an info bar in the cell
    //allow them go next
    
    //when a correct answer is clicked
    //also open up info bar in cell
    //indicate if they want to go next
    
    
    //do a scramble of all questions
    
    //core data with swift
    //later
    
    

//    
//    @IBAction func nextButtonPressed(sender: AnyObject) {
//        
//        let currentQuestionIndex = dao.questions.indexOf(dao.currentQuestion)
//        let nextQuestionIndex = currentQuestionIndex! + 1
//        
//        let lastObject = dao.questions.last
//        let lastQuestionIndex = dao.questions.indexOf(lastObject!)
//        
//        if(currentQuestionIndex < lastQuestionIndex){
//        
//        dao.currentQuestion = dao.questions[nextQuestionIndex]
//        
//        
//        currentQuestionLabel.text = dao.currentQuestion.question
//        answerALabel.text = dao.currentQuestion.a
//        answerBLabel.text = dao.currentQuestion.b
//        answerCLabel.text = dao.currentQuestion.c
//        answerDLabel.text = dao.currentQuestion.d
//        }
//        else{
//            view.backgroundColor = UIColor.blackColor()
//            
//            currentQuestionLabel.text = "End of Quiz!"
//            currentQuestionLabel.textColor = UIColor.whiteColor()
//
//        }
//        
//        
//    }
//    
    func quizLogic(){
        //question1
        //wenderlich once
    }
    
}
