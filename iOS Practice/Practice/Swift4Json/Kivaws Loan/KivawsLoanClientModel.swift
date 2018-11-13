//
//  KivawsLoanModel.swift
//  iOS Practice
//
//  Created by KL on 17/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

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
    
    struct KivawsLoanResponse: Decodable {
        var paging: Page
        var loans: [Loan]
    }
}
