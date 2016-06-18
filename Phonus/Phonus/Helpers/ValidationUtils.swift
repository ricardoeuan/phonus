//
//  ValidationUtils.swift
//  Phonus
//
//  Created by Ricardo Euán Romo on 5/18/16.
//  Copyright © 2016 Ricardo Euán Romo. All rights reserved.
//

import Foundation
import Eureka

var validator: Validator!
var isValidForm: Bool!

extension Form {
    
    func isValid() -> Bool {
        
        isValidForm = true        
        
        self.values(includeHidden: false).forEach {
            field in
            switch field.0 {
                case "name":
                    validator = Validator(strategy: NameStrategy())
                case "age":
                    validator = Validator(strategy: AgeStrategy())
                case "gender":
                    validator = Validator(strategy: GenderStrategy())
                case "location":
                    validator = Validator(strategy: LocationStrategy())
                case "Verificar Ubicación":
                    validator = Validator(strategy: LocationStrategy())
            default:
                validator = nil
            }
            
            if validator != nil && field.1 != nil {
                if !validator.isValidField(field.1) {
                    print("invalid field:", field.0)
                    print("invalid val:", field.1)
                    isValidForm = false
                    return
                }
            } else {
                print("nil field:", field.0)
                print("nil val:", field.1)
                isValidForm = false
            }
        }
        return isValidForm
    }
}