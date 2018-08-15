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
    
    /// Get all stops in a bound of a route
    func getStopsOfBound(route: String, bound: String, ServiceType: String, callback: @escaping (_ error: Error?, _ result: GetStopsInBoundResponse.StopsInfo?) -> Void) {
        
        // test url: http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=getstops&route=31M&bound=1
        guard let url = URL(string: "http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=\(Action.getStopsInBound.rawValue)&route=\(route)&bound=\(bound)&ServiceType=\(ServiceType)") else {
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
                    let response = try decoder.decode(GetStopsInBoundResponse.self, from: data)
                    callback(error, response.data)
                }
            } catch {
                callback(error, nil)
            }
        })
        
        task.resume()
    }
    
    
    /// Get all route in a stop by BSI code
    func getRoutesInStop(bsiCode: String, callback: @escaping (_ error: Error?, _ result: [String]?) -> Void) {
        
        // test url: http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=getRoutesInStop&bsiCode=WO04-N-1050-0
        guard let url = URL(string: "http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=\(Action.getRoutesInStop.rawValue)&bsiCode=\(bsiCode)") else {
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
                    let response = try decoder.decode(GetRoutesInStopsResponse.self, from: data)
                    callback(error, response.data)
                }
            } catch {
                callback(error, nil)
            }
        })
        
        task.resume()
    }
    
    /// Get all bound information of a route
    func getRouteBound(route: String, callback: @escaping (_ error: Error?, _ result: [GetRouteBoundResponse.Info]) -> Void) {
        
        // test url: http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=getroutebound&route=2F
        guard let url = URL(string: "http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=\(Action.getRouteBound.rawValue)&route=\(route)") else {
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                callback(error, [])
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let data = data {
                    let response = try decoder.decode(GetRouteBoundResponse.self, from: data)
                    if let result = response.data {
                        callback(error, result)
                    }else {
                        callback(error, [])
                    }
                }
            } catch {
                callback(error, [])
            }
        })
        
        task.resume()
    }
}

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


