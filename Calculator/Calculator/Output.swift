//
//  Output.swift
//  Calculator
//
//  Created by Yurii Vients on 10/12/17.
//  Copyright © 2017 Yurii Vients. All rights reserved.
//

import Foundation

class Output : OutputInterface {
    
    static let shared = Output()
    
    var displayText : InfoViewController!
    
    func display(_ result: String){
        if result == "inf" {
            let diplayResult = "Invalid operation"
            displayText?.display(diplayResult)
        }
        else {
            let diplayResult = String(format: "%g", Double(result)!)
            displayText?.display(diplayResult)
        }
        //         print("\(result)")
    }
    
    func displayHistory(historyValue: String){
        displayText?.history(historyValue)
    }
}
