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
    
    var answerData: FollowingAnswers?
    var replyButton = UIButton().then {
        $0.backgroundColor = .black
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.makeRounded(cornerRadius: 5)
        
    }
    
    
    override func awakeFromNib() {
        containView.setBorder(borderColor: .lightGray, borderWidth: 1.0)
        containView.makeRounded(cornerRadius: 6)
        answerTextView.delegate = self
        answerTextView.translatesAutoresizingMaskIntoConstraints = false
        answerTextView.isScrollEnabled = false
        questionTextView.delegate = self
        questionTextView.translatesAutoresizingMaskIntoConstraints = false
        questionTextView.isScrollEnabled = false
        profileImageView.makeRounded(cornerRadius: 17)
        profileImageView.contentMode = .scaleAspectFill
//        answerTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        questionTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
        
        
        
    }
    
    func setItems(question: String,answer: String,category: String,answerTime: String,
                  profileImgUrl: String,userName: String,isAnswered: Bool){
        
        questionTextView.text = question
        timeLabel.text = answerTime
        
        profileImageView.imageFromUrl(profileImgUrl, defaultImgPath: "")
        userNameLabel.text = userName
        questionInfoLabel.text = "[  \(category)에 관한 질문  ]  ·"
        questionInfoLabel.textColor = .slateGrey
        timeLabel.textColor = .slateGrey
        answerTextView.text = answer
//        if isAnswered == false {
//            answerTextView.text = "아직 송현님이 답하지 않은 질문입니다.\n답변을 하시고 글을 보시겠습니까?"
//            
//            
//        }
//        else{
//            answerTextView.text = answer
//        }
        
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
