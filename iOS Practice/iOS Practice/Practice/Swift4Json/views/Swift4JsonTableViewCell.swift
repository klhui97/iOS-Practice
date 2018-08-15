//
//  Swift4JsonTableViewCell.swift
//  iOS Practice
//
//  Created by david.hui on 7/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class Swift4JsonTableViewCell: UITableViewCell {

    let avatorImageView: CircleImageView = {
        let imageView = CircleImageView()
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    let nameLabel = UILabel()
    
    let loanLabel = UILabel()
    
    let dateLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.autoresizesSubviews = false
        contentView.add(avatorImageView, nameLabel, loanLabel, dateLabel)
        
        let views = ["avatorImageView": avatorImageView,
                     "nameLabel": nameLabel,
                     "loanLabel": loanLabel,
                     "dateLabel": dateLabel]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "[avatorImageView]-24-[nameLabel]-(>=8)-[loanLabel]", options: [.alignAllTop], metrics: nil, views: views))
        NSLayoutConstraint.activateHighPriority(NSLayoutConstraint.constraints(withVisualFormat: "V:|-24-[avatorImageView(48)]-(>=24)-|", options: [], metrics: nil, views: views))
        
        dateLabel.al_rightToMargin()
        dateLabel.al_leftToView(nameLabel)
        dateLabel.al_bottomToView(avatorImageView)
        
        avatorImageView.al_leftToMargin()
        loanLabel.al_rightToMargin()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
