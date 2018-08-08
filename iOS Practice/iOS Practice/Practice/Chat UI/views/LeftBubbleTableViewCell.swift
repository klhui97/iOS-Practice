//
//  LeftBubbleTableViewCell.swift
//  iOS Practice
//
//  Created by david.hui on 8/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class LeftBubbleTableViewCell: BaseBubbleTableViewCell {
    
    let bubbleContentView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.image = #imageLiteral(resourceName: "right_chat_background").resizableImage(withCapInsets: UIEdgeInsetsMake(15, 15, 15, 15))
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.add(bubbleContentView)
        bubbleContentView.isUserInteractionEnabled = true
        
        let views = ["bubbleContentView": bubbleContentView]
        NSLayoutConstraint.activateHighPriority(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[bubbleContentView]-16-|", options: [], metrics: nil, views: views))
        bubbleContentView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        bubbleContentView.al_rightToMargin()
        
        addTextViewOnBubbleView(bubbleView: bubbleContentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
