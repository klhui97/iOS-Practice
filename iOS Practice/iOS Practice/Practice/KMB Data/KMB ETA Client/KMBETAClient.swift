//
//  KMBETAClient.swift
//  iOS Practice
//
//  Created by KL on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

class KMBETAClient {
    
    static func getEtaInfo(routeStop :KMBData.RouteStop, callback: @escaping (_ result: [EtaData]?) -> Void) {
        
        // test url: http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=getstops&route=31M&bound=1
        let query: [String: String] = [
            "action": "geteta",
            "lang": "tc",
            "route": routeStop.route,
            "bound": routeStop.bound,
            "stop": routeStop.bsiCode.replacingOccurrences(of: "-", with: ""),
            "stop_seq": routeStop.stopSeq,
            "servicetype": routeStop.serviceType
        ]
        
        NetworkManager.decodableGet(url: "http://etav3.kmb.hk", query: query) { (error, result: EtaResponse?) in
            if let result = result {
                callback(result.response)
            }
        }
    }
}
