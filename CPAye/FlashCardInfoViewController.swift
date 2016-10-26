//
//  FlashCardInfoViewController.swift
//  CPAye
//
//  Created by Jo Tu on 10/25/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//

//
//  ReviewInfoViewController.swift
//  CPAye
//
//  Created by Jo Tu on 10/23/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//


import UIKit

class FlashCardInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate {
    let dao = DAO.sharedInstance
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    override func viewDidLoad() {
        
        
        print("review");
    }
    
    
    override func didReceiveMemoryWarning() {
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("flashCardInfo", forIndexPath: indexPath) as! FlashCardInfoCell
        
        
        cell.definitionLabel.delegate = self
        
        cell.definitionLabel.text = dao.currentFlashCard.definition
        
        
        //navigation controller clear and navigation text should beb gcolor
//tableview row 0 black text white bg
    //row 1 dark grey text light gray bg
        
        //ui
    //mastered label (kvo)
        //mastered gauge  (kvo)
        //revieing label
        //lgauge
        //learning label
        //learning gauge
        
        //you have mastered-5 times
        //reviewing know concept 1-2 times
        //learning don't know this word
        
        
        return cell
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0;
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        let rowHeight :CGFloat = 75.0
        
        
        return rowHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        //pressing action should just be pushed back to previous flash card concept
        //the main flash card vc should have a navcontroller and a way to go to next flash card 
        //maybe a swipe gesture to see the next flashcard concept oder  ..... 
        //data persistence to keep track of current flash card
        //fuc with scrambling questions
        
//        print(dao.review[indexPath.row].info)
        
        
    }
    
    
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}