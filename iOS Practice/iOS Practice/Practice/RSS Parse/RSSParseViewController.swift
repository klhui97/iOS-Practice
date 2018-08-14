//
//  RSSParseViewController.swift
//  iOS Practice
//
//  Created by KL on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class RSSParseViewController: UIViewController, XMLParserDelegate {
    
    struct Item {
        var title = String()
        var link = String()
    }
    
    var items: [Item] = []
    var eName: String = String()
    var itemTitle = String()
    var itemLink = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://appshopper.com/feed/?platform=ios&device=iphone&mode=featured&filter=price&type=free&category=all") {
            if let parse = XMLParser(contentsOf: url) {
                parse.delegate = self
                parse.parse()
            }
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        if elementName == "item" {
            itemTitle = String()
            itemLink = String()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            
            var item = Item()
            item.title = itemTitle
            item.link = itemLink
            
            items.append(item)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if eName == "title" {
                itemTitle += data
            } else if eName == "link" {
                itemLink += data
            }
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("done")
    }
}
