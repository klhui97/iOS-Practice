//
//  FreeAppParserModel.swift
//  iOS Practice
//
//  Created by KL on 17/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

// MARK: - Struct

extension FreeAppParser {
    
    struct Item {
        var title = ""
        var link = ""
        var category = ""
        var pubDate = ""
        var CDATA = Data()
        
        var attributedString: String {
            let attributedOptions: [NSAttributedString.DocumentReadingOptionKey : Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            do {
                return try NSAttributedString(data: CDATA, options: attributedOptions, documentAttributes: nil).string
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            return ""
        }
        
        mutating func set(_ type: RssTag.RawValue, _ string: String) {
            let newString = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            switch type {
            case RssTag.title.rawValue:
                title += newString
            case RssTag.link.rawValue:
                link += newString
            case RssTag.pubDate.rawValue:
                pubDate += newString
            case RssTag.category.rawValue:
                category += newString
            default:
                return
            }
        }
    }
}

// MARK: - Enum

extension FreeAppParser {
    
    enum RssTag: String {
        case item = "item"
        case title = "title"
        case link = "link"
        case category = "category"
        case pubDate = "pubDate"
    }
}
