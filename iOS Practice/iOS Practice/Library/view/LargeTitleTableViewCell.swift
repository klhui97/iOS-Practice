//
//  LargeTitleTableViewCell.swift
//  iOS Practice
//
//  Created by david.hui on 8/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

open class LargeTitleTableViewCell: UITableViewCell {
    
    open let largeTitleLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupAutoLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension LargeTitleTableViewCell {
    func setupAutoLayout() {
        let heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 52)
        heightConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([heightConstraint])
        contentView.add(largeTitleLabel)
        largeTitleLabel.al_leftToMargin()
        largeTitleLabel.al_bottomToView(contentView, distance: -7)
    }
}
