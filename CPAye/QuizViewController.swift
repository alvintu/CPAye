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
    var restartButton = UIButton()
    var currentQuestion : MultipleChoice = MultipleChoice(question: "", a: "", b: "", c: "", d: "", correctAnswer: "", info: "")
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var infoVC = UIViewController()
    var openedInfo : Bool  = false
    
    //lets try to do this without removing all objects in the array
    //i should able to make it work by resetting a counter
    //for some reason resetting a counter breaks it;
   var currentQuestionIndex = 0

    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        
        print("quiz");
        print("\(dao.questions.count) is the number of questions")
        
//        currentQuestionIndex = dao.questions.indexOf(dao.currentQuestion)!

        addInfoAndNextButton()
        loadInfoVC()
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        self.title = "Quiz"
        
    }
    
    
    
    
    func nextQuestion(){
        
        
        print(currentQuestionIndex)

        
        currentQuestionIndex+=1
        
        
//        let currentQuestionIndex = dao.questions.indexOf(dao.currentQuestion)
        
        
//        let nextQuestionIndex = currentQuestionIndex! + 1
        
        
//        let count = dao.questions.last
//        let lastQuestionIndex = dao.questions.indexOf(lastObject!)
//        
        
        if(currentQuestionIndex < dao.questions.count){
            
            dao.currentQuestion = dao.questions[currentQuestionIndex]
            print(dao.currentQuestion.question)
            self.tableView.reloadData()

            
        }
            
        else{
        
            print(currentQuestionIndex)
            print(dao.questions.count)
            
            
            
            
            
            tableView.allowsSelection = false
            tableView.separatorStyle = .None
            
            
            restartButton.hidden = false
            
            dao.currentQuestion = MultipleChoice(question: "End of Quiz!\nIf you don't feel comfortable,try the Flash Cards or Review tab and try again!", a: "", b: "", c: "", d: "", correctAnswer: "", info: "")
            
            self.tableView.reloadData()

            
        }
        
        
        if(openedInfo){
            openedInfo = false
            
            
            UIView .animateWithDuration(0.3, animations: {
                self.infoVC.view.frame = CGRectMake(0, -700, self.view.frame.size.width, self.view.frame.size.height/1.33)
                
            })
        }
        
        infoVC.viewDidLoad()


            fadeEM()
    }
    
    func restartQuiz(){
        print("restart")
        tableView.allowsSelection = true
        tableView.separatorStyle = .SingleLine
        restartButton.hidden = true
//        dao.restartQuiz()
        
    currentQuestionIndex = 0
    dao.currentQuestion = dao.questions[0]

        print(dao.questions.count)
        
        
        
    
        infoVC.viewDidLoad()

        tableView.reloadData()
        
    }
    
    //tableview delegate methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("quizCell", forIndexPath: indexPath) as! QuizCell
        cell.selectionStyle = UITableViewCellSelectionStyle.Default
        cell.questionInfoTextView.delegate = self

        
        cell.questionInfoTextView.userInteractionEnabled = false
        cell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        
//        cell.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
//        cell.contentView.layer.borderWidth = 2.0
//        
        
        

        
        cell.questionInfoTextView.delegate = self
        
        switch indexPath {
        case NSIndexPath(forRow: 0, inSection: 0) :
            

            cell.questionInfoTextView.text = dao.currentQuestion.question
            
        case NSIndexPath(forRow: 0, inSection: 1) :
            cell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)

            cell.questionInfoTextView.text = dao.currentQuestion.a
    
        case NSIndexPath(forRow: 0, inSection: 2) :
            
            cell.questionInfoTextView.text = dao.currentQuestion.b
        case NSIndexPath(forRow: 0, inSection: 3) :
            
            cell.questionInfoTextView.text = dao.currentQuestion.c
            
        case NSIndexPath(forRow: 0, inSection: 4) :
            
            cell.questionInfoTextView.text = dao.currentQuestion.d
            
        default:
            print("wot mate")

            cell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
            
