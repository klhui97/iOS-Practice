//
//  KLViewController.swift
//  iOS Practice
//
//  Created by KL on 14/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class KLViewController: UIViewController {
    
    let safeAreaContentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.add(safeAreaContentView)
        safeAreaContentView.al_fillSafeAreaView(view)
    }
}
