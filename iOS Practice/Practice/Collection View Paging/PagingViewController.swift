//
//  PagingViewController.swift
//  iOS Practice
//
//  Created by david.hui on 7/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class PagingViewController: KLViewController, KLPagingDelegate {
    
    let collectionViewController = PagingCollectionViewController()
    let topicContainerView = UIView()
    let topicStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(PagingCollectionViewController())
        if let collectionView = collectionViewController.collectionView {
            safeAreaContentView.add(collectionView)
            collectionView.al_fillSuperview()
        }
    }
    
    // MARK: - KLPagingDelegate
    func didScrollTo(pageFloat: CGFloat) {
        print(pageFloat)
    }
}
