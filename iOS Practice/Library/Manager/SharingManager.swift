//
//  SharingManager.swift
//  Big2Scorer
//
//  Created by KL on 6/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class SharingManager {
    
    static func shareApp(controller: UIViewController, soureView: UIView, appUrl: String) {
        guard let activityItem = URL(string: appUrl.urlEncoded()) else { return }
        
        let objectsToShare: [Any] = [activityItem]
        let vc = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        vc.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        vc.popoverPresentationController?.sourceView = soureView
        controller.present(vc, animated: true, completion: nil)
    }
}
