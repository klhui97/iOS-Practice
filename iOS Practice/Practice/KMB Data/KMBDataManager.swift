//
//  KMBDataManager
//  iOS Practice
//
//  Created by KL on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

/// a helper that loads all data from kmbData.json
class KMBDataManager {
    
    struct JsonFileStrut: Codable {
        var result: [KMBData]
    }
    
    static let shared = KMBDataManager()
    var kmbData: [KMBData] = []
    
    private init() {
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
    
    func getKmbData(route: String) -> KMBData? {
        if let target = kmbData.first(where: { $0.route == route.uppercased() }) {
            return target
        }else {
            return nil
        }
    }
}
