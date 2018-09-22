//
//  DateHelper.swift
//  TEDY-Makeathon
//
//  Created by KL on 9/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

class DateHelper {
    
    struct Time {
        let hour: Int
        let minute: Int
        let second: Int
    }
    
    static var now: Date {
        return Date()
    }
    
    /// Get the current time in string format
    ///
    /// - Parameter dateFormat: Swift dateFormat, default = "HH:mm:ss"
    /// - Returns: String
    static func currentTimeString(dateFormat: String = "HH:mm:ss") -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
    
    
    /// Convert string to Date
    ///
    /// - Parameters:
    ///   - dateFormat: Swift dateFormat, default = "yyyy-MM-dd HH:mm:ss"
    ///   - dateString: The text of date thats is going to be converted
    /// - Returns: Date?, nil: incorrect dateFormat or dateString
    static func stringToDate(dateFormat: String = "yyyy-MM-dd HH:mm:ss", dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.date(from: dateString)
    }
    
    static func dateToString(dateFormat: String = "yyyy-MM-dd HH:mm:ss", date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
    
    
    /// Find the time different between two date
    ///
    /// - Returns: Time objcet: (include hour, minute, second only), nil: Date format invaild
    static func timeDifferent(from fromDate: Date, to toDate: Date) -> Time? {
        let difference = Calendar.current.dateComponents([.hour, .minute, .second], from: fromDate, to: toDate)
        
        guard let hour = difference.hour, let minute = difference.minute, let second = difference.second else { return nil }
        return Time(hour: hour, minute: minute, second: second)
    }
}
