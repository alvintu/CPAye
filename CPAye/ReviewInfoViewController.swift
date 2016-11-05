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
//    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    override func viewDidLoad() {
        

        print("review");
    }
    
    
    override func didReceiveMemoryWarning() {
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "review", for: indexPath) as! ReviewInfoCell

        
        
        
        cell.reviewInfo.text  = dao.currentReviewSection.info[indexPath.row]
        cell.reviewInfo.delegate = self

        

        return cell
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dao.currentReviewSection.info.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        let rowHeight :CGFloat = 100.0
        
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print(dao.review[indexPath.row].info)
        
        
    }
    



func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

}
}
