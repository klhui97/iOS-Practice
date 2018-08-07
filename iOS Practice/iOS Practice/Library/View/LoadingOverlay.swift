//
//  LoadingOverlay.swift
//  iOS Practice
//
//  Created by david.hui on 7/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class LoadingOverlay: UIView {
    private let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadingIndicator.startAnimating()
    }
}

protocol HasLoadingOverlayProtocol: class {
    func showLoadingOverlay()
    func removeLoadingOverlay()
}

protocol HasLoadingOverlay: HasLoadingOverlayProtocol {
    associatedtype LoadingOverlay: UIView
    var loadingOverlay: LoadingOverlay? { get set }
    func showLoadingOverlay()
    func removeLoadingOverlay()
    
}

extension HasLoadingOverlay {
    func showLoadingOverlay(in view: UIView) {
        let loadingOverlay: LoadingOverlay
        if let _loadingOverlay = self.loadingOverlay {
            loadingOverlay = _loadingOverlay
        }
        else {
            loadingOverlay = LoadingOverlay()
            loadingOverlay.translatesAutoresizingMaskIntoConstraints = false
            self.loadingOverlay = loadingOverlay
        }
        
        view.addSubview(loadingOverlay)
        loadingOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadingOverlay.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func showLoadingOverlayInWindow() {
        guard let window = UIApplication.shared.keyWindow else { return }
        showLoadingOverlay(in: window)
    }
    
    func removeLoadingOverlay() {
        loadingOverlay?.removeFromSuperview()
    }
}

extension HasLoadingOverlay where Self: AppDelegate {
    func showLoadingOverlay() {
        showLoadingOverlayInWindow()
    }
}

extension HasLoadingOverlay where Self: UIViewController {
    func showLoadingOverlay() {
        showLoadingOverlay(in: self.view)
    }
    
    func showLoadingOverlayInNavigationController() {
        guard let nav = navigationController else {
            showLoadingOverlay()
            return
        }
        showLoadingOverlay(in: nav.view)
    }
}

