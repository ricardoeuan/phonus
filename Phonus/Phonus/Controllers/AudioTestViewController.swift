//
//  AudioTestViewController.swift
//  Phonus
//
//  Created by Ricardo Euán Romo on 4/25/16.
//  Copyright © 2016 Ricardo Euán Romo. All rights reserved.
//

import UIKit
import AVFoundation

class AudioTestViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    var engine: AVAudioEngine!
    var tone: AVTonePlayerUnit!
    let minSliderVal:Float = -5.0       //  250 hz
    let maxSliderVal:Float = 1.321925   //  20000 hz
    
    override func viewDidAppear(animated: Bool) {
        //TEST POST operation
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tone = AVTonePlayerUnit()
        label.text = String(format: "%.1f", tone.frequency)
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderChanged(sender: UISlider) {
        let freq = 8000.0 * pow(2.0, Double(slider.value))
        tone.frequency = freq
        label.text = String(format: "%.1f", freq)
    }
    
    
    @IBAction func togglePlay(sender: UIButton) {
        if tone.playing {
            engine.mainMixerNode.volume = 0.0
            tone.stop()
            sender.setTitle("Start", forState: .Normal)
        } else {
            tone.preparePlaying()
            tone.play()
            engine.mainMixerNode.volume = 1.0
            sender.setTitle("Stop", forState: .Normal)
        }
    }
}