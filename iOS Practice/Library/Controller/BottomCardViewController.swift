//
//  BottomCardViewController.swift
//  iOS Practice
//
//  Created by david.hui on 6/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class BottomCardViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval {
        return 0.3
    }
    let contentView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        view.backgroundColor = .white
        return view
    }()
    
    private let dimView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        return view
    }()
    private var contentViewStartConstraint: NSLayoutConstraint!
    private var contentViewEndConstraint: NSLayoutConstraint!
    private var contentViewEndViewBottomConstraint: NSLayoutConstraint!
    private var presenting = true
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .overCurrentContext
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        
        
        view.add(dimView)
        dimView.al_fillSuperview()
        dimView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDimView)))
        
        view.add(contentView)
        
        let views = ["contentView": contentView]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-8-[contentView]-8-|", options: [], metrics: nil, views: views))
        if #available(iOS 11.0, *) {
            contentView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            
            contentViewEndConstraint = contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 2)
            contentViewEndConstraint.priority = .defaultHigh
            
            contentViewEndViewBottomConstraint = contentView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -8)
            contentViewEndViewBottomConstraint.priority = .required
            contentViewEndViewBottomConstraint.isActive = true
        }
        else {
            contentView.topAnchor.constraint(greaterThanOrEqualTo: topLayoutGuide.bottomAnchor).isActive = true
            contentViewEndConstraint = NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -8)
        }
        contentViewStartConstraint = NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        contentViewEndConstraint.isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentingViewController?.view.tintAdjustmentMode = .dimmed
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.view.tintAdjustmentMode = .normal
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return presentingViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presenting = false
        return self
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if presenting {
            let containerView = transitionContext.containerView
            
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
            containerView.addSubview(toView)
            
            dimView.alpha = 0
            contentViewEndConstraint.isActive = false
            contentViewEndViewBottomConstraint?.isActive = false
            contentViewStartConstraint.isActive = true
            view.layoutIfNeeded()
            
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
                self.dimView.alpha = 1
                self.contentViewStartConstraint.isActive = false
                self.contentViewEndConstraint.isActive = true
                self.contentViewEndViewBottomConstraint?.isActive = true
                self.view.layoutIfNeeded()
            })
            animator.addCompletion({ (_) in
                transitionContext.completeTransition(true)
            })
            animator.startAnimation()
        }
        else{
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
                self.dimView.alpha = 0
                self.contentViewEndConstraint.isActive = false
                self.contentViewEndViewBottomConstraint?.isActive = false
                self.contentViewStartConstraint.isActive = true
                self.view.layoutIfNeeded()
            })
            animator.addCompletion({ (_) in
                transitionContext.completeTransition(true)
                //                let toView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
                //                toView.removeFromSuperview()
            })
            animator.startAnimation()
        }
    }
    
    // MARK: -
    
    @objc func didTapDimView() {
        dismiss(animated: true, completion: nil)
    }
}
