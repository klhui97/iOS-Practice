//
//  PopUpViewController.swift
//  iOS Practice
//
//  Created by david.hui on 6/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class PopUpViewController: KLCollectionViewController {
    
    var rows: [PopUpCollectionViewCell.PopUpType] = [.buttonAlert, .pickerView]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pop Up View"
        
        collectionView?.register(PopUpCollectionViewCell.self)
    }
    
    override func configCollectionViewFlowLayout() {
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        collectionViewFlowLayout.itemSize = CGSize(width: 100, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PopUpCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.type = rows[indexPath.row]
        cell.controller = self
        
        return cell
    }
}
