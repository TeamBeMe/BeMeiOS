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
    
    weak var delegate: UICollectionViewButtonDelegate?
    
    var questionId: Int?
    
    var answerId: Int?
    
    var indexPath: IndexPath?
    
    func setQuestionAnswer(_ que: String, _ ans: String, answerId: Int, questionId: Int) {
        question.text = que
        answer.text = ans
        self.answerId = answerId
        self.questionId = questionId
    }
    
    @IBAction func goToDetailButtonTapped(_ sender: Any) {
        
        delegate?.goToOneQuestionMoreAnswerButtonDidTapped(questionId!, question: question.text!)
    }
    @IBAction func goToAnswerDetailButtonTapped(_ sender: Any) {
        delegate?.goToAnswerDetailButtonDidTapped(answerId!)
    }
}
