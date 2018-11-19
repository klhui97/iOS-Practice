//
//  KLWebViewBottomCardViewController.swift
//  EasyBus
//
//  Created by david.hui on 6/11/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import WebKit

class KLWebViewBottomCardViewController: BottomCardViewController, WKNavigationDelegate, HasLoadingOverlay {

    var loadingOverlay: LoadingOverlay?
    var navTitle: String? = nil
    var doneTitle: String? = nil
    let navigationBar = UINavigationBar()
    var webView: WKWebView
    let url: String
    
    init(url: String, title: String? = nil) {
        self.url = url
        webView = WKWebView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingOverlay?.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        contentView.add(webView, navigationBar)
        setupAutoLayout()
        if let url = URL(string: self.url) {
            showLoadingOverlay(in: webView)
            webView.navigationDelegate = self
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func setupAutoLayout() {
        let views = ["webView": webView,
                     "navigationBar": navigationBar]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[navigationBar(44)][webView(\(ScreenSizeHelper.screenHeight - 120))]|", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views))
        webView.al_fillSuperViewHorizontally()
    }
    
    func customConfig(navTitle: String? = nil, doneTitle: String? = nil) {
        self.navTitle = navTitle
        self.doneTitle = doneTitle
    }
}

private extension KLWebViewBottomCardViewController {
    
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
