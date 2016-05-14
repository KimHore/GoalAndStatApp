//
//  CreateActivityController.swift
//  GoalAndStatApp
//
//  Created by DE DPU on 4/29/2559 BE.
//  Copyright © 2559 kimhore. All rights reserved.
//


import UIKit


class CreateActivityController: UIViewController {
    
   
    @IBOutlet weak var Acti: UITextField!
    
    @IBOutlet weak var Goal: UITextField!
    
    @IBAction func confirmAc(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        
        if ( Acti!.text != "") {
            if (Goal!.text != "") {
                var countt = 1
                var checker = 0
                let countevent = defaults.stringForKey("countevent")!
                while countt <= Int(countevent){
                    if(defaults.stringForKey("AcName\(countevent)")! == Acti.text){
                        checker = 1
              
                    }
                    countt = countt+1
                }
                if checker == 0{
                    defaults.setValue(Int(countevent)!+1, forKey: "countevent")
                    let countevents = defaults.stringForKey("countevent")!
                    defaults.setValue( Acti!.text, forKey: "AcName\(countevents)")
                    defaults.setValue(Goal!.text, forKey: "Goal\(countevents)")
                    //let datee = NSDate()
                    // defaults.setValue(datee, forKey: "date\(countevents)")
                    navigationController?.popViewControllerAnimated(true)
                }
                else if checker == 1 {
                    let objAlertController = UIAlertController(title: "Error !! ", message: "Redundance Activity Name!! ", preferredStyle: UIAlertControllerStyle.ActionSheet)
                    let objAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    objAlertController.addAction(objAction)
                    presentViewController(objAlertController, animated: true, completion: nil)
                    checker = 0
                }
                
            }
            else{
                let objAlertController = UIAlertController(title: "Error !! ", message: "Please Insert Again!! ", preferredStyle: UIAlertControllerStyle.ActionSheet)
                let objAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                objAlertController.addAction(objAction)
                presentViewController(objAlertController, animated: true, completion: nil)
                // print("--------")
            }
        }//if !=nill
            
        else {
            let objAlertController = UIAlertController(title: "Error !! ", message: "Please Insert Again!! ", preferredStyle: UIAlertControllerStyle.ActionSheet)
            let objAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            objAlertController.addAction(objAction)
            presentViewController(objAlertController, animated: true, completion: nil)
           // print("--------")
            
        }//else
        
    }

}

