//
//  NetworkManager.swift
//  iOS Practice
//
//  Created by david.hui on 17/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static func decodableGet<T: Decodable>(url: String, query: [String: String]?, callback: @escaping (_ error: Error?, _ decodedResult: T?) -> Void) {
        var urlComponents = URLComponents(url: URL(string: url)!, resolvingAgainstBaseURL: false)!
        if let query = query {
            urlComponents.queryItems = getQueryItems(from: query)
        }
        print("url", urlComponents.url!)
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                callback(error, nil)
                return
            }
            
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
                    print("no data")
                }
            } catch {
                callback(error, nil)
            }
        }).resume()
    }
    
    static func getQueryItems(from query: [String: String?]) -> [URLQueryItem] {
        var array = [URLQueryItem]()
        for case let (key, value?) in query {
            array.append(URLQueryItem(name: key, value: value))
        }
        return array
    }
}
