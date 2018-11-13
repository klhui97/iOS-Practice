//
//  PagingViewController.swift
//  iOS Practice
//
//  Created by KL on 7/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class PagingViewController: KLViewController, KLPagingDelegate {
    
    let collectionViewController = PagingCollectionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(collectionViewController)
        if let collectionView = collectionViewController.collectionView {
            safeAreaContentView.add(collectionView)
            collectionView.al_fillSuperview()
        }
        collectionViewController.pagingDelegate = self
    }
    
    // MARK: - KLPagingDelegate
    func didScrollTo(pageFloat: CGFloat) {
        print(pageFloat)
    }
}
