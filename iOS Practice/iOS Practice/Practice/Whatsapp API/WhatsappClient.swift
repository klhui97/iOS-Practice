//
//  WhatsappClient.swift
//  iOS Practice
//
//  Created by david.hui on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation
import SafariServices

class WhatsappClient: NSObject {
    
    static let shared = WhatsappClient()
    
    func openWhatsappViaSafari(controller: UIViewController, phone: String, text: String) {
        if let url = URL(string: "https://api.whatsapp.com/send?phone=\(phone)&text=\(text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            controller.present(vc, animated: true)
        }
    }
    
    func openWhatsappDirectly(controller: UIViewController, phone: String, text: String) {
        if let url = URL(string: "whatsapp://send?phone=\(phone)&text=\(text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
