//
//  KLAlertViewManager.swift
//  iOS Practice
//
//  Created by david.hui on 6/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class KLAlertViewManager {
    
    static let shared = KLAlertViewManager()
    let smartTipShowDuration:TimeInterval = 5
    let smartTipSlideDuration:TimeInterval = 0.3
    
    
    /// The view that is displaying the alert
    var animatedView: UIView?
    
    private init() {
        
    }
    
    func showBottomAlert(target targetView: UIView, size: CGSize = CGSize(width: ScreenSizeManager.screenWidth, height: 45), text: String, icon: UIImage? = nil, completion:(() -> Void)? = nil){
        
        let bottomInset = ScreenSizeManager.safeAreaBottomInset
        
        let smartAlertButton = UIButton(type: .custom)
        smartAlertButton.setTitle(text, for: UIControlState())
        smartAlertButton.frame = CGRect(x: 0, y: ScreenSizeManager.screenHeight, width: size.width, height: size.height + bottomInset)
        if (icon != nil) {
            smartAlertButton.setImage(icon, for: UIControlState())
            smartAlertButton.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 6)
        }
        smartAlertButton.backgroundColor = UIColor.orange
        smartAlertButton.setTitleColor(UIColor.white, for: UIControlState())
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
        
        UIView.animate(withDuration: smartTipSlideDuration, delay: 0, options: UIViewAnimationOptions(), animations: {
            [weak smartAlertButton] in
            guard let strongSmartAlertButton = smartAlertButton else { return }
            
            smartAlertButton?.alpha = 1
            smartAlertButton?.frame = CGRect(x: 0, y: strongSmartAlertButton.frame.origin.y - strongSmartAlertButton.frame.size.height, width: ScreenSizeManager.screenWidth, height: strongSmartAlertButton.frame.size.height)
        }) { [weak smartAlertButton] (completed) in
            if completed == true {
                UIView.animate(withDuration: self.smartTipSlideDuration, delay: self.smartTipShowDuration, options: UIViewAnimationOptions(), animations: {
                    [weak smartAlertButton] in
                    smartAlertButton?.alpha = 0
                }) { [weak smartAlertButton] (completed) in
                    smartAlertButton?.removeFromSuperview()
                }
            }
        }
    }
}
