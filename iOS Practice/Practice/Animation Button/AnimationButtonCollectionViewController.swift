//
//  AnimationButtonCollectionViewController.swift
//  iOS Practice
//
//  Created by david.hui on 31/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit


class AnimationButtonCollectionViewController: KLCollectionViewController {
    
    var rows: [AnimatedButtonCell.AnimationType] = [.shake, .pulsate]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Button Animation"
        
        collectionView?.register(AnimatedButtonCell.self)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        collectionViewFlowLayout.itemSize = CGSize(width: 60, height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnimatedButtonCell = collectionView.dequeueReusableCell(for: indexPath)
        if indexPath.row < rows.count {
            cell.type = rows[indexPath.row]
        }
        
        return cell
    }
}
