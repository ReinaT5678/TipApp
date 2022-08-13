//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPtcButton: UIButton!
    @IBOutlet weak var tenPtcButton: UIButton!
    @IBOutlet weak var twentyPtcButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var numberOfPeople = 2
    var bill = 0.0
    var finalBill = "0.0"
    var tipValue = 10.0
    var result = "0.0"
    let buttonTitleInt = 0
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPtcButton.isSelected = false
        tenPtcButton.isSelected = false
        twentyPtcButton.isSelected = false
        sender.isSelected = true
        
        //holds current tip value as a string
        let buttonTitle = sender.currentTitle!
        // converts button chosen to a string, without % sign
        let buttonTitleInt = String(buttonTitle.dropLast())
        // converts new integer (str) value into a double, unwraps value
        let buttonTitleDouble = Double(buttonTitleInt)!
        // divide by 100 to get decimal tip value
        tipValue = buttonTitleDouble / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        numberOfPeople = Int(sender.value)
        splitNumberLabel.text = String(numberOfPeople)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let billTotal = billTextField.text!
        bill = Double(billTotal)!
        
        let individualBill = bill * (1 + tipValue) / Double(numberOfPeople)
        finalBill = String(format: "%.2f", individualBill)
        print(individualBill)
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    // function to prepare before segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.result = finalBill
            destinationVC.split = numberOfPeople
            if tipValue != 10 {
                destinationVC.tip = Int(tipValue * 100)
            } else {
                destinationVC.tip = Int(tipValue)
            }
            
        }
    }
}

