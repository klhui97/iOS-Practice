//
//  ActivityIndicatorCollectionViewCell.swift
//  iOS Practice
//
//  Created by KL on 31/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class ActivityIndicatorCollectionViewCell: UICollectionViewCell {
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    var animation: KLActivityIndicatorAnimationDelegate? {
        didSet {
            animation?.setUpAnimation(in: contentView.layer, size: CGSize(width: 50, height: 50), color: .white)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.add(numberLabel)
        numberLabel.al_fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addIndicatorToLayer(layer: CALayer, size: CGFloat) {

    }
}
