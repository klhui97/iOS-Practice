//
//  DateHelper.swift
//  TEDY-Makeathon
//
//  Created by KL on 9/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

class DateHelper {
    
    static func getCurrentTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
}
