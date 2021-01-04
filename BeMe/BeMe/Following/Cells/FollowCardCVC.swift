//
//  FollowCardCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowCardCVC: UICollectionViewCell {
    static let identifier : String = "FollowCardCVC"
    
    @IBOutlet weak var containView: UIView!
    
    @IBOutlet weak var questionInfoLabel: UILabel!
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var moreButotn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var bookMarkButton: UIButton!
    
    
    
    override func awakeFromNib() {
        containView.setBorder(borderColor: .lightGray, borderWidth: 1.0)
        containView.makeRounded(cornerRadius: 6)
        answerTextView.delegate = self
        answerTextView.translatesAutoresizingMaskIntoConstraints = false
        answerTextView.isScrollEnabled = false
        questionTextView.delegate = self
        questionTextView.translatesAutoresizingMaskIntoConstraints = false
        questionTextView.isScrollEnabled = false
        
//        answerTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        questionTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        
        
        
    }
    
    func setItems(question: String,answer: String){
        answerTextView.text = answer
        questionTextView.text = question


    }
    

    
    
    
}

extension FollowCardCVC : UITextViewDelegate{
    
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
