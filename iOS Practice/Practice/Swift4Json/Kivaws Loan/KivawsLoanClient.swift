//
//  KivawsLoanClient.swift
//  iOS Practice
//
//  Created by KL on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

class KivawsLoanClient: NSObject {
    
    static func getLatestLoans(callback: @escaping (_ error: Error?, _ result: KivawsLoanResponse?) -> Void) {
        NetworkManager.decodableGet(url: "https://api.kivaws.org/v1/loans/newest.json", query: nil) { (error, result: KivawsLoanResponse?) in
            callback(error, result)
        }
    }
}
