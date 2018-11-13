//
//  WhatsappClient.swift
//  iOS Practice
//
//  Created by KL on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation
import SafariServices

class WhatsappClient: NSObject {
    
    static func openWhatsappViaSafari(controller: UIViewController, phone: String, text: String) {
        if let url = URL(string: "https://api.whatsapp.com/send?phone=\(phone.replacingOccurrences(of: " ", with: ""))&text=\(text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            controller.present(vc, animated: true)
        }
    }
    
    static func openWhatsappDirectly(controller: UIViewController, phone: String, text: String) {
        if let url = URL(string: "whatsapp://send?phone=\(phone.replacingOccurrences(of: " ", with: ""))&text=\(text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
