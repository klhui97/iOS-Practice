//
//  BaseBubbleTableViewCell.swift
//  iOS Practice
//
//  Created by david.hui on 8/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class BaseBubbleTableViewCell: UITableViewCell {
    
    var bubbleView: UIImageView? { get { return nil } }
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.clipsToBounds = false
        textView.isScrollEnabled = false
        textView.backgroundColor = nil
        textView.isEditable = false
        textView.isSelectable = true
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.dataDetectorTypes = .all
        textView.textContainerInset = .zero
        textView.contentInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        if let bubbleView = bubbleView {
            configureBubbleViewAutoLayout(bubbleView: bubbleView)
            addTextViewOnBubbleView(bubbleView: bubbleView)
        }else {
            fatalError("bubbleView has not been assigned")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBubbleViewAutoLayout(bubbleView: UIView) {
        fatalError("func configureBubbleViewAutoLayout(bubbleView: UIView) has not been implemented")
    }
    
    private func addTextViewOnBubbleView(bubbleView: UIView) {
        bubbleView.add(textView)
        
        let views = ["textView": textView]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[textView]-16-|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[textView]-8-|", options: [], metrics: nil, views: views))
    }
}
