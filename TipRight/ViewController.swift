//
//  ViewController.swift
//  TipRight
//
//  Created by Muhammet Yazmyradov on 12/25/15.
//  Copyright © 2015 myazmyradov. All rights reserved.
//

import UIKit

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
    
}

class ViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let keys = ["first", "second", "third"]
    
    var prevBillFieldText = ""

    @IBOutlet weak var billField:
        UITextField!
    
    @IBOutlet weak var tipLabel:
        UILabel!
    
    @IBOutlet weak var totalLabel:
        UILabel!
    
    @IBOutlet weak var tipControl:
        UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.setInteger(18, forKey: keys[0])
        defaults.setInteger(20, forKey: keys[1])
        defaults.setInteger(22, forKey: keys[2])
        defaults.synchronize()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Tip Calculator"
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tipControl.setTitle(String(defaults.integerForKey(keys[0])) + "%", forSegmentAtIndex: 0)
            
        tipControl.setTitle(String(defaults.integerForKey(keys[1])) + "%", forSegmentAtIndex: 1)
            
        tipControl.setTitle(String(defaults.integerForKey(keys[2])) + "%", forSegmentAtIndex: 2)
            
        onEditingChanged(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        if var x = billField.text {
            //prevent many zeros at the start
            if x.characters.count > 1 && x[0] == "0" && x[1] != "." {
                x = x[1...x.characters.count-1]
            }
            billField.text = x
        }
        
        //do not change anything if the new entry is invalid
        if billField.text != "" && billField.text != "." && Double(billField.text!) == nil {
            billField.text = prevBillFieldText
            return
        }
        
        //fix some stuff
        if var x = billField.text {
            //remove anything after 2nd decimal point, case .xy
            if x.characters.count > 3 && x[0] == "." {
                x = x[0...2]
            } else if x.characters.count > 3 && x[0] != "." && x.containsString(".") { //case many_x.yz
                if let range = x.rangeOfString(".") {
                    let distanceToEnd = range.startIndex.distanceTo(x.endIndex)
                    if distanceToEnd > 3 {
                        x = x[0...x.characters.count - 2]
                    }
                }
            }
            billField.text = x
            prevBillFieldText = x
        }
        
        let index = tipControl.selectedSegmentIndex
        let tipPercentage = defaults.integerForKey(keys[index])
        
        var bill = 0.0
        var tip = 0.0
        var total = 0.0
        
        if let x = Double(billField.text!) {
            bill = x
            tip = bill * (Double(tipPercentage) / 100.0)
            total = bill + tip
        }
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text  = String(format: "$%.2f", total)

    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
}

