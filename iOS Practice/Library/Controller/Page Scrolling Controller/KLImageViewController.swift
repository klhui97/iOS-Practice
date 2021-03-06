//
//  KLImageViewController.swift
//  iOS Practice
//
//  Created by KL on 5/10/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

open class KLImageViewController: UIViewController {
    
    public let imageView = UIImageView()
    private let imageContentMode: UIView.ContentMode
    public let index: Int
    
    init(index: Int, imageContentMode: UIView.ContentMode) {
        self.index = index
        self.imageContentMode = imageContentMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.tag = index
        view.addSubview(imageView)
        imageView.contentMode = imageContentMode
        NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }
}
