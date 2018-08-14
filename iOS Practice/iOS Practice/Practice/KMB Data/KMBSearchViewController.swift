//
//  KMBSearchViewController.swift
//  iOS Practice
//
//  Created by david.hui on 14/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class KMBSearchViewController: UITableViewController {
    
    enum Action: String {
        case getStop = "getstops"
    }
    
    var data: Result?
    
    let stop = "31M"
    let bound = "1"
    let action = Action.getStop
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        search { (error, result) in
            if let result = result {
                self.data = result
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = data {
            if section == 0 {
                return 1
            }else {
                return data.routeStops?.count ?? 0
            }
        }else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.section == 0, let baseInfo = data?.basicInfo {
            cell.textLabel?.text = "\(baseInfo.OriCName ?? "")   --->   \(baseInfo.DestCName ?? "")"
        }else if indexPath.section == 1, let stops = data?.routeStops {
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text =
            """
            \(stops[indexPath.row].CName ?? "")
            BSICode: \(stops[indexPath.row].BSICode ?? "")
            $ \(stops[indexPath.row].fare)
            Seq: \(stops[indexPath.row].Seq ?? "")
            Bound: \(stops[indexPath.row].Bound ?? "")
            """
        }
        
        return cell
    }
    
    // MARK: - API
    
    func search(callback: @escaping (_ error: Error?, _ result: Result?) -> Void) {
        
        // test url: http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=getstops&route=31M&bound=1
        guard let url = URL(string: "http://search.kmb.hk/KMBWebSite/Function/FunctionRequest.ashx?action=\(action.rawValue)&route=\(stop)&bound=\(bound)") else {
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

// MARK: - API response struct

extension KMBSearchViewController {
    
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
