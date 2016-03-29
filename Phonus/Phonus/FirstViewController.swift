//
//  FirstViewController.swift
//  Phonus
//
//  Created by Ricardo Euán on 2/19/16.
//  Copyright © 2016 Ricardo Euán. All rights reserved.
//

import UIKit

var name = ""
var selectedAge = ""

class FirstViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nameInput: UITextField!
   
    @IBOutlet weak var pickAge: UIPickerView!
    
    var ageArray = ["8 - 10", "11 - 13", "14 - 16", "17+"]
    
    @IBAction func sendInfo(sender: AnyObject) {
        
        name = String(nameInput.text!)
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ageArray.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return ageArray[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedAge = ageArray[row]
        
    }

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.nameInput.delegate = self
        
      //  self.pickAge.delegate = self
        //self.pickAge.dataSource = self
        
        
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

