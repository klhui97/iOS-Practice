//
//  KLAlertViewManager.swift
//  iOS Practice
//
//  Created by KL on 6/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

public class KLAlertViewManager {
    
    public let showDuration: TimeInterval = 3
    public let slideDuration: TimeInterval = 0.3
    public let backgroundColor = UIColor.orange
    public let textColor = UIColor.white
    
    /// The view that is displaying the alert
    public var animatedView: UIView?
    
    init() {
        
    }
    
    public func showBottomAlert(target targetView: UIView, size: CGSize = CGSize(width: ScreenSizeHelper.screenWidth, height: 54), text: String, icon: UIImage? = nil, completion:(() -> Void)? = nil){
        
        let bottomInset = ScreenSizeHelper.safeAreaBottomInset
        let initFrame = CGRect(x: 0, y: ScreenSizeHelper.screenHeight, width: size.width, height: size.height + bottomInset)
        let finalFrame = CGRect(x: 0, y: targetView.frame.height - initFrame.size.height, width: ScreenSizeHelper.screenWidth, height: initFrame.size.height)
        
        
        let smartAlertButton = UIButton(type: .custom)
        smartAlertButton.setTitle(text, for: UIControlState())
        smartAlertButton.frame = initFrame
        if (icon != nil) {
            smartAlertButton.setImage(icon, for: UIControlState())
            smartAlertButton.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 6)
        }
        smartAlertButton.backgroundColor = backgroundColor
        smartAlertButton.setTitleColor(textColor, for: UIControlState())
        smartAlertButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20)
        smartAlertButton.titleEdgeInsets.bottom = bottomInset
        smartAlertButton.alpha = 0
        smartAlertButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        smartAlertButton.titleLabel?.numberOfLines = 2
        smartAlertButton.titleLabel?.textAlignment = .center
        smartAlertButton.titleLabel?.minimumScaleFactor = 12
        smartAlertButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        animatedView?.removeFromSuperview()
        animatedView = smartAlertButton
        targetView.addSubview(smartAlertButton)
        
        UIView.animate(withDuration: slideDuration, delay: 0, options: UIViewAnimationOptions(), animations: {
            [weak smartAlertButton] in
            smartAlertButton?.alpha = 1
            smartAlertButton?.frame = finalFrame
        }) { [weak smartAlertButton] (completed) in
            if completed == true {
                UIView.animate(withDuration: self.slideDuration, delay: self.showDuration, options: UIViewAnimationOptions(), animations: {
                    [weak smartAlertButton] in
                    smartAlertButton?.alpha = 0
                    smartAlertButton?.frame = initFrame
                }) { [weak smartAlertButton] (completed) in
                    smartAlertButton?.removeFromSuperview()
                }
            }
        }
    }
}
