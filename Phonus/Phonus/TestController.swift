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
    
    @IBOutlet var playB: UIButton!
    @IBAction func playButton(sender: AnyObject) {
        
        playB.hidden = true
        yesB.hidden = false
        noB.hidden = false
        //continueButton.hidden = false
        
    }
    
    @IBOutlet var continueButton: UIButton!
    
    @IBOutlet weak var value: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet var yesB: UIButton!
    @IBAction func yesButton(sender: AnyObject) {
        
        if plus == false {
            
            continueButton.hidden = false
            noB.hidden = true
            yesB.hidden = true
            
        }
        
        else {
            slider.value += 1000
        }
        
        
        hzValue()
        plus = true

    }
    
    @IBOutlet var noB: UIButton!
    @IBAction func noButton(sender: AnyObject) {
        
        slider.value -= 100
        hzValue()
        plus = false
        
    }
    
    func hzValue () {
        
        value.text = String(Int(slider.value))
        hzResults = value.text!
        
    }
    
    override func viewDidLoad() {
        
        yesB.hidden = true
        noB.hidden = true
        continueButton.hidden = true
        value.text = String(Int(slider.value))
        
        
        
    }
    
    
}
