//
//  MainViewController.swift
//  Calculator
//
//  Created by Yurii Vients on 10/10/17.
//  Copyright © 2017 Yurii Vients. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, InputDelegate {
    
    var validator  = InputValidator()
    
    func enterDigit(_ value: String) {
//        brain.digit(Int(vaue)!)
//        print("mainValue == \(vaue)")
        
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
        else if value == "AC"
         {
            validator.memory(Memory(rawValue: value)!)
         }
        else {
            validator.digit(Int(value)!)
        }

    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
//            validator.resultClosure = {Double,Error -> Void in
//                if let resultValue = result {
//                
//                }
//            }
        
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


