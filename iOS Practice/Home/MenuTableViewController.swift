//
//  HomeTableViewController.swift
//  iOS Practice
//
//  Created by KL on 6/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

protocol MenuTableViewControllerDelegate {
    func changeViewController(toController: UIViewController)
}

private extension MenuTableViewController {
    
    func getController(_ rowType: Row) -> UIViewController {
        
        switch rowType {
        case .swift4Json:
            return Swift4JsonTableViewController()
        case .chatUi:
            return ChatUITableViewController()
        case .inputObserver:
            return InputObserverViewController()
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
        case .circleProgressView:
            return CircleProgressViewController()
        case .magicalGridView:
            return MagicalGridViewController()
        case .animationView:
            return AnimationViewTableViewController()
        case .animationButton:
            return AnimationButtonCollectionViewController()
        case .activityIndicator:
            return ActivityIndicatorCollectionViewController()
        case .popUpView:
            return PopUpViewController()
        case .collectionViewPaging:
            return PagingViewController()
        case .speechRecognition:
            return SpeechRecognitionViewController()
        case .infinteImagesScroll:
            var images: [UIImage] = []
            for i in 1...5 {
                images.append(UIImage(named: "demo\(i)")!)
            }
            return KLImagePageViewController(mode: .autoInfinite, images: images)
        case .arKitsTapToadd:
            return ARKitTapToAddViewController()
        }
    }
}

class MenuTableViewController: KLTableViewController {
    
    // MARK: - Practice data
    enum Row: String {
        case swift4Json = "Codable JSON Example"
        case chatUi = "Chat UI"
        case inputObserver = "Input Observer"
        case bluetoothReadWrite = "BT Read&Write"
        case messageUi = "Message UI"
        case hkKmbData = "KMB Data"
        case whatsappApi = "Whatsapp API"
        case rssParse = "RSS Parse"
        case circleProgressView = "Circle Progress View"
        case magicalGridView = "Magical Grid View"
        case animationView = "Animation View"
        case animationButton = "Animation Button"
        case activityIndicator = "Activity Indicator"
        case popUpView = "Pop Up View"
        case collectionViewPaging = "Collection View Paging"
        case speechRecognition = "Speech Recognition"
        case infinteImagesScroll = "Infinte images scroll"
        case arKitsTapToadd = "AR Kits(Tap to add)"
    }
    
    var rows: [Row] = [.arKitsTapToadd, .infinteImagesScroll, .collectionViewPaging, .speechRecognition, .swift4Json, .hkKmbData, .chatUi, .inputObserver, .bluetoothReadWrite, .messageUi, .whatsappApi, .rssParse, .circleProgressView, .magicalGridView, .animationView, .animationButton, .activityIndicator, .popUpView]
    var delegate: MenuTableViewControllerDelegate?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .white
        tableView.register(LargeTitleTableViewCell.self)
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
            delegate?.changeViewController(toController: getController(rows[indexPath.row]))
        }
    }
}
