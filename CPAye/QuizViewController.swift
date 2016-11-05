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
    
    let dao = DAO.sharedInstance
    let prefs = UserDefaults.standard
    var currentQuestion : MultipleChoice = MultipleChoice(question: "", a: "", b: "", c: "", d: "", correctAnswer: "", info: "")

    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var infoButton = UIButton()
    var nextButton = UIButton()
    var restartButton = UIButton()
    
    var infoVC = UIViewController()
    var openedInfo : Bool  = false

    var currentQuestionIndex = 0

    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        

//        addInfoAndNextButton()
        loadInfoVC()

        self.title = "Quiz"
        tableView.isScrollEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(QuizViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

//        addInfoAndNextButton()

        
        rotated()

        
        
        currentQuestionIndex = prefs.integer(forKey: "currentQuestionIndex")
        dao.currentQuestion = dao.questions[currentQuestionIndex]
        tableView.reloadData()

        
        
    }
    
    func rotated()
    {
        
        
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation))
        {
            print("landscape")
            addInfoAndNextButtonForLandScape()

        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation))
        {
            print("Portrait")
//            addInfoAndNextButton()
            addInfoAndNextButton()


        }
        
        
        
        UIView .animate(withDuration: 0.3, animations: {
            self.infoVC.view.frame = CGRect(x: 0, y: -700, width: self.view.frame.size.width, height: self.view.frame.size.height/1.33)})
    
    }
    
    
    
    
    func nextQuestion(){
        
        
        print(currentQuestionIndex)

        
        currentQuestionIndex+=1
        prefs.setValue(currentQuestionIndex, forKey: "currentQuestionIndex")
        
        
  
        if(currentQuestionIndex < dao.questions.count){
            
            dao.currentQuestion = dao.questions[currentQuestionIndex]
            self.tableView.reloadData()
            
        }
            
        else{
   
            
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
            
            
            restartButton.isHidden = false
            
        currentQuestionIndex = 0
            prefs.setValue(currentQuestionIndex, forKey: "currentQuestionIndex")

            
            dao.currentQuestion = MultipleChoice(question: "End of Quiz!\nIf you don't feel comfortable,try the Flash Cards or Review tab and try again!", a: "", b: "", c: "", d: "", correctAnswer: "", info: "")
            
            self.tableView.reloadData()

            
        }
        
        
        if(openedInfo){
            openedInfo = false
            
            
            UIView .animate(withDuration: 0.3, animations: {
                self.infoVC.view.frame = CGRect(x: 0, y: -700, width: self.view.frame.size.width, height: self.view.frame.size.height/1.33)
                
            })
        }
        
        infoVC.viewDidLoad()


            fadeEM()
    }
    
    
    
    func restartQuiz(){

        tableView.allowsSelection = true
        tableView.separatorStyle = .singleLine
        restartButton.isHidden = true

        
        dao.currentQuestion = dao.questions[currentQuestionIndex]
        
        
        infoVC.viewDidLoad()
        tableView.reloadData()
        
    }
    
    //tableview delegate methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! QuizCell
        cell.selectionStyle = UITableViewCellSelectionStyle.default
        cell.questionInfoTextView.delegate = self
        
        
        cell.questionInfoTextView.isUserInteractionEnabled = false
        cell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        
        
        switch indexPath {
        case IndexPath(row: 0, section: 0) :
            
            
            cell.questionInfoTextView.text = dao.currentQuestion.question
            
        case IndexPath(row: 0, section: 1) :
            cell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
            
            cell.questionInfoTextView.text = dao.currentQuestion.a
            
        case IndexPath(row: 0, section: 2) :
            
            cell.questionInfoTextView.text = dao.currentQuestion.b
        case IndexPath(row: 0, section: 3) :
            
            cell.questionInfoTextView.text = dao.currentQuestion.c
            
        case IndexPath(row: 0, section: 4) :
            
            cell.questionInfoTextView.text = dao.currentQuestion.d
            
        default:
            
            cell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
            
            //        }
        }
        return cell
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        var rowHeight :CGFloat = 0.0
        
        switch indexPath {

        case IndexPath(row: 0, section: 0) :
            
        rowHeight = self.view.frame.height/4
        case IndexPath(row: 0, section: 1) :
            
        rowHeight = self.view.frame.height/9

        
        case IndexPath(row: 0, section: 2) :
        
            rowHeight = self.view.frame.height/9
            
        case IndexPath(row: 0, section: 3) :
        
            rowHeight = self.view.frame.height/9
        
        case IndexPath(row: 0, section: 4) :
        
            rowHeight = self.view.frame.height/9
        
        default:
        
            rowHeight = self.view.frame.height/9
        
    }
    
        return rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red:0.98, green:0.17, blue:0.41, alpha:1.0)
        
        let tempCell = selectedCell as! QuizCell
        tempCell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)

        
        UIView.animate(withDuration: 1.0, animations: {
            
            self.infoButton.isHidden = true
            self.nextButton.isHidden = true


        self.infoButton.isHidden = false
        self.nextButton.isHidden = false

            })
        
        switch indexPath {
            //cell.titleLabel.text = "\(currentShop.categoryDeal) - 09/12/2016 - Hunter College" //specifics later
            
            
        case IndexPath(row: 0, section: 0) :

            selectedCell.contentView.backgroundColor = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0)

            tempCell.questionInfoTextView.textColor = UIColor.white
            


            
        case IndexPath(row: 0, section: 1) :
            
            enableButtons()

            tempCell.questionInfoTextView.textColor = UIColor.white


            
                    if(dao.currentQuestion.correctAnswer == "a"){

                        UIView.animate(withDuration: 0.5, animations: {
                            
                        selectedCell.contentView.backgroundColor = UIColor.white

                        selectedCell.contentView.backgroundColor = UIColor(red:0.64, green:0.91, blue:0.53, alpha:1.0)

                        })
                        


                    print("correct")
                    
                    }
                    else{
                        print("incorrect")

                        UIView.animate(withDuration: 0.5, animations: {
                            selectedCell.contentView.backgroundColor = UIColor.white

                            selectedCell.contentView.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
                            

                        })
                        
                    }
            
            
        case IndexPath(row: 0, section: 2) :
            enableButtons()

            tempCell.questionInfoTextView.textColor = UIColor.white

        
                if(dao.currentQuestion.correctAnswer == "b"){

                    UIView.animate(withDuration: 0.5, animations: {
                        selectedCell.contentView.backgroundColor = UIColor.white
                        
                        selectedCell.contentView.backgroundColor = UIColor(red:0.64, green:0.91, blue:0.53, alpha:1.0)



                    })
                    
                    
                }
                else{

                    UIView.animate(withDuration: 0.5, animations: {
                        selectedCell.contentView.backgroundColor = UIColor.white
                        
                        selectedCell.contentView.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
                        

                    })
                    
            }
            
    
            
        case IndexPath(row: 0, section: 3) :
            enableButtons()

            tempCell.questionInfoTextView.textColor = UIColor.white

            
            if(dao.currentQuestion.correctAnswer == "c"){

                UIView.animate(withDuration: 0.5, animations: {
                    selectedCell.contentView.backgroundColor = UIColor.white
                    
                    selectedCell.contentView.backgroundColor = UIColor(red:0.64, green:0.91, blue:0.53, alpha:1.0)

                })
                
                
                
            }
            else{

                UIView.animate(withDuration: 0.5, animations: {
                    selectedCell.contentView.backgroundColor = UIColor.white
                    
                    selectedCell.contentView.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
                                    })
                
                
                
                
            }
        case IndexPath(row: 0, section: 4) :
            enableButtons()

            tempCell.questionInfoTextView.textColor = UIColor.white

            
            if(dao.currentQuestion.correctAnswer == "d"){

                UIView.animate(withDuration: 0.5, animations: {
                    selectedCell.contentView.backgroundColor = UIColor.white
                    
                    selectedCell.contentView.backgroundColor = UIColor(red:0.64, green:0.91, blue:0.53, alpha:1.0)

                })
                
                
                
                
            }
            else{

                UIView.animate(withDuration: 0.5, animations: {
                    selectedCell.contentView.backgroundColor = UIColor.white
                    
                    selectedCell.contentView.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
                    

                })
                
                
                
            }
            
            

            
        default:
            tempCell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)

            print("default")
            
