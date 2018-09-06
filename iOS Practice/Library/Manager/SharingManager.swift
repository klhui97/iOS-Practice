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
        guard let ActivityItem = URL(string: appUrl.urlEncoded()) else { return }
        
        let objectsToShare: [Any] = [ActivityItem]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        activityVC.popoverPresentationController?.sourceView = soureView
        controller.present(activityVC, animated: true, completion: nil)
    }
}
