//
//  NoneSelectionStyleTableViewCell.swift
//  iOS Practice
//
//  Created by KL on 29/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class NoneSelectionStyleTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
