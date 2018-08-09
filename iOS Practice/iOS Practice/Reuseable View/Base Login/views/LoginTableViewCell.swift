//
//  LoginTableViewCell.swift
//  iOS Practice
//
//  Created by david.hui on 9/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class LoginTableViewCell: UITableViewCell {
    
    let fieldNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        return textField
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.add(fieldNameLabel, inputTextField)
        let views = ["fieldNameLabel": fieldNameLabel,
                     "inputTextField": inputTextField]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[fieldNameLabel(100)]-8-[inputTextField]-16-|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views))
        NSLayoutConstraint.activateHighPriority(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[fieldNameLabel(40)]-8-|", options: [], metrics: nil, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
