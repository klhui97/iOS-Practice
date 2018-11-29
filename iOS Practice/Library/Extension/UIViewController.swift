//
//  UIViewController.swift
//  iOS Practice
//
//  Created by KL on 29/11/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func navigationControllerPerferLargeTitle() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .always
        }
    }
}
