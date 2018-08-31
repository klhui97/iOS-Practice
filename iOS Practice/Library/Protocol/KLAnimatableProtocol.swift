//
//  KLAnimatableProtocol.swift
//  iOS Practice
//
//  Created by david.hui on 31/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

protocol KLAnimatableProtocol {
    var center: CGPoint { get }
    var layer: CALayer { get }
}

extension KLAnimatableProtocol where Self: UIView {
    
    func test() {

    }
    
    func deepPress() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        setInitValue(pulse, fromValue: nil, toValue: 1.0, byValue: 0.2)
        
        pulse.duration = 0.2
        
        pulse.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        pulse.damping = 0.1
        pulse.isRemovedOnCompletion = true
        
        addAnimation(pulse)
    }

    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        
        let fromPoint = CGPoint(x: center.x - 3, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 3, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        setInitValue(shake, fromValue: fromValue, toValue: toValue, byValue: nil)
        
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        addAnimation(shake)
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        setInitValue(pulse, fromValue: 1.2, toValue: 1.0, byValue: nil)
        
        pulse.duration = 0.2
        pulse.initialVelocity = 0.5
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        addAnimation(pulse)
    }
    private func setInitValue(_ animation: CABasicAnimation, fromValue: Any? = nil, toValue: Any? = nil, byValue: Any? = nil) {
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.byValue = byValue
    }
    
    private func addAnimation(_ animation: CABasicAnimation) {
        layer.add(animation, forKey: nil)
    }
}
