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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.italicSystemFontOfSize(12)
        }
        
        form = Section("Búsqueda:")
            <<< IntRow("examenId"){
                $0.title = "ID de Examen:"
            }
            
            +++ Section("Results")
            <<< TextRow("Date") {
                $0.title = "Fecha"
                $0.disabled = true
            }
            <<< NameRow("Name") {
                $0.title = "Nombre"
                $0.disabled = true
            }
            <<< IntRow("MinFreq") {
                $0.title = "Minimum Frequency"
                $0.disabled = true
            }
            <<< IntRow("MaxFreq") {
                $0.title = "Maximum Frequency"
                $0.disabled = true
            }
            
            +++ Section()
            <<< ButtonRow() {
                $0.title = "Buscar"
                $0.onCellSelection { cell, row in
                    self.loadExamDetails(self.form.values()["examenId"] as! Int)
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadExamDetails(examId: Int) {
        PhonusAPIManager.sharedInstance.getExamDetails(examId) { result in
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
            self.form.setValues(["Date": examDetails.date, "Name": examDetails.name, "MinFreq": examDetails.minFrequency, "MaxFreq": examDetails.maxFrequency])
            self.tableView?.reloadData()
            print(examDetails.description())
        }
    }
}