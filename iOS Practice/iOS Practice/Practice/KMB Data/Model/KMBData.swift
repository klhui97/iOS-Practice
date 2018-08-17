//
//  KMBData.swift
//  iOS Practice
//
//  Created by KL on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

struct KMBData: Codable {
    var route: String
    var services: [Service]
    
    enum CodingKeys: String, CodingKey {
        case route = "Route"
        case services = "Services"
    }
    
    struct Service: Codable {
        var serviceType: String
        var bound: String
        var route: String
        var basicInfo: BasicInfo
        var routeStops: [RouteStop]
        
        enum CodingKeys: String, CodingKey {
            case serviceType = "SERVICE_TYPE"
            case bound = "BOUND"
            case route = "ROUTE"
            case basicInfo = "BASIC_INFO"
            case routeStops = "ROUTE_STOPS"
        }
    }
    
    struct BasicInfo: Codable {
        var originName: String
        var destinationName: String
        
        enum CodingKeys: String, CodingKey {
            case originName = "OriCName"
            case destinationName = "DestCName"
        }
    }
    
    struct RouteStop: Codable {
        var cName: String
        var serviceType: String
        var bound: String
        var route: String
        var bsiCode: String
        var stopSeq: String
        
        enum CodingKeys: String, CodingKey {
            case cName = "CName"
            case serviceType = "ServiceType"
            case bound = "Bound"
            case route = "Route"
            case stopSeq = "Seq"
            case bsiCode = "BSICode"
        }
    }
}
