//
//  MenuTableViewController.swift
//  Phonus
//
//  Created by Ricardo Euán Romo on 5/7/16.
//  Copyright © 2016 Ricardo Euán Romo. All rights reserved.
//

import UIKit
import CoreData

class MenuTableViewcontroller: UITableViewController {
    
    var selectedMenuItem : Int = 0
    
    var names: [String] = ["Raul", "Mario"]
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch core data objects
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Exam")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for result in results as! [NSManagedObject] {
                print(result.valueForKey("name")!)
                print(result.valueForKey("age")!)
                print(result.valueForKey("gender")!)
                print(result.valueForKey("maxFrequency")!)
                print(result.valueForKey("minFrequency")!)
                print(result.valueForKey("ipAddress")!)
                print(result.valueForKey("latitude")!)
                print(result.valueForKey("longitude")!)
                
                names.append(result.valueForKey("name")! as! String)
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return names.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL")
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.lightGrayColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        //cell!.textLabel?.text = "Test \(indexPath.row+1)"
        
        if names.count > 0 {
            cell!.textLabel?.text = names[indexPath.item]
        } else {
          cell!.textLabel?.text = "No hay exámenes por enviar."
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        /*let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
        case 0:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController1")
            break
        case 1:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController2")
            break
        case 2:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController3")
            break
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController4")
            break
        }
        sideMenuController()?.setContentViewController(destViewController)
        */
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
}
