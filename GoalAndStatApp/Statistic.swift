//
//  Statistic.swift
//  GoalAndStatApp
//
//  Created by scarlettjun on 5/6/2559 BE.
//  Copyright © 2559 kimhore. All rights reserved.
//


import UIKit
class Statistic : UIViewController, UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var listStAc: UITableView!
    
    var row:Int = 0
    var rowtemp:String = ""
    var keytemp:Int = 0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        
        if let stringOne = defaults.stringForKey("countevent"){
            if Int(stringOne) > 0 {
                row = Int(stringOne)!
                listStAc.reloadData()
            }
            
            
        }else{
            defaults.setValue("0", forKey: "countevent")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        
        if let stringOne = defaults.stringForKey("countevent"){
            if Int(stringOne) > 0 {
                row = Int(stringOne)!
                listStAc.reloadData()
            }
            
            
        }else{
            defaults.setValue("0", forKey: "countevent")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete{
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.removeObjectForKey("AcName\(indexPath.row+1)")
            let stringOne = defaults.stringForKey("countevent")
            defaults.setValue(Int(stringOne!)!-1, forKey: "countevent")
            
            row -= 1
            
            listStAc.reloadData()
            
            
            
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let defaults = NSUserDefaults.standardUserDefaults()
        rowtemp = defaults.stringForKey("AcName\(indexPath.row+1)")!
        keytemp = indexPath.row
        performSegueWithIdentifier("segueStL", sender: nil)
        
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueStL") {
            var svc = segue.destinationViewController as! StatisticList;
            
            svc.toPass = rowtemp
            svc.key = keytemp
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return row;
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cells")
        let defaults = NSUserDefaults.standardUserDefaults()
        if let stringOne = defaults.stringForKey("AcName\(indexPath.row+1)"){
            
            
            cell?.textLabel?.text = stringOne
            
            
            
        }
        
        
        return cell!
    }
    

    
}