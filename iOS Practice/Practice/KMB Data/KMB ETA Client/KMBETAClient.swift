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

// MARK: - Struct

extension KMBETAClient {
    
    struct EtaResponse: Codable {
        var responsecode: Int
        var response: [EtaData]
    }
    
    struct EtaData: Codable {
        var etaDisplayString: String {
            if let remindingArrivalTime = remindingArrivalTime {
                return remindingArrivalTime + "  /  " + detailArrivalTime
            }else {
                return shortArrivalTime + "  /  " + detailArrivalTime
            }
            
        }
        var detailArrivalTime: String
        var shortArrivalTime: String
        
        var remindingArrivalTime: String? {
            if let arrivalDate = DateHelper.stringToDate(dateString: detailArrivalTime) {
                if let remainingTime = DateHelper.timeDifferent(from: DateHelper.now, to: arrivalDate) {
                    var expression: String = "仲有: "
                    if remainingTime.hour != 0 {
                        expression += String(remainingTime.hour) + "小時"
                    }
                    if remainingTime.minute != 0 {
                        expression += String(remainingTime.minute) + "分鐘"
                    }
                    if remainingTime.second != 0 {
                        expression += String(remainingTime.second) + "秒"
                    }
                    expression += "到達"
                    return expression
                }
            }
            return nil
        }
        
        enum CodingKeys: String, CodingKey {
            case detailArrivalTime = "ex"
            case shortArrivalTime = "t"
        }
    }
}
