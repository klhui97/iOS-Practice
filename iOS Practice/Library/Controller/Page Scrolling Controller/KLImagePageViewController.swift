//
//  KLImagePageViewController.swift
//  iOS Practice
//
//  Created by david.hui on 5/10/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class KLImagePageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    enum ScrollMode {
        case infinite
        case normal
    }
    
    var images: [UIImage] = [] {
        didSet {
            if let vc = initImageViewController(at: 0) {
                setViewControllers([vc], direction: .forward, animated: false, completion: nil)
            }
        }
    }
    
    var mode: ScrollMode = .normal
    
    init(mode: ScrollMode, images: [UIImage]) {
        self.mode = mode
        self.images = images
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vc = initImageViewController(at: 0) {
            setViewControllers([vc], direction: .forward, animated: false, completion: nil)
        }
        dataSource = self
        delegate = self
    }
    
    @objc func didTapImage() {
        
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard images.count > 1 else { return nil }
        
        if let viewController = viewController as? KLImageViewController {
            let index = viewController.index - 1
            if index < 0 {
                switch mode {
                case .infinite:
                    return initImageViewController(at: images.count - 1)
                case .normal:
                    return nil
                }
            }

            return initImageViewController(at: index)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard images.count > 1 else { return nil }
        
        if let viewController = viewController as? KLImageViewController {
            let index = viewController.index + 1
            if index >= images.count {
                switch mode {
                case .infinite:
                    return initImageViewController(at: 0)
                case .normal:
                    return nil
                }
            }
            
            return initImageViewController(at: index)
        }
        
        return nil
    }
}

private extension KLImagePageViewController {
    
    func initImageViewController(at index: Int) -> KLImageViewController? {
        guard images.count > 0 && index < images.count else {
            return nil
        }
        
        let vc = KLImageViewController(index: index, imageContentMode: UIView.ContentMode.scaleAspectFill)
        let image = images[index]
        vc.imageView.image = image
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        vc.imageView.addGestureRecognizer(tap)
        vc.imageView.isUserInteractionEnabled = true
        return vc
    }
}
