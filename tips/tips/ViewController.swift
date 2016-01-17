//
//  ViewController.swift
//  tips
//
//  Created by Roger Tan on 1/16/16.
//  Copyright © 2016 Roger Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    var selectedTipIndex = 0
    var selectedTipStrategyIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00";
        totalLabel.text = "$0.00";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        updateFields()
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func updateFields() {
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[selectedTipIndex]
        
        
        var billAmount = (billField.text! as NSString).doubleValue
        var tip = billAmount * tipPercentage
        
        var total = billAmount + tip
        
        if selectedTipStrategyIndex == 1 {
            // round up
            var roundedUpTotal = ceil(total)
            tip += (roundedUpTotal - total)
            total = roundedUpTotal
        } else if selectedTipStrategyIndex == 2 {
            // palindromic
            var palindromeTotal = palindromize(total)
            if palindromeTotal < total {
                palindromeTotal = palindromize(ceil(total))
            }
            tip += (palindromeTotal - total)
            total = palindromeTotal
        }
    
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        var defaults = NSUserDefaults.standardUserDefaults()
        
        selectedTipIndex = defaults.integerForKey("tip_percentage_index")
        selectedTipStrategyIndex = defaults.integerForKey("tip_strategy_index")
        updateFields()
    }
    
    func palindromize(amount: Double) -> Double {
        var str = String(format: "%.2f", amount)
        str = str.stringByReplacingOccurrencesOfString(".", withString: "")
        
        var strLength : Int = str.characters.count
        var halfLength : Double = Double(strLength) / 2
        
        var prefix = str.characters.prefix(Int(floor(halfLength)))
        
        var firstHalf = str.characters.prefix(Int(ceil(halfLength)))
        
        var combined = String(firstHalf + prefix.reverse())
        
        return Double(combined)! / 100
    }
    
}

