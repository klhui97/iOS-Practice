//
//  ValidatorManager.swift
//  iOS Practice
//
//  Created by KL on 31/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

class ValidatorHelper {
    
    public static func isValidatedEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: email) {
            return true
        }
        return false
    }
}
