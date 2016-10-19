//
//  QuizViewController.swift
//  CPAye
//
//  Created by Jo Tu on 10/18/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//

import UIKit
import Foundation

class QuizViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate{
    
    let dao = DAO.sharedInstance;
    var infoButton = UIButton()
    var nextButton = UIButton()
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        
        print("quiz");
        print("\(dao.questions.count) is the number of questions")
        

        addInfoAndNextButton()
        
    }
    
    //tableview delegate methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("quizCell", forIndexPath: indexPath) as! QuizCell
        cell.selectionStyle = UITableViewCellSelectionStyle.Default
        cell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)

        cell.questionInfoTextView.userInteractionEnabled = false
        let fixedWidth = cell.questionInfoTextView.frame.size.width
        cell.questionInfoTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = cell.questionInfoTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = cell.questionInfoTextView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        cell.questionInfoTextView.frame = newFrame;

        
        cell.questionInfoTextView.delegate = self
        
        switch indexPath {
        case NSIndexPath(forRow: 0, inSection: 0) :
    
            cell.questionInfoTextView.textColor = UIColor.blackColor()
            cell.questionInfoTextView.text = dao.currentQuestion.question
            
        case NSIndexPath(forRow: 1, inSection: 0) :
            cell.questionInfoTextView.text = dao.currentQuestion.a
    
        case NSIndexPath(forRow: 2, inSection: 0) :
            
            cell.questionInfoTextView.text = dao.currentQuestion.b
        case NSIndexPath(forRow: 3, inSection: 0) :
            
            cell.questionInfoTextView.text = dao.currentQuestion.c
            
        case NSIndexPath(forRow: 4, inSection: 0) :
            
            cell.questionInfoTextView.text = dao.currentQuestion.d
            
        default:

            cell.questionInfoTextView.text = ""
            
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
        rowHeight = self.view.frame.height/9

        
        case NSIndexPath(forRow: 2, inSection: 0) :
        
            rowHeight = self.view.frame.height/9
        case NSIndexPath(forRow: 3, inSection: 0) :
        
            rowHeight = self.view.frame.height/9
        
        case NSIndexPath(forRow: 4, inSection: 0) :
        
            rowHeight = self.view.frame.height/9
        
        default:
        
            rowHeight = self.view.frame.height/9
        
    }
    
        return rowHeight
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.redColor()
        
        let tempCell = selectedCell as! QuizCell
        
        UIView.animateWithDuration(1.0, animations: {
            
            self.infoButton.hidden = true
            self.nextButton.hidden = true


        self.infoButton.hidden = false
        self.nextButton.hidden = false

            })
        
        switch indexPath {
            //cell.titleLabel.text = "\(currentShop.categoryDeal) - 09/12/2016 - Hunter College" //specifics later
            
            
        case NSIndexPath(forRow: 0, inSection: 0) :

            selectedCell.contentView.backgroundColor = UIColor.whiteColor()

            
        case NSIndexPath(forRow: 1, inSection: 0) :

            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()

            
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
            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()

        
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
            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()

            
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
                    
                    selectedCell.contentView.backgroundColor = UIColor.redColor()
                })
                
                
                print("correct")
                
                
            }
        case NSIndexPath(forRow: 4, inSection: 0) :
            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()

            
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
                    
                    selectedCell.contentView.backgroundColor = UIColor.redColor()
                })
                
                
            }
            
            

            
        default:
            print("default")
            
//            selectedCell.contentView.backgroundColor = UIColor.whiteColor()
            
        }

    }
    
     func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cellToDeSelect:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        cellToDeSelect.contentView.backgroundColor = UIColor.whiteColor()
        
        
        
        let tempCell = cellToDeSelect as! QuizCell
        
        
        switch indexPath {
            //cell.titleLabel.text = "\(currentShop.categoryDeal) - 09/12/2016 - Hunter College" //specifics later
            
            
        case NSIndexPath(forRow: 0, inSection: 0) :
            tempCell.questionInfoTextView.textColor =  UIColor.blackColor()
        
        default:

        
        tempCell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        
        }
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
    
        
//    }
    
    
    func nextQuestion(){
        

        let currentQuestionIndex = dao.questions.indexOf(dao.currentQuestion)
        let nextQuestionIndex = currentQuestionIndex! + 1
        
        let lastObject = dao.questions.last
        let lastQuestionIndex = dao.questions.indexOf(lastObject!)
        
        if(currentQuestionIndex < lastQuestionIndex){
            
            dao.currentQuestion = dao.questions[nextQuestionIndex]
            
            

        }
        
        else{
print("Do we get here?")
            
            
            
            
        
            dao.currentQuestion.question = "End of Quiz! If you don't feel comfortable,try the Flash Cards or Review tab and try again!"
            dao.currentQuestion.a = ""
            dao.currentQuestion.b = ""
            dao.currentQuestion.c = ""
            dao.currentQuestion.d = ""
            

            
        }
        
tableView.reloadData()
        
        
        
        
        
        UIView.animateWithDuration(10.0, animations: {
            
            self.infoButton.hidden = false
            self.nextButton.hidden = false
            
            
            self.infoButton.hidden = true
            self.nextButton.hidden = true
            
        })

    }
    
    
    
    func infoOnQuestion(){
        
        print("info")
    }
    
    
    
    func addInfoAndNextButton(){
        
        
        infoButton = UIButton(frame: CGRect(x: 0, y: self.view.frame.height-100, width: self.view.frame.width/2, height: 50))
        infoButton.backgroundColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        

        infoButton.setTitle("Info", forState: .Normal)
        infoButton.addTarget(self, action: #selector(infoOnQuestion), forControlEvents: .TouchUpInside)
        infoButton.layer.cornerRadius = 10.0
        
        self.view.addSubview(infoButton)
        
        nextButton = UIButton(frame: CGRect(x: self.view.frame.width/2, y: self.view.frame.height-100, width: self.view.frame.width/2, height: 50))
        nextButton.backgroundColor = .greenColor()
        nextButton.setTitle("Next", forState: .Normal)
        nextButton.addTarget(self, action: #selector(nextQuestion), forControlEvents: .TouchUpInside)
        nextButton.layer.cornerRadius = 10.0
        
        self.view.addSubview(nextButton)
        
        
        infoButton.hidden = true
        nextButton.hidden = true


    
    }
    
    
    
}
