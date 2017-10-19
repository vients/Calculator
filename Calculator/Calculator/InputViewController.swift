//
//  ViewController.swift
//  Calculator
//
//  Created by Yurii Vients on 10/9/17.
//  Copyright © 2017 Yurii Vients. All rights reserved.
//

import UIKit
import  AVFoundation
class InputViewController: UIViewController, InputInterface {
    
     var delegate: InputDelegate?
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func symbolPressed(_ symbol: String){
        delegate?.enterDigit(symbol)
        
//        delegate?.digit(Int(symbol)!)
//         print("\(symbol)")
//        brain.digitPressed(Int(symbol)!)
//        if symbol == "7" || symbol == "4" || symbol == "5" || symbol == "8" || symbol == "123"
//        {
//            delegate?.enterDigit(symbol)
//        }
//        else if symbol == "+" || symbol == "-" || symbol == "×" || symbol == "÷"
//        {
//         delegate?.enterDigit(symbol)
//        }
//        else if symbol == "sin" || symbol == "cos" || symbol == "tan"
//        {
//           delegate?.enterDigit(symbol)
//        }
    }
    
    @IBAction func tapOnButton(_ sender: UIButton) {
       
        symbolPressed(sender.currentTitle!)
        playClick()
    }
    
    func playClick() {
        AudioServicesPlaySystemSound(1104)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InputViewSegue"{
            let destinationVC = segue.destination as! AdditionViewController
            destinationVC.delegate = delegate

        }
        else if segue.identifier == "ScrollViewControllerSegue" {
            let destinationVC = segue.destination as! ScrollViewController
            destinationVC.delegate = delegate
        }
    }

    }





