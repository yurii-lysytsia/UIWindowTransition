//
//  SuccesViewController.swift
//  UIWindowTransitionExample
//
//  Created by Yuri Fox on 31.01.2018.
//  Copyright © 2018 Yuri Lysytsia Developer. All rights reserved.
//

import UIKit

class SuccesViewController: UIViewController {

    static var controller: UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SuccesViewController")
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.viewDidTap))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc private func viewDidTap() {
        guard let window = UIApplication.shared.windows.first else { return }
        let controller = MainViewController.controller
        window.setRootViewController(controller, transitionOptions: nil)
    }
    
}
