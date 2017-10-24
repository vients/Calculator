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
    }
    
    @IBAction func tapOnButton(_ sender: UIButton) {
       
        symbolPressed(sender.currentTitle!)
        
        if sender.currentTitle == "AC"{
            sender.shake()
        }
        else if sender.currentTitle == "="
        {
            sender.pulsate()
        }
        else {
            sender.flash()
        }
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





