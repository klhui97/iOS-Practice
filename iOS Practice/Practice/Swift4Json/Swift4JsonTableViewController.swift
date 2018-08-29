//
//  Swift4JsonTableViewController.swift
//  iOS Practice
//
//  Created by KL on 7/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class Swift4JsonTableViewController: KLTableViewController {
    
    var loans: [KivawsLoanClient.Loan] = [] {
        didSet {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Loan List"
        
        tableView.register(Swift4JsonTableViewCell.self)
        tableView.layoutMargins = UIEdgeInsetsMake(0, 24, 0, 24)
        tableView.allowsSelection = false
        
        let tableViewRefreshControl = UIRefreshControl()
        tableViewRefreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
        tableViewRefreshControl.tintColor = .purple
        tableView.refreshControl = tableViewRefreshControl
        
        showLoadingOverlayInNavigationController()
        KivawsLoanClient.getLatestLoans { (err, repsonse) in
            OperationQueue.main.addOperation {
                self.loadingOverlay?.removeFromSuperview()
                if let repsonse = repsonse {
                    self.loans = repsonse.loans
                }
            }
        }
    }
    
    // MARK: - Method
    @objc func handleRefresh() {
        KivawsLoanClient.getLatestLoans { (err, repsonse) in
            OperationQueue.main.addOperation {
                if let repsonse = repsonse {
                    self.loans = repsonse.loans
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loans.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Swift4JsonTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.nameLabel.text = loans[indexPath.row].name
        cell.loanLabel.text = "$ " + String(loans[indexPath.row].loanAmount ?? 0)
        cell.dateLabel.text = loans[indexPath.row].postedDate
        
        return cell
    }
}
