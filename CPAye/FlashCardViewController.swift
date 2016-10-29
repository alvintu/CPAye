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
    var frontTapLabelCopy : UILabel!
    
    var showingAnswer = false

    
    var currentFlashCardIndex = 0
    


    
    
    override func viewDidLoad() {
        

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FlashCardViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)

        

        
        currentFlashCardIndex = prefs.integerForKey("currentFlashCardIndex")
        dao.currentFlashCard = dao.flashCards[currentFlashCardIndex]
        print(currentFlashCardIndex)

        
        rotated()

        


        
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
        
    }
    
    
    

    func knowThisWord(){
        
        print("I know")
        
        
        
        
        

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
        
        slideFlashCard()

        
    }

    func dontKnowThisWord(){
        
        print("I don't know.")
        
        //put the same information
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
    
    
}


