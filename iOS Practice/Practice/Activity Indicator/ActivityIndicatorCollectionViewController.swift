//
//  ActivityIndicatorCollectionViewController.swift
//  iOS Practice
//
//  Created by david.hui on 31/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class ActivityIndicatorCollectionViewController: KLCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        title = "Activity Indicator"
        
        collectionView?.register(ActivityIndicatorCollectionViewCell.self)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        collectionViewFlowLayout.itemSize = CGSize(width: 100, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ActivityIndicatorCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.backgroundColor = .black
        
        return cell
    }
}
