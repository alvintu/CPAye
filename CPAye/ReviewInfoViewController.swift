//
//  ReviewInfoViewController.swift
//  CPAye
//
//  Created by Jo Tu on 10/23/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//

import UIKit

import UIKit

class ReviewInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let dao = DAO.sharedInstance
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    override func viewDidLoad() {
        print("review");
    }
    
    
    override func didReceiveMemoryWarning() {
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("review", forIndexPath: indexPath) as! ReviewInfoCell
        
        
        
        cell.reviewInfo.text  = dao.currentReviewSection.info[indexPath.row] as! String
        
        //        cell.selectionStyle = UITableViewCellSelectionStyle.Default
        //        cell.questionInfoTextView.delegate = self
        //
        //
        //        cell.questionInfoTextView.userInteractionEnabled = false
        //        cell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        //
        //        cell.questionInfoTextView.delegate = self
        //
        //        switch indexPath {
        //        case NSIndexPath(forRow: 0, inSection: 0) :
        //
        //
        //            cell.questionInfoTextView.text = dao.currentQuestion.question
        //
        //        case NSIndexPath(forRow: 0, inSection: 1) :
        //            cell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        //
        //            cell.questionInfoTextView.text = dao.currentQuestion.a
        //
        //        case NSIndexPath(forRow: 0, inSection: 2) :
        //
        //            cell.questionInfoTextView.text = dao.currentQuestion.b
        //        case NSIndexPath(forRow: 0, inSection: 3) :
        //
        //            cell.questionInfoTextView.text = dao.currentQuestion.c
        //
        //        case NSIndexPath(forRow: 0, inSection: 4) :
        //
        //            cell.questionInfoTextView.text = dao.currentQuestion.d
        //
        //        default:
        //
        //            cell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        //
        //            //        }
        //        }
        return cell
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dao.currentReviewSection.info.count
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0;
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        let rowHeight :CGFloat = 50.0
        //
        //        switch indexPath {
        //
        //        case NSIndexPath(forRow: 0, inSection: 0) :
        //
        //            rowHeight = self.view.frame.height/4
        //        case NSIndexPath(forRow: 0, inSection: 1) :
        //
        //            rowHeight = self.view.frame.height/9
        //
        //
        //        case NSIndexPath(forRow: 0, inSection: 2) :
        //
        //            rowHeight = self.view.frame.height/9
        //
        //        case NSIndexPath(forRow: 0, inSection: 3) :
        //
        //            rowHeight = self.view.frame.height/9
        //
        //        case NSIndexPath(forRow: 0, inSection: 4) :
        //
        //            rowHeight = self.view.frame.height/9
        //
        //        default:
        //
        //            rowHeight = self.view.frame.height/9
        //
        //        }
        
        return rowHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        print(dao.review[indexPath.row].info)
        
        
        //        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        //        selectedCell.contentView.backgroundColor = UIColor(red:0.98, green:0.17, blue:0.41, alpha:1.0)
        //
        //        let tempCell = selectedCell as! QuizCell
        //        tempCell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        //
        //
        //        UIView.animateWithDuration(1.0, animations: {
        //
        //            self.infoButton.hidden = true
        //            self.nextButton.hidden = true
        //
        //
        //            self.infoButton.hidden = false
        //            self.nextButton.hidden = false
        //
        //        })
        //
        //        switch indexPath {
        //            //cell.titleLabel.text = "\(currentShop.categoryDeal) - 09/12/2016 - Hunter College" //specifics later
        //
        //
        //        case NSIndexPath(forRow: 0, inSection: 0) :
        //
        //            selectedCell.contentView.backgroundColor = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0)
        //
        //            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()
        //
        //
        //
        //
        //        case NSIndexPath(forRow: 0, inSection: 1) :
        //
        //            enableButtons()
        //
        //            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()
        //
        //
        //
        //            if(dao.currentQuestion.correctAnswer == "a"){
        //
        //                UIView.animateWithDuration(0.5, animations: {
        //
        //                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
        //
        //                    selectedCell.contentView.backgroundColor = UIColor(red:0.64, green:0.91, blue:0.53, alpha:1.0)
        //
        //                })
        //
        //
        //
        //                print("correct")
        //
        //            }
        //            else{
        //                print("incorrect")
        //
        //                UIView.animateWithDuration(0.5, animations: {
        //                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
        //
        //                    selectedCell.contentView.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
        //
        //
        //                })
        //
        //            }
        //
        //
        //        case NSIndexPath(forRow: 0, inSection: 2) :
        //            enableButtons()
        //
        //            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()
        //
        //
        //            if(dao.currentQuestion.correctAnswer == "b"){
        //
        //                UIView.animateWithDuration(0.5, animations: {
        //                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
        //
        //                    selectedCell.contentView.backgroundColor = UIColor(red:0.64, green:0.91, blue:0.53, alpha:1.0)
        //
        //
        //
        //                })
        //
        //
        //            }
        //            else{
        //
        //                UIView.animateWithDuration(0.5, animations: {
        //                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
        //
        //                    selectedCell.contentView.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
        //
        //
        //                })
        //
        //            }
        //
        //
        //
        //        case NSIndexPath(forRow: 0, inSection: 3) :
        //            enableButtons()
        //
        //            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()
        //
        //
        //            if(dao.currentQuestion.correctAnswer == "c"){
        //
        //                UIView.animateWithDuration(0.5, animations: {
        //                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
        //
        //                    selectedCell.contentView.backgroundColor = UIColor(red:0.64, green:0.91, blue:0.53, alpha:1.0)
        //
        //                })
        //
        //
        //
        //            }
        //            else{
        //
        //                UIView.animateWithDuration(0.5, animations: {
        //                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
        //
        //                    selectedCell.contentView.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
        //                })
        //
        //
        //
        //
        //            }
        //        case NSIndexPath(forRow: 0, inSection: 4) :
        //            enableButtons()
        //
        //            tempCell.questionInfoTextView.textColor = UIColor.whiteColor()
        //
        //
        //            if(dao.currentQuestion.correctAnswer == "d"){
        //
        //                UIView.animateWithDuration(0.5, animations: {
        //                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
        //
        //                    selectedCell.contentView.backgroundColor = UIColor(red:0.64, green:0.91, blue:0.53, alpha:1.0)
        //
        //                })
        //
        //
        //
        //
        //            }
        //            else{
        //                
        //                UIView.animateWithDuration(0.5, animations: {
        //                    selectedCell.contentView.backgroundColor = UIColor.whiteColor()
        //                    
        //                    selectedCell.contentView.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
        //                    
        //                    
        //                })
        //                
        //                
        //                
        //            }
        //            
        //            
        //            
        //            
        //        default:
        //            tempCell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        //            
        //            print("default")
        //            
        //            //            selectedCell.contentView.backgroundColor = UIColor.whiteColor()
        //            
    }
    



func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//    let cellToDeSelect:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
//    cellToDeSelect.contentView.backgroundColor = UIColor.whiteColor()
//    
//    
//    
    //        let tempCell = cellToDeSelect as! QuizCell
    //        
    //        
    //        switch indexPath {
    //            //cell.titleLabel.text = "\(currentShop.categoryDeal) - 09/12/2016 - Hunter College" //specifics later
    //            
    //            
    //        case NSIndexPath(forRow: 0, inSection: 0) :
    //            tempCell.questionInfoTextView.textColor =  UIColor.blackColor()
    //            
    //        default:
    //            
    //            
    //            tempCell.questionInfoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
    
    //        }
    //    }
}
}