//
//  ReviewSection.swift
//  CPAye
//
//  Created by Jo Tu on 10/23/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//

import Foundation



class ReviewSection: NSObject {
    
    var title  : String
    var info = []
    
    init(title:String,info:NSMutableArray) {
        
        self.title = title
        self.info = info
        
    }
    
}