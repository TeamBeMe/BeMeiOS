//
//  EmptyThoughtCVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/09.
//

import UIKit

class EmptyThoughtCVC: UICollectionViewCell {
    static let identifier: String = "EmptyThoughtCVC"
    
    @IBOutlet weak var todayButton: UIButton!
    
    weak var delegate: UICollectionViewButtonDelegate?
    
    @IBAction func goToTodayAnswerButtonTapped(_ sender: Any) {
        delegate?.goToTodayAnswerButtonDidTapped()
    }
}
