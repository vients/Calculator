//
//  MainViewController.swift
//  Calculator
//
//  Created by Yurii Vients on 10/10/17.
//  Copyright © 2017 Yurii Vients. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, InputDelegate  {
    
    var validator  = InputValidator()
    
    func enterDigit(_ value: String) {

        print("mainValue == \(value)")
        
            if value == "+" || value == "-" || value == "×" || value == "÷" || value == "^" || value == "="
            {
                validator.operation(Operation(rawValue: value)!)
            }
            else if value == "√" || value == "sin" || value == "cos" || value == "tan" || value == "ln"
                || value == "log" || value == "!" || value == "%" || value == "sinh" || value == "cosh" || value == "tanh"
            {
                validator.function(Function(rawValue: value)!)
            }
            else if value == "." || value == "(" || value == ")"
            {
                validator.Utility(Utility(rawValue: value)!)
            }
            else if value == "π" || value == "π/2" || value == "e" || value == "e^"
            {
                validator.Constants(Constants(rawValue: value)!)
            }
            else if value == "AC" || value == "mc" || value == "m+" || value == "m-" || value == "mr"
            {
                validator.memory(Memory(rawValue: value)!)
            }
 
            else if Int(value as? String ?? "") != nil
            {

                validator.digit(Int(value)!)
            }
            else {
                print("Invalid operation")
        }

    }
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InputViewControllerSegue"{
            let destinationVC = segue.destination as! InputViewController
            destinationVC.delegate = self
        }
    }
    
}


