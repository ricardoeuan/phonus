//
//  Validator.swift
//  Phonus
//
//  Created by Ricardo Euán Romo on 5/13/16.
//  Copyright © 2016 Ricardo Euán Romo. All rights reserved.
//

import Foundation

protocol ValidateStrategy {
    func isValidString(string: String) -> Bool
}

class Validator {
    
    let strategy: ValidateStrategy
    
    func isValidString(string: String) -> Bool {
        return self.strategy.isValidString(string)
    }
    
    init(strategy: ValidateStrategy){
        self.strategy = strategy
    }
}

// TODO: Improve regex to accept whitespaces and limited size
class NameStrategy : ValidateStrategy{
    
    let pattern:String = "[a-z]{1,10}$"
    
    func isValidString(string: String) -> Bool {
        
        return string.rangeOfString(pattern, options: .RegularExpressionSearch) != nil
        
    }
}