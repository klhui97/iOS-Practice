//
//  UITableView.swift
//  iOS Practice
//
//  Created by david.hui on 7/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

protocol ReusableView {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {
    
}

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
        return cell
    }
}
