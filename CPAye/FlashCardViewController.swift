//
//  FlashCardViewController.swift
//  CPAye
//
//  Created by Jo Tu on 10/18/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//
//
//  ReviewViewController.swift
//  CPAye
//
//  Created by Jo Tu on 10/18/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//

import UIKit

class FlashCardViewController: UIViewController,UITextViewDelegate {
    let dao = DAO.sharedInstance
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var flashCardInfoVC = UIViewController()
    
    var flashCardContainerView = UIView()
    var flashCardTextView = UITextView()
    var frontTapLabel = UILabel()
    let prefs = UserDefaults.standard
    
    
    
    
    var back = UITextView()

    var knowButton : UIButton!
    var dontKnowButton : UIButton!
    var singleTap  = UITapGestureRecognizer()
    
    var showingAnswer = false

    
    var currentFlashCardIndex = 0
    
    
    var masteredLabel : UILabel!
    var reviewingLabel : UILabel!
    var learningLabel : UILabel!
    
    var masteredProgressView : UIProgressView!
    var reviewingProgressView : UIProgressView!
    var learningProgressView : UIProgressView!

    var masterCounter  = 0
    var reviewCounter = 0
    var learningCounter = 0


    


    
    
    override func viewDidLoad() {
        

        

        

        
        currentFlashCardIndex = prefs.integer(forKey: "currentFlashCardIndex")
        dao.currentFlashCard = dao.flashCards[currentFlashCardIndex]
        print(currentFlashCardIndex)

        loadProgressLabelAndProgressViews()

        loadBasicUI()
        loadConceptFromSingleton()

progressCounter()

        
//        loadHiddenButtons()
        
        print("flashCard")
    }
    

    
    

    func knowThisWord(){
        
        print("√ I know")
        

        
        dao.currentFlashCard.grade+=1
        
        prefs.set(dao.currentFlashCard.grade, forKey: (dao.currentFlashCard.concept + "\n" + dao.currentFlashCard.definition))

        

        currentFlashCardIndex+=1


       
        if(currentFlashCardIndex < dao.flashCards.count){
            
            dao.currentFlashCard = dao.flashCards[currentFlashCardIndex]


        }
        else{
            dao.currentFlashCard = dao.flashCards[0]
            currentFlashCardIndex = 0

            
        }
        prefs.setValue(currentFlashCardIndex, forKey: "currentFlashCardIndex")

        
        loadConceptFromSingleton()
        progressCounter()
        reloadProgressViewWhenGradeCounterSet()

        
        slideFlashCard()
        

        

        
    }

    func dontKnowThisWord(){
        
        print("X I don't know.")
        
        
        
        
        dao.currentFlashCard.grade-=1
        
        prefs.set(dao.currentFlashCard.grade, forKey: (dao.currentFlashCard.concept + "\n" + dao.currentFlashCard.definition))

        
        
        currentFlashCardIndex+=1
        
        
        
        
        
        
        
        if(currentFlashCardIndex < dao.flashCards.count){
            
            dao.currentFlashCard = dao.flashCards[currentFlashCardIndex]
            
            
        }
        else{
            dao.currentFlashCard = dao.flashCards[0]
            currentFlashCardIndex = 0
            
            
        }
        prefs.setValue(currentFlashCardIndex, forKey: "currentFlashCardIndex")
        
        
        loadConceptFromSingleton()
        progressCounter()
        
        reloadProgressViewWhenGradeCounterSet()

        slideFlashCard()
        
        
    }
    
    
    
