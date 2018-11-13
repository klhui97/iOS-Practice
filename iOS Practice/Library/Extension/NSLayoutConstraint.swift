//
//  NSLayoutConstraint.swift
//  iOS Practice
//
//  Created by KL on 7/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    public static func activateHighPriority(_ constraints: [NSLayoutConstraint]) {
        for constraint in constraints {
            constraint.priority = .defaultHigh
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    public static func activateLowPriority(_ constraints: [NSLayoutConstraint]) {
        for constraint in constraints {
            constraint.priority = .defaultLow
        }
        NSLayoutConstraint.activate(constraints)
    }
}
