//
//  WhatsappApiViewController.swift
//  iOS Practice
//
//  Created by KL on 14/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import SafariServices

class WhatsappApiViewController: KLViewController, UITextFieldDelegate {
    
    let phoneTextField: PaddingTextField = {
        let textField = PaddingTextField(edgeInsets: UIEdgeInsets(top: 0, left: 116, bottom: 0, right: 16))
        textField.backgroundColor = .groupTableViewBackground
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.text = "852"
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        label.text = "Phone:"
        label.textColor = .black
        label.backgroundColor = .groupTableViewBackground
        textField.leftView = label
        textField.leftViewMode = .always
        return textField
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Content:"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let textTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .groupTableViewBackground
        textView.layer.cornerRadius = 4
        textView.clipsToBounds = true
        textView.text = "Default Message"
        return textView
    }()
    
    // MARK: - Life cycle
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Whatsapp API"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .done, target: self, action: #selector(didTapSendButton))
        
        setupLayout()
    }
    
    // MARK: - Init
    
    func setupLayout() {
        phoneTextField.delegate = self
        
        safeAreaContentView.add(phoneTextField, textTextView, messageLabel)
        
        let views = ["phoneTextField": phoneTextField,
                     "textTextView": textTextView,
                     "messageLabel": messageLabel]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-24-[phoneTextField]-24-|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-24-[phoneTextField(40)]-16-[messageLabel]-16-[textTextView(150)]", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views))
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textTextView.becomeFirstResponder()
        return true
    }
    
    // MARK: - Action
    
    @objc func didTapSendButton() {
        view.endEditing(true)

        if let phone = phoneTextField.text, let navigationController = navigationController {
            WhatsappClient.openWhatsappViaSafari(controller: navigationController, phone: phone, text: textTextView.text)
//            WhatsappClient.openWhatsappDirectly(controller: navigationController, phone: phone, text: textTextView.text)
        }
    }
}
