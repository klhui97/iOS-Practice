//
//  KMBDataHelper.swift
//  iOS Practice
//
//  Created by david.hui on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

class KMBDataHelper: NSObject {
    
    static let shared = KMBDataHelper()
    
    var routeBoundInfoDict: [String: [KMBClient.GetRouteBoundResponse.Info]] = [:]
    var routeInfoStopsDict: [KMBClient.GetRouteBoundResponse.Info: KMBClient.GetStopsInBoundResponse.StopsInfo] = [:]
}
