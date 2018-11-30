//
//  UITableView.swift
//  iOS Practice
//
//  Created by KL on 7/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

public protocol ReusableView {
    static var defaultReuseIdentifier: String { get }
}

public extension ReusableView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {
    
}

public extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
        return cell
    }
}

extension UICollectionViewCell: ReusableView {
    
}

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
        return cell
    }
}
