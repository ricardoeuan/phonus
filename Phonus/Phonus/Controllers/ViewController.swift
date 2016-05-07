//
//  ViewController.swift
//  Phonus
//
//  Created by Ricardo Euán Romo on 4/16/16.
//  Copyright © 2016 Ricardo Euán Romo. All rights reserved.
//

import UIKit
import SwiftyJSON
import CircleMenu
import AVFoundation

extension UIColor {
    static func color(red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        return UIColor(
            colorLiteralRed: Float(1.0) / Float(255.0) * Float(red),
            green: Float(1.0) / Float(255.0) * Float(green),
            blue: Float(1.0) / Float(255.0) * Float(blue),
            alpha: alpha)
    }
}

class ViewController: UIViewController, ENSideMenuDelegate {
    
    let systemSoundID: SystemSoundID = 1259;
    
    let items: [(icon: String, color: UIColor)] = [
        ("icon_home", UIColor(red:0.19, green:0.57, blue:1, alpha:1)),
        ("icon_search", UIColor(red:0.22, green:0.74, blue:0, alpha:1)),
        ("notifications-btn", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
        ("settings-btn", UIColor(red:0.51, green:0.15, blue:1, alpha:1)),
        ("nearby-btn", UIColor(red:1, green:0.39, blue:0, alpha:1)),
        ]        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.                        
                let button = CircleMenu(
                    frame: CGRect(x: 335, y: 400, width: 100, height: 100),
                    normalIcon:"icon_menu",
                    selectedIcon:"icon_close",
                    buttonsCount: 5,
                    duration: 0.3,
                    distance: 180)
                button.backgroundColor = UIColor.lightGrayColor()
                button.delegate = self
                button.layer.cornerRadius = button.frame.size.width / 2.0
                view.addSubview(button)
        
        let circleButton = UIButton(type: .Custom)
        circleButton.frame = CGRectMake(75, 800, 100, 100)
        circleButton.layer.cornerRadius = circleButton.frame.size.width / 2.0
        circleButton.setTitle("12", forState: UIControlState.Normal)
        circleButton.setBackgroundImage(UIImage(named:"total-btn.png"), forState: .Normal)
        circleButton.addTarget(self, action: #selector(thumbsUpButtonPressed), forControlEvents: .TouchUpInside)
        view.addSubview(circleButton)
        
        let label = UILabel(frame: CGRectMake(75, 870, 100, 100))
        label.textAlignment = NSTextAlignment.Center
        label.text = "Total"
        self.view.addSubview(label)
        
        let sentButton = UIButton(type: .Custom)
        sentButton.frame = CGRectMake(250, 800, 100, 100)
        sentButton.layer.cornerRadius = sentButton.frame.size.width / 2.0
        sentButton.setTitle("7", forState: UIControlState.Normal)
        sentButton.setBackgroundImage(UIImage(named:"passed-btn.png"), forState: .Normal)
        sentButton.addTarget(self, action: #selector(thumbsUpButtonPressed), forControlEvents: .TouchUpInside)
        view.addSubview(sentButton)
        
        let sentLabel = UILabel(frame: CGRectMake(250, 870, 100, 100))
        sentLabel.textAlignment = NSTextAlignment.Center
        sentLabel.text = "Passed"
        self.view.addSubview(sentLabel)
        
        let pendingButton = UIButton(type: .Custom)
        pendingButton.frame = CGRectMake(425, 800, 100, 100)
        pendingButton.layer.cornerRadius = pendingButton.frame.size.width / 2.0
        pendingButton.setTitle("4", forState: UIControlState.Normal)
        pendingButton.setBackgroundImage(UIImage(named:"failed-btn.png"), forState: .Normal)
        pendingButton.addTarget(self, action: #selector(thumbsUpButtonPressed), forControlEvents: .TouchUpInside)
        view.addSubview(pendingButton)
        
        let pendingLabel = UILabel(frame: CGRectMake(425, 870, 100, 100))
        pendingLabel.textAlignment = NSTextAlignment.Center
        pendingLabel.text = "Failed"
        self.view.addSubview(pendingLabel)
        
        let unsentButton = UIButton(type: .Custom)
        unsentButton.frame = CGRectMake(600, 800, 100, 100)
        unsentButton.layer.cornerRadius = unsentButton.frame.size.width / 2.0
        unsentButton.setTitle("2", forState: UIControlState.Normal)
        unsentButton.setBackgroundImage(UIImage(named:"unsent-btn.png"), forState: .Normal)
        unsentButton.addTarget(self, action: #selector(thumbsUpButtonPressed), forControlEvents: .TouchUpInside)
        view.addSubview(unsentButton)
        
        let unsentLabel = UILabel(frame: CGRectMake(600, 870, 100, 100))
        unsentLabel.textAlignment = NSTextAlignment.Center
        unsentLabel.text = "Unsent"
        self.view.addSubview(unsentLabel)
        
        self.sideMenuController()?.sideMenu?.delegate = self
    }
    
    func thumbsUpButtonPressed() {
        print("thumbs up button pressed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func circleMenu(circleMenu: CircleMenu, willDisplay button: CircleMenuButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        button.setImage(UIImage(imageLiteral: items[atIndex].icon), forState: .Normal)
        
        
        // set highlited image
        let highlightedImage  = UIImage(imageLiteral: items[atIndex].icon).imageWithRenderingMode(.AlwaysTemplate)
        button.setImage(highlightedImage, forState: .Highlighted)
        button.tintColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
        
    }
    
    func circleMenu(circleMenu: CircleMenu, buttonWillSelected button: CircleMenuButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    }
    
    func circleMenu(circleMenu: CircleMenu, buttonDidSelected button: CircleMenuButton, atIndex: Int) {
        switch atIndex {
        case 0:
            performSegueWithIdentifier("Exam", sender: nil)
        case 1:
            performSegueWithIdentifier("Results", sender: nil)
        case 2:
            AudioServicesPlaySystemSound(systemSoundID)
        default:
            print("nothing selected")
        }
    }
    
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        print("sideMenuShouldOpenSideMenu")
        return true
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }
}

