//
//  MainViewController.swift
//  Calculator
//
//  Created by Yurii Vients on 10/10/17.
//  Copyright © 2017 Yurii Vients. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController, InputDelegate  {
    
    @IBOutlet weak var soundButton: UIButton!
    
    var validator  = InputValidator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        soundIsActive = UserDefaults.standard.bool(forKey: "isSaved")
    }
    
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
    
    var soundIsActive : Bool = true {
        didSet {
            if soundIsActive {
                soundButton.setImage(#imageLiteral(resourceName: "speaker"), for: .normal)
                print("ON")
            } else {
                soundButton.setImage(#imageLiteral(resourceName: "mute"), for: .normal)
                print("OFF")
            }
        }
    }
    
    func soundTap() {
        if soundIsActive == true {
            AudioServicesPlaySystemSound(1104)
        } else {
            print("")
        }
    }
    @IBAction func soundButton(_ sender: Any) {
        soundIsActive = !soundIsActive
        UserDefaults.standard.set(soundIsActive, forKey: "isSaved")
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


