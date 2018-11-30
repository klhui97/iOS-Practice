//
//  KLCollectionViewController.swift
//  iOS Practice
//
//  Created by KL on 31/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

open class KLCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let collectionViewFlowLayout: UICollectionViewFlowLayout
    
    init() {
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: collectionViewFlowLayout)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(UICollectionViewCell.self)
        configCollectionViewFlowLayout()
    }
    
    open func configCollectionViewFlowLayout() {
        fatalError("configCollectionViewFlowLayout(): has not been implemented")
    }
}
