//
//  DiffArticleTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/01.
//

import UIKit
import Kingfisher

class ArticleTVC: UITableViewCell {
    static let identifier: String = "ArticleTVC"
    
    @IBOutlet weak var answerCardView: UIView!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var scrapButton: UIButton!
    
    lazy var isScrapped: Bool = false
    
    var answerId: Int?
    
    var questionId: Int?
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        answerCardView.setBorderWithRadius(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
        answerTextView.font = UIFont(name: "AppleSDGothicNeo-Light", size: 14.0)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setCardDatas(que: String, date: String, cate: String, content: String, profileImage: String?, nick: String, isScrap: Bool, answerId: Int, questionId: Int) {
        
        question.text = que
        subTitle.text = "[  \(cate)에 관한 질문  ]  ·  \(date)"
        answerTextView.text = content
        nickNameLabel.text = nick
        isScrapped = isScrap
        self.answerId = answerId
        self.questionId = questionId
        
        if isScrapped {
            scrapButton.setImage(UIImage.init(named: "btnScrapSelected"), for: .normal)
            
        } else {
            scrapButton.setImage(UIImage.init(named: "btnScrapUnselected"), for: .normal)
        }
        
        if let pi = profileImage {
            if pi == "" {
                profileImageView.image = UIImage(named: "imgProfile")
            } else {
                let url = URL(string: pi)
                profileImageView.kf.setImage(with: url)
            }
        }
    }
    
    
    //MARK: - IBAction
    @IBAction func scrapButtonTapped(_ sender: UIButton) {
        
        print(isScrapped)
        if isScrapped {
            isScrapped = false
            sender.setImage(UIImage.init(named: "btnScrapUnselected"), for: .normal)
        } else {
            isScrapped = true
            sender.setImage(UIImage.init(named: "btnScrapSelected"), for: .normal)
        }
        
        delegate?.exploreAnswerScrapButtonDidTapped(answerId!)
    }
    
    @IBAction func goToDetailExploreVC(_ sender: UIButton) {
        
        delegate?.goToMoreAnswerButtonDidTapped(questionId: questionId!, question: question.text!)
    }
    
    @IBAction func goToAnswerDetailButtonTapped(_ sender: Any) {
        
        delegate?.goToCommentButtonTapped(answerId!)
    }
    
}
