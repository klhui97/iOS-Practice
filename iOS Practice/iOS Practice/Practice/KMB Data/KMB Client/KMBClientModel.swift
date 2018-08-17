//
//  KMBClientModel.swift
//  iOS Practice
//
//  Created by david.hui on 17/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

// MARK: - Enum

extension KMBClient {
    
    enum Action: String {
        case getStopsInBound = "getstops"
        case getRoutesInStop = "getRoutesInStop"
        case getRouteBound = "getroutebound"
    }
}

// MARK: - Struct

extension KMBClient {
    
    struct GetRouteBoundResponse: Decodable {
        var data: [Info]?
        var result: Bool?
        
        struct Info: Decodable, Hashable {
            var hashValue: Int {
                if let route = route, let bound = bound, let serviceType = serviceType {
                    return route.hashValue + bound + serviceType
                }else {
                    return 0
                }
            }
            
            var bound: Int?
            var route: String?
            var serviceType: Int?
            
            var boundString: String {
                if let bound = bound {
                    return String(bound)
                }else {
                    return ""
                }
            }
            
            var serviceTypeString: String {
                if let serviceType = serviceType {
                    return String(serviceType)
                }else {
                    return ""
                }
            }
            
            enum CodingKeys: String, CodingKey {
                case bound = "BOUND"
                case route = "ROUTE"
                case serviceType = "SERVICE_TYPE"
            }
        }
    }
    
    struct GetRoutesInStopsResponse: Decodable {
        var data: [String]?
        var result: Bool?
    }
    
    struct GetStopsInBoundResponse: Decodable {
        var data: StopsInfo?
        var result: Bool?
        
        struct StopsInfo: Decodable {
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
                var ServiceType: String?
                
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
}
