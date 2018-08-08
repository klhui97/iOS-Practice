//
//  RightBubbleTableViewCell.swift
//  iOS Practice
//
//  Created by david.hui on 8/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class RightBubbleTableViewCell: BaseBubbleTableViewCell {
    
    let profileImageView: CircleImageView = {
        let imageView = CircleImageView()
        imageView.backgroundColor = .purple
        imageView.layer.cornerRadius = 18
        return imageView
    }()
    
    let bubbleContentView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.image = #imageLiteral(resourceName: "left_chat_background").resizableImage(withCapInsets: UIEdgeInsetsMake(15, 15, 15, 15))
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textView.textColor = .darkGray
        
        contentView.add(profileImageView, bubbleContentView)
        bubbleContentView.isUserInteractionEnabled = true
        
        let views = ["profileImageView": profileImageView,
                     "bubbleContentView": bubbleContentView]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-[profileImageView(36)]-7-[bubbleContentView]", options: [], metrics: nil, views: views))
        bubbleContentView.trailingAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor).isActive = true
        
        profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        NSLayoutConstraint.activateHighPriority(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[bubbleContentView]-16-|", options: [], metrics: nil, views: views))
        profileImageView.al_topToView(bubbleContentView)
        
        addTextViewOnBubbleView(bubbleView: bubbleContentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
