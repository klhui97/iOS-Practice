//
//  HomeTableViewController.swift
//  iOS Practice
//
//  Created by KL on 6/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

protocol MenuTableViewControllerDelegate {
    func changeRootViewControllerTo(controller: UIViewController)
}

private extension MenuTableViewController {
    
    func getController(_ rowType: Row) -> UIViewController {
        
        switch rowType {
        case .swift4Json:
            return Swift4JsonTableViewController()
        case .chatUi:
            return ChatUITableViewController()
        case .notificationObserver:
            return NotificationObserverViewController()
        case .bluetoothReadWrite:
            return BluetoothReadWriteViewController()
        case .messageUi:
            return MessageUiViewController()
        case .hkKmbData:
            return KMBSearchViewController()
        case .whatsappApi:
            return WhatsappApiViewController()
        case .rssParse:
            return RSSParseViewController()
        }
    }
}

class MenuTableViewController: UITableViewController {
    
    // MARK: - Practice data
    enum Row: String {
        case swift4Json = "Swift 4 JSON"
        case chatUi = "Chat UI"
        case notificationObserver = "Notification Observer"
        case bluetoothReadWrite = "BT Read&Write"
        case messageUi = "Message UI"
        case hkKmbData = "KMB Data"
        case whatsappApi = "Whatsapp API"
        case rssParse = "RSS Parse"
    }
    
    var rows: [Row] = [.swift4Json, .hkKmbData, .chatUi, .notificationObserver, .bluetoothReadWrite, .messageUi, .whatsappApi, .rssParse]
    var delegate: MenuTableViewControllerDelegate?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 52
        tableView.register(LargeTitleTableViewCell.self)
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return rows.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: LargeTitleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.largeTitleLabel.text = "Menu"
            return cell
        default:
            let cell = UITableViewCell()
            cell.textLabel?.text = rows[indexPath.row].rawValue
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            delegate?.changeRootViewControllerTo(controller: getController(rows[indexPath.row]))
        }
    }
}
