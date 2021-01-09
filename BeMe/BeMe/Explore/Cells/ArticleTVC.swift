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
    
    lazy var isScrapped: Bool = false
    
    @IBOutlet weak var answerCardView: UIView!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        answerCardView.setBorderWithRadius(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
        answerTextView.font = UIFont(name: "AppleSDGothicNeo-Light", size: 14.0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setCardDatas(que: String, date: String, cate: String, content: String, profileImage: String?, nick: String) {
        
        question.text = que
        subTitle.text = "[  \(cate)에 관한 질문  ]  ·  \(date)"
        answerTextView.text = content
        nickNameLabel.text = nick
        
        if let pi = profileImage {
            if pi == "" {
                profileImageView.image = UIImage(named: "imgProfile")
            } else {
                let url = URL(string: pi)
                profileImageView.kf.setImage(with: url)
            }
        } else {
            
        }
        
    }
    
    
    //MARK: - IBAction
    @IBAction func scrapButtonTapped(_ sender: UIButton) {
        
        if isScrapped {
            isScrapped = false
            sender.setImage(UIImage.init(named: "btnScrapUnselected"), for: .normal)
        } else {
            isScrapped = true
            sender.setImage(UIImage.init(named: "btnScrapSelected"), for: .normal)
        }
        
    }
    
    @IBAction func goToDetailExploreVC(_ sender: UIButton) {
        print("?????????????뭐지")
    }
}
