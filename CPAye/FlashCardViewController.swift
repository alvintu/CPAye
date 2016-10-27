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
    
    @IBOutlet weak var flashCardContainerView: UIView!
    @IBOutlet weak var flashCardTextView: UITextView!
    @IBOutlet weak var frontTapLabel: UILabel!
    
    var back: UITextView!
    var knowButton : UIButton!
    var dontKnowButton : UIButton!
    var singleTap  = UITapGestureRecognizer()
    
    var showingAnswer = false


    
    
    override func viewDidLoad() {
        
        back =  UITextView(frame: CGRect(x: flashCardTextView.frame.origin.x, y: flashCardTextView.frame.origin.y, width: flashCardTextView.frame.size.width, height: flashCardTextView.frame.size.height * 2.5))

        back.delegate = self
        back.editable = false
        back.selectable = false
        back.userInteractionEnabled = false
        
        let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(26)]
        let boldString = NSMutableAttributedString(string:dao.currentFlashCard.concept, attributes:attrs)
        
        
        flashCardTextView.attributedText = boldString
        flashCardTextView.textAlignment = .Center
        

       





         singleTap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        singleTap.numberOfTapsRequired = 1
        
        flashCardContainerView.addGestureRecognizer(singleTap)


        
//        loadHiddenButtons()
        
        print("flashCard")
    }
    
    
    
    
    
    func loadHiddenButtons(){
        
//        knowButton.removeFromSuperview()
//        dontKnowButton.removeFromSuperview()
//        
        

        
        
        knowButton = UIButton(frame: CGRect(x: 0, y: (back.frame.height - back.frame.height/2), width: back.frame.width/1.5, height: back.frame.height/4))
        knowButton.backgroundColor = UIColor.greenColor()
        knowButton.setTitle("I know this word", forState: .Normal)
        knowButton.addTarget(self, action: #selector(knowThisWord), forControlEvents: .TouchUpInside)
        
        self.flashCardContainerView.addSubview(knowButton)
        
        dontKnowButton = UIButton(frame: CGRect(x:0, y: (knowButton.frame.origin.y + knowButton.frame.size.height), width: knowButton.frame.width, height: knowButton.frame.height))
        dontKnowButton.backgroundColor = UIColor.redColor()
        
        dontKnowButton.setTitle("I don't know this word", forState: .Normal)
        dontKnowButton.addTarget(self, action: #selector(dontKnowThisWord), forControlEvents: .TouchUpInside)
        
        self.flashCardContainerView.addSubview(dontKnowButton)


//        knowButton.hidden = fa
//        dontKnowButton.hidden = true
        
    }
    func knowThisWord(){
        
        print("I know")
        
        //know counter on flashCard
        //
        let originalFrame = self.flashCardContainerView.frame
        
        UIView.animateWithDuration(0.6, delay: 0, options: [], animations: {
            self.flashCardContainerView.frame = CGRectMake(-800, self.flashCardContainerView.frame.origin.y, self.flashCardContainerView.frame.size.width, self.flashCardContainerView.frame.size.height)
//            self.flashCardContainerView.hidden = true


            }, completion: {_ in
                UIView.animateWithDuration(0.1, delay: 0, options:[], animations: {
                
                        self.flashCardContainerView.hidden = true
                
                self.flashCardContainerView.frame = CGRectMake(900, self.flashCardContainerView.frame.origin.y, self.flashCardContainerView.frame.size.width, self.flashCardContainerView.frame.size.height)
                
                
                
                    },completion:{ _ in
                        
                        UIView .animateWithDuration(0.4, delay: 0, options:[], animations: {
                            self.flashCardContainerView.hidden = false
                            
                            
                            self.flashCardContainerView.frame = CGRectMake(originalFrame.origin.x, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height)
                            
                        },completion: nil)
                        
                        
                    }
            )
        })

    
            

            
        

        
        
//        self.flashCardContainerView.hidden = true


        
        
  
        
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
            showingAnswer = true
            
            flashCardContainerView.removeGestureRecognizer(singleTap)

        
    }
        loadHiddenButtons()

    
        

        



    }
    
    
    
    
    
    
    

    
    
    


}


