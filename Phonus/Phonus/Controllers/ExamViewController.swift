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

class ExamViewController: FormViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var validator: Validator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib. 
        
        locationManager = CLLocationManager()
        validator = Validator(strategy:NameStrategy())
        
        // Request authorization from user
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if  isConnectedToNetwork && CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        TextRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.italicSystemFontOfSize(12)
        }
        
        form = Section("Nuevo Examen de Phonus:")
            
            +++ Section(){
                $0.tag = "unknown_s"
            }
            <<< TextFloatLabelRow("name"){
                $0.title = "Nombre:"
            }
            
            <<< IntFloatLabelRow("age"){
                $0.title = "Edad:"
            }
            
            <<< SegmentedRow<String>("gender"){
                $0.title = "Sexo:"
                $0.options = ["Masculino", "Femenino"]
                $0.value = "M"
            }
            
            +++ Section()
            
            <<< SwitchRow("Verificar Ubicación"){
                $0.title = $0.tag
            }
            
            +++ Section(footer: "Esta es tu ubicación actual y puede ser modificada manualmente"){
                $0.hidden = .Function(["Verificar Ubicación"], { form -> Bool in
                    let row: RowOf<Bool>! = form.rowByTag("Verificar Ubicación")
                    return row.value ?? false == false
                })
            }
            <<< LocationRow("location"){
                $0.title = "Tu ubicación actual"
                $0.value = locationManager.location
            }
        
            +++ Section()
            <<< ButtonRow() {
                $0.title = "Continuar"
                $0.onCellSelection { cell, row in
                    if self.form.isValid() {
                        self.performSegueWithIdentifier("AudioTest", sender: nil)
                    }
                }
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        self.form.setValues(["location" : CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)])
        self.tableView?.reloadData()
    }
    
    // MARK: Share form data to AudioTestViewController
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "AudioTest") {
            let svc = segue.destinationViewController as! AudioTestViewController
            svc.name = self.form.rowByTag("name")!.baseValue as! String
            svc.location = self.form.rowByTag("location")!.baseValue as! CLLocation
        }
    }
}