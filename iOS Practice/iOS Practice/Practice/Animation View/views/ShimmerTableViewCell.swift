//
//  ShimmerTableViewCell.swift
//  iOS Practice
//
//  Created by david.hui on 29/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class ShimmerTableViewCell: NoneSelectionStyleTableViewCell {
    
    let gradientLayer = CAGradientLayer()
    let animation = CABasicAnimation(keyPath: "transform.translation.x")
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        
        let darkTextLabel = UILabel()
        darkTextLabel.text = "Shimmer"
        darkTextLabel.textColor = UIColor(white: 1, alpha: 0.2)
        darkTextLabel.font = UIFont.systemFont(ofSize: 80)
        darkTextLabel.textAlignment = .center
        
        let shinyTextLabel = UILabel()
        shinyTextLabel.text = "Shimmer"
        shinyTextLabel.textColor = .white
        shinyTextLabel.font = UIFont.systemFont(ofSize: 80)
        shinyTextLabel.textAlignment = .center
        
        contentView.add(shinyTextLabel)
        shinyTextLabel.al_fillSuperview()
        NSLayoutConstraint.activateHighPriority([contentView.heightAnchor.constraint(equalToConstant: 70)])
        
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        
        let angle = 30 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)

//        contentView.layer.addSublayer(gradientLayer)
//        contentView.layer.masksToBounds = true
        shinyTextLabel.layer.mask = gradientLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = contentView.frame
        
        gradientLayer.removeAllAnimations()
        animation.fromValue = -contentView.frame.width
        animation.toValue = contentView.frame.width
        animation.duration = 1
        animation.repeatCount = Float.infinity
        gradientLayer.add(animation, forKey: nil)
    }
}
