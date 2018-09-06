//
//  HomeViewController.swift
//  iOS Practice
//
//  Created by david.hui on 8/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class HomeViewController: KLViewController, MenuTableViewControllerDelegate {

    let menuManager = MenuManager()
    
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
        
        menuManager.setDelegate(delegate: self)
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
        menuManager.showMenu()
    }
    
    // MARK: - MenuTableViewControllerDelegate
    func changeViewController(toController: UIViewController) {
        menuManager.removeMenu(duration: 0.1, completion: {
            self.navigationController?.pushViewController(toController, animated: true)
        })
    }
    
    
}
