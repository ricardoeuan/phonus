//
//  FirstViewController.swift
//  Phonus
//
//  Created by Ricardo Euán on 2/19/16.
//  Copyright © 2016 Ricardo Euán. All rights reserved.
//

import UIKit

var name = ""

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameInput: UITextField!
   
    @IBAction func sendInfo(sender: AnyObject) {
        
        name = String(nameInput.text!)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.nameInput.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //close keyboard when touch outside the keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    //close keyboard with intro Key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }


}

