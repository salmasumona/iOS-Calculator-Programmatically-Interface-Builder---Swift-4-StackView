//
//  viewControllerExtension.swift
//  calculatorProgrammatically
//
//  Created by Apple on 5/13/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

extension ViewController {
   
    @objc func numberPressed(_ sender: UIButton!) {
        
        if runningNumber.count <= 8 {
            runningNumber += "\((sender.titleLabel!.text!))"
            inputTextView.text = runningNumber
        }
    }
    
    @objc func allClearPressed(_ sender: UIButton!) {
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .Null
        inputTextView.text = "0"
    }
    
    @objc func dotPressed(_ sender: UIButton!) {
        if runningNumber.count <= 7 {
            runningNumber += "."
            inputTextView.text = runningNumber
        }
    }
    
    @objc func equalPressed(_ sender: UIButton!) {
        operation(operation: currentOperation)
    }
    
    @objc func addPressed(_ sender: UIButton!) {
        operation(operation: .Add)
    }
    
    @objc func subtractPressed(_ sender: UIButton!) {
        operation(operation: .Subtract)
    }
    
    @objc func multiplyPressed(_ sender: UIButton!) {
        operation(operation: .Multiply)
    }
    
    @objc func dividePressed(_ sender: UIButton!) {
        operation(operation: .Divide)
    }
    
    func operation(operation:Operation){
        if currentOperation != .Null{
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
                print("r \(rightValue)")
                print("l \(leftValue == "")")
                if leftValue=="" {
                    print("test1")
                    createAlert(titleText : "Alert", messageText : "Please enter a digit.")
                }
                if currentOperation == .Add && leftValue != "" {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }else if currentOperation == .Subtract  && leftValue != "" {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                }else if currentOperation == .Multiply  && leftValue != "" {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                }else if currentOperation == .Divide  && leftValue != "" {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                print("result \(result)")
                leftValue = result
                if (result != "" && Double(result)!.truncatingRemainder(dividingBy: 1) == 0){
                    result = "\(Int(Double(result)!))"
                }
                
                inputTextView.text = result
            }
            currentOperation = operation
        }else{
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    func createAlert(titleText : String, messageText : String){
        print("test2 \(titleText) \(messageText)")
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
