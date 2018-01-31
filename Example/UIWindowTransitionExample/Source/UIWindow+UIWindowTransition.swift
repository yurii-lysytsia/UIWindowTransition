//
//  UIWindow+UIWindowTransition.swift
//  UIWindowTransition
//
//  Created by Yuri Fox on 31.01.2018.
//  Copyright © 2018 Yuri Lysytsia Developer. All rights reserved.
//

import UIKit

public extension UIWindow {
    
    /// Change the root view controller of the window
    ///
    /// - Parameters:
    ///   - controller: controller to set
    ///   - options: options of the transition
    public func setRootViewController(_ controller: UIViewController, transitionOptions: UIWindowTransitionOptions?) {
        
        guard let options = transitionOptions else {
            self.rootViewController = controller
            return
        }
        
        switch options.transition {
        case .fade, .toBottom, .toTop, .toRight, .toLeft:
            self.layer.add(options.transitionAnimation, forKey: kCATransition)
            self.rootViewController = controller
            self.makeKeyAndVisible()
            
        case .zoom(scale: let scale):
            guard
                let snapshot = controller.view.snapshotView(afterScreenUpdates: true),
                let currentViewController = self.rootViewController
                else { return }
            
            currentViewController.view.addSubview(snapshot)
            snapshot.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            UIView.transition(with: controller.view, duration: options.duration, options: options.curve.animationOption, animations: {
                snapshot.transform = .identity
            }) { [weak self] _ in
                snapshot.removeFromSuperview()
                self?.rootViewController = controller
            }
            
        }
        
    }
    
}

extension UIViewAnimationCurve {
    
    var animationOption: UIViewAnimationOptions {
        switch self {
        case .linear: return .curveLinear
        case .easeIn: return .curveEaseIn
        case .easeOut: return .curveEaseOut
        case .easeInOut: return .curveEaseInOut
        }
    }
    
}

