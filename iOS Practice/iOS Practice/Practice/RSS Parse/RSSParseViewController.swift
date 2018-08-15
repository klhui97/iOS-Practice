//
//  RSSParseViewController.swift
//  iOS Practice
//
//  Created by KL on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class RSSParseViewController: KLViewController {
    
    var items: [FreeAppParser.Item] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parse = FreeAppParser()
        parse.fetchData { (items) in
            self.items = items
        }
    }
    

}
