//
//  iOSMessageManager.swift
//  Big2Scorer
//
//  Created by david.hui on 30/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import MessageUI

class iOSMessageManager {
    
    static func showEmail(presenter: UIViewController, delegate: MFMailComposeViewControllerDelegate, emailTitle: String = "", messageBody: String = "", toRecipients: [String] = []) {
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.setSubject(emailTitle)
        mailComposer.setMessageBody(messageBody, isHTML: false)
        mailComposer.setToRecipients(toRecipients)
        mailComposer.mailComposeDelegate = delegate
        
        if MFMailComposeViewController.canSendMail() {
            presenter.present(mailComposer, animated: true)
        }
    }
}
