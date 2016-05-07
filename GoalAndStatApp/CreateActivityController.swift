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
                let countevent = defaults.stringForKey("countevent")!
                defaults.setValue(Int(countevent)!+1, forKey: "countevent")
                let countevents = defaults.stringForKey("countevent")!
                defaults.setValue( Acti!.text, forKey: "AcName\(countevents)")
                defaults.setValue(Goal!.text, forKey: "Goal\(countevents)")
                //let datee = NSDate()
               // defaults.setValue(datee, forKey: "date\(countevents)")
                navigationController?.popViewControllerAnimated(true)
                
                
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

