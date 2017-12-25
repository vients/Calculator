//
//  AdditionViewController.swift
//  Calculator
//
//  Created by Yurii Vients on 10/14/17.
//  Copyright © 2017 Yurii Vients. All rights reserved.
//

import UIKit
import AVFoundation
class AdditionViewController: UIViewController, InputInterface {

    var delegate: InputDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func symbolPressed(_ symbol: String) {
        delegate?.enterDigit(symbol)
    }
    
    @IBAction func buttonPress(_ sender: UIButton) {
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
//        playClick()
        delegate?.soundTap()
    }
    
    func playClick() {
        AudioServicesPlaySystemSound(1104)
    }

}
