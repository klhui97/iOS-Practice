//
//  ScreenSizeManager.swift
//  iOS Practice
//
//  Created by KL on 6/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

public class ScreenSizeHelper {
    
    public static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public static var windowWidth: CGFloat {
        if let window = UIApplication.shared.keyWindow {
            return window.frame.size.width
        }else {
            return 0
        }
    }
    
    public static var windowHeight: CGFloat {
        if let window = UIApplication.shared.keyWindow {
            return window.frame.size.height
        }else {
            return 0
        }
    }
    
    public static var safeAreaBottomInset: CGFloat {
        if let window = UIApplication.shared.keyWindow {
            if #available(iOS 11.0, *) {
                return window.safeAreaInsets.bottom
            } else {
                return 0
            }
        }else {
            return 0
        }
    }
}
