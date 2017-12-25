//
//  Protocol.swift
//  Calculator
//
//  Created by Yurii Vients on 10/10/17.
//  Copyright © 2017 Yurii Vients. All rights reserved.
//

import Foundation

// MARK: Protocols
protocol InputInterface {
    func symbolPressed(_ symbol: String)
}

protocol OutputInterface {
    func display(_ result: String)
}

protocol CalculatorInterface {
    func digit(_ value: Int)
    func operation(_ operation: Operation)
    func function(_ function: Function)
    func memory(_ memory: Memory)
    func Utility(_ utility: Utility)
    func Constants(_ constants: Constants)
    
}

protocol InputDelegate {
    func enterDigit(_ value: String)
    func soundTap()
}

enum Operation: String {
    case plus  = "+"
    case minus = "-"
    case mult  = "×"
    case div   = "÷"
    case pow   = "^"
    case equal = "="
}

enum Function: String {
    case sqrt    = "√"
    case sin     = "sin"
    case cos     = "cos"
    case tan     = "tan"
    case sinh    = "sinh"
    case cosh    = "cosh"
    case tanh    = "tanh"
    case ln      = "ln"
    case log     = "log"
    case fact    = "!"
    case percent = "%"
    case sign    = "+/-"
}

enum Memory: String {
    case memoryRead   = "mr"
    case memoryClean  = "mc"
    case memoryAdd    = "m+"
    case memoryRemove = "m-"
    case clean        = "C"
    case allClean     = "AC"
}

enum Utility: String {
    case dot          = "."
    case leftBracket  = "("
    case rightBracket = ")"
}

enum Constants: String {
    case pi = "π"
    case pi2 = "π/2"
    case e  = "e"
    case ex = "e^"
}

