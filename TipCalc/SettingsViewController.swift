//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Sarah Villegas  on 1/27/18.
//  Copyright © 2018 Sarah Villegas . All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipPercents: UISegmentedControl!
    
    var tipVals = [0.18, 0.2, 0.25]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //Access UserDefaults
        let defaults = UserDefaults.standard
        
        let tipPercent = defaults.double(forKey: "percentage")
        
        if tipPercent == 0.0{
            
            defaults.set(0.18, forKey: "percentage")
            
        }
        if tipPercent == 0.18{
            
            tipPercents.selectedSegmentIndex = 0
            defaults.set(tipPercents.selectedSegmentIndex, forKey: "curSelected")
        }
        else if tipPercent == 0.2{
            
            tipPercents.selectedSegmentIndex = 1
            defaults.set(tipPercents.selectedSegmentIndex, forKey: "curSelected")
        }
        else if tipPercent == 0.25{
            
            tipPercents.selectedSegmentIndex = 2
            defaults.set(tipPercents.selectedSegmentIndex, forKey: "curSelected")
        }
        
        // Force UserDefaults to save.
        defaults.synchronize()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func changeTip(_ sender: Any) {
        
        // load percent value
        let defaults = UserDefaults.standard
        let tipPercent = defaults.double(forKey: "percentage")
        
        // Not the current default values
        if tipPercent != tipVals[tipPercents.selectedSegmentIndex] {
            
            defaults.set(tipVals[tipPercents.selectedSegmentIndex] , forKey: "percentage")
            // Force UserDefaults to save.
            defaults.synchronize()
        }
        
    }

    @IBAction func calculateNewTip(_ sender: Any) {
        
        
        //Access UserDefaults
        let defaults = UserDefaults.standard
    
        let billAmount =  defaults.double(forKey: "bill")
        
        // Calculate new values
        let tip = billAmount * tipVals[tipPercents.selectedSegmentIndex]
        let total = tip + billAmount
        
        // Save all values
        defaults.set(tip, forKey: "tipAmount")
        defaults.set(total, forKey: "total")
        
        // Force UserDefaults to save.
        defaults.synchronize()
        
        // Update the values for Tip & Total
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
