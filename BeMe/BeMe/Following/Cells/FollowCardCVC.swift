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
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var bookMarkButton: UIButton!
    var indexInVC: Int?
    var followScrapButtonDelegate: FollowScrapButtonDelegate?
    var answerData: FollowingAnswers?
    var isScrapped: Bool?
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
        
        let containTabGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpContainView))
        containView.addGestureRecognizer(containTabGesture)
        profileImageView.isUserInteractionEnabled = true
        
        let profileTabGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpProfile))
        profileImageView.addGestureRecognizer(profileTabGesture)
        print("aaaaaaa")
        
        let labelTabGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpProfile))
        userNameLabel.isUserInteractionEnabled = true
        userNameLabel.addGestureRecognizer(labelTabGesture)
        
        
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
        
        if answerData?.isScrapped == false{
            bookMarkButton.setImage(UIImage(named: "btnScrapUnselected"), for: .normal)
        }
        else{
            bookMarkButton.setImage(UIImage(named: "btnScrapSelected"), for: .normal)
        }
        
        
        
    }
    

    @IBAction func scrapButtonTapped(_ sender: Any) {
        
//        if (answerData?.isScrapped)! {
//            bookMarkButton.setImage(UIImage(named: "btnScrapUnselected"), for: .normal)
//        }
//        else{
//            bookMarkButton.setImage(UIImage(named: "btnScrapSelected"), for: .normal)
//        }
        followScrapButtonDelegate?.scrapButtonAction(answerID: (answerData?.id)!,
                                                     wasScrapped: (answerData?.isScrapped)!,
                                                     indexInVC: indexInVC!
                                                     )
        
    }
    
    @objc func touchUpContainView(){
        
        followScrapButtonDelegate?.containViewTap(answerID: (answerData?.id)!)
    }
    
    
    @IBAction func moreButtonAction(_ sender: Any) {
        followScrapButtonDelegate?.moreButtonTap(questionID: (answerData?.questionID)!,
                                                 question: (answerData?.question)!)
    }
    
    @objc func touchUpProfile(){
        print("callllllllllllll")
        followScrapButtonDelegate?.profileSelectedTap(userID: (answerData?.userID)!)
        
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


extension FollowCardCVC: FollowingToScrapDelegate {
    func setScrap(wasScrapped: Bool) {
        if wasScrapped{
            bookMarkButton.setImage(UIImage(named: "btnScrapUnselected"), for: .normal)
        }
        else{
            bookMarkButton.setImage(UIImage(named: "btnScrapSelected"), for: .normal)
        }
        
    }
}


protocol FollowingToScrapDelegate{
    func setScrap(wasScrapped: Bool)
    
}


extension FollowingToScrapDelegate {
    func setScrap(wasScrapped: Bool) {}
   
}
