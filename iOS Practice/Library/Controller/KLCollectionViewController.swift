//
//  KLCollectionViewController.swift
//  iOS Practice
//
//  Created by david.hui on 31/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class KLCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let collectionViewFlowLayout: UICollectionViewFlowLayout
    
    init() {
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: collectionViewFlowLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(UICollectionViewCell.self)
    }
}
