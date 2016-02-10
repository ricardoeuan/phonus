//
//  FirstViewController.swift
//  prueba
//
//  Created by Raúl T on 01/02/16.
//  Copyright © 2016 rtc. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let edades = ["8","9","10","11","12","..."]
    

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return edades.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    return edades[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    

}

