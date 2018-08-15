//
//  RSSParseViewController.swift
//  iOS Practice
//
//  Created by KL on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import SafariServices

class RSSParseViewController: KLTableViewController {
    
    var items: [FreeAppParser.Item] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FreeAppCell.self)
        tableView.layoutMargins = UIEdgeInsetsMake(0, 24, 0, 8)
        
        let parse = FreeAppParser()
        showLoadingOverlayInNavigationController()
        parse.fetchData { (items) in
            OperationQueue.main.addOperation {
                self.loadingOverlay?.removeFromSuperview()
                self.items = items
            }
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FreeAppCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.confige(model: items[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let url = URL(string: items[indexPath.row].link) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            navigationController?.present(vc, animated: true)
        }
    }
}
