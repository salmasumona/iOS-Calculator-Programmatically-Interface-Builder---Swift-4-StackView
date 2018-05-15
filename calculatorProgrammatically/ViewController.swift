//
//  ViewController.swift
//  calculatorProgrammatically
//
//  Created by Apple on 5/9/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

enum Operation:String{
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case Null = "Null"
}

class ViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .black
        setupViews()
    }
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation:Operation = .Null
    
    let topUIview: UIView = {
        let topview = UIView()
        topview.translatesAutoresizingMaskIntoConstraints = false
        topview.backgroundColor = UIColor.black
        //topview.center = view.center
        return topview
    }()
    let inputTextView: UILabel = {
        let textView = UILabel()
        textView.text = "0"
        textView.textAlignment = .center
        textView.textColor = UIColor.gray
        textView.backgroundColor = UIColor.black
        textView.frame.size = CGSize(width: 70, height: 80)
        //textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let buttonDictionary1 = [
        1:["AC",UIColor.darkGray],
        2:["/",UIColor.orange]
    ]
    let buttonDictionary2 = [
        3:["7",UIColor.gray],
        4:["8",UIColor.gray],
        5:["9",UIColor.gray],
        6:["*",UIColor.orange]
    ]
    let buttonDictionary3 = [
        7:["4",UIColor.gray],
        8:["5",UIColor.gray],
        9:["6",UIColor.gray],
        10:["-",UIColor.orange]
    ]
    let buttonDictionary4 = [
        11:["1",UIColor.gray],
        12:["2",UIColor.gray],
        13:["3",UIColor.gray],
        14:["+",UIColor.orange]
    ]
    let buttonDictionary5 = [
        15:["0",UIColor.gray],
        16:[".",UIColor.gray],
        17:["=",UIColor.orange]
    ]
    
    func inputButton(withColor color:UIColor, title:String, width:Int, height:Int) -> UIButton{
        let button = UIButton()
        button.backgroundColor = color
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }
    
    func setupViews(){

        //let blackButton = inputButton(withColor: UIColor.green, title: "Black", width:30, height:80)
        
        let subStackView =  rowCreate(arr:buttonDictionary1)
        let subStackView2 = rowCreate(arr:buttonDictionary2)
        let subStackView3 = rowCreate(arr:buttonDictionary3)
        let subStackView4 = rowCreate(arr:buttonDictionary4)
        let subStackView5 = rowCreate(arr:buttonDictionary5)
        
        let stackView = UIStackView(arrangedSubviews: [inputTextView,subStackView,subStackView2,subStackView3,subStackView4,subStackView5])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        stackView.widthAnchor.constraint(equalToConstant: CGFloat(350)).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: CGFloat(450)).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       
        //topUIview.addSubview(stackView)
//        let viewsDictionary = ["stackView":stackView]
//        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[stackView]-5-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
//        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[stackView]-5-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
//        topUIview.addConstraints(stackView_H)
//        topUIview.addConstraints(stackView_V)
    }
    func rowCreate(arr: Dictionary<Int, Array<Any>>) -> UIStackView{
        var buttonArray = [UIButton]()
        var w = 0
        let arrSorted = arr.sorted(by: {$0.key < $1.key})
        var alphaVal = 0.4
        
        for (key,val) in arrSorted {
            
            if arr.count==2 && key == 1 {
                w = 260
                alphaVal = 1.0
            }else if arr.count==3 && key == 15 {
                w = 165
            }else {
                w = 80
            }
            
            if key == 2 || key == 6 || key == 10 || key == 14 || key == 17 {
                alphaVal = 1.0
            }
            
            let button = UIButton()
            button.backgroundColor = (val[1] as? UIColor)?.withAlphaComponent(CGFloat(alphaVal))
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: CGFloat(w)).isActive = true
            button.heightAnchor.constraint(equalToConstant: 80).isActive = true
            button.layer.cornerRadius = CGFloat(0.4 * Double(80))
            button.clipsToBounds = true
            if String(describing: val[0]) == "AC" {
                button.addTarget(self, action: #selector(allClearPressed), for: .touchUpInside)
            }else if String(describing: val[0]) == "/" {
                button.addTarget(self, action: #selector(dividePressed), for: .touchUpInside)
            }else if String(describing: val[0]) == "+" {
                button.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
            }else if String(describing: val[0]) == "-" {
                button.addTarget(self, action: #selector(subtractPressed), for: .touchUpInside)
            }else if String(describing: val[0]) == "*" {
                button.addTarget(self, action: #selector(multiplyPressed), for: .touchUpInside)
            }else if String(describing: val[0]) == "." {
                button.addTarget(self, action: #selector(dotPressed), for: .touchUpInside)
            }else if String(describing: val[0]) == "=" {
                button.addTarget(self, action: #selector(equalPressed), for: .touchUpInside)
            }else {
                button.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
            }
            
            button.setTitle(String(describing: val[0]), for: .normal)
            buttonArray += [button]
        }
        let subStackView = UIStackView(arrangedSubviews: buttonArray)
        subStackView.axis = .horizontal
        subStackView.distribution = .equalSpacing
        subStackView.alignment = .fill
        subStackView.translatesAutoresizingMaskIntoConstraints = false
        subStackView.spacing = 5
        return subStackView
    }
}

