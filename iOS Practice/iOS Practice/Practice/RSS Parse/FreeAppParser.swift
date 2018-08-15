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
    private var currentElement = ""
    private var currentTitle:String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentLink:String = "" {
        didSet {
            currentLink = currentLink.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
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
    }
}

// MARK: - Enum

extension FreeAppParser {
    
    enum RssTag: String {
        case item = "item"
        case title = "title"
        case link = "link"
    }
}

// MARK: - XMLParserDelegate

extension FreeAppParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("didStartElement \(elementName)")
        currentElement = elementName
        
        if currentElement == RssTag.item.rawValue {
            currentTitle = ""
            currentLink = ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("didEndElement \(elementName)")
        if elementName == "item" {
            var item = Item()
            item.title = currentTitle
            item.link = currentLink
            items.append(item)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch string {
        case RssTag.title.rawValue:
            currentTitle += string
        case RssTag.link.rawValue:
            currentLink += string
        default:
            break
        }
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        items = []
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(items)
    }
}
