//
//  CalculatorViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    
    // MARK: - Outlets -
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    // MARK: - Properties -
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    // MARK: - Actions -
    @IBAction func tipChanged(_ sender: UIButton) {
        // used to dismiss the keyboard
        billTextField.endEditing(true)
        
        // Deselect all tip buttons using the outlets
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // Make the button that triggere the action selected
        sender.isSelected = true
        
        // Get the current title of the button that was pressed
        let buttonTitle = sender.currentTitle!
        
        //Remove the character (%) from the title then turn it back into a string
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        
        // turn the string into a double
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        
        // Divide the percent expressed out of 100 into a decimal
        tip = buttonTitleAsANumber / 100
        
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        // get the text the user typed in the billTextField
        let bill = billTextField.text!
        
        //If the text is not an empty String ""
        if bill != "" {
            
            //Turn the bill from a String e.g. "123.50" to an actual String with decimal places.
            //e.g. 125.50
            billTotal = Double(bill)!
            
            //Multiply the bill by the tip percentage and divide by the number of people to split the bill.
            let result = billTotal * (1 + tip) / Double(numberOfPeople)
            
            //Round the result to 2 decimal places and turn it into a String.
            finalResult = String(format: "%.2f", result)
        }
        
        self.performSegue(withIdentifier: "ResultsViewModalSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsViewModalSegue" {
            guard let destinationVC = segue.destination as? ResultsViewController else { return }
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
}

