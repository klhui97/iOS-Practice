//
//  MagicalGridViewController.swift
//  iOS Practice
//
//  Created by KL on 29/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class MagicalGridViewController: KLViewController {
    
    let numberOfRow = 30
    let numberOfCol = 15
    
    var selectedCell: UIView?
    var cellViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Magical Grid"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupGrid()
    }
    
    private func setupGrid() {
        let width = getGridItemWidth()
        let height = getGridItemHeight()
        
        // i = col, j = row
        for j in 0..<numberOfRow {
            for i in 0..<numberOfCol {
                let cellView = UIView(frame: CGRect(x: CGFloat(i) * width, y: CGFloat(j) * height, width: width, height: height))
                cellView.backgroundColor = .randomColor
                cellView.layer.borderColor = UIColor.black.cgColor
                cellView.layer.borderWidth = 0.5
                cellViews.append(cellView)
                safeAreaContentView.addSubview(cellView)
            }
        }
        
        safeAreaContentView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: safeAreaContentView)
        
        
        let i = Int(location.x / getGridItemWidth())
        let j = Int(location.y / getGridItemHeight())

        if selectedCell != nil {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }

        if i < numberOfCol, j < numberOfRow, j * numberOfCol + i < cellViews.count {
            let target = cellViews[j * numberOfCol + i]
            selectedCell = target
            
            if gesture.state == .ended {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    target.layer.transform = CATransform3DIdentity
                }, completion: nil)
            }else {
                safeAreaContentView.bringSubview(toFront: target)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    target.layer.transform = CATransform3DMakeScale(3, 3, 3)
                }, completion: nil)
            }
        }else {
            selectedCell = nil
        }
    }
    
    private func getGridItemWidth() -> CGFloat {
        return safeAreaContentView.frame.width / CGFloat(numberOfCol)
    }
    
    private func getGridItemHeight() -> CGFloat {
        return safeAreaContentView.frame.height / CGFloat(numberOfRow)
    }
}
