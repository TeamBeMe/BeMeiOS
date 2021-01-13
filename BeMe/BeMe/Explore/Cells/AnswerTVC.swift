//
//  AnswerTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/03.
//

import UIKit


class AnswerTVC: UITableViewCell {
    static let identifier: String = "AnswerTVC"
    
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var scrapButton: UIButton!
    
    private var isScrapped: Bool = false
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    var indexPath: IndexPath?
    
    var answerId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.makeRounded(cornerRadius: profileImageView.bounds.width / 2)
        answerView.setBorderWithRadius(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
        answerView.makeRounded(cornerRadius: 8.0)
    }

    func setCardDatas(date: String, cate: String, content: String, profileImage: String?, nick: String, isScrap: Bool, answerId: Int, questionId: Int) {
        
        subTitleLabel.text = "[  \(cate)에 관한 질문  ]  ·  \(date)"
        answerTextView.text = content
        nickNameLabel.text = nick
        isScrapped = isScrap
        self.answerId = answerId
        
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
    
    @IBAction func scrapButtonTapped(_ sender: UIButton) {
        
        delegate?.exploreAnswerScrapButtonDidTapped(answerId!)
        if isScrapped {
            isScrapped = false
            sender.setImage(UIImage.init(named: "btnScrapUnselected"), for: .normal)
        } else {
            isScrapped = true
            sender.setImage(UIImage.init(named: "btnScrapSelected"), for: .normal)
        }
    }
    
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        
        delegate?.settingButtonDidTapped(to: indexPath!, isAuthor: false, commentId: 0, content: "")
    }
    
    
    @IBAction func goToCommentButtonTapped(_ sender: Any) {
        
        delegate?.goToCommentButtonTapped(answerId!)
    }
    
}
