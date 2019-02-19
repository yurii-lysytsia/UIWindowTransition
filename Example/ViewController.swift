//
//  ViewController.swift
//  Example
//
//  Created by Yuri Fox on 2/19/19.
//  Copyright © 2019 Yuri Lysytsia. All rights reserved.
//

import UIKit
import UIWindowTransition

class ViewController: UIViewController {

    private let durationFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    @IBOutlet private weak var durationSlider: UISlider!
    @IBOutlet private weak var durationLabel: UILabel!

    @IBAction private func durationSliderValueChanged(_ sender: UISlider) {
        let value = NSNumber(value: sender.value)
        let duration = self.durationFormatter.string(from: value)!
        self.durationLabel.text = "Transition duration \(duration)s"
    }
    
    @IBAction private func transitionButtonDidTap(_ sender: UIButton) {
        let alert = UIAlertController(title: "Select the type of transition", message: nil, preferredStyle: .actionSheet)
        
        UIWindow.TransitionStyle.allCases.forEach { (style) in
            alert.addAction(.init(title: style.rawValue, style: .default) { _ in
                self.setNewRootViewController(style: style)
            })
        }
        
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }

    private func setNewRootViewController(style: UIWindow.TransitionStyle) {
        let controller = (self.storyboard?.instantiateInitialViewController())!
        controller.view.backgroundColor = [
            UIColor.red, UIColor.blue, UIColor.orange, UIColor.white, UIColor.yellow
        ].randomElement()!
        let duration = TimeInterval(self.durationSlider.value)
        let transition = UIWindow.Transition(style: style, duration: duration)
        UIApplication.shared.setRootViewController(controller, transition: transition)
    }
    
}

