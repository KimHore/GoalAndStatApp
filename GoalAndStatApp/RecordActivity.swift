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
        
        AcName.text = toPass
        let defaults = NSUserDefaults.standardUserDefaults()
        if let Gdid = defaults.stringForKey("GDid\(key)") {
            
        GD = Int(Gdid)
            CountAc.text! = String(GD)
        }
        else{
          defaults.setValue("0", forKey: "GDid\(key)")
            
            GD = 0
            CountAc.text! = String(GD)
        }
    }
    
   
    
    
    
    @IBOutlet weak var AcName: UILabel!
 
    @IBOutlet weak var CountAc: UILabel!
    
    
    @IBAction func plus(sender: AnyObject) {
        GD! += 1
        CountAc.text! = String(GD)
        
    }
    
    
    @IBAction func nega(sender: AnyObject) {
       GD! -= 1
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
       
        let date = NSDate()
         defaults.setValue(date , forKey: "date\(key)")
         defaults.setValue(String(GD) , forKey: "GDid\(key)")
            
        navigationController?.popViewControllerAnimated(true)

        
    }
    
}

