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
    let prefs = NSUserDefaults.standardUserDefaults()
    
    
    
    
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
        

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FlashCardViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)

        

        
        currentFlashCardIndex = prefs.integerForKey("currentFlashCardIndex")
        dao.currentFlashCard = dao.flashCards[currentFlashCardIndex]
        print(currentFlashCardIndex)

        loadProgressLabelAndProgressViews()

        rotated()

progressCounter()

        
//        loadHiddenButtons()
        
        print("flashCard")
    }
    
    
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            print("landscape")

            loadBasicUI()
            loadConceptFromSingleton()
            
            if(showingAnswer)
            {
                loadHiddenButtons()

            
        }
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            print("Portrait")
            //            addInfoAndNextButton()

            loadBasicUI()
            loadConceptFromSingleton()
            
            if(showingAnswer){
                loadHiddenButtons()

            }

 
        }
        
        reloadProgressViewWhenGradeCounterSet()
        

        
    }
    
    
    

    func knowThisWord(){
        
        print("I know")
        
        
        
        dao.currentFlashCard.grade+=1
        

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
        
        print("I don't know.")
        
        
        
        
        dao.currentFlashCard.grade-=1
        
        
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
        
        let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(15)]
        let boldString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        boldString.appendAttributedString(attributedString)
        
        back.attributedText = boldString
        back.textAlignment = .Left
        
        



