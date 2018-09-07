//
//  PagingCollectionViewController.swift
//  iOS Practice
//
//  Created by david.hui on 7/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

protocol KLPagingDelegate {
    func didScrollTo(pageFloat: CGFloat)
}

class PagingCollectionViewController: KLCollectionViewController {

    enum Page {
        case firstPage
        case SecondPage
        case thirdPage
    }
    
    let items: [Page] = [.firstPage, .SecondPage, .thirdPage]
    var pagingDelegate: KLPagingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.isScrollEnabled = true
        collectionView?.isPagingEnabled = true
    }

    override func configCollectionViewFlowLayout() {
        collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionViewFlowLayout.minimumLineSpacing = 0
    }
    
    // MARK: - Collection View data scource and delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? .red : .green
        
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView else {
            return
        }
        pagingDelegate?.didScrollTo(pageFloat: collectionView.contentOffset.x / collectionView.frame.size.width)
    }
    
}
