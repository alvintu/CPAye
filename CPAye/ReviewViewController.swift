//
//  ReviewViewController.swift
//  CPAye
//
//  Created by Jo Tu on 10/18/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let dao = DAO.sharedInstance
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var reviewInfoVC = UIViewController()
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.title = "Review"
        

    }
    
    
    override func didReceiveMemoryWarning() {
        
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("review", forIndexPath: indexPath) as! ReviewCell
        
    
        
        
        cell.sectionNameLabel.text = dao.review[indexPath.row].title
    
        return cell
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dao.review.count
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0;
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        let rowHeight :CGFloat = 50.0

        
        return rowHeight
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        print(dao.review[indexPath.row].info)
        
        reviewInfoVC = mainStoryboard.instantiateViewControllerWithIdentifier("reviewInfo")
        
        let currentReviewSection = dao.review[indexPath.row]
        dao.currentReviewSection = currentReviewSection
        self.navigationController?.pushViewController(reviewInfoVC, animated: true)
        

//            
        }
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cellToDeSelect:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        cellToDeSelect.contentView.backgroundColor = UIColor.whiteColor()
        
        
        

}

