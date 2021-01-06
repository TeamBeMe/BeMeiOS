//
//  UITableViewButtonSelectedDelegate.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/06.
//

import Foundation

protocol UITableViewButtonSelectedDelegate: class {
    func settingButtonDidTapped()
    
    func moreCellButtonDidTapped(to indexPath: IndexPath)
    
    func moreAnswerButtonDidTapped(to indexPath: IndexPath)
}

extension UITableViewButtonSelectedDelegate {
    func settingButtonDidTapped() {}
    
    func moreCellButtonDidTapped(to: IndexPath) {}
    
    func moreAnswerButtonDidTapped(to indexPath: IndexPath) {}
}
