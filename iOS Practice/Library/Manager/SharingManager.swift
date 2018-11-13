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
        let activityVc = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVc.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        activityVc.popoverPresentationController?.sourceView = soureView
        controller.present(activityVc, animated: true, completion: nil)
    }
}
