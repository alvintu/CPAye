//
//  FlashCardClass.swift
//  CPAye
//
//  Created by Jo Tu on 10/25/16.
//  Copyright © 2016 alvorithms. All rights reserved.
//


import Foundation



class FlashCardClass: NSObject {
    
    var concept  : String
    var definition : String
    
    init(concept:String,definition:String) {
        
        self.concept = concept
        self.definition = definition
        
    }
    
}