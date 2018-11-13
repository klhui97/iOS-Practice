//
//  AnimationButtonCollectionViewController.swift
//  iOS Practice
//
//  Created by KL on 31/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit


class AnimationButtonCollectionViewController: KLCollectionViewController {
    
    var rows: [AnimatedButtonCell.AnimationType] = [.test, .shake, .pulsate, .deepPress]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Button Animation"
        
        collectionView?.register(AnimatedButtonCell.self)
    }
    
    override func configCollectionViewFlowLayout() {
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        collectionViewFlowLayout.itemSize = CGSize(width: 100, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnimatedButtonCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.type = rows[indexPath.row]
        
        return cell
    }
}
