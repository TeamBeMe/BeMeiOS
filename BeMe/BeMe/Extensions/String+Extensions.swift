//
//  String+Extensions.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import Foundation
extension String {
    func isValidEmailAddress() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    func isValidPassword() -> Bool {

        let regEx = "(?=.*[A-Za-z])(?=.*[0-9]).{8,20}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        
        return pred.evaluate(with: self)
    }
    
    func isValidNickName() -> Bool {
        let regEx = "[A-Za-z0-9]*"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        
        return pred.evaluate(with: self)
    }
    
}
