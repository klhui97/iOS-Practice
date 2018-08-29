//
//  MagicalGridViewController.swift
//  iOS Practice
//
//  Created by david.hui on 29/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class MagicalGridViewController: KLViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupGrid()
    }
    
    private func setupGrid() {
        let numberOfRow = 30
        let numberOfCol = 15
        let width = safeAreaContentView.frame.width / CGFloat(numberOfCol)
        let height = safeAreaContentView.frame.height / CGFloat(numberOfRow)
        
        // i = col, j = row
        for j in 0..<numberOfRow {
            for i in 0..<numberOfCol {
                let squareView = UIView(frame: CGRect(x: CGFloat(i) * width, y: CGFloat(j) * height, width: width, height: height))
                squareView.backgroundColor = .randomColor
                squareView.layer.borderColor = UIColor.black.cgColor
                squareView.layer.borderWidth = 0.5
                safeAreaContentView.addSubview(squareView)
            }
        }
        
        safeAreaContentView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: safeAreaContentView)
        print(location)
    }
}
