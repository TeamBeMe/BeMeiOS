//
//  UITableView+Extensions.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/03.
//

import UIKit

extension UITableView {
    
    // Dynamic Cell Height : 테이블뷰 셀의높이를 동적으로 구성하고 싶을때의 기본 설정
    func setDynamicCellHeight(to def: CGFloat = 200) {
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = def;
    }
    
}
