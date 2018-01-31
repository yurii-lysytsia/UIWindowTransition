//
//  UIWindowTransitionOptions.swift
//  UIWindowTransition
//
//  Created by Yuri Fox on 31.01.2018.
//  Copyright © 2018 Yuri Lysytsia Developer. All rights reserved.
//

import UIKit

/// Transition options to set root view controller
public struct UIWindowTransitionOptions {
    
    /// Transition of the animation
    public enum Transition {
        case fade, toTop, toBottom, toLeft, toRight
        case zoom(scale: CGFloat)
    }
    
    /// Animation of the transition
    public var transition: Transition
    
    /// Duration of the animation (default is 0.25)
    public var duration: TimeInterval = 0.25
    
    /// Curve of the transition (default is `linear`)
    public var curve: UIViewAnimationCurve = .linear
    
    /// Initialize a new options object with given direction, curve and duration
    public init(transition: Transition) {
        self.transition = transition
    }
    
    /// Return the animation to perform for given options object
    var transitionAnimation: CATransition {
        let transition = CATransition()
        transition.duration = self.duration
        
        switch self.curve {
        case .linear: transition.timingFunction =
            CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        case .easeIn: transition.timingFunction =
            CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
        case .easeOut: transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        case .easeInOut: transition.timingFunction =
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        }
        
        switch self.transition {
        case .fade:
            transition.type = kCATransitionFade
            transition.subtype = nil
        case .toLeft:
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
        case .toRight:
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
        case .toTop:
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromTop
        case .toBottom:
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromBottom
        default:
            return transition
        }
        
        return transition
        
    }
    
}
