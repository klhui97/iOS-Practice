//
//  NetworkManager.swift
//  iOS Practice
//
//  Created by KL on 17/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}

class NetworkManager {
    
    static func request(url: String, query: [String: String]?, method: RequestMethod = .get, callback: ((_ error: Error?, _ data: Data?) -> Void)? = nil) {
        guard let url = URL(string: url) else {
            callback?(nil, nil)
            return
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            callback?(nil, nil)
            return
        }
        
        if let query = query {
            urlComponents.queryItems = getQueryItems(from: query)
        }
        #if targetEnvironment(simulator)
        print("url", urlComponents.url!)
        #endif
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            callback?(error, data)
        }).resume()
    }
    
    static func request(url: String, bodyQuery: [String: Any]?, method: RequestMethod = .get, callback: ((_ error: Error?, _ data: Data?) -> Void)? = nil) {
        let urlComponents = URLComponents(url: URL(string: url)!, resolvingAgainstBaseURL: false)!
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method.rawValue
        if let bodyQuery = bodyQuery {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyQuery)
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            callback?(error, data)
        }).resume()
    }
    
    static func decodableGet<T: Decodable>(url: String, query: [String: String]?, callback: @escaping (_ error: Error?, _ decodedResult: T?) -> Void) {
        
        request(url: url, query: query, method: .get) { (error, data) in
            let decoder = JSONDecoder()
            do {
                if let data = data {
                    let decodedResult = try decoder.decode(T.self, from: data)
                    callback(error, decodedResult)
                    #if targetEnvironment(simulator)
                    let result = try? JSONSerialization.jsonObject(with: data, options: [])
                    print("returned json: ", result ?? "JSONSerialization error")
                    #endif
                }else {
                    callback(error, nil)
                }
            } catch {
                callback(error, nil)
            }
        }
    }
    
    static func decodablePost<T: Decodable>(url: String, bodyQuery: [String: Any]?, callback: @escaping (_ error: Error?, _ decodedResult: T?) -> Void) {
        
        request(url: url, bodyQuery: bodyQuery, method: .post) { (error, data) in
            let decoder = JSONDecoder()
            do {
                if let data = data {
                    let decodedResult = try decoder.decode(T.self, from: data)
                    callback(error, decodedResult)
                    #if targetEnvironment(simulator)
                    let result = try? JSONSerialization.jsonObject(with: data, options: [])
                    print("returned json: ", result ?? "JSONSerialization error")
                    #endif
                }else {
                    callback(error, nil)
                }
            } catch {
                callback(error, nil)
            }
        }
    }
    
    static func getQueryItems(from query: [String: String?]) -> [URLQueryItem] {
        var array = [URLQueryItem]()
        for case let (key, value?) in query {
            array.append(URLQueryItem(name: key, value: value))
        }
        return array
    }
}
