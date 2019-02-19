//
//  UIWindowTransition.swift
//  UIWindowTransition
//
//  Created by Yuri Fox on 10/2/18.
//  Copyright © 2018 Yuri Lysytsia. All rights reserved.
//

import class UIKit.UIWindow
import class UIKit.UIView
import class UIKit.UIViewController
import class UIKit.UIImageView
import class UIKit.UIImage
import class UIKit.UIApplication
import func UIKit.UIRectClip
import func UIKit.UIGraphicsBeginImageContext
import func UIKit.UIGraphicsGetCurrentContext
import func UIKit.UIGraphicsGetImageFromCurrentImageContext
import func UIKit.UIGraphicsEndImageContext
import class QuartzCore.CATransition
import class QuartzCore.CAMediaTimingFunction
import struct QuartzCore.CATransform3D
import func QuartzCore.CATransform3DMakeScale
import func QuartzCore.CATransform3DMakeTranslation
import var QuartzCore.CATransform3DIdentity
import var QuartzCore.CALayer.kCATransition
import struct Foundation.TimeInterval
import struct CoreGraphics.CGFloat
import struct CoreGraphics.CGRect


extension UIWindow {
    
    /// Options for window root view controller transition
    public struct Transition {
        
        /// Style of the transition animation (default is .none)
        public var style: TransitionStyle
        
        /// Duration of the transition animation (default is 0.3)
        public var duration: TimeInterval
        
        public init(style: TransitionStyle = .none, duration: TimeInterval = 0.3) {
            self.style = style
            self.duration = duration
        }
        
    }
    
    /// Style for window root view controller transition
    public enum TransitionStyle: String, CaseIterable {
        case none
        case fade
        case flipFromLeft
        case flipFromRight
        case flipFromTop
        case flipFromBottom
        case curlUp
        case curlDown
        case fromLeft
        case fromRight
        case fromTop
        case fromBottom
        case zoomOut
        case zoomIn
        case sliceVertical
        case sliceHorizontal
    }
    
