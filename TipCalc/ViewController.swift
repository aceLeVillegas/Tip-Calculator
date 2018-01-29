//
//  ViewController.swift
//  TipCalc
//
//  Created by Sarah Villegas  on 1/22/18.
//  Copyright © 2018 Sarah Villegas . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Labels
   
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipAmount: UISegmentedControl!
    
    var defaultTip = 0.18
    // tip Percentages
    var tipPercentage = [0.18, 0.2, 0.25]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Tip Calculator"
        self.billTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        
        //Access UserDefaults
        let defaults = UserDefaults.standard
        
        let tipPercent = defaults.double(forKey: "percentage")
        if tipPercent == 0.0{
            
            defaults.set(0.18, forKey: "percentage")
            // Force UserDefaults to save.
            defaults.synchronize()
        }
        else if tipPercent != defaultTip {
            
            defaultTip = tipPercent
        }
        
        // Update the Tip selected
        if tipPercent == tipPercentage[0]{
            
            tipAmount.selectedSegmentIndex = 0
        }
        else if tipPercent == tipPercentage[1]{
            
            tipAmount.selectedSegmentIndex = 1
        }
        else if tipPercent == tipPercentage[2]{
            
            tipAmount.selectedSegmentIndex = 2
        }
        
        let curTip = defaults.double(forKey: "tipAmount")
        let curTotal = defaults.double(forKey: "total")
        let curBill = defaults.double(forKey: "bill")

        
        if curTip != 0.0{
            
            tipLabel.text = String(format: "$%.2f", curTip)
        }
        if curTotal != 0.0{
            
            totalLabel.text = String(format: "$%.2f", curTotal)
        }
        if curBill != 0.0{
            
            billTextField.text = String(format: "%.2f", curBill)
        }
        
        
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
    }
    
    @IBAction func onTap(_ sender: Any) {
        
        view.endEditing(true)
    }
   
    @IBAction func calculateTip(_ sender: Any) {
        
        
        //Access UserDefaults
        let defaults = UserDefaults.standard
        
        // Check if bill value is nil
        if let bill = Double(billTextField.text!) {
            
            // Calculate values
            let tip = bill * tipPercentage[tipAmount.selectedSegmentIndex]
            let total = tip + bill
            
            // Save all values
            defaults.set(bill, forKey: "bill")
            defaults.set(tip, forKey: "tipAmount")
            defaults.set(total, forKey: "total")
            defaults.set(tipPercentage[tipAmount.selectedSegmentIndex], forKey: "percentage")
            
            // Force UserDefaults to save.
            defaults.synchronize()
            
            // Update the values for Tip & Total
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
        }
        else{
            // When the value in the textbox is nil 
            let nilBill = 0.0
            let tip = nilBill * defaultTip
            let total = tip + nilBill
            

            // Update the values for Tip & Total
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
        }


   
    }
    
    
    // Optionally initialize the property to a desired starting value
//    self.firstView.alpha = 0
//    self.secondView.alpha = 1
//    UIView.animate(withDuration:0.4, animations: {
//    // This causes first view to fade in and second view to fade out
//    self.firstView.alpha = 1
//    self.secondView.alpha = 0
//    })
    
    
}

