//
//  Swift4JsonTableViewController.swift
//  iOS Practice
//
//  Created by KL on 7/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

extension Swift4JsonTableViewController {
    
    // MARK: - JSON Structure
    struct Page: Decodable {
        var page: Int?
        var total: Int?
        var page_size: Int?
        var pages: Int?
    }
    
    struct Loan: Decodable {
        var id: Int?
        var name: String?
        var posted_date: String?
        var loan_amount: Double?
    }
    
    struct APIResponse: Decodable {
        var paging: Page
        var loans: [Loan]
    }
}

class Swift4JsonTableViewController: UITableViewController, HasLoadingOverlay {
    
    var loadingOverlay: LoadingOverlay?
    
    var loans: [Loan] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Loan List"
        
        tableView.register(Swift4JsonTableViewCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.layoutMargins = UIEdgeInsetsMake(0, 24, 0, 24)
        tableView.allowsSelection = false
        
        let tableViewRefreshControl = UIRefreshControl()
        tableViewRefreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
        tableViewRefreshControl.tintColor = .purple
        tableView.refreshControl = tableViewRefreshControl
        
        showLoadingOverlayInNavigationController()
        getLatestLoans { (err, loans) in
            OperationQueue.main.addOperation {
                self.loadingOverlay?.removeFromSuperview()
                if let loans = loans {
                    self.loans = loans
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Method
    @objc func handleRefresh() {
        getLatestLoans { (err, loans) in
            OperationQueue.main.addOperation {
                if let loans = loans {
                    self.loans = loans
                    self.tableView.reloadData()
                    self.tableView.refreshControl?.endRefreshing()
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
        cell.loanLabel.text = "$ " + String(loans[indexPath.row].loan_amount ?? 0)
        cell.dateLabel.text = loans[indexPath.row].posted_date
        
        return cell
    }

    // MARK: - API
    func getLatestLoans(callback: @escaping (_ error: Error?, _ result: [Loan]?) -> Void) {
        guard let loanUrl = URL(string: "https://api.kivaws.org/v1/loans/newest.json") else {
            return
        }
        
        let request = URLRequest(url: loanUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                callback(error, nil)
                return
            }
        
            let decoder = JSONDecoder()
            do {
                if let data = data {
                    let response = try decoder.decode(APIResponse.self, from: data)
                    callback(error, response.loans)
                }
            } catch {
                callback(error, nil)
            }
        })
        
        task.resume()
    }
}
