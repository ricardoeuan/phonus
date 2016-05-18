//
//  AudioTestViewController.swift
//  Phonus
//
//  Created by Ricardo Euán Romo on 4/25/16.
//  Copyright © 2016 Ricardo Euán Romo. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import CoreLocation
import CoreData

//var exams = [NSManagedObject]()

class AudioTestViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    
    var engine: AVAudioEngine!
    var tone: AVTonePlayerUnit!
    var asyncSliderUpdater: NSTimer!
    let minSliderVal:Float = 0.0
    let maxSliderVal:Float = 20000.0
    
    var ipAddress:String!
    var isTestCompleted: Bool = false
    
    var progress: KDCircularProgress!
    
    // MARK: Shared variables from ExaViewController
    
    var name: String!
    var location: CLLocation!    
    
    override func viewDidAppear(animated: Bool) {
        //TEST POST operation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.color(0, green: 25, blue: 51, alpha: 1)
        lowButton.backgroundColor = UIColor.whiteColor()
        highButton.backgroundColor = UIColor.whiteColor()
        
        tone = AVTonePlayerUnit()
        label.text = String(format: "%.1f", tone.frequency) + " Hz"
        slider.minimumValue = minSliderVal
        slider.maximumValue = maxSliderVal
        slider.value = 8000.0
        slider.hidden = true
        
        let format = AVAudioFormat(standardFormatWithSampleRate: tone.sampleRate, channels: 1)
        
        engine = AVAudioEngine()
        engine.attachNode(tone)
        
        let mixer = engine.mainMixerNode
        engine.connect(tone, to: mixer, format: format)
        do {
            try engine.start()
        } catch let error as NSError {
            print(error)
        }
        
        if let ipAddress = NetworkUtils.getIPAddress() {
            self.ipAddress = ipAddress
        } else {
            self.ipAddress = "127.0.0.1"
        }
        
        initCircularProgress()
        startPlaying()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: KDCircularProgress
    
    func initCircularProgress() {
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        progress.startAngle = -90
        progress.angle = Double(slider.value / 55.5555556)
        progress.progressThickness = 0.6
        progress.trackThickness = 0.8
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = true
        progress.glowMode = .Forward
        //progress.setColors(UIColor.color(0, green: 245, blue: 255, alpha: 1))
        progress.setColors(UIColor.color(0, green: 204, blue: 204, alpha: 1))
        progress.trackColor = UIColor.darkGrayColor()
        progress.center = CGPoint(x: view.center.x, y: view.center.y)
        view.addSubview(progress)
    }
    
    // MARK: AVPlayerUnit start
    func startPlaying() {
        tone.preparePlaying()
        tone.play()
        engine.mainMixerNode.volume = 1.0
    }
    
    // MARK: Slider Control
    // Uncomment this function to adapt to one-touch interaction test
    /*func asyncSliderUpate() {
        slider.value += 0.1690715383
        let freq = 8000.0 * pow(2.0, Double(slider.value))
        tone.frequency = freq
        progress.angle = Double((slider.value * 55.5555556) + 285)
        label.text = String(format: "%.1f", freq) + " Hz"
    }*/
    
    // MARK: Send Results Confirmation
    
    func showConfirmationAlert() {
        let resultsAlert = UIAlertController(title: "Resultados", message: String(format: "%.1f", tone.frequency) + " Hz\n" + getResultsAdvice(), preferredStyle: UIAlertControllerStyle.Alert)
        resultsAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            if isConnectedToNetwork {
                PhonusAPIManager.sharedInstance.postExam(self.name, maxFrequency: self.tone.frequency, minFrequency: 20.0, ipAddress: self.ipAddress, latitude: self.location.coordinate.latitude, longitude: self.location.coordinate.longitude, completionHandler: { result in
                    guard result.error == nil, let successValue = result.value
                        where successValue as! NSObject == true else {
                            if let error = result.error {
                                print(error)
                            }
                            let alertController = UIAlertController(title: "Error al enviar examen de Phonus",
                                message: "Lo sentimos, tus resultados no se han podido enviar. " +
                                "Es posible que el servicio de Phonus no esté disponible.",
                                preferredStyle: .Alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            alertController.addAction(okAction)
                            self.presentViewController(alertController, animated:true, completion: nil)
                            return
                    }
                    self.navigationController?.popViewControllerAnimated(true)
                })
            } else {
                
                // There's no network connection. Store variables in dataModel to be sent once we're connected
                
                let alert = UIAlertController(title: "No se ha Enviado el Examen", message: "Phonus guardará tus resultados y los enviará cuando tengas una conexión a internet.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }))
                
                self.storePendingExam(self.name, maxFrequency: self.tone.frequency, minFrequency: 20.0, ipAddress: self.ipAddress, latitude: self.location.coordinate.latitude, longitude: self.location.coordinate.longitude)
                self.presentViewController(alert, animated: true, completion: nil)                                
            }
        
            //POST without router implementation
            /*
            let postEndpoint: String = "https://phonus.azurewebsites.net/api/examen/Registrar"
            let newPost: [String : AnyObject] = [
                "NombreAplicante" : "\"\(self.name)\"",
                "FrecuenciaMaxima" : self.tone.frequency,
                "FrecuenciaMinima" : 250,
                "DireccionIp" : "\(self.ipAddres)",
                "Latitud" : self.location.coordinate.latitude,
                "Longitud" : self.location.coordinate.longitude ]
            Alamofire.request(.POST, postEndpoint, parameters: newPost, encoding: .JSON)
                .responseJSON{ response in
                    guard response.result.error == nil else {
                        print(response.result.error)
                        return
                    }
                    
                    if let value: AnyObject = response.result.value {
                        let post = JSON(value)
                        print("The post is: " + post.description)
                    }
            }
            self.navigationController?.popViewControllerAnimated(true)*/
    }))
        resultsAlert.addAction(UIAlertAction(title: "Cancelar", style: .Default, handler: nil))
        presentViewController(resultsAlert, animated: true, completion: nil)
    }
    
    func getJSONFromDictionary(params: NSDictionary) -> NSData {
        let jsonParams: NSData!
        do {
            jsonParams = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch {
            jsonParams = nil
        }
        return jsonParams
    }
    
    func storePendingExam(name: String, maxFrequency: Double, minFrequency: Double, ipAddress: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("Exam",
                                                        inManagedObjectContext:managedContext)
        
        let exam = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
        
        exam.setValue(name, forKey: "name")
        exam.setValue(maxFrequency, forKey: "maxFrequency")
        exam.setValue(minFrequency, forKey: "minFrequency")
        exam.setValue(ipAddress, forKey: "ipAddress")
        exam.setValue(latitude, forKey: "latitude")
        exam.setValue(longitude, forKey: "longitude")
        
        do {
            try managedContext.save()
            //exams.append(exam)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func getResultsAdvice() -> String {
        return tone.frequency > 16000 ? "Excelente !" : "Es recomendable que visites a tu médico"
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        super.willMoveToParentViewController(parent)
        if parent == nil {
            engine.mainMixerNode.volume = 0.0
            tone.stop()
        }
    }
    
    // MARK: UI Actions
    // Uncomment below UI actions to adapt to one-touch interaction test
    /*@IBAction func startTest(sender: AnyObject) {
        tone.preparePlaying()
        tone.play()
        engine.mainMixerNode.volume = 1.0
        asyncSliderUpdater = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(AudioTestViewController.asyncSliderUpate), userInfo: nil, repeats: true)
    }
    
    @IBAction func endTest(sender: AnyObject) {
        asyncSliderUpdater.invalidate()
        engine.mainMixerNode.volume = 0.0
        tone.stop()
        showConfirmationAlert()
    }*/
    
    
    @IBAction func increaseFrequency(sender: UIButton) {
        if(isTestCompleted) {
            engine.mainMixerNode.volume = 0.0
            tone.stop()
            showConfirmationAlert()
        } else {
            slider.value += 1000
            let freq = Double(slider.value)
            tone.frequency = freq
            progress.angle = Double(slider.value / 55.5555556)
            label.text = String(format: "%.1f", freq) + " Hz"
        }
    }
    
    @IBAction func lowerFrequency(sender: UIButton) {
        isTestCompleted = true
        slider.value -= 100
        let freq = Double(slider.value)
        tone.frequency = freq
        progress.angle = Double(slider.value / 55.5555556)
        label.text = String(format: "%.1f", freq) + " Hz"
    }
    
}