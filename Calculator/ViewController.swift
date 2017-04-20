//
//  ViewController.swift
//  Calculator
//
//  Created by Michel Deiman on 16/02/2017.
//  Copyright © 2017 Michel Deiman. All rights reserved.
//

import UIKit

extension UIUserInterfaceSizeClass: CustomStringConvertible {
	public var description: String {
		switch self {
		case .compact: return "compact"
		case .regular: return "regular"
		default: return "unspecified"
		}
	}
}


class ViewController: UIViewController {
	
	@IBOutlet weak var display: UILabel!
	var displayValue: Double {
		get {   return Double(display.text!)!
		}
		set {   display.text = String(newValue)
		}
	}
	
	var userIsInTheMiddleOfTyping = false
	
	private func showSizeClasses() -> String {
		let horizontalDescription = traitCollection.horizontalSizeClass.description
		let verticalDescription = traitCollection.verticalSizeClass.description
		return ("Width: \(horizontalDescription)  height: \(verticalDescription)")
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print(showSizeClasses())
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		coordinator.animate(alongsideTransition: { (coordinator) in
			print(self.showSizeClasses())
		}, completion: nil)
		//		print(showSizeClasses())
	}
	
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }

    
    

}

