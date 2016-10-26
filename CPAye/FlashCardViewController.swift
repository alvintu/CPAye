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

class FlashCardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let dao = DAO.sharedInstance
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var flashCardInfoVC = UIViewController()
    
    override func viewDidLoad() {
    }
    
    
    override func didReceiveMemoryWarning() {
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("flashCard", forIndexPath: indexPath) as! FlashCardCell
        
        
        cell.conceptLabel.text = dao.flashCards[indexPath.row].concept
        
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
        
        let rowHeight :CGFloat = 50.0
        
        
        return rowHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        flashCardInfoVC = mainStoryboard.instantiateViewControllerWithIdentifier("flashCardInfo")
        
        let currentFlashCard = dao.flashCards[indexPath.row]
        dao.currentFlashCard = currentFlashCard
        self.navigationController?.pushViewController(flashCardInfoVC, animated: true)
        
        
        //
    }
    

func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    let cellToDeSelect:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
    cellToDeSelect.contentView.backgroundColor = UIColor.whiteColor()
    
    
    
}


}


