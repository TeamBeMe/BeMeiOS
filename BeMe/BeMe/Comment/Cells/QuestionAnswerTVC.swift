//
//  QuestionAnswerTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/06.
//

import UIKit

class QuestionAnswerTVC: UITableViewCell {
    static let identifier: String = "QuestionAnswerTVC"
   
    @IBOutlet weak var moreAnswerButton: UIButton!
    @IBOutlet weak var profileView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    var indexPath: IndexPath?
    
    var questionId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moreAnswerButton.makeRound(to: 4)
        profileImageView.makeRounded(cornerRadius: profileImageView.bounds.width)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInformation(question: String, category: String, date: String, profileImg: String, nickName: String, content: String, questionId: Int) {
        questionLabel.text = question
        categoryLabel.text = "[  \(category)에 관한 질문  ]"
        dateLabel.text = date
        if profileImg == "" {
            profileImageView.image = UIImage(named: "imgProfile")
        } else {
            let url = URL(string: profileImg)
            profileImageView.kf.setImage(with: url)
        }
        nickNameLabel.text = nickName
        answerTextView.text = content
        self.questionId = questionId
    }
    
    
    @IBAction func moreAnswerButtonTapped(_ sender: UIButton) {
        
        delegate?.goToMoreAnswerButtonDidTapped(questionId: questionId!, question: questionLabel.text!)
        
    }
    
}
