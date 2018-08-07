//
//  CircleImageView.swift
//  iOS Practice
//
//  Created by david.hui on 7/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class CircleImageView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        contentMode = .scaleAspectFill
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        setContentHuggingPriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
