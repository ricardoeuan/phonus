//
//  ExamViewController.swift
//  Phonus
//
//  Created by Ricardo Euán Romo on 4/24/16.
//  Copyright © 2016 Ricardo Euán Romo. All rights reserved.
//

import UIKit
import Eureka
import CoreLocation

class ExamViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        TextRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.italicSystemFontOfSize(12)
        }
        
        form = Section("Nuevo Examen de Phonus:")
            <<< SegmentedRow<String>("segments"){
                $0.options = ["Anonimo", "Registrado"]
                $0.value = "Registrado"
            }
            +++ Section(){
                $0.tag = "unknown_s"
                $0.hidden = "$segments != 'Anonimo'" // .Predicate(NSPredicate(format: "$segments != 'Sport'"))
            }
            <<< NameRow(){
                $0.title = "Nombre:"
            }
            
            <<< NameRow(){
                $0.title = "Apellido Paterno:"
            }
            
            <<< NameRow(){
                $0.title = "Apellido Materno:"
            }
            
            +++ Section(){
                $0.tag = "registered_s"
                $0.hidden = "$segments != 'Registrado'"
            }
            <<< IntRow(){
                $0.title = "ID de Examen:"
            }
            
            +++ Section()
            
            <<< SwitchRow("Modificar Ubicación"){
                $0.title = $0.tag
            }
            
            +++ Section(footer: "Esta es tu ubicación actual y puede ser modificada manualmente"){
                $0.hidden = .Function(["Modificar Ubicación"], { form -> Bool in
                    let row: RowOf<Bool>! = form.rowByTag("Modificar Ubicación")
                    return row.value ?? false == false
                })
            }
            <<< LocationRow(){
                $0.title = "Tu ubicación actual"
                $0.value = CLLocation(latitude: 21.9329867, longitude: -102.3394496)
        }
        
            +++ Section()
            <<< ButtonRow() {
                $0.title = "Continue"
                $0.onCellSelection { cell, row in
                    // Validate
                    self.performSegueWithIdentifier("AudioTest", sender: nil)
                }
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}