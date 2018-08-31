//
//  AnimatedButtonCell.swift
//  iOS Practice
//
//  Created by david.hui on 31/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class AnimatedButtonCell: UICollectionViewCell {
    
    enum AnimationType: String {
        case shake = "shake"
        case pulsate = "pulsate"
    }
    
    var type: AnimationType? {
        didSet {
            button.setTitle(type?.rawValue, for: UIControlState())
        }
    }
    
    let button = AnimatedButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.add(button)
        button.al_fillSuperview()
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonOnClicked), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonOnClicked() {
        guard let type = type else { return }
        switch type {
        case .shake:
            button.shake()
        case .pulsate:
            button.pulsate()
        }
    }
}