//            selectedCell.contentView.backgroundColor = UIColor.whiteColor()
            
        }

    }
    
     func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cellToDeSelect:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cellToDeSelect.contentView.backgroundColor = UIColor.white
        
        
        
        let tempCell = cellToDeSelect as! QuizCell
        
        
        switch indexPath {
            //cell.titleLabel.text = "\(currentShop.categoryDeal) - 09/12/2016 - Hunter College" //specifics later
            
            
        case IndexPath(row: 0, section: 0) :
            tempCell.questionInfoTextView.textColor =  UIColor.black
        
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
    

    
    func addInfoAndNextButtonForLandScape(){
        
        infoButton.removeFromSuperview()
        nextButton.removeFromSuperview()
        restartButton.removeFromSuperview()

        
        
        infoButton = UIButton(frame: CGRect(x: 0, y: self.view.frame.height-120, width: self.view.frame.width/2, height: 70))
        infoButton.backgroundColor = UIColor(red:0.20, green:0.67, blue:0.86, alpha:1.0)
        
        
        infoButton.setTitle("Info", for: UIControlState())
        infoButton.addTarget(self, action: #selector(infoOnQuestion), for: .touchUpInside)
        infoButton.layer.cornerRadius = 10.0
        
        self.view.addSubview(infoButton)
        
        nextButton = UIButton(frame: CGRect(x: self.view.frame.width/2, y: self.view.frame.height-120, width: self.view.frame.width/2, height: 70))
        nextButton.backgroundColor = UIColor(red:0.35, green:0.83, blue:0.15, alpha:1.0)
        
        
        nextButton.setTitle("Next", for: UIControlState())
        nextButton.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        nextButton.layer.cornerRadius = 10.0
        
        self.view.addSubview(nextButton)
        
        
        
        restartButton = UIButton(frame: CGRect(x: self.view.frame.width/2-50, y: self.view.frame.height/2, width: 100, height: 100))
        restartButton.backgroundColor = .red
        restartButton.setTitle("Restart", for: UIControlState())
        restartButton.addTarget(self, action: #selector(restartQuiz), for: .touchUpInside)
        restartButton.layer.cornerRadius = 10.0
        
        self.view.addSubview(restartButton)
        
        
        

        
        
        
        
        
        //
        //        infoButton.hidden = true
        //        nextButton.hidden = true
        
        fadeEM()
        
        //
        
        restartButton.isHidden = true
        
        
        
        
    }
    
    
    
  
    
    func addInfoAndNextButton(){
        
        
        infoButton.removeFromSuperview()
        nextButton.removeFromSuperview()
        restartButton.removeFromSuperview()

        
        
        infoButton = UIButton(frame: CGRect(x: 0, y: self.view.frame.height-140, width: self.view.frame.width/2, height: 100))
        infoButton.backgroundColor = UIColor(red:0.20, green:0.67, blue:0.86, alpha:1.0)
        

        infoButton.setTitle("Info", for: UIControlState())
        infoButton.addTarget(self, action: #selector(infoOnQuestion), for: .touchUpInside)
        infoButton.layer.cornerRadius = 10.0
        
        self.view.addSubview(infoButton)
        
        nextButton = UIButton(frame: CGRect(x: self.view.frame.width/2, y: self.view.frame.height-140, width: self.view.frame.width/2, height: 100))
        nextButton.backgroundColor = UIColor(red:0.35, green:0.83, blue:0.15, alpha:1.0)
        
        
        nextButton.setTitle("Next", for: UIControlState())
        nextButton.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        nextButton.layer.cornerRadius = 10.0
        
        self.view.addSubview(nextButton)
        
        
        
        restartButton = UIButton(frame: CGRect(x: self.view.frame.width/2-50, y: self.view.frame.height/2, width: 100, height: 100))
        restartButton.backgroundColor = .red
        restartButton.setTitle("Restart", for: UIControlState())
        restartButton.addTarget(self, action: #selector(restartQuiz), for: .touchUpInside)
        restartButton.layer.cornerRadius = 10.0
        
        self.view.addSubview(restartButton)
        
        
        
        
        
        

        
        
        
        
        
        

        
        
//        
//        infoButton.hidden = true
//        nextButton.hidden = true
        
fadeEM()

//
        
        restartButton.isHidden = true



    
    }
    
    func hideInfoAndNextButtons(){
        

        UIView.animate(withDuration: 0.5, animations: {

            self.infoButton.isHidden = false
            self.nextButton.isHidden = false
            self.view.layoutIfNeeded()

            
            self.infoButton.isHidden = true
            self.nextButton.isHidden = true
            self.view.layoutIfNeeded()

            
        })
    }
    
    
    func fadeEM(){
        
        infoButton.alpha = 0.2
        nextButton.alpha = 0.2
        infoButton.isUserInteractionEnabled = false
        nextButton.isUserInteractionEnabled = false
        

    }
    
    func enableButtons(){
        infoButton.alpha = 1.0
        nextButton.alpha = 1.0
        infoButton.isUserInteractionEnabled = true
        nextButton.isUserInteractionEnabled = true
    }
    
    
    func slideInfoUpOrDown(){
        
        if(openedInfo){
            openedInfo = false
            
            
            UIView .animate(withDuration: 0.3, animations: {
                self.infoVC.view.frame = CGRect(x: 0, y: -700, width: self.view.frame.size.width, height: self.view.frame.size.height/1.33)
                
            })
            
        }
        else{
            openedInfo = true
            
            
            UIView .animate(withDuration: 0.3, animations: {
                
                self.infoVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height/1.33)
                
                
            })
            
        }
        
    }
    
    func loadInfoVC(){
        
        infoVC = mainStoryboard.instantiateViewController(withIdentifier: "infoViewController")
    
        self .addChildViewController(infoVC) //popover content is settingsvc
        
        infoVC.view.frame = CGRect(x: 0, y: -700, width: self.view.frame.size.width, height: self.view.frame.size.height/1.33)
        
        self.view.addSubview(infoVC.view)
        
        
        
        
        
    }
    
    
    
}