    func progressCounter(){
        
        masterCounter = 0
        reviewCounter = 0
        learningCounter = 0
        for flashcard in dao.flashCards{
            if(flashcard.grade <= 0){
                learningCounter+=1
            }
            else if(flashcard.grade > 0 && flashcard.grade < 5){
                reviewCounter+=1
            }
            else{
                masterCounter+=1
            }
            print(flashcard.grade)
        }
        
        let castedFlashCardCount = Float(dao.flashCards.count)

        let castedMasteredCounter = Float(masterCounter)
        masteredLabel.text = "Master of: \(masterCounter) out of \(dao.flashCards.count) concepts"
        
        let castedReviewCounter = Float(reviewCounter)
        print("reviewingProgress is \(reviewingProgressView.progress)")
        reviewingLabel.text = "Reviewing: \(reviewCounter) out of \(dao.flashCards.count) concepts"
        
        let castedLearningCounter = Float(learningCounter)

        learningLabel.text = "Still Learning: \(learningCounter) out of \(dao.flashCards.count) concepts"

        
        

        
        //ui
            

            self.masteredProgressView.progress = castedMasteredCounter/castedFlashCardCount
            self.reviewingProgressView.progress = castedReviewCounter/castedFlashCardCount
            self.learningProgressView.progress = castedLearningCounter/castedFlashCardCount
            
            
        

    


        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func tapped() {

        print("tapped")

        
        let normalText = "\n\n" + dao.currentFlashCard.definition
        
        let boldText  = dao.currentFlashCard.concept
        
        let attributedString = NSMutableAttributedString(string:normalText)
        
        let attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
        let boldString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        boldString.append(attributedString)
        
        back.attributedText = boldString
        back.textAlignment = .left
        
        



//        back.backgroundColor = UIColor.blackColor()

        if(!showingAnswer){
        UIView.transition(from: flashCardTextView, to: back, duration: 1, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
            loadProgressViewsWhenInfoClicked()
            loadHiddenButtons()

            showingAnswer = true
            

        
    }

        

    }
    
    
    
    
    
    
    
    func slideFlashCard(){
        
        

        let originalFrame = self.flashCardContainerView.frame
        
        UIView.animate(withDuration: 0.6, delay: 0, options: [], animations: {
            self.flashCardContainerView.frame = CGRect(x: -800, y: self.flashCardContainerView.frame.origin.y, width: self.flashCardContainerView.frame.size.width, height: self.flashCardContainerView.frame.size.height)
            //            self.flashCardContainerView.hidden = true
            
            
            }, completion: {_ in
                UIView.animate(withDuration: 0.1, delay: 0, options:[], animations: {
                    
                    self.flashCardContainerView.isHidden = true
                    

                    UIView.transition(from: self.back, to: self.flashCardTextView, duration: 1, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
                    self.showingAnswer = false
                    self.knowButton.isHidden = true
                    self.dontKnowButton.isHidden = true
                    
                    
        
                    
                    self.flashCardContainerView.frame = CGRect(x: 900, y: self.flashCardContainerView.frame.origin.y, width: self.flashCardContainerView.frame.size.width, height: self.flashCardContainerView.frame.size.height)
                    
                    
                    
                    },completion:{ _ in
                        
                        UIView .animate(withDuration: 0.4, delay: 0, options:[], animations: {
                            self.flashCardContainerView.isHidden = false
                            self.frontTapLabel.isHidden = false

                            
                            
                            self.flashCardContainerView.frame = CGRect(x: originalFrame.origin.x, y: originalFrame.origin.y, width: originalFrame.size.width, height: originalFrame.size.height)
                            
                            },completion: nil)
                    }
                )
        })
        

        
        
    }


    
    
    
    func loadHiddenButtons(){
        
        
        frontTapLabel.isHidden = true
        
        
        knowButton = UIButton(frame: CGRect(x: 0, y: (back.frame.height - back.frame.height/2), width: back.frame.width, height: back.frame.height/4))
        knowButton.backgroundColor = UIColor.green
        knowButton.setTitle("✅ I know this word", for: UIControlState())
        knowButton.addTarget(self, action: #selector(knowThisWord), for: .touchUpInside)
        
        self.flashCardContainerView.addSubview(knowButton)
        
        dontKnowButton = UIButton(frame: CGRect(x:0, y: (knowButton.frame.origin.y + knowButton.frame.size.height), width: knowButton.frame.width, height: knowButton.frame.height))
        dontKnowButton.backgroundColor = UIColor(red:1.00, green:0.48, blue:0.48, alpha:1.0)
        
        dontKnowButton.setTitle("❌ I don't know this word", for: UIControlState())
        dontKnowButton.addTarget(self, action: #selector(dontKnowThisWord), for: .touchUpInside)
        
        self.flashCardContainerView.addSubview(dontKnowButton)
    }
    
    func loadConceptFromSingleton(){
        let attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 20)]
        let boldString = NSMutableAttributedString(string:dao.currentFlashCard.concept, attributes:attrs)
        
        
        flashCardTextView.attributedText = boldString
        
        

    }
  
    
    
    func reloadProgressViewWhenGradeCounterSet(){
        
        masteredProgressView.isHidden = true
        reviewingProgressView.isHidden = true
        learningProgressView.isHidden = true
        
        masteredLabel.isHidden = true
        reviewingLabel.isHidden = true
        learningLabel.isHidden = true
        
        
        UIView .animate(withDuration: 1.0, delay: 0, options:[], animations: {
            
            
            
            
            self.masteredLabel.frame = CGRect(x: 0, y: self.view.frame.height/1.75, width: self.view.frame.width, height: 20)
            //        masteredLabel.text = "Master of: \(masterCounter) out of \(dao.flashCards.count) concepts"
            self.masteredLabel.textAlignment = NSTextAlignment.center
            
            
            self.masteredProgressView.frame = CGRect(x: self.masteredLabel.frame.origin.x, y: self.masteredLabel.frame.origin.y + 30, width: self.view.frame.width/1.25, height: 1)
            self.masteredProgressView.center.x = self.view.center.x
            //        self.masteredProgressView.progressTintColor = UIColor.greenColor()
            //        masteredProgressView.progress = 0.0
            
            
            //////
            
            self.reviewingLabel.frame = CGRect(x: 0, y: self.masteredProgressView.frame.origin.y + 30, width: self.view.frame.width, height: 20)
            
            //        reviewingLabel.text = "Reviewing: \(reviewCounter) out of \(dao.flashCards.count) concepts"
            self.reviewingLabel.textAlignment = NSTextAlignment.center
            
            //        reviewingProgressView = UIProgressView.init(progressViewStyle: .Default)
            self.reviewingProgressView.frame = CGRect(x: self.reviewingLabel.frame.origin.x, y: self.reviewingLabel.frame.origin.y + 30, width: self.view.frame.width/1.25, height: 1)
            self.reviewingProgressView.center.x = self.view.center.x
            //        reviewingProgressView.progressTintColor = UIColor.orangeColor()
            //        reviewingProgressView.progress = 0.0  //dummy progress
            
            
            /////
            
            self.learningLabel.frame = CGRect(x: 0, y: self.reviewingProgressView.frame.origin.y + 30, width: self.view.frame.width, height: 20)
            //        learningLabel.text = "Still Learning: \(learningCounter) out of \(dao.flashCards.count) concepts"
            self.learningLabel.textAlignment = NSTextAlignment.center
            
            //        learningProgressView = UIProgressView.init(progressViewStyle: .Default)
            self.learningProgressView.frame = CGRect(x: self.learningLabel.frame.origin.x, y: self.learningLabel.frame.origin.y + 30, width: self.view.frame.width/1.25, height: 1)
            self.learningProgressView.center.x = self.view.center.x
            //        learningProgressView.progressTintColor = UIColor.redColor()
            //        learningProgressView.progress = 0.0 //dummy progress
            
            
            self.masteredProgressView.isHidden = false
            self.reviewingProgressView.isHidden = false
            self.learningProgressView.isHidden = false
            
            self.masteredLabel.isHidden = false
            self.reviewingLabel.isHidden = false
            self.learningLabel.isHidden = false
            
            },completion: nil)
        
    }
    
    
    
    
    func loadProgressViewsWhenInfoClicked(){
        
        masteredProgressView.isHidden = true
        reviewingProgressView.isHidden = true
        learningProgressView.isHidden = true
        
        masteredLabel.isHidden = true
        reviewingLabel.isHidden = true
        learningLabel.isHidden = true
        
        
        UIView .animate(withDuration: 1.0, delay: 0, options:[], animations: {
            
            

        
        self.masteredLabel.frame = CGRect(x: 0, y: self.view.frame.height/1.5, width: self.view.frame.width, height: 20)
//        masteredLabel.text = "Master of: \(masterCounter) out of \(dao.flashCards.count) concepts"
        self.masteredLabel.textAlignment = NSTextAlignment.center
        
        
        self.masteredProgressView.frame = CGRect(x: self.masteredLabel.frame.origin.x, y: self.masteredLabel.frame.origin.y + 30, width: self.view.frame.width/1.25, height: 1)
        self.masteredProgressView.center.x = self.view.center.x
//        self.masteredProgressView.progressTintColor = UIColor.greenColor()
//        masteredProgressView.progress = 0.0
        
        
        //////
        
        self.reviewingLabel.frame = CGRect(x: 0, y: self.masteredProgressView.frame.origin.y + 30, width: self.view.frame.width, height: 20)
        
//        reviewingLabel.text = "Reviewing: \(reviewCounter) out of \(dao.flashCards.count) concepts"
        self.reviewingLabel.textAlignment = NSTextAlignment.center
        
//        reviewingProgressView = UIProgressView.init(progressViewStyle: .Default)
        self.reviewingProgressView.frame = CGRect(x: self.reviewingLabel.frame.origin.x, y: self.reviewingLabel.frame.origin.y + 30, width: self.view.frame.width/1.25, height: 1)
        self.reviewingProgressView.center.x = self.view.center.x
//        reviewingProgressView.progressTintColor = UIColor.orangeColor()
//        reviewingProgressView.progress = 0.0  //dummy progress
        
        
        /////
        
        self.learningLabel.frame = CGRect(x: 0, y: self.reviewingProgressView.frame.origin.y + 30, width: self.view.frame.width, height: 20)
//        learningLabel.text = "Still Learning: \(learningCounter) out of \(dao.flashCards.count) concepts"
        self.learningLabel.textAlignment = NSTextAlignment.center
        
//        learningProgressView = UIProgressView.init(progressViewStyle: .Default)
       self.learningProgressView.frame = CGRect(x: self.learningLabel.frame.origin.x, y: self.learningLabel.frame.origin.y + 30, width: self.view.frame.width/1.25, height: 1)
        self.learningProgressView.center.x = self.view.center.x
//        learningProgressView.progressTintColor = UIColor.redColor()
//        learningProgressView.progress = 0.0 //dummy progress
        
            
            self.masteredProgressView.isHidden = false
            self.reviewingProgressView.isHidden = false
            self.learningProgressView.isHidden = false
            
            self.masteredLabel.isHidden = false
            self.reviewingLabel.isHidden = false
            self.learningLabel.isHidden = false
        
            },completion: nil)

    }
    
    
    
    func loadBasicUI(){
        
        
        
        flashCardContainerView.removeFromSuperview()
        flashCardTextView.removeFromSuperview()
        frontTapLabel.removeFromSuperview()
        back.removeFromSuperview()
        
        flashCardContainerView = UIView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width/1.25, height: view.frame.height/2))
        
        
        flashCardTextView = UITextView.init(frame: CGRect(x: 0, y: 0,width: view.frame.size.width/1.25, height: view.frame.height/4))
        frontTapLabel =  UILabel.init(frame: CGRect(x: 0,y: flashCardTextView.frame.size.height/2 ,width: flashCardTextView.frame.size.width, height: flashCardTextView.frame.height/2))
        
        
        flashCardContainerView.center = view.center
        
        
        flashCardTextView.isEditable = false
        flashCardTextView.isSelectable = false
        flashCardTextView.isUserInteractionEnabled = false
        flashCardTextView.textAlignment = NSTextAlignment.center
        
        
        
        
        frontTapLabel.text = "Tap to see meaning ->"
        frontTapLabel.textColor = UIColor.white
        frontTapLabel.layer.cornerRadius = 10.0
        frontTapLabel.textAlignment = NSTextAlignment.center
        frontTapLabel.adjustsFontSizeToFitWidth = true
        frontTapLabel.backgroundColor = UIColor.lightGray
        
        flashCardContainerView.addSubview(flashCardTextView)
        flashCardTextView.addSubview(frontTapLabel)
        view.addSubview(flashCardContainerView)
        
        
        
        
        back =  UITextView(frame: CGRect(x: flashCardTextView.frame.origin.x, y: flashCardTextView.frame.origin.y, width: flashCardTextView.frame.size.width, height: flashCardTextView.frame.size.height * 1.5  ))
        
        
        
        
        back.layer.cornerRadius = 10.0
        
        
        back.delegate = self
        back.isEditable = false
        back.isSelectable = false
        
        back.isUserInteractionEnabled = false
        
        //        flashCardContainerView.layer.cornerRadius = 10.0
        flashCardTextView.layer.cornerRadius = 10.0
        flashCardContainerView.layer.cornerRadius = 10.0
        singleTap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        singleTap.numberOfTapsRequired = 1
        flashCardContainerView.addGestureRecognizer(singleTap)
        
    }
    
    func loadProgressLabelAndProgressViews(){
        ///
        masteredLabel = UILabel.init(frame: CGRect(x: 0, y: view.frame.height/1.75, width: view.frame.width, height: 20))
        masteredLabel.text = "Master of: \(masterCounter) out of \(dao.flashCards.count) concepts"
        masteredLabel.textAlignment = NSTextAlignment.center
        
        
        masteredProgressView = UIProgressView.init(progressViewStyle: .default)
        masteredProgressView.frame = CGRect(x: masteredLabel.frame.origin.x, y: masteredLabel.frame.origin.y + 30, width: view.frame.width/1.25, height: 1)
        masteredProgressView.center.x = view.center.x
        masteredProgressView.progressTintColor = UIColor.green
        masteredProgressView.progress = 0.0
        
        
        //////
        
        reviewingLabel = UILabel.init(frame: CGRect(x: 0, y: masteredProgressView.frame.origin.y + 30, width: view.frame.width, height: 20))
        
        reviewingLabel.text = "Reviewing: \(reviewCounter) out of \(dao.flashCards.count) concepts"
        reviewingLabel.textAlignment = NSTextAlignment.center
        
        reviewingProgressView = UIProgressView.init(progressViewStyle: .default)
        reviewingProgressView.frame = CGRect(x: reviewingLabel.frame.origin.x, y: reviewingLabel.frame.origin.y + 30, width: view.frame.width/1.25, height: 1)
        reviewingProgressView.center.x = view.center.x
        reviewingProgressView.progressTintColor = UIColor.orange
        reviewingProgressView.progress = 0.0  //dummy progress
        
        
        /////
        
        learningLabel = UILabel.init(frame: CGRect(x: 0, y: reviewingProgressView.frame.origin.y + 30, width: view.frame.width, height: 20))
        learningLabel.text = "Still Learning: \(learningCounter) out of \(dao.flashCards.count) concepts"
        learningLabel.textAlignment = NSTextAlignment.center
        
        learningProgressView = UIProgressView.init(progressViewStyle: .default)
        learningProgressView.frame = CGRect(x: learningLabel.frame.origin.x, y: learningLabel.frame.origin.y + 30, width: view.frame.width/1.25, height: 1)
        learningProgressView.center.x = view.center.x
        learningProgressView.progressTintColor = UIColor.red
        learningProgressView.progress = 0.0 //dummy progress
        
        
        
        
        view.addSubview(masteredLabel)
        view.addSubview(masteredProgressView)
        view.addSubview(reviewingLabel)
        view.addSubview(reviewingProgressView)
        view.addSubview(learningLabel)
        view.addSubview(learningProgressView)
        
        
        
        
    }
    

}


