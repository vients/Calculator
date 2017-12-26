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
    private var inputValue: String!
    var brain = Brain()
    var dot = false
    private var memoryVal: Int = 0
    
    func digit(_ value: Int){
        if inputValue == nil || inputValue == "0" {
            inputValue = String(value)
        }
        else if inputValue.last == "." || inputValue.last! >= "0" && inputValue.last! <= "9" || (inputValue.count == 1 &&
            (inputValue.last == "+" || inputValue.last == "-"))  {
            inputValue = inputValue + "\(value)"
        }
        else if inputValue.last == ")" {
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
            else if inputValue.last == "."{
                inputValue! += "0 +"
            }
            else if  inputValue.last == "+" || inputValue.last == "-"
                || inputValue.last == "×" || inputValue.last == "÷"
                || inputValue.last == "^"  {
                
                inputValue.removeLast()
                inputValue = inputValue + ("+")
            }
            else {
                inputValue = inputValue + (" +")
            }
            dot = false
            brain.pressEquation(equation: inputValue)
            
        case .minus :
            
            if inputValue == nil || inputValue == "" || inputValue == "0"
            {
                inputValue = "-"
            }
            else if inputValue.last == "."{
                inputValue! += "0 -"
            }
            else if  inputValue.last == "+" || inputValue.last == "-"
                || inputValue.last == "×" || inputValue.last == "÷"
                || inputValue.last == "^" {
                
                inputValue.removeLast()
                inputValue = inputValue + ("-")
            }
            else if inputValue.last != "√"  {
                inputValue = inputValue + (" -")
            }
            dot = false
            brain.pressEquation(equation: inputValue)
     
        case .mult :
            
            if inputValue == nil || inputValue == "" || inputValue == "0"{
                
                inputValue = "0"
            }
            else if inputValue.last == "."{
                inputValue! += "0 ×"
            }
                
            else if  inputValue.last == "+" || inputValue.last == "-"
                || inputValue.last == "×" || inputValue.last == "÷"
                || inputValue.last == "^"  {
                
                inputValue.removeLast()
                inputValue = inputValue + ("×")
            }
            else   {
                inputValue = inputValue + (" ×")
            }
            dot = false
            brain.pressEquation(equation: inputValue)
           
        case .div :
            dot = false
            
            if inputValue == nil || inputValue == "" || inputValue == "0"{
                
                inputValue = "0"
            }
            else if  inputValue.last == "+" || inputValue.last == "-"
                || inputValue.last == "×" || inputValue.last == "÷"
                || inputValue.last == "^"  {
                
                inputValue.removeLast()
                inputValue = inputValue + ("÷")
            }
            else  {
                inputValue = inputValue + (" ÷")
            }
            brain.pressEquation(equation: inputValue)
          
        case .pow :
            dot = false
            
            if inputValue == nil || inputValue == "" || inputValue == "0"{
                
                inputValue = "0"
            }
            else if  inputValue.last == "+" || inputValue.last == "-"
                || inputValue.last == "×" || inputValue.last == "÷"
                || inputValue.last == "^"  {
                
                inputValue.removeLast()
                inputValue = inputValue + ("^")
            }
            else  {
                inputValue = inputValue + (" ^")
            }
            brain.pressEquation(equation: inputValue)
            
        case .equal :
            dot = false
            //            brain.clear()
            //            inputValue = nil
            brain.equalPress()
            inputValue = nil
        
        }
        
    }
    
    func function(_ function: Function){
        switch function {
        case .sqrt:
            dot = false
            
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "√"
            }
            else if inputValue.last! >= "0" && inputValue.last! <= "9" || inputValue.last == "π" || inputValue.last == "e"
                || inputValue.last == "!" || inputValue.last == ")"
            {
                inputValue = inputValue + (" × √")
            }
            else if inputValue.last != "." {
                inputValue = inputValue + (" √")
            }
            brain.pressEquation(equation: inputValue)
           
            
        case .sin:
            dot = false
            
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "sin "
            }
            else if inputValue.last == ")" || inputValue.last! >= "0" && inputValue.last! <= "9" {
                inputValue = inputValue + " × sin "
            } else {
                inputValue = inputValue + " sin "
            }
            brain.pressEquation(equation: inputValue)
            
        case .cos:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0"{
                inputValue = "cos "
            }
            else if inputValue.last! >= "0" && inputValue.last! <= "9"
                || inputValue.last == "π" || inputValue.last == "e"
                || inputValue.last == ")"  {
                inputValue = inputValue + " × cos "
            }
            else if inputValue.last != "." {
                inputValue = inputValue + " cos "
            }
            brain.pressEquation(equation: inputValue)
            
        case .tan:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0"{
                inputValue = "tan "
            }
            else if inputValue.last! >= "0" && inputValue.last! <= "9" || inputValue.last == "π" || inputValue.last == "e"
                || inputValue.last == ")" {
                inputValue = inputValue + " × tan "
            }
            else if inputValue.last != "." {
                inputValue = inputValue + " tan "
            }
            brain.pressEquation(equation: inputValue)
            
        case .sinh:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "sinh "
            }
            else if inputValue.last == ")" || inputValue.last! >= "0" && inputValue.last! <= "9" {
                inputValue = inputValue + " × sinh "
            } else {
                inputValue = inputValue + " sinh "
            }
            brain.pressEquation(equation: inputValue)
            
        case .cosh:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "cosh "
            }
            else if inputValue.last == ")" || inputValue.last! >= "0" && inputValue.last! <= "9" {
                inputValue = inputValue + " × cosh "
            } else {
                inputValue = inputValue + " cosh "
            }
            brain.pressEquation(equation: inputValue)
            
        case .tanh:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "tanh "
            }
            else if inputValue.last == ")" || inputValue.last! >= "0" && inputValue.last! <= "9" {
                inputValue = inputValue + " × tanh "
            } else {
                inputValue = inputValue + " tanh "
            }
            brain.pressEquation(equation: inputValue)
            
        case .ln:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "ln "
            } else if inputValue.last == ")" || inputValue.last! >= "0" && inputValue.last! <= "9" {
                inputValue = inputValue + " × ln ("
            } else {
                inputValue = inputValue + " ln ("
            }
            brain.pressEquation(equation: inputValue)
            
        case .log:
            dot = false
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "log "
            } else if inputValue.last == ")" || inputValue.last! >= "0" && inputValue.last! <= "9" {
                inputValue = inputValue + " × log ("
            } else {
                inputValue = inputValue + " log ("
            }
            brain.pressEquation(equation: inputValue)
            
        case .fact:
            dot = false
            if inputValue == nil || inputValue == "" {
                inputValue = "0"
            }
            else if inputValue.last! >= "0" && inputValue.last! <= "9" || inputValue.last == "π" || inputValue.last == "e" {
                inputValue = inputValue + (" !")
            }
            brain.pressEquation(equation: inputValue)
            
        case .percent:
            if inputValue == nil || inputValue == "" {
                inputValue = "0"
            }
            else if inputValue.last! >= "0" && inputValue.last! <= "9" {
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
            } else if inputValue.last != "." && dot == false {
                if inputValue.last! >= "0" && inputValue.last! <= "9" {
                    inputValue! += "."
                    dot = true
                } else if inputValue.last == "(" || inputValue.last == "+" || inputValue.last == "-"
                    || inputValue.last == "×" || inputValue.last == "÷" {
                    inputValue = inputValue + " 0."
                    dot = true
                }
            }
            brain.pressEquation(equation: inputValue)
            
        case .leftBracket:
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "("
            }
            else if inputValue.last! >= "0" && inputValue.last! <= "9"{
                inputValue = inputValue + " × ("
            }
            else{
                inputValue = inputValue + " ("
            }
            brain.pressEquation(equation: inputValue)
            
        case .rightBracket:
            if inputValue == nil || inputValue == "" || inputValue == "0"{
                inputValue = "0"
            }
            else if inputValue.last != "(" {
                inputValue = inputValue + " )"
                
            }
            brain.pressEquation(equation: inputValue)
            
        }
        
    }
    
    func memory(_ memory: Memory){
        switch memory {
            
        case .allClean:
            inputValue = nil
            brain.clear()
            
        case .memoryAdd:
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                memoryVal = 0
            }
            else {
                memoryVal = memoryVal + Int(brain.getResult())!
            }
            
        case .memoryClean:
            memoryVal = 0
            
        case .memoryRemove:
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                memoryVal = 0
            }
            else {
                memoryVal = memoryVal - Int(brain.getResult())!
            }
            
        case .memoryRead:
            digit(memoryVal)
            
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
            else if inputValue.last! >= "0" && inputValue.last! <= "9" || inputValue.last == "π" || inputValue.last == "e"
                || inputValue.last == ")" {
                inputValue = inputValue + " \(String(Double.pi))"
            }
            else if inputValue.last != "."{
                inputValue = inputValue + " \(String(Double.pi))"
            }
            dot = true
            
            brain.pressEquation(equation: inputValue)
            
        case .pi2:
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = String(Double.pi/2)
            }
            else if inputValue.last! >= "0" && inputValue.last! <= "9" || inputValue.last == "π" || inputValue.last == "e"
                || inputValue.last == ")" {
                inputValue = inputValue + " \(String(Double.pi/2))"
            }
            else if inputValue.last != "."{
                inputValue = inputValue + " \(String(Double.pi/2))"
            }
            dot = true
            
            brain.pressEquation(equation: inputValue)
            
            
            
        case .e:
            if inputValue == nil || inputValue == "" || inputValue == "0"{
                inputValue = String(M_E)
            }
            else if inputValue.last! >= "0" && inputValue.last! <= "9" || inputValue.last == "π" || inputValue.last! == "e"
                || inputValue.last! == ")" {
                inputValue = inputValue + " \(String(M_E))"
            }
            else if inputValue.last != "."{
                inputValue = inputValue + " \(String(M_E))"
            }
            dot = true
            
            brain.pressEquation(equation: inputValue)
            
        case .ex:
            if inputValue == nil || inputValue == "" || inputValue == "0" {
                inputValue = "e^"
            }
            else if inputValue.last! >= "0" && inputValue.last! <= "9" || inputValue.last == "π" || inputValue.last! == "e"
                || inputValue.last! == ")" {
                inputValue = inputValue + (" × e^")
            }
            else if inputValue.last != "."{
                inputValue = inputValue + (" e^")
            }
            brain.pressEquation(equation: inputValue)
            
        }
        
    }
    
}

