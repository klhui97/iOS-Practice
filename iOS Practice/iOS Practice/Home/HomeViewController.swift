//
//  HomeViewController.swift
//  iOS Practice
//
//  Created by david.hui on 8/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, MenuTableViewControllerDelegate {

    let menuController = MenuTableViewController()
    var menuWidthConstraint: NSLayoutConstraint?
    
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
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigation()
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
    @objc func showMenu() {
        if let window = UIApplication.shared.keyWindow {
            let menuWidth = window.frame.size.width / 1.5
            
            navigationController?.view.add(overlayView)
            overlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOverlayView)))
            overlayView.al_fillSuperview()
            
            window.add(menuContainerView)
            
            if menuWidthConstraint == nil {
                menuWidthConstraint = menuContainerView.widthAnchor.constraint(equalToConstant: menuWidth)
            }
            NSLayoutConstraint.activate([menuWidthConstraint!])
            
            NSLayoutConstraint.activate([
                menuContainerView.topAnchor.constraint(equalTo: window.topAnchor),
                menuContainerView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                menuContainerView.bottomAnchor.constraint(equalTo: window.bottomAnchor)])
            
            menuContainerView.add(menuController.view)
            
            NSLayoutConstraint.activate([
                menuController.view.leadingAnchor.constraint(equalTo: menuContainerView.safeAreaLayoutGuide.leadingAnchor),
                menuController.view.trailingAnchor.constraint(equalTo: menuContainerView.safeAreaLayoutGuide.trailingAnchor),
                menuController.view.topAnchor.constraint(equalTo: menuContainerView.safeAreaLayoutGuide.topAnchor),
                menuController.view.bottomAnchor.constraint(equalTo: menuContainerView.safeAreaLayoutGuide.bottomAnchor)])
            
            overlayView.alpha = 0
            menuWidthConstraint?.constant = 0
            window.layoutIfNeeded()
            
            let animator = UIViewPropertyAnimator(duration: 0.35, dampingRatio: 1, animations: {
                self.overlayView.alpha = 1
                self.menuWidthConstraint?.constant = menuWidth
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
                self.menuWidthConstraint?.constant = 0
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
