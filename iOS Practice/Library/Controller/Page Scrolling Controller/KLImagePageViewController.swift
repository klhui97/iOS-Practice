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
        case autoInfinite
        case normal
    }
    
    var images: [UIImage] = [] {
        didSet {
            if let vc = initImageViewController(at: 0) {
                setViewControllers([vc], direction: .forward, animated: false, completion: nil)
            }
        }
    }
    
    private var autoScrollTimer: Timer?
    private var mode: ScrollMode = .normal
    
    // Auto scroll config
    private let autoScrollTimeInterval: TimeInterval = 3
    
    // MARK: - Init
    
    init(mode: ScrollMode, images: [UIImage]) {
        self.mode = mode
        self.images = images
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit")
    }
    
    // MARK: - Life cycle
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // To make sure the memory can be free
        disableAutoScrollTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vc = initImageViewController(at: 0) {
            setViewControllers([vc], direction: .forward, animated: false, completion: nil)
        }
        
        title = "Infinte images scroll"
        startAutoScrollTimer()
        
        dataSource = self
        delegate = self
    }
    
    @objc func didTapImage() {
        print("didTapImage")
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? KLImageViewController else { return nil}
        
        let index = viewController.index - 1
        
        if index >= 0 && mode == .normal {
            return nil
        }
        
        if let nextIndex = getVaildScrollIndex(target: index) {
            return initImageViewController(at: nextIndex)
        }else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? KLImageViewController else { return nil}
        
        let index = viewController.index + 1
        
        if index >= images.count && mode == .normal {
            return nil
        }
        
        if let nextIndex = getVaildScrollIndex(target: index) {
            return initImageViewController(at: nextIndex)
        }else {
            return nil
        }
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        disableAutoScrollTimer()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let vc = pageViewController.viewControllers?[0] as? KLImageViewController {
            print("Scrolled to \(vc.index)")
        }
        startAutoScrollTimer()
    }
}

private extension KLImagePageViewController {
    
    func initImageViewController(at index: Int) -> KLImageViewController? {
        guard images.count > 0 && index >= 0 && index < images.count else { return nil }
        
        let vc = KLImageViewController(index: index, imageContentMode: UIView.ContentMode.scaleAspectFill)
        vc.imageView.image = images[vc.index]
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        vc.imageView.addGestureRecognizer(tap)
        vc.imageView.isUserInteractionEnabled = true
        
        return vc
    }
    
    // MARK: - Auto scroll
    
    func startAutoScrollTimer() {
        disableAutoScrollTimer()
        guard mode == .autoInfinite, images.count > 1 else { return }
        autoScrollTimer = Timer(timeInterval: autoScrollTimeInterval, target: self, selector: #selector(autoScrollTimerFire), userInfo: nil, repeats: true)
        if let autoScrollTimer = autoScrollTimer {
            RunLoop.main.add(autoScrollTimer, forMode: RunLoopMode.commonModes)
        }
    }
    
    @objc func autoScrollTimerFire() {
        if let currentVc = viewControllers?[0] as? KLImageViewController, let index = getVaildScrollIndex(target: currentVc.index + 1), let newVc = initImageViewController(at: index) {
            setViewControllers([newVc], direction: .forward, animated: true, completion: nil)
        }
        print("autoScrollTimerFire")
    }
    
    func disableAutoScrollTimer() {
        if autoScrollTimer != nil {
            autoScrollTimer?.invalidate()
            autoScrollTimer = nil
        }
    }
    
    private func getVaildScrollIndex(target index: Int) -> Int? {
        guard images.count > 0 else { return nil }
        
        if index < 0 {
            return images.count - 1
        }else if (index >= images.count) {
            return 0
        }else {
            return index
        }
    }
}
