//
//  DiffThoughtCVC.swift
//  BeMe
//
//  Created by 이재용 on 2020/12/31.
//

import UIKit

class DiffThoughtCVC: UICollectionViewCell {
    static let identifier: String = "DiffThoughtCVC"
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UITextView!
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    var indexPath: IndexPath?
    
    func setQuestionAnswer(_ que: String, _ ans: String) {
        question.text = que
        answer.text = ans
    }
    
    @IBAction func goToDetailButtonTapped(_ sender: Any) {
        delegate?.moreAnswerButtonDidTapped(to: indexPath!)
    }
}
