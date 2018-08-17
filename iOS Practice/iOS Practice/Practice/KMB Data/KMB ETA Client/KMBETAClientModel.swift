//
//  KMBETAClientModel.swift
//  iOS Practice
//
//  Created by david.hui on 17/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

// MARK: - Struct

extension KMBETAClient {
    
    struct EtaResponse: Codable {
        var responsecode: Int
        var response: [EtaData]
    }
    
    struct EtaData: Codable {
        var detailArrivalTime: String
        var shortArrivalTime: String
        
        enum CodingKeys: String, CodingKey {
            case detailArrivalTime = "ex"
            case shortArrivalTime = "t"
        }
    }
}
