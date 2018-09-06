//
//  HomeViewController.swift
//  iOS Practice
//
//  Created by david.hui on 8/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class HomeViewController: KLViewController, MenuTableViewControllerDelegate {

    let menuController = MenuTableViewController()
    var menuWidth: CGFloat!
    var menuLeadingConstraint: NSLayoutConstraint?
    
    // MARK: - View
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    let menuContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let testingButton: UIButton = {
        let button = UIButton()
        button.setTitle("test", for: UIControlState())
        button.backgroundColor = .black
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigation()
        
        view.add(backgroundImageView)
        backgroundImageView.al_fillSuperview()
        view.add(testingButton)
        testingButton.al_centerToView()
        testingButton.addTarget(self, action: #selector(testButtonOnClicked), for: UIControlEvents.touchUpInside)
        overlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOverlayView)))
        
        if let window = UIApplication.shared.keyWindow {
            menuWidth = window.frame.size.width / 1.5
        }
        
        menuController.delegate = self
    }
    
    // MARK: - Init
    private func initNavigation() {
        title = "Home"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(showMenu))
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Action
    @objc func testButtonOnClicked() {
        KLAlertViewManager.shared.showBottomAlert(target: view, text: "hi")
    }
    
    @objc func showMenu() {
        if let window = UIApplication.shared.keyWindow {
            navigationController?.view.add(overlayView)
            overlayView.al_fillSuperview()
            
            // menuContainerView
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
            menuContainerView.add(menuController.tableView)
            NSLayoutConstraint.activate([
                menuController.tableView.leadingAnchor.constraint(equalTo: menuContainerView.leadingAnchor),
                menuController.tableView.trailingAnchor.constraint(equalTo: menuContainerView.trailingAnchor),
                menuController.tableView.topAnchor.constraint(equalTo: menuContainerView.topAnchor, constant: UIApplication.shared.statusBarFrame.height),
                menuController.tableView.bottomAnchor.constraint(equalTo: menuContainerView.bottomAnchor)])
            
            // before animation
            overlayView.alpha = 0
            menuLeadingConstraint?.constant = -menuWidth
            view.layoutIfNeeded()
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
    
    // MARK: - Method
    private func removeMenu(duration: TimeInterval, completion: (() -> Void)? = nil) {
        if let window = UIApplication.shared.keyWindow {
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
                self.overlayView.alpha = 0
                self.menuLeadingConstraint?.constant = -self.menuWidth
                window.layoutIfNeeded()
            })
            
            animator.addCompletion { (_) in
                self.overlayView.removeFromSuperview()
                self.menuContainerView.removeFromSuperview()
                self.menuController.view.removeFromSuperview()
                if let completion = completion {
                    completion()
                }
            }
            
            animator.startAnimation()
        }
    }
    
    // MARK: - MenuTableViewControllerDelegate
    
    func changeRootViewControllerTo(controller: UIViewController) {
        removeMenu(duration: 0.1, completion: {
            self.navigationController?.pushViewController(controller, animated: true)
        })
    }
    
    
}
