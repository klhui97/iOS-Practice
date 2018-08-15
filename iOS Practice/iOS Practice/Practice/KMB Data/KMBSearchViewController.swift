//
//  KMBSearchViewController.swift
//  iOS Practice
//
//  Created by david.hui on 14/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class KMBSearchViewController: UITableViewController, HasLoadingOverlay {
    
    var data: KMBClient.Result? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let route = "2F"
    let bound = "1"
    let action = KMBClient.Action.getStop
    
    var loadingOverlay: LoadingOverlay?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "KMB Data"
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchKmbData()
    }
    
    func fetchKmbData() {
        showLoadingOverlayInNavigationController()
        KMBClient.shared.fetchKmbData(action: action, route: route, bound: bound) { (error, result) in
            OperationQueue.main.addOperation {
                self.removeLoadingOverlay()
                
                guard let result = result else {
                    if let error = error {
                        print(error)
                    }
                    return
                }
                
                self.data = result
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = data {
            if section == 0 {
                return 1
            }else {
                return data.routeStops?.count ?? 0
            }
        }else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.section == 0, let baseInfo = data?.basicInfo {
            cell.textLabel?.text = "\(baseInfo.OriCName ?? "")   --->   \(baseInfo.DestCName ?? "")"
        }else if indexPath.section == 1, let stops = data?.routeStops {
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text =
            """
            \(stops[indexPath.row].CName ?? "")
            BSICode: \(stops[indexPath.row].BSICode ?? "")
            $ \(stops[indexPath.row].fare)
            Seq: \(stops[indexPath.row].Seq ?? "")
            Bound: \(stops[indexPath.row].Bound ?? "")
            """
        }
        
        return cell
    }
    
}
