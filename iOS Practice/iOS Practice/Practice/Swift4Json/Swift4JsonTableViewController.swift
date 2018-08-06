//
//  Swift4JsonTableViewController.swift
//  iOS Practice
//
//  Created by KL on 7/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class Swift4JsonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .yellow
        return cell
    }

}
