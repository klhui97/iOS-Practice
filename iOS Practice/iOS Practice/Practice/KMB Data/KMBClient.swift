//
//  KMBClient.swift
//  iOS Practice
//
//  Created by david.hui on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

class KMBClient: NSObject {
    
    static let shared = KMBClient()
    
    func fetchKmbData(action: Action, route: String, bound: String, callback: @escaping (_ error: Error?, _ result: Result?) -> Void) {
        
        // test url: http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=getstops&route=31M&bound=1
        guard let url = URL(string: "http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=\(action.rawValue)&route=\(route)&bound=\(bound)") else {
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
                    let response = try decoder.decode(APIResponse.self, from: data)
                    callback(error, response.data)
                }
            } catch {
                callback(error, nil)
            }
        })
        
        task.resume()
    }
}

// MARK: - Enum

extension KMBClient {
    
    enum Action: String {
        case getStop = "getstops"
    }
}

// MARK: - Struct

extension KMBClient {
    
    struct APIResponse: Decodable {
        var data: Result?
        var result: Bool?
    }
    
    struct Result: Decodable {
        var basicInfo: BasicInfo?
        var routeStops: [RouteStop]?
        
        struct BasicInfo: Decodable {
            var OriCName: String?
            var DestCName: String?
        }
        
        struct RouteStop: Decodable {
            var CName: String?
            var BSICode: String?
            var Bound: String?
            var Seq: String?
            
            private var AirFare: String?
            
            var fare: Double {
                if let AirFare = AirFare, let fare = Double(AirFare) {
                    return round(10 * fare) / 10
                }else {
                    return 0
                }
            }
        }
    }
}


