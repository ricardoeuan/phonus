//
//  TestController.swift
//  Phonus
//
//  Created by Raúl T on 15/03/16.
//  Copyright © 2016 Ricardo Euán. All rights reserved.
//

import Foundation
import UIKit

var hzResults = ""
class Test: UIViewController {

    var minus = true
    var plus = true
    
    @IBOutlet var continueButton: UIButton!
    
    @IBOutlet weak var value: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func yesButton(sender: AnyObject) {
        
        slider.value += 1000
        hzValue()

    }
    
    @IBAction func noButton(sender: AnyObject) {
        
        slider.value -= 100
        hzValue()

        //continueButton.hidden = false

        
    }
    
    func hzValue () {
        
        value.text = String(Int(slider.value))
        hzResults = value.text!
        
    }
    
    override func viewDidLoad() {
        
        //continueButton.hidden = true
        
        value.text = String(Int(slider.value))
        
        
        
    }
    
    
}
