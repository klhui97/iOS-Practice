//
//  AnimatedButtonCell.swift
//  iOS Practice
//
//  Created by david.hui on 31/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class AnimatedButton: UIButton, KLAnimatableProtocol {
}

class AnimatedButtonCell: UICollectionViewCell {
    
    enum AnimationType: String {
        case shake = "shake"
        case pulsate = "pulsate"
        case deepPress = "deepPress"
        case test = "test"
    }
    
    var type: AnimationType? {
        didSet {
            button.setTitle(type?.rawValue, for: UIControlState())
        }
    }
    
    let button = AnimatedButton()
    var autoPressEffectTimer = Timer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.add(button)
        button.al_fillSuperview()
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonOnClicked), for: .touchUpInside)
        
        autoPressEffectTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: (#selector(timerPress)), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func timerPress() {
        buttonOnClicked()
    }
    
    @objc func buttonOnClicked() {
        guard let type = type else { return }
        switch type {
        case .test:
            button.test()
        case .shake:
            button.shake()
        case .pulsate:
            button.pulsate()
        case .deepPress:
            button.deepPress()
        }
    }
}


