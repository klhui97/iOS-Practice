//
//  KMBServiceInfoTableViewController.swift
//  iOS Practice
//
//  Created by david.hui on 17/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class KMBServiceInfoTableViewController: KLTableViewController {
    
    let service: KMBData.Service
    
    init(service: KMBData.Service) {
        self.service = service
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.routeStops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let stop = service.routeStops[indexPath.row]
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = """
        \(stop.cName)
        """
        
        return cell
    }
}
