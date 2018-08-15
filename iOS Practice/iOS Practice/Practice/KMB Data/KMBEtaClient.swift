//
//  KMBEtaClient.swift
//  iOS Practice
//
//  Created by KL on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

class KMBEtaClient {
    
    static let shared = KMBEtaClient()
    
    func getEtaInfo(routeStop :KMBData.Service.RouteStop, callback: @escaping (_ error: Error?, _ result: [EtaData]?) -> Void) {
        
        // test url: http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=getstops&route=31M&bound=1
        guard let url = URL(string: "http://etav3.kmb.hk/?action=geteta&lang=tc&route=\(routeStop.route)&bound=\(routeStop.bound)&stop=\(routeStop.bsiCode.replacingOccurrences(of: "-", with: ""))&stop_seq=\(routeStop.stopSeq)&servicetype=\(routeStop.serviceType)") else {
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                callback(error, nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let data = data {
                    let response = try decoder.decode(etaResponse.self, from: data)
                    callback(error, response.response)
                }
            } catch {
                callback(error, nil)
            }
        })
        
        task.resume()
    }
}

// MARK: - Struct

extension KMBEtaClient {
    
    struct etaResponse: Codable {
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
