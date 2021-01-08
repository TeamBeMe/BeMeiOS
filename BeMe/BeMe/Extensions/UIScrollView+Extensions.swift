//
//  UIScrollView+Extensions.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/07.
//

import UIKit

extension UIScrollView {
    
    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
           self.contentInset = edgeInsets
           self.scrollIndicatorInsets = edgeInsets
    }
}
