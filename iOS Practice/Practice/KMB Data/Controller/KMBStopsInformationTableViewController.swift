//
//  KMBStopsInformationTableViewController.swift
//  iOS Practice
//
//  Created by david.hui on 17/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class KMBStopsInformationTableViewController: KLTableViewController {
    
    var service: KMBData.Service
    
    init(service: KMBData.Service) {
        self.service = service
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ETATableViewCell.self)
        
        for (i, _) in service.routeStops.enumerated() {
            KMBETAClient.getEtaInfo(routeStop: service.routeStops[i]) { (eta) in
                guard eta != nil else { return }
                OperationQueue.main.addOperation {
                    self.service.routeStops[i].eta = eta
                    self.tableView.reloadRows(at: [IndexPath(row: i, section: 0)], with: UITableViewRowAnimation.automatic)
                }
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.routeStops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ETATableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let stop = service.routeStops[indexPath.row]
        
        cell.stopNameLabel.text = stop.cName
        if let etas = service.routeStops[indexPath.row].eta {
            var etaString = ""
            for eta in etas {
                etaString += eta.shortArrivalTime + "\n"
            }
            cell.etaLabel.text = etaString
        }
        
        return cell
    }
}