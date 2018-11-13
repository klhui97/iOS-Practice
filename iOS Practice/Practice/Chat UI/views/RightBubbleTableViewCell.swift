//
//  RightBubbleTableViewCell.swift
//  iOS Practice
//
//  Created by KL on 8/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class RightBubbleTableViewCell: BaseBubbleTableViewCell {
    
    override var bubbleView: UIImageView? { get { return bubbleContentView}}
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureBubbleViewAutoLayout(bubbleView: UIView) {
        contentView.add(profileImageView, bubbleView)
        bubbleView.isUserInteractionEnabled = true
        
        let views = ["profileImageView": profileImageView,
                     "bubbleView": bubbleView]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-[profileImageView(36)]-7-[bubbleView]", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate([bubbleView.trailingAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor)])
        
        profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        NSLayoutConstraint.activateHighPriority(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[bubbleView]-16-|", options: [], metrics: nil, views: views))
        profileImageView.al_topToView(bubbleView)
    }
}
