//
//  GenericTableViewController.swift
//  iOS Practice
//
//  Created by david.hui on 29/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class GenericTableViewCell<T>: UITableViewCell {
    
    var item: T!
}

class GenericTableViewController<T: GenericTableViewCell<U>, U>: UITableViewController {
    
    var items = [U]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: GenericTableViewCell<U> = tableView.dequeueReusableCell(for: indexPath) as! GenericTableViewCell<U>
        cell.item = items[indexPath.row]
        
        return cell
    }
}
