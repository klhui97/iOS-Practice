//
//  GenericBottomCardViewController.swift
//  iOS Practice
//
//  Created by KL on 19/11/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

open class GenericBottomCardViewController<T: UIView>: BottomCardViewController {
    
    public let coreView: T
    
    public var coreViewHeight: CGFloat = ScreenSizeHelper.screenHeight - 120
    public var navTitle: String? = nil
    public var doneTitle: String? = nil
    public let navigationBar = UINavigationBar()
    
    init(view: T) {
        self.coreView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        contentView.add(navigationBar, coreView)
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        let views = ["coreView": coreView,
                     "navigationBar": navigationBar]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[navigationBar(44)][coreView(\(coreViewHeight))]|", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views))
        coreView.al_fillSuperViewHorizontally()
    }
    
    func customConfig(navTitle: String? = nil, doneTitle: String? = nil) {
        self.navTitle = navTitle
        self.doneTitle = doneTitle
    }
    
    func setupNavigationBar() {
        let doneButtonItem: UIBarButtonItem
        if let doneTitle = doneTitle {
            doneButtonItem = UIBarButtonItem(title: doneTitle, style: .done, target: self, action: #selector(didDone))
        }
        else {
            doneButtonItem = UIBarButtonItem(title: "關閉", style: .done, target: self, action: #selector(didDone))
        }
        navigationItem.rightBarButtonItem = doneButtonItem
        navigationBar.items = [navigationItem]
    }
    
    @objc func didDone() {
        dismiss(animated: true)
    }
}
