//
//  SettingsViewController.swift
//  TipRight
//
//  Created by Muhammet Yazmyradov on 12/25/15.
//  Copyright © 2015 myazmyradov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    let keys = ["first", "second", "third"]
    
    @IBOutlet weak var tipSettingsControl:
        UISegmentedControl!
    
    @IBOutlet weak var tipStepper:
        UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        let value = defaults.integerForKey(keys[1])
        tipStepper.value = Double(value)
        
        tipSettingsControl.setTitle(String(defaults.integerForKey(keys[0])) + "%", forSegmentAtIndex: 0)
        
        tipSettingsControl.setTitle(String(defaults.integerForKey(keys[1])) + "%", forSegmentAtIndex: 1)
        
        tipSettingsControl.setTitle(String(defaults.integerForKey(keys[2])) + "%", forSegmentAtIndex: 2)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onStep(sender: AnyObject) {
        let index = tipSettingsControl.selectedSegmentIndex
        defaults.setInteger(Int(tipStepper.value), forKey: keys[index])
        defaults.synchronize()
        
        let value = defaults.integerForKey(keys[index])
        tipSettingsControl.setTitle(String(value) + "%", forSegmentAtIndex: index)
    }
    
    
    @IBAction func onChangeIndex(sender: AnyObject) {
        let index = tipSettingsControl.selectedSegmentIndex
        let value = defaults.integerForKey(keys[index])
        tipStepper.value = Double(value)
    }
    
}
