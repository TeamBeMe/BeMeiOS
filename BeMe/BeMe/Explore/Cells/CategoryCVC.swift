//
//  DiffCategoryCell.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/01.
//

import UIKit

class CategoryCVC: UICollectionViewCell {
    static let identifier: String = "CategoryCVC"
    @IBOutlet weak var name: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .black
                name.textColor = .white
            } else {
                backgroundColor = .white
                name.textColor = .black
            }
        }
    }
}
