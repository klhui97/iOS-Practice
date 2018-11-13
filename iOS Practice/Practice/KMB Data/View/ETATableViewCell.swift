//
//  ETATableViewCell.swift
//  iOS Practice
//
//  Created by KL on 17/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class ETATableViewCell: UITableViewCell {
    
    let stopNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    let etaLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.add(stopNameLabel, etaLabel)
        let views = ["stopNameLabel": stopNameLabel,
                     "etaLabel": etaLabel]
        NSLayoutConstraint.activateHighPriority(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[stopNameLabel]-8-[etaLabel]-16-|", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views)
        )
        
        stopNameLabel.al_leftToMargin()
        stopNameLabel.al_rightToMargin()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
