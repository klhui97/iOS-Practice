//
//  LoginTableViewController.swift
//  iOS Practice
//
//  Created by KL on 9/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class LoginTableViewController: KLTableViewController {
    
    enum InputType: Int {
        case name = 1
        case password = 2
        
        var displayName: String {
            switch self {
            case .name: return "Name"
            case .password: return "Password"
            }
        }
    }
    
    
    var row: [InputType] = [.name, .password]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Base Login"
        
        tableView.allowsSelection = false
        tableView.register(LoginTableViewCell.self)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let type = InputType(rawValue: textField.tag) else { return }
        switch type {
        case .name:
            if ValidatorHelper.isValidatedEmail(textField.text ?? "") {
                print("isValidatedEmail")
            }else {
                print("isNotValidatedEmail")
            }
            print("name changed to \(textField.text ?? "")")
        case .password:
            print("password changed to \(textField.text ?? "")")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return row.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LoginTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        let type = row[indexPath.row]
        
        cell.fieldNameLabel.text = type.displayName
        cell.inputTextField.tag = type.rawValue
        cell.inputTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        return cell
    }
}
