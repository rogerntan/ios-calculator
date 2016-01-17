//
//  SettingsViewController.swift
//  tips
//
//  Created by Roger Tan on 1/16/16.
//  Copyright © 2016 Roger Tan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipPercentages: UISegmentedControl!
    @IBOutlet weak var tipStrategyControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func onTipValueChanged(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipPercentages.selectedSegmentIndex, forKey: "tip_percentage_index")
        defaults.synchronize()
    }

    @IBAction func onAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onStrategyAction(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipStrategyControl.selectedSegmentIndex, forKey: "tip_strategy_index")
        defaults.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // pick the selected one based on what the user had saved
        var defaults = NSUserDefaults.standardUserDefaults()
        tipPercentages.selectedSegmentIndex = defaults.integerForKey("tip_percentage_index")
        tipStrategyControl.selectedSegmentIndex = defaults.integerForKey("tip_strategy_index")
    }
}
