//
//  UIColor.swift
//  iOS Practice
//
//  Created by david.hui on 29/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

extension UIColor {
    
    public static var randomColor: UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }
    
    public static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
}
