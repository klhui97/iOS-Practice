//
//  UINavigationItem.swift
//  EasyBus
//
//  Created by KL on 6/11/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

public extension UINavigationItem {
    
    public func removeBackButtonText() {
        self.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