    /// Set the root view controller of this window with transition
    ///
    /// - Parameters:
    ///   - transition: options of the transition
    ///   - viewController: new root view controller to set
    public func transition(_ transition: Transition, to viewController: UIViewController) {
        let style = transition.style
        let duration = transition.duration
        
        switch style {
        case .none:
            self.rootViewController = viewController
            
        case .fromLeft, .fromRight, .fromTop, .fromBottom:
            let animation = CATransition()
            animation.duration = duration
            animation.timingFunction = CAMediaTimingFunction(name: .linear)
            animation.type = .push
            switch style {
            case .fromLeft: animation.subtype = .fromLeft
            case .fromRight: animation.subtype = .fromRight
            case .fromTop: animation.subtype = .fromTop
            case .fromBottom: animation.subtype = .fromBottom
            default: fatalError("It's impossible. But if it's happened tell developer about that")
            }
            self.layer.add(animation, forKey: kCATransition)
            self.rootViewController = viewController
            
        case .zoomOut, .zoomIn:
            guard let snapshot = snapshotView(afterScreenUpdates: true) else {
                self.rootViewController = viewController
                return
            }
            
            let scale: CGFloat = style == .zoomIn ? 0.01 : 1.5
            
            viewController.view.addSubview(snapshot)
            self.rootViewController = viewController
            
            UIView.animate(withDuration: duration, animations: {
                snapshot.layer.opacity = 0.00
                snapshot.layer.transform = CATransform3DMakeScale(scale, scale, scale)
            }) { _ in
                snapshot.removeFromSuperview()
            }
            
        case .sliceVertical:
            let width = viewController.view.frame.width
            let halfHeight = viewController.view.frame.height/2
            let aboveRect = CGRect(x: 0, y: 0, width: width, height: halfHeight)
            let belowRect = CGRect(x: 0, y: halfHeight, width: width, height: halfHeight)
            
            let aboveImageView = UIImageView(image: self.clippedImage(rect: aboveRect))
            let belowImageView = UIImageView(image: self.clippedImage(rect: belowRect))

            viewController.view.addSubview(aboveImageView)
            viewController.view.addSubview(belowImageView)
            self.rootViewController = viewController

            viewController.view.layer.transform = CATransform3DMakeScale(0.98, 0.98, 1)

            UIView.animate(withDuration: duration, animations: {
                aboveImageView.layer.transform = CATransform3DMakeTranslation(0, -halfHeight, 0)
                belowImageView.layer.transform = CATransform3DMakeTranslation(0, halfHeight, 0)
                viewController.view.layer.transform = CATransform3DIdentity
            }) { _ in
                aboveImageView.removeFromSuperview()
                belowImageView.removeFromSuperview()
            }
            
        case .sliceHorizontal:
            let halfWidth = viewController.view.frame.width/2
            let wholeHeight = viewController.view.frame.height
            let leftRect = CGRect(x: 0, y: 0, width: halfWidth, height: wholeHeight)
            let rightRect = CGRect(x: halfWidth, y: 0, width: halfWidth, height: wholeHeight)
            
            let leftImageView = UIImageView(image: self.clippedImage(rect: leftRect))
            let rightImageView = UIImageView(image: self.clippedImage(rect: rightRect))
            
            viewController.view.addSubview(leftImageView)
            viewController.view.addSubview(rightImageView)
            self.rootViewController = viewController
            
            viewController.view.layer.transform = CATransform3DMakeScale(0.98, 0.98, 1)
            
            UIView.animate(withDuration: duration, animations: {
                leftImageView.layer.transform = CATransform3DMakeTranslation(-halfWidth, 0, 0)
                rightImageView.layer.transform = CATransform3DMakeTranslation(halfWidth * 2, 0, 0)
                viewController.view.layer.transform = CATransform3DIdentity
            }) { _ in
                leftImageView.removeFromSuperview()
                rightImageView.removeFromSuperview()
            }
            
        default:
            
            let options: UIView.AnimationOptions = {
                switch style {
                case .fade: return .transitionCrossDissolve
                case .flipFromLeft: return .transitionFlipFromLeft
                case .flipFromRight: return .transitionFlipFromRight
                case .flipFromTop: return .transitionFlipFromTop
                case .flipFromBottom: return .transitionFlipFromBottom
                case .curlUp: return .transitionCurlUp
                case .curlDown: return .transitionCurlDown
                default: fatalError("It's impossible. But if it's happened tell developer about that")
                }
            }()
            
            UIView.transition(with: self, duration: duration, options: options, animations: { [weak self] in
                self?.rootViewController = viewController
                }, completion: nil)
            
        }
    }
    
    /// Set the root view controller of this window with transition style
    ///
    /// - Parameters:
    ///   - viewController: new root view controller to set
    ///   - style: style of the transition
    public func transition(to viewController: UIViewController, style: TransitionStyle) {
        let transition = Transition(style: style)
        self.transition(transition, to: viewController)
    }
    
    /// Set the root view controller of this window with random transition
    ///
    /// - Parameter viewController: new root view controller to set
    public func randomTransition(to viewController: UIViewController) {
        let style = TransitionStyle.allCases.randomElement() ?? .none
        self.transition(to: viewController, style: style)
    }
    
}

extension UIApplication {
    
    /// Set the root view controller of main application window with transition
    ///
    /// - Parameters:
    ///   - newRootController: new root view controller to set
    ///   - transition: options of the transition
    /// - Returns: if true the transition was successful
    @discardableResult
    public func setRootViewController(_ newRootController: UIViewController, transition: UIWindow.Transition) -> Bool {
        
        guard let window = self.windows.first ?? self.keyWindow else { return false }
        window.transition(transition, to: newRootController)
        return true
        
    }
    
    /// Set the root view controller of main application window with transition style
    ///
    /// - Parameters:
    ///   - newRootController: new root view controller to set
    ///   - style: style of the transition
    /// - Returns: if true the transition was successful
    @discardableResult
    public func setRootViewController(_ newRootController: UIViewController, style: UIWindow.TransitionStyle) -> Bool {
        
        let transition = UIWindow.Transition(style: style)
        return self.setRootViewController(newRootController, transition: transition)
        
    }
    
}

extension UIView {
    
    fileprivate func clippedImage(rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(self.frame.size)
        let context = UIGraphicsGetCurrentContext()
        context!.saveGState()
        UIRectClip(rect)
        self.layer.render(in: context!)
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return output!
    }
    
}
