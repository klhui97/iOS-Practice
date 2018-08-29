//
//  ChatUITableViewController.swift
//  iOS Practice
//
//  Created by david.hui on 8/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class ChatUITableViewController: KLTableViewController {

    let sampleChats = ["Hello John! How are you doing?",
                       "Perfect, I am really glad to hear that! How may I help you today?",
                       "I am really sorry to hear that. Is there anything I can do to help you?",
                       "Hello Mary. I understand the problem and will be happy to help you. Let’s see what I can do.",
                       "Hello! May I have your name please?",
                       "Let me check that I have this right…",
                       "Let me see if I have this correct, you want me to…"]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Chat UI"
        
        tableView.allowsSelection = false
        tableView.register(LeftBubbleTableViewCell.self)
        tableView.register(RightBubbleTableViewCell.self)
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleChats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell: LeftBubbleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.textView.text = sampleChats[indexPath.row]
            cell.layoutIfNeeded()
            return cell
        }else {
            let cell: RightBubbleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.textView.text = sampleChats[indexPath.row]
            cell.layoutIfNeeded()
            return cell
        }
    }
}
