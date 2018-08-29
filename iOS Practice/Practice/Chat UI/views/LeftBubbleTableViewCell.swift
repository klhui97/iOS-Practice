//
//  LeftBubbleTableViewCell.swift
//  iOS Practice
//
//  Created by david.hui on 8/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class LeftBubbleTableViewCell: BaseBubbleTableViewCell {
    
    override var bubbleView: UIImageView? { get { return bubbleContentView } }
    
    let bubbleContentView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.image = #imageLiteral(resourceName: "right_chat_background").resizableImage(withCapInsets: UIEdgeInsetsMake(15, 15, 15, 15))
        return imageView
    }()
    
    override func configureBubbleViewAutoLayout(bubbleView: UIView) {
        contentView.add(bubbleView)
        bubbleView.isUserInteractionEnabled = true
        
        let views = ["bubbleView": bubbleView]
        NSLayoutConstraint.activateHighPriority(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[bubbleView]-16-|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activateHighPriority(NSLayoutConstraint.constraints(withVisualFormat: "[bubbleView]-16-|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate([bubbleView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.layoutMarginsGuide.leadingAnchor)])
    }
}
