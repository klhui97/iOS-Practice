//
//  ScreenSizeManager.swift
//  iOS Practice
//
//  Created by KL on 6/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class ScreenSizeHelper {
    
    static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var windowWidth: CGFloat {
        if let window = UIApplication.shared.keyWindow {
            return window.frame.size.width
        }else {
            return 0
        }
    }
    
    static var windowHeight: CGFloat {
        if let window = UIApplication.shared.keyWindow {
            return window.frame.size.height
        }else {
            return 0
        }
    }
    
    static var safeAreaBottomInset: CGFloat {
        if let window = UIApplication.shared.keyWindow {
            return window.safeAreaInsets.bottom
        }else {
            return 0
        }
    }
}
