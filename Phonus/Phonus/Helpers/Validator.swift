//
//  Validator.swift
//  Phonus
//
//  Created by Ricardo Euán Romo on 5/13/16.
//  Copyright © 2016 Ricardo Euán Romo. All rights reserved.
//

import Foundation

protocol ValidateStrategy {
    func isValidField(field: Any?) -> Bool
}

class Validator {
    
    let strategy: ValidateStrategy
    
    func isValidField(field: Any?) -> Bool {
        return self.strategy.isValidField(field)
    }
    
    init(strategy: ValidateStrategy){
        self.strategy = strategy
    }
}

// TODO: Improve regex to accept whitespaces and limited size
class NameStrategy : ValidateStrategy{
    
    let pattern:String = "[a-z]{1,10}$"
    
    func isValidField(field: Any?) -> Bool {
        let value = field as! String
        print("NameStrategy : ",value.rangeOfString(pattern, options: .RegularExpressionSearch) != nil)
        return value.rangeOfString(pattern, options: .RegularExpressionSearch) != nil
    }
}

// TODO: Implement
// Matches any number between 1 - 120
class AgeStrategy : ValidateStrategy {
    func isValidField(field: Any?) -> Bool {
        print("AgeStrategy : true")
        return true
    }
}

// TODO: Refactor
// is M or F
class GenderStrategy : ValidateStrategy {
    func isValidField(field: Any?) -> Bool {
        let value = field as! String
        return value == "Masculino" || value == "Femenino"
    }
}

// TODO: Implement
// is between (-90, 90), (-180, 180)
class LocationStrategy : ValidateStrategy {
    func isValidField(field: Any?) -> Bool {
        print("LocationStrategy : true")
        return true
    }
}

// TODO: Implement
// Matches any digit
class ExamIdStrategy : ValidateStrategy {
    func isValidField(field: Any?) -> Bool {
        return true
    }
}
