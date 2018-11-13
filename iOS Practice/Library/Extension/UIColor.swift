//
//  UIColor.swift
//  iOS Practice
//
//  Created by KL on 29/8/2018.
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
    
    public static func rgb(hex: Int) -> UIColor {
        return UIColor(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat((hex & 0x0000FF)) / 255.0, alpha: CGFloat(1.0))
    }
}
