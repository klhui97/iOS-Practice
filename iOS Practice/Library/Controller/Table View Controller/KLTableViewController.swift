//
//  KLTableViewController.swift
//  iOS Practice
//
//  Created by KL on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

open class KLTableViewController: UITableViewController, HasLoadingOverlay {
    
    public var loadingOverlay: LoadingOverlay?
    
    override init(style: UITableViewStyle = .plain) {
        super.init(style: style)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
    }
}
