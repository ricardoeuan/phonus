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
    
    var validator: Validator!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        validator = Validator(strategy: ExamIdStrategy())
        
        TextRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.italicSystemFontOfSize(12)
        }
        
        form = Section("Búsqueda:")
            <<< IntRow("examenId"){
                $0.title = "ID de Examen:"
            }
            +++ Section("Examen")
            <<< TextRow("Date") {
                $0.title = "Fecha"
                $0.disabled = true
            }
            <<< NameRow("Name") {
                $0.title = "Nombre"
                $0.disabled = true
            }
            <<< IntRow("MinFreq") {
                $0.title = "Frecuencia Mínima"
                $0.disabled = true
            }
            <<< IntRow("MaxFreq") {
                $0.title = "Frecuencia Máxima"
                $0.disabled = true
            }
            
            +++ Section()
            <<< ButtonRow() {
                $0.title = "Buscar"
                $0.onCellSelection { cell, row in
                    // 1st Validation nil
                    if self.form.rowByTag("examenId")!.baseValue != nil {
                        // 2nd Validation regex
                        if self.validator.isValidString(String(self.form.rowByTag("examenId")!.baseValue)) {
                            self.loadExamDetails(self.form.values()["examenId"] as! Int)
                        }
                    }
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