//
//  NSLayoutConstraint.swift
//  iOS Practice
//
//  Created by david.hui on 7/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    open static func activateHighPriority(_ constraints: [NSLayoutConstraint]) {
        for constraint in constraints {
            constraint.priority = .defaultHigh
        }
        NSLayoutConstraint.activate(constraints)
    }
}
