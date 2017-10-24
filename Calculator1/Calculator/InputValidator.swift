//
//  InputValidator.swift
//  Calculator
//
//  Created by Yurii Vients on 10/14/17.
//  Copyright © 2017 Yurii Vients. All rights reserved.
//

import Foundation

class InputValidator : CalculatorInterface
{
    var inputValue: String!
    let output = Output.shared
    var brain = Brain()
    var dot = false
    
//    var countLeftBrackets: Int = 0
//    var countRightBrackets: Int = 0
    
    func digit(_ value: Int){
        if inputValue == nil || inputValue == "0" {
            inputValue = String(value)
        }
        else if inputValue.characters.last == "." || inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" || (inputValue.characters.count == 1 &&
            (inputValue.characters.last == "+" || inputValue.characters.last == "-"))  {
            inputValue = inputValue + "\(value)"
        }
        else if inputValue.characters.last == ")" {
            inputValue = inputValue + " × \(value)"
        }
        else {
            inputValue = inputValue + " \(value)"
        }
        
        brain.pressEquation(equation: inputValue)
    }
    
    func operation(_ operation: Operation){
        switch operation {
        case .plus :

            if inputValue == nil || inputValue == "" || inputValue == "0"{
                
                inputValue = "+"
            }
            else if inputValue.characters.last == "."{
                inputValue! += "0 +"
            }
            else if  inputValue.characters.last == "+" || inputValue.characters.last == "-"
                || inputValue.characters.last == "×" || inputValue.characters.last == "÷"
                || inputValue.characters.last == "^"  {
                
                 inputValue.characters.removeLast()
                 inputValue = inputValue + ("+")
            }
            else {
                inputValue = inputValue + (" +")
            }
            dot = false
            
            output.displayHistory(historyValue: inputValue)
            
        case .minus :

            if inputValue == nil || inputValue == "" || inputValue == "0"
            {
                inputValue = "-"
            }
            else if inputValue.characters.last == "."{
                inputValue! += "0 -"
            }
            else if  inputValue.characters.last == "+" || inputValue.characters.last == "-"
                || inputValue.characters.last == "×" || inputValue.characters.last == "÷"
                || inputValue.characters.last == "^" {
                
                inputValue.characters.removeLast()
                inputValue = inputValue + ("-")
            }
            else if inputValue.characters.last != "√"  {
                inputValue = inputValue + (" -")
            }
            dot = false
            output.displayHistory(historyValue: inputValue)
            
            
        case .mult :

            if inputValue == nil || inputValue == "" || inputValue == "0"{
                
                inputValue = ""
            }
            else if inputValue.characters.last == "."{
                inputValue! += "0 ×"
            }
            
            else if  inputValue.characters.last == "+" || inputValue.characters.last == "-"
                || inputValue.characters.last == "×" || inputValue.characters.last == "÷"
                || inputValue.characters.last == "^"  {
                
                inputValue.characters.removeLast()
                inputValue = inputValue + ("×")
            }
            else   {
                inputValue = inputValue + (" ×")
            }
            dot = false
            
            output.displayHistory(historyValue: inputValue)
            
        case .div :
            dot = false

            if inputValue == nil || inputValue == "" || inputValue == "0"{
                
                inputValue = ""
            }
            else if  inputValue.characters.last == "+" || inputValue.characters.last == "-"
                || inputValue.characters.last == "×" || inputValue.characters.last == "÷"
                || inputValue.characters.last == "^"  {
                
                inputValue.characters.removeLast()
                inputValue = inputValue + ("÷")
            }
            else  {
                inputValue = inputValue + (" ÷")
            }
            
            output.displayHistory(historyValue: inputValue)

        case .pow :
            dot = false

            if inputValue == nil || inputValue == "" || inputValue == "0"{
                
                inputValue = ""
            }
            else if  inputValue.characters.last == "+" || inputValue.characters.last == "-"
                || inputValue.characters.last == "×" || inputValue.characters.last == "÷"
                || inputValue.characters.last == "^"  {
                
                inputValue.characters.removeLast()
                inputValue = inputValue + ("^")
            }
            else  {
                inputValue = inputValue + (" ^")
            }
            
            output.displayHistory(historyValue: inputValue)
            
        case .equal :
            dot = false

//            brain.clear()
//            inputValue = nil
            brain.equalPress()
             inputValue = nil
           
            
        default : break
            
        }
     
    }
    func function(_ function: Function){
        switch function {
        case .sqrt:
            dot = false

            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "√"
            }
            else if inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" || inputValue.characters.last == "π" || inputValue.characters.last == "e"
                || inputValue.characters.last == "!" || inputValue.characters.last == ")"
            {
                inputValue = inputValue + (" × √")
            }
            else if inputValue.characters.last != "." {
                inputValue = inputValue + (" √")
            }
            
            output.displayHistory(historyValue: inputValue)

        case .sin:
            dot = false

//            if inputValue == nil || inputValue == "" || inputValue == "0" {
//                inputValue = "sin ("
//             }
//            else if inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9"
//                || inputValue.characters.last == "π" || inputValue.characters.last == "e"
//                || inputValue.characters.last == ")" {
//                
//                inputValue = inputValue + " × sin ("
//            }
//            else if inputValue.characters.last != "." {
//                inputValue = inputValue + " sin ("
//            }
//            output.displayHistory(historyValue: inputValue)

            
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "sin "
            }
             else if inputValue.characters.last == ")" || inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" {
                inputValue = inputValue + " × sin "
            } else {
                inputValue = inputValue + " sin "
            }
                output.displayHistory(historyValue: inputValue)
            
        case .cos:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0"{
                inputValue = "cos "
            }
            else if inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9"
                || inputValue.characters.last == "π" || inputValue.characters.last == "e"
                || inputValue.characters.last == ")"  {
                inputValue = inputValue + " × cos "
            }
            else if inputValue.characters.last != "." {
                inputValue = inputValue + " cos "
            }
            output.displayHistory(historyValue: inputValue)
            
        case .tan:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0"{
                inputValue = "tan "
            }
            else if inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" || inputValue.characters.last == "π" || inputValue.characters.last == "e"
                || inputValue.characters.last == ")" {
                inputValue = inputValue + " × tan "
            }
            else if inputValue.characters.last != "." {
                inputValue = inputValue + " tan "
            }
            output.displayHistory(historyValue: inputValue)
            
        case .sinh:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "sinh "
            }
            else if inputValue.characters.last == ")" || inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" {
                inputValue = inputValue + " × sinh "
            } else {
                inputValue = inputValue + " sinh "
            }
            output.displayHistory(historyValue: inputValue)

            
        case .cosh:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "cosh "
            }
            else if inputValue.characters.last == ")" || inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" {
                inputValue = inputValue + " × cosh "
            } else {
                inputValue = inputValue + " cosh "
            }
            output.displayHistory(historyValue: inputValue)
            
        case .tanh:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "tanh "
            }
            else if inputValue.characters.last == ")" || inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" {
                inputValue = inputValue + " × tanh "
            } else {
                inputValue = inputValue + " tanh "
            }
            output.displayHistory(historyValue: inputValue)
            
        case .ln:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "ln "
            } else if inputValue.characters.last == ")" || inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" {
                inputValue = inputValue + " × ln ("
            } else {
                inputValue = inputValue + " ln ("
            }
            output.displayHistory(historyValue: inputValue)
            
        case .log:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "log "
            } else if inputValue.characters.last == ")" || inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" {
                inputValue = inputValue + " × log ("
            } else {
                inputValue = inputValue + " log ("
            }
            output.displayHistory(historyValue: inputValue)
            
        case .fact:
            dot = false
            if inputValue == nil || inputValue == "" {
                inputValue = "0"
            }
            else if inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" || inputValue.characters.last == "π" || inputValue.characters.last == "e" {
                inputValue = inputValue + (" !")
            }
            brain.pressEquation(equation: inputValue)
        case .percent:
            if inputValue == nil || inputValue == "" {
                inputValue = "0"
            }
            else if inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" {
                inputValue = inputValue + (" %")
            }
            brain.pressEquation(equation: inputValue)
        
        default:
            break
        }
    }
   
    func Utility(_ utility: Utility){
        switch utility {
        case .dot:
            if inputValue == nil || inputValue == "0" || inputValue == "" {
                inputValue = "0."
                dot = true
            } else if inputValue.characters.last != "." && dot == false {
                if inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" {
                    inputValue! += "."
                    dot = true
                } else if inputValue.characters.last == "(" || inputValue.characters.last == "+" || inputValue.characters.last == "-"
                || inputValue.characters.last == "×" || inputValue.characters.last == "÷" {
                    inputValue = inputValue + " 0."
                    dot = true
                }
            }
            brain.pressEquation(equation: inputValue)
//            output.displayHistory(historyValue: inputValue)
            
        case .leftBracket:
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "("
            }
            else if inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9"{
                inputValue = inputValue + " × ("
            }
            else{
                inputValue = inputValue + " ("
            }
            brain.pressEquation(equation: inputValue)
            output.displayHistory(historyValue: inputValue)

        case .rightBracket:
            if inputValue == nil || inputValue == "" || inputValue == "0"{
                inputValue = "0"
            }
            else if inputValue.characters.last != "(" {
                inputValue = inputValue + " )"
                
            }
            brain.pressEquation(equation: inputValue)
            output.displayHistory(historyValue: inputValue)
            
        default:
            break
        }
        
    }
    
    func memory(_ memory: Memory){
        switch memory {
        
        case .allClean:
            inputValue = nil
            brain.clear()
        
        default:
            break
        }
    }
    
    func Constants(_ constants: Constants){
        switch constants {
        case .pi:
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = String(Double.pi)
            }
            else if inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" || inputValue.characters.last == "π" || inputValue.characters.last == "e"
                || inputValue.characters.last == ")" {
                inputValue = inputValue + " \(String(Double.pi))"
            }
            else if inputValue.characters.last != "."{
                inputValue = inputValue + " \(String(Double.pi))"
            }
            dot = true
            brain.pressEquation(equation: inputValue)
       
        case .pi2:
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = String(Double.pi/2)
            }
            else if inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" || inputValue.characters.last == "π" || inputValue.characters.last == "e"
                || inputValue.characters.last == ")" {
                inputValue = inputValue + " \(String(Double.pi/2))"
            }
            else if inputValue.characters.last != "."{
                inputValue = inputValue + " \(String(Double.pi/2))"
            }
            dot = true
            brain.pressEquation(equation: inputValue)
            

            
        case .e:
            if inputValue == nil || inputValue == "" || inputValue == "0"{
                inputValue = String(M_E)
            }
            else if inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" || inputValue.characters.last == "π" || inputValue.characters.last! == "e"
                || inputValue.characters.last! == ")" {
                inputValue = inputValue + " \(String(M_E))"
            }
            else if inputValue.characters.last != "."{
                inputValue = inputValue + " \(String(M_E))"
            }
            dot = true
//           output.displayHistory(historyValue: inputValue)
             brain.pressEquation(equation: inputValue)
            
        case .ex:
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "e^"
            }
            else if inputValue.characters.last! >= "0" && inputValue.characters.last! <= "9" || inputValue.characters.last == "π" || inputValue.characters.last! == "e"
                || inputValue.characters.last! == ")" {
                inputValue = inputValue + (" × e^")
            }
            else if inputValue.characters.last != "."{
                inputValue = inputValue + (" e^")
            }
           
            output.displayHistory(historyValue: inputValue)

        default:
            break
        }
        
    }
    
    var resultClosure: ((Double?, Error?) -> Void)?
    

}

