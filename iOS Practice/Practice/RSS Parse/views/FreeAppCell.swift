//
//  FreeAppCell.swift
//  iOS Practice
//
//  Created by KL on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class FreeAppCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    let pubDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.add(titleLabel, pubDateLabel)
        let views = ["titleLabel": titleLabel,
                     "pubDateLabel": pubDateLabel]
        NSLayoutConstraint.activateHighPriority(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[titleLabel(<=500)]-8-[pubDateLabel]-8-|", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views)
        )
        titleLabel.al_leftToMargin()
        titleLabel.al_rightToMargin()
        
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func confige(model: FreeAppParser.Item) {
        titleLabel.text = model.attributedString
        pubDateLabel.text = model.pubDate
    }
}
