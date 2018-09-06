//
//  KMBSearchViewController.swift
//  iOS Practice
//
//  Created by david.hui on 14/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class KMBSearchViewController: KLTableViewController, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    var targetRouteData: KMBData? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "KMB Data"
        
        // Load the shared data first
        print(KMBDataManager.shared.getKmbData)
        
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true) {
            self.targetRouteData = KMBDataManager.shared.getKmbData(route: searchBar.text ?? "")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let targetRouteData = targetRouteData {
            return targetRouteData.services.count
        }else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return targetRouteData?.route ?? "Please enter a correct route number."
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.accessoryType = .disclosureIndicator
        
        if let service = targetRouteData?.services[indexPath.row] {
            if service.serviceType == "1" {
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = """
                路線\(service.bound):  由 \(service.basicInfo.originName) 出發至 \(service.basicInfo.destinationName)
                """
            }else {
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = """
                ＊特別線:  由 \(service.basicInfo.originName) 出發至 \(service.basicInfo.destinationName)
                """
            }
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let service = targetRouteData?.services[indexPath.row] {
            navigationController?.pushViewController(KMBStopsInformationTableViewController(service: service), animated: true)
        }
    }
}
