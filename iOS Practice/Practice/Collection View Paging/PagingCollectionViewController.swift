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
        case fourthPage
        case fifthPage
    }
    
    let items: [Page] = [.firstPage, .SecondPage, .thirdPage, .fourthPage, .fifthPage]
    var pagingDelegate: KLPagingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.isScrollEnabled = true
        collectionView?.isPagingEnabled = true
        collectionView?.register(ImageCollectionViewCell.self)
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
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        cell.imageView.image = UIImage(named: "demo\(indexPath.row % 5 + 1)")
        
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView else {
            return
        }
        pagingDelegate?.didScrollTo(pageFloat: collectionView.contentOffset.x / collectionView.frame.size.width)
    }
    
}
