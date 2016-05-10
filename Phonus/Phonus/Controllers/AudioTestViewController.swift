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

class AudioTestViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    
    var engine: AVAudioEngine!
    var tone: AVTonePlayerUnit!
    var asyncSliderUpdater: NSTimer!
    let minSliderVal:Float = -5.0       //  250 hz
    let maxSliderVal:Float = 1.321925   //  20000 hz
    
    var progress: KDCircularProgress!
    
    // MARK: Shared variables from ExaViewController
    
    var name: String!
    var location: CLLocation!
    
    var examParams:[String: AnyObject]!
    
    override func viewDidAppear(animated: Bool) {
        //TEST POST operation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.color(0, green: 51, blue: 102, alpha: 1)
        
        tone = AVTonePlayerUnit()
        label.text = String(format: "%.1f", tone.frequency) + " Hz"
        slider.minimumValue = minSliderVal
        slider.maximumValue = maxSliderVal
        slider.value = 0.0
        
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
        
        initCircularProgress()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: KDCircularProgress
    
    func initCircularProgress() {
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        progress.startAngle = -90
        progress.angle = Double((slider.value * 55.5555556) + 285)
        progress.progressThickness = 0.6
        progress.trackThickness = 0.8
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = true
        progress.glowMode = .Forward
        //progress.setColors(UIColor.color(0, green: 245, blue: 255, alpha: 1))
        progress.setColors(UIColor.greenColor())
        progress.trackColor = UIColor.darkGrayColor()
        progress.center = CGPoint(x: view.center.x, y: view.center.y)
        view.addSubview(progress)
    }
    
    // MARK: Slider Control
    
    func asyncSliderUpate() {
        slider.value += 0.1690715383
        let freq = 8000.0 * pow(2.0, Double(slider.value))
        tone.frequency = freq
        progress.angle = Double((slider.value * 55.5555556) + 285)
        label.text = String(format: "%.1f", freq) + " Hz"
    }
    
    // MARK: Send Results Confirmation
    
    func displayConfirmationAlert() {
        let refreshAlert = UIAlertController(title: "Confirmation", message: "Your results will be sent : " + "\(tone.frequency) Hz", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
        
        self.examParams = [ "NombreAplicante" : "\(self.name)",
            "FrecuenciaMaxima" : 250,
            "FrecuenciaMinima" : self.tone.frequency,
            "DireccionIp" : "192.168.1.254",
            "Latitud" : self.location.coordinate.latitude,
            "Longitud" : self.location.coordinate.longitude]
            
            print(self.examParams)
            
        PhonusAPIManager.sharedInstance.postExam(self.examParams, completionHandler: { result in
            guard result.error == nil, let successValue = result.value
                where successValue as! NSObject == true else {
                if let error = result.error {
                    print(error)
                }
                    let alertController = UIAlertController(title: "Could not send results",
                        message: "Sorry, your results couldn't be sent. " +
                        "Maybe Phonus service is down or you don't have an internet connection.",
                        preferredStyle: .Alert)
                        
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(okAction)
                    self.presentViewController(alertController, animated:true, completion: nil)
                    return
            }
            self.navigationController?.popViewControllerAnimated(true)
        })
    }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    // MARK: UI Actions
    
    @IBAction func startTest(sender: AnyObject) {
        tone.preparePlaying()
        tone.play()
        engine.mainMixerNode.volume = 1.0
        asyncSliderUpdater = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(AudioTestViewController.asyncSliderUpate), userInfo: nil, repeats: true)
    }
    
    @IBAction func endTest(sender: AnyObject) {
        asyncSliderUpdater.invalidate()
        engine.mainMixerNode.volume = 0.0
        tone.stop()
        displayConfirmationAlert()
    }
}