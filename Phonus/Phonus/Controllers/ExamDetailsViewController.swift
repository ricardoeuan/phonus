//
//  ResultsViewController.swift
//  Phonus
//
//  Created by Ricardo Euán Romo on 4/24/16.
//  Copyright © 2016 Ricardo Euán Romo. All rights reserved.
//

import UIKit
import Eureka

class ExamDetailsViewController: FormViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadExamDetails()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadExamDetails() {
        PhonusAPIManager.sharedInstance.getExamDetails(21) { result in
            // Validate response error
            if let error = result.error {
                print("Error calling /examen/DetallesExamen")
                print(error)
                return
            }
            
            // Validate response is not nil
            guard let examDetails = result.value else {
                print("Error calling /examen/DetallesExamen : result is nil")
                return
            }
            print(examDetails.description())
        }
    }
}