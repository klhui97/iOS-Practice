//
//  MessageUiViewController.swift
//  iOS Practice
//
//  Created by david.hui on 14/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import MessageUI

class MessageUiViewController: KLViewController, MFMailComposeViewControllerDelegate {

    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Message UI test"
        
        safeAreaContentView.add(label)
        label.numberOfLines = 0
        safeAreaContentView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        label.al_leftToMargin()
        label.al_rightToMargin()
        label.al_centerYToView()
        
        guard MFMailComposeViewController.canSendMail() else {
            label.text = "This device doesn't allow you to send mail."
            return
        }
        
        let emailTitle = "Hi, KL"
        let messageBody = "Hey, Hello:)"
        let toRecipients = ["me@klhui.hk"]
        
        iOSMessageManager.showEmail(presenter: self, delegate: self, emailTitle: emailTitle, messageBody: messageBody, toRecipients: toRecipients)
    }

    // MARK: - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail cancelled")
        case MFMailComposeResult.saved:
            print("Mail saved")
        case MFMailComposeResult.sent:
            print("Mail sent")
        case MFMailComposeResult.failed:
            print("Failed to send: \(error?.localizedDescription ?? "")")
        }
        
        dismiss(animated: true, completion: nil)
    }
}
