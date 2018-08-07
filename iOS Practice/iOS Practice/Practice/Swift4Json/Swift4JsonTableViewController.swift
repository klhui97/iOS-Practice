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
        var page: Int
        var total: Int
        var page_size: Int
        var pages: Int
    }
    
    struct Loan: Decodable {
        var id: Int
        var name: String
    }
    
    struct APIResponse: Decodable {
        var paging: Page
        var loans: [Loan]
    }
}

class Swift4JsonTableViewController: UITableViewController {

    var loans: [Loan] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(Swift4JsonTableViewCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 96
        getLatestLoans()
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
        cell.backgroundColor = .yellow
        cell.contentView.backgroundColor = .blue
        return cell
    }

    // MARK: - API
    func getLatestLoans() {
        guard let loanUrl = URL(string: "https://api.kivaws.org/v1/loans/newest.json") else {
            return
        }
        
        let request = URLRequest(url: loanUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let data = data {
                    let response = try decoder.decode(APIResponse.self, from: data)
                    self.loans = response.loans
                    OperationQueue.main.addOperation({
                        self.tableView.reloadData()
                    })
                }
            } catch {
                print(error)
            }
        })
        
        task.resume()
    }
}
