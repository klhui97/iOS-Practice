//
//  AnimationViewTableViewController.swift
//  iOS Practice
//
//  Created by KL on 29/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class AnimationViewTableViewController: KLTableViewController {
    
    enum Animation {
        case shimmer
        
        var cellClass: AnyClass {
            switch self {
            case .shimmer:
                return ShimmerTableViewCell.self
            }
        }
    }
    
    let rows: [Animation] = [.shimmer]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Animation View"
        
        for row in rows {
            tableView.register(row.cellClass, forCellReuseIdentifier: String(describing: row.cellClass))
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: rows[indexPath.row].cellClass), for: indexPath)
        return cell
    }
}
