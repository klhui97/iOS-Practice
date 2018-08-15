//
//  KivawsLoanClient.swift
//  iOS Practice
//
//  Created by david.hui on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

class KivawsLoanClient: NSObject {
    
    static let shared = KivawsLoanClient()
    
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

// MARK: - Struct

extension KivawsLoanClient {
    
    struct Page: Decodable {
        var page: Int?
        var total: Int?
        var pageSize: Int?
        var pages: Int?
        
        enum CodingKeys: String, CodingKey {
            case page
            case total
            case pageSize = "page_size"
            case pages
        }
    }
    
    struct Loan: Decodable {
        var id: Int?
        var name: String?
        var postedDate: String?
        var loanAmount: Double?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case postedDate = "posted_date"
            case loanAmount = "loan_amount"
        }
    }
    
    struct APIResponse: Decodable {
        var paging: Page
        var loans: [Loan]
    }
}
