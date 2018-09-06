//
//  PopUpCollectionViewCell.swift
//  iOS Practice
//
//  Created by david.hui on 6/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class PopUpCollectionViewCell: UICollectionViewCell {
    
    enum PopUpType: String {
        case buttonAlert = "buttonAlert"
        case pickerView = "pickerView"
    }
    
    var type: PopUpType? {
        didSet {
            button.setTitle(type?.rawValue, for: UIControlState())
        }
    }
    let button = AnimatedButton()
    var controller: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.add(button)
        button.al_fillSuperview()
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonOnClicked), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonOnClicked() {
        guard let type = type else { return }
        switch type {
        case .buttonAlert:
            if let view = controller?.view {
                KLAlertViewManager.shared.showBottomAlert(target: view, text: "hi")
            }
        case .pickerView:
            let vc = PickerViewController(items: ["1", "2", "3"], selectedIndex: 0, didSelectAtIndexCallback: { (selectedIndex) in
            })
            vc.callbackImmediatelyWhenValueChange = false
            controller?.present(vc, animated: true, completion: nil)
        }
    }
}
