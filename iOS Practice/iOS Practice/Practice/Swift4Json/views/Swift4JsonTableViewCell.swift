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
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.add(avatorImageView)
        let views = ["avatorImageView": avatorImageView]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-24-[avatorImageView]", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-24-[avatorImageView(48)]-24-|", options: [], metrics: nil, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
