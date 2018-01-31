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
        
        // Window which need set root view controller
        guard let window = UIApplication.shared.windows.first else { return }
        
        /*
         Animation for UIWindow transition:
         - Fade: center -> center (animated change alpha)
         - zoom: center -> center (scale from `scale` to 1.0)
         - toTop: bottom -> top
         - toBottom: top -> bottom
         - toLeft: right -> left
         - toRight: left -> right
         */
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
        
        // You can create options if you would like animated set root view controller.
        var options = UIWindowTransitionOptions(transition: animation)
        options.duration = 0.4 // Set custom duration in seconds if need. Default is 0.25s
        options.curve = .easeIn // Set custom curve if need. Default is linear
        
        // New root view controller
        let controller = SuccesViewController.controller
        
        /*
         controller - new rootViewController
         transitionOptions - options for transition. If you put `nil`, viewController will change without animation
         */
        window.setRootViewController(controller, transitionOptions: options)
        
    }
    
}
