//
//  FreeAppParser.swift
//  iOS Practice
//
//  Created by david.hui on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

class FreeAppParser: NSObject {

    private var items: [Item] = []
    private var currentItem = Item()
    private var currentElement = ""
    private var parserCompletionHandler:(([Item]) -> Void)?
    
    func fetchData(completionHandler: (([Item]) -> Void)?) {
        parserCompletionHandler = completionHandler
        
        if let url = URL(string: "https://appshopper.com/feed/?platform=ios&device=iphone&mode=featured&filter=price&type=free&category=all") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    if let error = error {
                        print(error)
                    }
                    return
                }
                
                let parse = XMLParser(data: data)
                parse.delegate = self
                parse.parse()
            }
            
            task.resume()
        }
    }
}

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

// MARK: - XMLParserDelegate

extension FreeAppParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if currentElement == RssTag.item.rawValue {
            currentItem = Item()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == RssTag.item.rawValue {
            items.append(currentItem)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentItem.set(currentElement, string)
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        items = []
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(items)
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        currentItem.CDATA = CDATABlock
    }
}
