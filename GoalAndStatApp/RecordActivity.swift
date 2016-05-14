//
//  RecordActivity.swift
//  GoalAndStatApp
//
//  Created by DE DPU on 5/4/2559 BE.
//  Copyright © 2559 kimhore. All rights reserved.
//

import Foundation
import UIKit


class RecordActivity: UIViewController {
    var toPass:String!
    var key:Int!
    var GD:Int!
    
    
    override func viewDidLoad() {
        if GD == nil {
            GD = 0
            CountAc.text! = String(GD)
        }
        AcName.text = toPass
      
    }
    
   
    
    
    
    @IBOutlet weak var AcName: UILabel!
 
    @IBOutlet weak var CountAc: UILabel!
    
    
    @IBAction func plus(sender: AnyObject) {
       
        GD! = GD+1
        CountAc.text! = String(GD)
        
    }
    
    
    @IBAction func nega(sender: AnyObject) {
       
       GD! = GD-1
        if GD >= 0  {
            
        
        CountAc.text! = String(GD)
        }
        else{
            let objAlertController = UIAlertController(title: "Error !! ", message: "Don't Insert Negative Value!! ", preferredStyle: UIAlertControllerStyle.ActionSheet)
            let objAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            objAlertController.addAction(objAction)
            presentViewController(objAlertController, animated: true, completion: nil)
            
        }
    }
   
    
    @IBAction func Confirm(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.stringForKey("counteventSt") == nil{
            defaults.setValue("0", forKey: "counteventSt")

        }
        let countevent = defaults.stringForKey("counteventSt")!
        defaults.setValue(Int(countevent)!+1, forKey: "counteventSt")
        let counteventSt = defaults.stringForKey("counteventSt")!
        let currentDate = NSDate()
       
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let date = dateFormatter.stringFromDate(currentDate)
        
       
        
        
        defaults.setValue(AcName!.text, forKey: "AcNameSt\(counteventSt)")
         defaults.setValue(String(date) , forKey: "dateSt\(counteventSt)")
         defaults.setValue(String(GD!) , forKey: "GDidSt\(counteventSt)")
        
        //let d = defaults.stringForKey("dateSt\(counteventSt)")!
        //print("date=\(d)")
        //print("counteventSt=\(counteventSt)")
       // let temp = defaults.stringForKey("AcNameSt\(counteventSt)")
        //print("acnameSt=\(temp)")
        navigationController?.popViewControllerAnimated(true)

        
    }
    
}

