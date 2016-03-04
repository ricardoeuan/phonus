//
//  FirstViewController.swift
//  Phonus
//
//  Created by Ricardo Euán on 2/19/16.
//  Copyright © 2016 Ricardo Euán. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var nameInput: UITextField!

    @IBOutlet weak var resultsLabel: UILabel!
    
    @IBOutlet weak var resultsSentLabel: UILabel!
    
   
    @IBAction func sendInfo(sender: AnyObject) {
        
        //resultsSentLabel.text = nameInput.text
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

