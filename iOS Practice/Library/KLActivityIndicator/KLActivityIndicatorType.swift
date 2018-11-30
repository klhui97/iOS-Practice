//
//  KLActivityIndicatorType.swift
//  iOS Practice
//
//  Created by KL on 31/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

public enum KLActivityIndicatorView {
    case threeBallPulse
    case ballGridPulse
    case ballClipRotate
    case squareSpin
    
    func animation() -> KLActivityIndicatorAnimationDelegate {
        switch self {
        case .threeBallPulse:
            return KLActivityIndicatorThreeBallPulse()
        case .ballGridPulse:
            return KLActivityIndicatorBallGridPulse()
        case .ballClipRotate:
            return KLActivityIndicatorAnimationBallClipRotate()
        case .squareSpin:
            return KLActivityIndicatorAnimationSquareSpin()
        }
    }
    
}
