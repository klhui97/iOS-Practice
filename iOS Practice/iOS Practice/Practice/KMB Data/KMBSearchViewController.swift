//
//  KMBSearchViewController.swift
//  iOS Practice
//
//  Created by david.hui on 14/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class KMBSearchViewController: KLTableViewController {
    
    var data: KMBClient.GetStopsInBoundResponse.StopsInfo? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "KMB Data"
        
        print(KMBDataHelper.shared.kmbData.count)
        if let services = KMBDataHelper.shared.getService(route: "2F") {
            print(services.count)
            KMBEtaClient.shared.getEtaInfo(routeStop: services[0].routeStops[2]) { (error, etaData) in
                if let etaData = etaData {
                    print(etaData)
                }
            }
        }
//        fetchKmbData()
    }
    
    func fetchKmbData() {
        showLoadingOverlayInNavigationController()
        KMBClient.shared.getStopsOfBound(route: "2F", bound: "1", ServiceType: "1") { (error, result) in
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
