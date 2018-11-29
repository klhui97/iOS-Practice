//
//  VersionHelper.swift
//  Big2Scorer
//
//  Created by KL on 6/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

class VersionHelper {
    
    static var versionString: String {
        guard let dictionary = Bundle.main.infoDictionary, let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }
    
    static var fullVersionString: String {
        guard let dictionary = Bundle.main.infoDictionary, let version = dictionary["CFBundleVersion"] as? String else { return "" }
        return versionString + "." + version
    }
}
