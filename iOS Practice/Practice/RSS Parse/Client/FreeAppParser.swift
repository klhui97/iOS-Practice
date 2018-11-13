//
//  FreeAppParser.swift
//  iOS Practice
//
//  Created by KL on 15/8/2018.
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
        
        let query: [String: String] = [
            "platform": "ios",
            "device": "iphone",
            "mode": "featured",
            "filter": "price",
            "type": "free",
            "category": "all"
        ]
        
        NetworkManager.request(url: "https://appshopper.com/feed", query: query, method: .get) { (error, data) in
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
