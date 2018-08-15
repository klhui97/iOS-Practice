//
//  FreeAppCell.swift
//  iOS Practice
//
//  Created by david.hui on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class FreeAppCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let pubDateLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.add(titleLabel, pubDateLabel)
        let views = ["titleLabel": titleLabel,
                     "pubDateLabel": pubDateLabel]
        NSLayoutConstraint.activateHighPriority(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[titleLabel]-16-[pubDateLabel]-16-|", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views)
        )
        titleLabel.al_leftToMargin()
        titleLabel.al_rightToMargin()
        
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func confige(model: FreeAppParser.Item) {
        titleLabel.text = model.title
        pubDateLabel.text = model.pubDate
    }
}
