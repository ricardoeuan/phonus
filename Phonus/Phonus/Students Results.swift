//
//  Students Results.swift
//  Phonus
//
//  Created by Raúl T on 15/03/16.
//  Copyright © 2016 Ricardo Euán. All rights reserved.
//

import Foundation
import UIKit

class StudentsResults: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var studentInfo: UIView!
    
    @IBOutlet weak var studentID: UITextField!
    
    override func viewDidLoad() {
        
        self.studentID.delegate = self
        
    }
    
    //close keyboard when touch outside the keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
}