//        back.backgroundColor = UIColor.blackColor()

        if(!showingAnswer){
        UIView.transitionFromView(flashCardTextView, toView: back, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
            loadProgressViewsWhenInfoClicked()
            loadHiddenButtons()

            showingAnswer = true
            

        
    }

        

    }
    
    
    
    
    
    
    
    func slideFlashCard(){
        
        
        
        let originalFrame = self.flashCardContainerView.frame
        
        UIView.animateWithDuration(0.6, delay: 0, options: [], animations: {
            self.flashCardContainerView.frame = CGRectMake(-800, self.flashCardContainerView.frame.origin.y, self.flashCardContainerView.frame.size.width, self.flashCardContainerView.frame.size.height)
            //            self.flashCardContainerView.hidden = true
            
            
            }, completion: {_ in
                UIView.animateWithDuration(0.1, delay: 0, options:[], animations: {
                    
                    self.flashCardContainerView.hidden = true
                    

                    UIView.transitionFromView(self.back, toView: self.flashCardTextView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
                    self.showingAnswer = false
                    self.knowButton.hidden = true
                    self.dontKnowButton.hidden = true
                    
                    
        
                    
                    self.flashCardContainerView.frame = CGRectMake(900, self.flashCardContainerView.frame.origin.y, self.flashCardContainerView.frame.size.width, self.flashCardContainerView.frame.size.height)
                    
                    
                    
                    },completion:{ _ in
                        
                        UIView .animateWithDuration(0.4, delay: 0, options:[], animations: {
                            self.flashCardContainerView.hidden = false
                            self.frontTapLabel.hidden = false

                            
                            
                            self.flashCardContainerView.frame = CGRectMake(originalFrame.origin.x, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height)
                            
                            },completion: nil)
                    }
                )
        })
        

        
        
    }


    
    
    
    func loadHiddenButtons(){
        
        
        frontTapLabel.hidden = true
        
        
        knowButton = UIButton(frame: CGRect(x: 0, y: (back.frame.height - back.frame.height/2), width: back.frame.width, height: back.frame.height/4))
        knowButton.backgroundColor = UIColor.greenColor()
        knowButton.setTitle("I know this word", forState: .Normal)
        knowButton.addTarget(self, action: #selector(knowThisWord), forControlEvents: .TouchUpInside)
        
        self.flashCardContainerView.addSubview(knowButton)
        
        dontKnowButton = UIButton(frame: CGRect(x:0, y: (knowButton.frame.origin.y + knowButton.frame.size.height), width: knowButton.frame.width, height: knowButton.frame.height))
        dontKnowButton.backgroundColor = UIColor.redColor()
        
        dontKnowButton.setTitle("I don't know this word", forState: .Normal)
        dontKnowButton.addTarget(self, action: #selector(dontKnowThisWord), forControlEvents: .TouchUpInside)
        
        self.flashCardContainerView.addSubview(dontKnowButton)
    }
    
    func loadConceptFromSingleton(){
        let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(20)]
        let boldString = NSMutableAttributedString(string:dao.currentFlashCard.concept, attributes:attrs)
        
        
        flashCardTextView.attributedText = boldString
        
        

    }
  
    
    
    func reloadProgressViewWhenGradeCounterSet(){
        
        masteredProgressView.hidden = true
        reviewingProgressView.hidden = true
        learningProgressView.hidden = true
        
        masteredLabel.hidden = true
        reviewingLabel.hidden = true
        learningLabel.hidden = true
        
        
        UIView .animateWithDuration(1.0, delay: 0, options:[], animations: {
            
            
            
            
            self.masteredLabel.frame = CGRectMake(0, self.view.frame.height/1.75, self.view.frame.width, 20)
            //        masteredLabel.text = "Master of: \(masterCounter) out of \(dao.flashCards.count) concepts"
            self.masteredLabel.textAlignment = NSTextAlignment.Center
            
            
            self.masteredProgressView.frame = CGRectMake(self.masteredLabel.frame.origin.x, self.masteredLabel.frame.origin.y + 30, self.view.frame.width/1.25, 1)
            self.masteredProgressView.center.x = self.view.center.x
            //        self.masteredProgressView.progressTintColor = UIColor.greenColor()
            //        masteredProgressView.progress = 0.0
            
            
            //////
            
            self.reviewingLabel.frame = CGRectMake(0, self.masteredProgressView.frame.origin.y + 30, self.view.frame.width, 20)
            
            //        reviewingLabel.text = "Reviewing: \(reviewCounter) out of \(dao.flashCards.count) concepts"
            self.reviewingLabel.textAlignment = NSTextAlignment.Center
            
            //        reviewingProgressView = UIProgressView.init(progressViewStyle: .Default)
            self.reviewingProgressView.frame = CGRectMake(self.reviewingLabel.frame.origin.x, self.reviewingLabel.frame.origin.y + 30, self.view.frame.width/1.25, 1)
            self.reviewingProgressView.center.x = self.view.center.x
            //        reviewingProgressView.progressTintColor = UIColor.orangeColor()
            //        reviewingProgressView.progress = 0.0  //dummy progress
            
            
            /////
            
            self.learningLabel.frame = CGRectMake(0, self.reviewingProgressView.frame.origin.y + 30, self.view.frame.width, 20)
            //        learningLabel.text = "Still Learning: \(learningCounter) out of \(dao.flashCards.count) concepts"
            self.learningLabel.textAlignment = NSTextAlignment.Center
            
            //        learningProgressView = UIProgressView.init(progressViewStyle: .Default)
            self.learningProgressView.frame = CGRectMake(self.learningLabel.frame.origin.x, self.learningLabel.frame.origin.y + 30, self.view.frame.width/1.25, 1)
            self.learningProgressView.center.x = self.view.center.x
            //        learningProgressView.progressTintColor = UIColor.redColor()
            //        learningProgressView.progress = 0.0 //dummy progress
            
            
            self.masteredProgressView.hidden = false
            self.reviewingProgressView.hidden = false
            self.learningProgressView.hidden = false
            
            self.masteredLabel.hidden = false
            self.reviewingLabel.hidden = false
            self.learningLabel.hidden = false
            
            },completion: nil)
        
    }
    
    
    
    
    func loadProgressViewsWhenInfoClicked(){
        
        masteredProgressView.hidden = true
        reviewingProgressView.hidden = true
        learningProgressView.hidden = true
        
        masteredLabel.hidden = true
        reviewingLabel.hidden = true
        learningLabel.hidden = true
        
        
        UIView .animateWithDuration(1.0, delay: 0, options:[], animations: {
            
            

        
        self.masteredLabel.frame = CGRectMake(0, self.view.frame.height/1.5, self.view.frame.width, 20)
//        masteredLabel.text = "Master of: \(masterCounter) out of \(dao.flashCards.count) concepts"
        self.masteredLabel.textAlignment = NSTextAlignment.Center
        
        
        self.masteredProgressView.frame = CGRectMake(self.masteredLabel.frame.origin.x, self.masteredLabel.frame.origin.y + 30, self.view.frame.width/1.25, 1)
        self.masteredProgressView.center.x = self.view.center.x
//        self.masteredProgressView.progressTintColor = UIColor.greenColor()
//        masteredProgressView.progress = 0.0
        
        
        //////
        
        self.reviewingLabel.frame = CGRectMake(0, self.masteredProgressView.frame.origin.y + 30, self.view.frame.width, 20)
        
//        reviewingLabel.text = "Reviewing: \(reviewCounter) out of \(dao.flashCards.count) concepts"
        self.reviewingLabel.textAlignment = NSTextAlignment.Center
        
//        reviewingProgressView = UIProgressView.init(progressViewStyle: .Default)
        self.reviewingProgressView.frame = CGRectMake(self.reviewingLabel.frame.origin.x, self.reviewingLabel.frame.origin.y + 30, self.view.frame.width/1.25, 1)
        self.reviewingProgressView.center.x = self.view.center.x
//        reviewingProgressView.progressTintColor = UIColor.orangeColor()
//        reviewingProgressView.progress = 0.0  //dummy progress
        
        
        /////
        
        self.learningLabel.frame = CGRectMake(0, self.reviewingProgressView.frame.origin.y + 30, self.view.frame.width, 20)
//        learningLabel.text = "Still Learning: \(learningCounter) out of \(dao.flashCards.count) concepts"
        self.learningLabel.textAlignment = NSTextAlignment.Center
        
//        learningProgressView = UIProgressView.init(progressViewStyle: .Default)
       self.learningProgressView.frame = CGRectMake(self.learningLabel.frame.origin.x, self.learningLabel.frame.origin.y + 30, self.view.frame.width/1.25, 1)
        self.learningProgressView.center.x = self.view.center.x
//        learningProgressView.progressTintColor = UIColor.redColor()
//        learningProgressView.progress = 0.0 //dummy progress
        
            
            self.masteredProgressView.hidden = false
            self.reviewingProgressView.hidden = false
            self.learningProgressView.hidden = false
            
            self.masteredLabel.hidden = false
            self.reviewingLabel.hidden = false
            self.learningLabel.hidden = false
        
            },completion: nil)

    }
    
    
    
    func loadBasicUI(){
        
        
        
        flashCardContainerView.removeFromSuperview()
        flashCardTextView.removeFromSuperview()
        frontTapLabel.removeFromSuperview()
        back.removeFromSuperview()
        
        flashCardContainerView = UIView.init(frame: CGRectMake(0, 0, view.frame.size.width/1.25, view.frame.height/2))
        
        
        flashCardTextView = UITextView.init(frame: CGRectMake(0, 0,view.frame.size.width/1.25, view.frame.height/4))
        frontTapLabel =  UILabel.init(frame: CGRectMake(0,flashCardTextView.frame.size.height/2 ,flashCardTextView.frame.size.width, flashCardTextView.frame.height/2))
        
        
        flashCardContainerView.center = view.center
        
        
        flashCardTextView.editable = false
        flashCardTextView.selectable = false
        flashCardTextView.userInteractionEnabled = false
        flashCardTextView.textAlignment = NSTextAlignment.Center
        
        
        
        
        frontTapLabel.text = "Tap to see meaning ->"
        frontTapLabel.layer.cornerRadius = 10.0
        frontTapLabel.textAlignment = NSTextAlignment.Center
        frontTapLabel.adjustsFontSizeToFitWidth = true
        frontTapLabel.backgroundColor = UIColor.grayColor()
        
        flashCardContainerView.addSubview(flashCardTextView)
        flashCardTextView.addSubview(frontTapLabel)
        view.addSubview(flashCardContainerView)
        
        
        
        
        back =  UITextView(frame: CGRect(x: flashCardTextView.frame.origin.x, y: flashCardTextView.frame.origin.y, width: flashCardTextView.frame.size.width, height: flashCardTextView.frame.size.height * 1.5  ))
        
        
        
        
        back.layer.cornerRadius = 10.0
        
        
        back.delegate = self
        back.editable = false
        back.selectable = false
        
        back.userInteractionEnabled = false
        
        //        flashCardContainerView.layer.cornerRadius = 10.0
        flashCardTextView.layer.cornerRadius = 10.0
        flashCardContainerView.layer.cornerRadius = 10.0
        singleTap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        singleTap.numberOfTapsRequired = 1
        flashCardContainerView.addGestureRecognizer(singleTap)
        
    }
    
    func loadProgressLabelAndProgressViews(){
        ///
        masteredLabel = UILabel.init(frame: CGRectMake(0, view.frame.height/1.75, view.frame.width, 20))
        masteredLabel.text = "Master of: \(masterCounter) out of \(dao.flashCards.count) concepts"
        masteredLabel.textAlignment = NSTextAlignment.Center
        
        
        masteredProgressView = UIProgressView.init(progressViewStyle: .Default)
        masteredProgressView.frame = CGRectMake(masteredLabel.frame.origin.x, masteredLabel.frame.origin.y + 30, view.frame.width/1.25, 1)
        masteredProgressView.center.x = view.center.x
        masteredProgressView.progressTintColor = UIColor.greenColor()
        masteredProgressView.progress = 0.0
        
        
        //////
        
        reviewingLabel = UILabel.init(frame: CGRectMake(0, masteredProgressView.frame.origin.y + 30, view.frame.width, 20))
        
        reviewingLabel.text = "Reviewing: \(reviewCounter) out of \(dao.flashCards.count) concepts"
        reviewingLabel.textAlignment = NSTextAlignment.Center
        
        reviewingProgressView = UIProgressView.init(progressViewStyle: .Default)
        reviewingProgressView.frame = CGRectMake(reviewingLabel.frame.origin.x, reviewingLabel.frame.origin.y + 30, view.frame.width/1.25, 1)
        reviewingProgressView.center.x = view.center.x
        reviewingProgressView.progressTintColor = UIColor.orangeColor()
        reviewingProgressView.progress = 0.0  //dummy progress
        
        
        /////
        
        learningLabel = UILabel.init(frame: CGRectMake(0, reviewingProgressView.frame.origin.y + 30, view.frame.width, 20))
        learningLabel.text = "Still Learning: \(learningCounter) out of \(dao.flashCards.count) concepts"
        learningLabel.textAlignment = NSTextAlignment.Center
        
        learningProgressView = UIProgressView.init(progressViewStyle: .Default)
        learningProgressView.frame = CGRectMake(learningLabel.frame.origin.x, learningLabel.frame.origin.y + 30, view.frame.width/1.25, 1)
        learningProgressView.center.x = view.center.x
        learningProgressView.progressTintColor = UIColor.redColor()
        learningProgressView.progress = 0.0 //dummy progress
        
        
        
        
        view.addSubview(masteredLabel)
        view.addSubview(masteredProgressView)
        view.addSubview(reviewingLabel)
        view.addSubview(reviewingProgressView)
        view.addSubview(learningLabel)
        view.addSubview(learningProgressView)
        
        
        
        
    }
    
    
    

    
}


