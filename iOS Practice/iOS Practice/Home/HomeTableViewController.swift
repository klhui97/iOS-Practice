//
//  HomeTableViewController.swift
//  iOS Practice
//
//  Created by KL on 6/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

private extension HomeTableViewController {
    
    func getController(_ rowType: Row) -> UIViewController {
        
        switch rowType {
        case .Swift4Json:
            return Swift4JsonTableViewController()
        }
    }
}

class HomeTableViewController: UITableViewController {
    
    // MARK: - Practice data
    enum Row: String {
        case Swift4Json = "Swift 4 JSON"
    }
    
    var rows: [Row] = [.Swift4Json]
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigation()
        tableView.tableFooterView = nil
    }
    
    // MARK: - Init
    
    fileprivate func initNavigation() {
        title = "iOS Practice Menu"
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = rows[indexPath.row].rawValue
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(getController(rows[indexPath.row]), animated: true)
        
    }
}
