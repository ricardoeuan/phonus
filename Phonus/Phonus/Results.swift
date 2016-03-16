//
//  Results.swift
//  Phonus
//
//  Created by Raúl T on 15/03/16.
//  Copyright © 2016 Ricardo Euán. All rights reserved.
//

import Foundation
import UIKit

class TestResult: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLayoutSubviews() {

        message.text = "Thanks for participating \(name). Your results have been sent."
        
    }
    

}