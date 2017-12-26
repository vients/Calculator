//
//  Brain.swift
//  Calculator
//
//  Created by Yurii Vients on 10/11/17.
//  Copyright © 2017 Yurii Vients. All rights reserved.
//

import Foundation

class Brain {
    
    let output = Output.shared
    var equation: String?
    var history: String?
    private var memory: String?
    
    func pressEquation(equation: String){
        
        self.history = equation
        self.equation = equation
        print("equation = \(equation)")
        operationCalculate()
    }
    
    
    func parseInfix(_ equationStr: String) -> [String] {
        let tokens = equationStr.split{ $0 == " " }.map(String.init)
        return tokens
    }
    
    func calculateResult() -> Double {
        if equation == nil {
            equation = "0"
        }
        let rpnStr = reverseToPolandNotation(tokens: parseInfix(equation ?? "")) //  RPN
        var stack : [String] = [] // stack for digit
        
        for tok in rpnStr {
            if Double(tok) != nil  {
                stack += [tok]
                
            } else if !stack.isEmpty && (tok == Function.sin.rawValue
                || tok == Function.cos.rawValue
                || tok == Function.tan.rawValue
                || tok == Function.ln.rawValue
                || tok == Function.sqrt.rawValue
                || tok == Function.log.rawValue
                || tok == Function.sinh.rawValue
                || tok == Function.cosh.rawValue
                || tok == Function.tanh.rawValue
                || tok == Function.fact.rawValue
                || tok == Constants.pi.rawValue
                || tok == Constants.ex.rawValue)
                || tok == Function.percent.rawValue {
                
                if let operand = Double((stack.removeLast())) {
                    switch tok {
                    case Function.sin.rawValue:
                        stack += [String(sin(operand))]
                    case Function.cos.rawValue:
                        stack += [String(cos(operand))]
                    case Function.tan.rawValue:
                        stack += [String(tan(operand))]
                    case Function.sinh.rawValue:
                        stack += [String(sinh(operand))]
                    case Function.cosh.rawValue:
                        stack += [String(cosh(operand))]
                    case Function.tanh.rawValue:
                        stack += [String(tanh(operand))]
                    case Function.ln.rawValue:
                        stack += [String(log(operand))]
                    case Function.log.rawValue:
                        stack += [String(log(operand)/log(10.0))]
                    case Function.sqrt.rawValue:
                        stack += [String(sqrt(operand))]
                    case Function.fact.rawValue:
                        stack += [String(factorial(operand))]
                    case Function.percent.rawValue:
                        stack += [String(percent(perValue: Int(operand)))]
                    case Constants.ex.rawValue:
                        stack += [String( pow(M_E, operand))]
                    default:
                        break
                    }
                }
            } else {
                if stack.count > 1 {
                    if let secondOperand = Double(stack.removeLast()), let firstOperand = Double(stack.removeLast()) {
                        switch tok {
                        case Operation.plus.rawValue:
                            stack += [String(firstOperand + secondOperand)]
                        case Operation.minus.rawValue:
                            stack += [String(firstOperand - secondOperand)]
                        case Operation.div.rawValue:
                            stack += [String(firstOperand / secondOperand)]
                        case Operation.mult.rawValue:
                            stack += [String(firstOperand * secondOperand)]
                        case Operation.pow.rawValue:
                            stack += [String(pow(firstOperand,secondOperand))]
                            
                        default:
                            break
                        }
                    }
                } else {
                    return 0.0
                }
            }
        }
        
        print("stackResult = \(stack)")
        return Double(stack.removeLast())!
    }
    
    func reverseToPolandNotation(tokens: [String]) -> [String] {
        var rpn : [String]   = [] // buffer for entire equation in RPN
        var stack : [String] = [] // buffer for operation
        
        // dictionary with priority operation
        let operationPrec: Dictionary<String, Int> = [
            Operation.pow.rawValue: 4,
            Function.sqrt.rawValue: 5,
            Operation.mult.rawValue: 3,
            Operation.div.rawValue: 3,
            Operation.plus.rawValue: 2,
            Operation.minus.rawValue: 2,
            Function.ln.rawValue: 4,
            Function.log.rawValue: 4,
            Function.sin.rawValue: 5,
            Function.cos.rawValue: 5,
            Function.tan.rawValue: 5,
            Function.sinh.rawValue: 5,
            Function.cosh.rawValue: 5,
            Function.tanh.rawValue: 5,
            Constants.ex.rawValue: 5,
            Function.percent.rawValue: 5
        ]
        
        for tok in tokens {
            switch tok {
            case Utility.leftBracket.rawValue:
                stack += [tok]
            case Utility.rightBracket.rawValue:
                while !stack.isEmpty {
                    let op = stack.removeLast()
                    if op == Utility.leftBracket.rawValue {
                        break
                    } else {
                        rpn += [op]
                    }
                }
            default:
                if let operand1 = operationPrec[tok] {
                    for op in stack.reversed() {
                        if let operand2 = operationPrec[op], !(operand1 > operand2) {
                            rpn += [stack.removeLast()]
                            continue
                        }
                        break
                    }
                    stack += [tok]
                } else {
                    rpn += [tok]
                }
            }
        }
        print("rpn = \(rpn)")
        return (rpn + stack.reversed())
    }
    
    func factorial(_ n: Double) -> Double {
        if n == 0 {
            return 1
        }
        else {
            return abs(n) * factorial(abs(n) - 1)
        }
    }
    
    func percent(perValue: Int) -> Double {
        return (Double(perValue) / 100)
    }
    
    func displayHistory(currentvalue: String) {
        output.displayHistory(historyValue: currentvalue)
    }
    
    func equalPress()  {
        
        //      let equalresult = String(format: "%g", calculateResult())
        let equalresult =  calculateResult()
        
        output.display(String(equalresult))
        output.displayHistory(historyValue: "")
    }
    
    func operationCalculate() {
        let result = calculateResult()
        memory = String(format: "%g", Double(result))
        
        output.display(String(result))
        displayHistory(currentvalue: history!)
    }
    
    
    func clear() {
        //      equation = nil
        output.displayHistory(historyValue: "")
        output.display("0")
    }
    
    func getResult() -> String {
        return memory!
    }
    
}








