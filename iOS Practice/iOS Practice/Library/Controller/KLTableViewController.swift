//
//  KLTableViewController.swift
//  iOS Practice
//
//  Created by david.hui on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class KLTableViewController: UITableViewController, HasLoadingOverlay {
    
    var loadingOverlay: LoadingOverlay?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
    }
}
