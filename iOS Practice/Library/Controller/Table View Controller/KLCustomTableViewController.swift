//
//  KLCustomTableViewController.swift
//  EasyBus
//
//  Created by KL on 21/10/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

protocol HasEmptyTableView {
    var emptyView: UIView { get }
}

extension HasEmptyTableView where Self: KLCustomTableViewController {
    
    func showOrRemoveEmptyViewIfNeeded() {
        if tableView.visibleCells.isEmpty {
            safeAreaContentView.add(emptyView)
            emptyView.al_fillSuperview()
        }else {
            emptyView.removeFromSuperview()
        }
    }
}

class KLCustomTableViewController: KLViewController, UITableViewDelegate, UITableViewDataSource, HasLoadingOverlay {
    
    var loadingOverlay: LoadingOverlay?
    let tableView: UITableView
    
    init(style: UITableViewStyle) {
        self.tableView = UITableView(frame: .zero, style: style)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableViewSetup()
    }
    
    
    /// Override this function to customize the position of table view
    func tableViewSetup() {
        safeAreaContentView.add(tableView)
        tableView.al_fillSuperview()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("nedd to override this function")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("nedd to override this function")
    }
}
