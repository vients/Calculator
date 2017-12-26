//
//  OutputViewController.swift
//  Calculator
//
//  Created by Yurii Vients on 10/9/17.
//  Copyright © 2017 Yurii Vients. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, OutputInterface  {
    
    let output = Output.shared
    
    @IBOutlet private weak var historyLabel: UILabel!
    @IBOutlet private weak var resultLabel: UILabel!
    
    @IBOutlet weak var soundButton: UIButton!
    
    func display(_ result: String) {
        resultLabel.text =  result
    }
    
    func history(_ resultHistory: String) {
        historyLabel.text = resultHistory
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.displayText = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
