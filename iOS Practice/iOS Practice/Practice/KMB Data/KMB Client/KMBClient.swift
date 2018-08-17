//
//  KMBClient.swift
//  iOS Practice
//  Created by david.hui on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

class KMBClient: NSObject {
    
    let baseUrl = "http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx"
    static let shared = KMBClient()
    
    /// Get all stops in a bound of a route
    func getStopsOfBound(route: String, bound: String, ServiceType: String, callback: @escaping (_ error: Error?, _ result: GetStopsInBoundResponse?) -> Void) {
        
        // test url: http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=getstops&route=31M&bound=1
        let query: [String: String] = [
            "action": Action.getStopsInBound.rawValue,
            "route": route,
            "bound": bound,
            "ServiceType": ServiceType,
        ]
        
        NetworkManager.decodableGet(url: baseUrl, query: query) { (error, result: GetStopsInBoundResponse?) in
            callback(error, result)
        }
    }
    
    
    /// Get all route in a stop by BSI code
    func getRoutesInStop(bsiCode: String, callback: @escaping (_ error: Error?, _ result: GetRoutesInStopsResponse?) -> Void) {
        
        // test url: http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=getRoutesInStop&bsiCode=WO04-N-1050-0
        let query: [String: String] = [
            "action": Action.getRoutesInStop.rawValue,
            "bsiCode": bsiCode
        ]
        
        NetworkManager.decodableGet(url: baseUrl, query: query) { (error, result: GetRoutesInStopsResponse?) in
            callback(error, result)
        }
    }
    
    /// Get all bound information of a route
    func getRouteBound(route: String, callback: @escaping (_ error: Error?, _ result: GetRouteBoundResponse?) -> Void) {
        
        // test url: http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=getroutebound&route=2F
        let query: [String: String] = [
            "action": Action.getRouteBound.rawValue,
            "route": route
        ]
        
        NetworkManager.decodableGet(url: baseUrl, query: query) { (error, result: GetRouteBoundResponse?) in
            callback(error, result)
        }
    }
}




