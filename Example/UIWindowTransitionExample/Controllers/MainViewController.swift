//
//  MainViewController.swift
//  UIWindowTransitionExample
//
//  Created by Yuri Fox on 31.01.2018.
//  Copyright © 2018 Yuri Lysytsia Developer. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    static var controller: UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        return controller
    }
    
    @IBAction func buttonDidTap(_ sender: UIButton) {
        
        guard let window = UIApplication.shared.windows.first else { return }
        
        let animation: UIWindowTransitionOptions.Transition
        
        switch sender.tag {
        case 0: animation = .fade
        case 1: animation = .zoom(scale: 0.5)
        case 2: animation = .zoom(scale: 1.5)
        case 3: animation = .toTop
        case 4: animation = .toBottom
        case 5: animation = .toLeft
        case 6: animation = .toRight
        default: return
        }
        
        let controller = SuccesViewController.controller
        
        var options = UIWindowTransitionOptions(transition: animation)
        options.duration = 0.4
        options.curve = .easeIn
        
        window.setRootViewController(controller, transitionOptions: options)
        
    }
    
}
