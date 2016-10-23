//
//  QuestionInfoViewController.swift
//  CPAye
//
//  Created by Jo Tu on 10/20/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//

import UIKit

class QuestionInfoViewController: UIViewController {
    
    let dao = DAO.sharedInstance
    
    @IBOutlet weak var infoTextView: UITextView!
    var info : String = ""
    var passedInfo : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    infoTextView.text =  dao.currentQuestion.info
        
        
        infoTextView.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)

    }

    
    override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
    }
}
