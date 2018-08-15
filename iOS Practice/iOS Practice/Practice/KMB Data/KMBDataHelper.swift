//
//  KMBDataHelper.swift
//  iOS Practice
//
//  Created by david.hui on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

/// a helper to load all data from kmbData.json
class KMBDataHelper: NSObject {
    
    struct JsonFileStrut: Codable {
        var result: [KMBData]
    }
    
    static let shared = KMBDataHelper()
    var kmbData: [KMBData] = []
    
    private override init() {
        if let path = Bundle.main.path(forResource: "kmbData", ofType: "json") {
            
            let decoder = JSONDecoder()
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decodedResult = try decoder.decode(JsonFileStrut.self, from: data)
                kmbData = decodedResult.result

            } catch {
                // handle error
            }
        }
    }
    
    func getService(route: String) -> [KMBData.Service]? {
        if let target = kmbData.first(where: { $0.route == route }) {
            return target.services
        }else {
            return nil
        }
    }
}
