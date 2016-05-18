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
        ("nearby-btn", UIColor(red:1, green:0.39, blue:0, alpha:1)),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.color(0, green: 25, blue: 51, alpha: 1)

                let button = CircleMenu(
                    frame: CGRect(x: 0, y: 0, width: 95, height: 95),
                    normalIcon:"icon_menu",
                    selectedIcon:"icon_close",
                    buttonsCount: 5,
                    duration: 0.3,
                    distance: 160)
                button.center = CGPoint(x: view.center.x, y: view.center.y - 50)
                button.backgroundColor = UIColor.lightGrayColor()
                button.layer.cornerRadius = button.frame.size.width / 2.0
                button.delegate = self
                view.addSubview(button)
        
        addTrackingMenuButton(75, title: "12", imageName: "total-btn.png", labelText: "Total")
        addTrackingMenuButton(250, title: "7", imageName: "passed-btn.png", labelText: "Passed")
        addTrackingMenuButton(425, title: "4", imageName: "failed-btn.png", labelText: "Failed")
        addTrackingMenuButton(600, title: "2", imageName: "unsent-btn.png", labelText: "Unsent")
        
        self.sideMenuController()?.sideMenu?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Circle Menu
    
    func circleMenu(circleMenu: CircleMenu, willDisplay button: CircleMenuButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        button.setImage(UIImage(imageLiteral: items[atIndex].icon), forState: .Normal)
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
    
    // MARK: Side Menu
    
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
    
    // MARK: Custom functions
    
    func addTrackingMenuButton(x: CGFloat, title: String, imageName: String, labelText: String) {
        let circleButton = UIButton(type: .Custom)
        circleButton.frame = CGRectMake(x, 800, 100, 100)
        circleButton.layer.cornerRadius = circleButton.frame.size.width / 2.0
        circleButton.setTitle(title, forState: UIControlState.Normal)
        circleButton.setBackgroundImage(UIImage(named:imageName), forState: .Normal)
        circleButton.addTarget(self, action: #selector(thumbsUpButtonPressed), forControlEvents: .TouchUpInside)
        view.addSubview(circleButton)
        
        let label = UILabel(frame: CGRectMake(x, 870, 100, 100))
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.text = labelText
        self.view.addSubview(label)
    }
    
    func thumbsUpButtonPressed() {
        print("thumbs up button pressed")
    }
}

