//
//  FollowNotAnsweredCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/13.
//

import UIKit

class FollowNotAnsweredCVC: UICollectionViewCell {
    static let identifier : String = "FollowNotAnsweredCVC"
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var answerDateLabel: UILabel!
    
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var answerTextView: UITextView!
    
    @IBOutlet weak var replyButton: UIButton!
    var answerData: FollowingAnswers?
    
    override func awakeFromNib() {
        containView.setBorder(borderColor: .lightGray, borderWidth: 1.0)
        containView.makeRounded(cornerRadius: 6)
        answerTextView.delegate = self
        answerTextView.translatesAutoresizingMaskIntoConstraints = false
        answerTextView.isScrollEnabled = false
        questionTextView.delegate = self
        questionTextView.translatesAutoresizingMaskIntoConstraints = false
        questionTextView.isScrollEnabled = false
       
        
        
        
    }
    
    func setItems(inputAnswer: FollowingAnswers){
        
        questionTextView.text = inputAnswer.question
        answerDateLabel.text = inputAnswer.answerDate
      
        categoryLabel.text = "[  \(inputAnswer.category)에 관한 질문  ]  ·"
        categoryLabel.textColor = .slateGrey
        answerDateLabel.textColor = .slateGrey
        answerTextView.text = "아직 송현님이 답하지 않은 질문입니다.\n답변을 하시고 글을 보시겠습니까?"

        
        
    }
    

    
    
    
}

extension FollowNotAnsweredCVC : UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width,height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
                textView.snp.makeConstraints{
                    $0.height.equalTo(estimatedSize.height)
                }

            }
            
            
        }
    }
    
}
