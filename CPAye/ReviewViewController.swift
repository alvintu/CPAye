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
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.title = "Review"
        

    }
    
    
    override func didReceiveMemoryWarning() {
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "review", for: indexPath) as! ReviewCell
        
    
        
        
        cell.sectionNameLabel.text = dao.review[indexPath.row].title
    
        return cell
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dao.review.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        let rowHeight :CGFloat = 50.0

        
        return rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print(dao.review[indexPath.row].info)
        
        reviewInfoVC = mainStoryboard.instantiateViewController(withIdentifier: "reviewInfo")
        
        let currentReviewSection = dao.review[indexPath.row]
        dao.currentReviewSection = currentReviewSection
        self.navigationController?.pushViewController(reviewInfoVC, animated: true)
        

//            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAtIndexPath indexPath: IndexPath) {
        let cellToDeSelect:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cellToDeSelect.contentView.backgroundColor = UIColor.white
        
        
        

}

