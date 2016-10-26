//
//  ReviewInfoViewController.swift
//  CPAye
//
//  Created by Jo Tu on 10/23/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//

import UIKit

import UIKit

class ReviewInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate {
    let dao = DAO.sharedInstance
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    override func viewDidLoad() {
        

        print("review");
    }
    
    
    override func didReceiveMemoryWarning() {
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("review", forIndexPath: indexPath) as! ReviewInfoCell
        cell.reviewInfo.delegate = self

        
        
        
        cell.reviewInfo.text  = dao.currentReviewSection.info[indexPath.row] as! String
        

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
        
        let rowHeight :CGFloat = 75.0
 
        
        return rowHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        print(dao.review[indexPath.row].info)
        
        
    }
    



func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {

}
}