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
        
        
    }

    
    override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
    }
}