//        }
        }
            return cell
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0;
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        var rowHeight :CGFloat = 0.0
        
        switch indexPath {

        case NSIndexPath(forRow: 0, inSection: 0) :
            
        rowHeight = self.view.frame.height/4
        case NSIndexPath(forRow: 0, inSection: 1) :
            
        rowHeight = self.view.frame.height/9

        
        case NSIndexPath(forRow: 0, inSection: 2) :
        
            rowHeight = self.view.frame.height/9
            
        case NSIndexPath(forRow: 0, inSection: 3) :
        
            rowHeight = self.view.frame.height/9
        
        case NSIndexPath(forRow: 0, inSection: 4) :
        
            rowHeight = self.view.frame.height/9
        
        default:
        
            rowHeight = self.view.frame.height/9
        
    }
    
        return rowHeight
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        
        
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red:0.98, green:0.17, blue:0.41, alpha:1.0)
        
        let tempCell = selectedCell as! QuizCell
        tempCell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)

        
        UIView.animateWithDuration(1.0, animations: {
            
            self.infoButton.hidden = true
            self.nextButton.hidden = true


        self.infoButton.hidden = false
        self.nextButton.hidden = false

            })
        
        switch indexPath {
            //cell.titleLabel.text = "\(currentShop.categoryDeal) - 09/12/2016 - Hunter College" //specifics later
            
            
        case NSIndexPath(forRow: 0, inSection: 0) :

            selectedCell.contentView.backgroundColor = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0)

            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()
            


            
        case NSIndexPath(forRow: 0, inSection: 1) :
            
            enableButtons()

            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()


            
                    if(dao.currentQuestion.correctAnswer == "a"){

                        UIView.animateWithDuration(0.5, animations: {
                            
                        selectedCell.contentView.backgroundColor = UIColor.whiteColor()

                        selectedCell.contentView.backgroundColor = UIColor(red:0.64, green:0.91, blue:0.53, alpha:1.0)

                        })
                        


                    print("correct")
                    
                    }
                    else{
                        print("incorrect")

                        UIView.animateWithDuration(0.5, animations: {
                            selectedCell.contentView.backgroundColor = UIColor.whiteColor()

                            selectedCell.contentView.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
                            

                        })
                        
                    }
            
            
        case NSIndexPath(forRow: 0, inSection: 2) :
            enableButtons()

            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()

        
                if(dao.currentQuestion.correctAnswer == "b"){

                    UIView.animateWithDuration(0.5, animations: {
                        selectedCell.contentView.backgroundColor = UIColor.whiteColor()
                        
                        selectedCell.contentView.backgroundColor = UIColor(red:0.64, green:0.91, blue:0.53, alpha:1.0)



                    })
                    
                    
                    print("correct")
                    
                }
                else{
                    print("incorrect")

                    UIView.animateWithDuration(0.5, animations: {
                        selectedCell.contentView.backgroundColor = UIColor.whiteColor()
                        
                        selectedCell.contentView.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
                        

                    })
                    
            }
            
    
            
        case NSIndexPath(forRow: 0, inSection: 3) :
            enableButtons()

            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()

            
            if(dao.currentQuestion.correctAnswer == "c"){

                UIView.animateWithDuration(0.5, animations: {
                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
                    
                    selectedCell.contentView.backgroundColor = UIColor(red:0.64, green:0.91, blue:0.53, alpha:1.0)

                })
                
                
                print("correct")
                
            }
            else{
                print("incorrect")

                UIView.animateWithDuration(0.5, animations: {
                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
                    
                    selectedCell.contentView.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
                                    })
                
                
                print("correct")
                
                
            }
        case NSIndexPath(forRow: 0, inSection: 4) :
            enableButtons()

            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()

            
            if(dao.currentQuestion.correctAnswer == "d"){

                UIView.animateWithDuration(0.5, animations: {
                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
                    
                    selectedCell.contentView.backgroundColor = UIColor(red:0.64, green:0.91, blue:0.53, alpha:1.0)

                })
                
                
                
                print("correct")
                
            }
            else{
                print("incorrect")

                UIView.animateWithDuration(0.5, animations: {
                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
                    
                    selectedCell.contentView.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
                    

                })
                
                
                
            }
            
            

            
        default:
            tempCell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)

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

    
    
    func infoOnQuestion(){
        
        slideInfoUpOrDown()
        
    }
    
    
    
  
    
    func addInfoAndNextButton(){
        
        
        infoButton = UIButton(frame: CGRect(x: 0, y: self.view.frame.height-160, width: self.view.frame.width/2, height: 100))
        infoButton.backgroundColor = UIColor(red:0.20, green:0.67, blue:0.86, alpha:1.0)
        

        infoButton.setTitle("Info", forState: .Normal)
        infoButton.addTarget(self, action: #selector(infoOnQuestion), forControlEvents: .TouchUpInside)
        infoButton.layer.cornerRadius = 10.0
        
        self.view.addSubview(infoButton)
        
        nextButton = UIButton(frame: CGRect(x: self.view.frame.width/2, y: self.view.frame.height-160, width: self.view.frame.width/2, height: 100))
        nextButton.backgroundColor = UIColor(red:0.35, green:0.83, blue:0.15, alpha:1.0)
        
        
        nextButton.setTitle("Next", forState: .Normal)
        nextButton.addTarget(self, action: #selector(nextQuestion), forControlEvents: .TouchUpInside)
        nextButton.layer.cornerRadius = 10.0
        
        self.view.addSubview(nextButton)
        
        
        
        restartButton = UIButton(frame: CGRect(x: self.view.frame.width/2-50, y: self.view.frame.height/2, width: 100, height: 100))
        restartButton.backgroundColor = .redColor()
        restartButton.setTitle("Restart", forState: .Normal)
        restartButton.addTarget(self, action: #selector(restartQuiz), forControlEvents: .TouchUpInside)
        restartButton.layer.cornerRadius = 10.0
        
        self.view.addSubview(restartButton)
        
        
        
        
        
        
        
//        
//        infoButton.hidden = true
//        nextButton.hidden = true
        
fadeEM()

//
        
        restartButton.hidden = true



    
    }
    
    func hideInfoAndNextButtons(){
        

        UIView.animateWithDuration(0.5, animations: {

            self.infoButton.hidden = false
            self.nextButton.hidden = false
            self.view.layoutIfNeeded()

            
            self.infoButton.hidden = true
            self.nextButton.hidden = true
            self.view.layoutIfNeeded()

            
        })
    }
    
    
    func fadeEM(){
        
        infoButton.alpha = 0.2
        nextButton.alpha = 0.2
        infoButton.userInteractionEnabled = false
        nextButton.userInteractionEnabled = false
        

    }
    
    func enableButtons(){
        infoButton.alpha = 1.0
        nextButton.alpha = 1.0
        infoButton.userInteractionEnabled = true
        nextButton.userInteractionEnabled = true
    }
    
    
    func slideInfoUpOrDown(){
        
        if(openedInfo){
            openedInfo = false
            
            
            UIView .animateWithDuration(0.3, animations: {
                self.infoVC.view.frame = CGRectMake(0, -700, self.view.frame.size.width, self.view.frame.size.height/1.33)
                
            })
            
        }
        else{
            openedInfo = true
            
            
            UIView .animateWithDuration(0.3, animations: {
//                self.mapButton.setImage(UIImage(named: "tableView"), forState: UIControlState.Normal)
                
                self.infoVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/1.33)
                
                
            })
            
        }
        
        //        navigationController?.pushViewController(dao.mapVC, animated: true)
    }
    
    func loadInfoVC(){
        
        infoVC = mainStoryboard.instantiateViewControllerWithIdentifier("infoViewController")
    
        self .addChildViewController(infoVC) //popover content is settingsvc
        
        infoVC.view.frame = CGRectMake(0, -700, self.view.frame.size.width, self.view.frame.size.height/1.33)
        
        self.view.addSubview(infoVC.view)
        
        
        
        
        
    }
    
    
    
}
