//
//  MenuManager.swift
//  iOS Practice
//
//  Created by KL on 6/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class MenuManager {
    
    let controller: MenuTableViewController
    var menuLeadingConstraint: NSLayoutConstraint?
    let menuWidth: CGFloat
    
    let menuContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    init() {
        controller = MenuTableViewController()
        menuWidth = ScreenSizeHelper.windowWidth / 1.5
        overlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOverlayView)))
    }
    
    func setDelegate(delegate: MenuTableViewControllerDelegate) {
        controller.delegate = delegate
    }
    
    func showMenu() {
        if let window = UIApplication.shared.keyWindow {
            
            window.add(overlayView)
            overlayView.al_fillSuperview()
            
            window.add(menuContainerView)
            if menuLeadingConstraint == nil {
                menuLeadingConstraint = menuContainerView.leadingAnchor.constraint(equalTo: window.leadingAnchor)
            }
            NSLayoutConstraint.activate([
                menuLeadingConstraint!,
                menuContainerView.topAnchor.constraint(equalTo: window.topAnchor),
                menuContainerView.widthAnchor.constraint(equalToConstant: menuWidth),
                menuContainerView.bottomAnchor.constraint(equalTo: window.bottomAnchor)])
            
            // menuController
            menuContainerView.add(controller.tableView)
            NSLayoutConstraint.activate([
                controller.tableView.leadingAnchor.constraint(equalTo: menuContainerView.leadingAnchor),
                controller.tableView.trailingAnchor.constraint(equalTo: menuContainerView.trailingAnchor),
                controller.tableView.topAnchor.constraint(equalTo: menuContainerView.topAnchor, constant: UIApplication.shared.statusBarFrame.height),
                controller.tableView.bottomAnchor.constraint(equalTo: menuContainerView.bottomAnchor)])
            
            // before animation
            overlayView.alpha = 0
            menuLeadingConstraint?.constant = -menuWidth
            window.layoutIfNeeded()
            
            let animator = UIViewPropertyAnimator(duration: 0.35, dampingRatio: 1, animations: {
                self.overlayView.alpha = 1
                self.menuLeadingConstraint?.constant = 0
                window.layoutIfNeeded()
            })
            
            animator.startAnimation()
        }
    }
    
    @objc func didTapOverlayView() {
        removeMenu(duration: 0.35, completion: nil)
    }
    
    func removeMenu(duration: TimeInterval, completion: (() -> Void)? = nil) {
        if let window = UIApplication.shared.keyWindow {
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
                self.overlayView.alpha = 0
                self.menuLeadingConstraint?.constant = -self.menuWidth
                window.layoutIfNeeded()
            })
            
            animator.addCompletion { (_) in
                self.overlayView.removeFromSuperview()
                self.menuContainerView.removeFromSuperview()
                self.controller.view.removeFromSuperview()
                if let completion = completion {
                    completion()
                }
            }
            
            animator.startAnimation()
        }
    }
}
