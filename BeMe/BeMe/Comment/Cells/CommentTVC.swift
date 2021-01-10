//
//  CommentTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/05.
//

import UIKit

class CommentTVC: UITableViewCell {
    static let identifier: String = "CommentTVC"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var moreCommentLabel: UILabel!
    @IBOutlet weak var moreImageView: UIImageView!
    @IBOutlet weak var moreCommentView: UIView!
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    var indexPath: IndexPath?
    
    var commentId: Int?
    
    var isAuthor: Bool?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setInformations(profileImage: String, nickName: String, publicFlag: Bool, isVisible: Bool ,content: String, date: String, commentId: Int, isAuthor: Bool) {
        
        self.commentId = commentId
        self.isAuthor = isAuthor
        if isVisible {
            if profileImage == "" {
                profileImageView.image = UIImage.init(named: "imgProfile")
            } else {
                let url = URL(string: profileImage)
                profileImageView.kf.setImage(with: url)
            }
            
            nickNameLabel.text = nickName
            lockImageView.isHidden = publicFlag
            contentTextView.text = content
            dateLabel.text = date
        } else {
            profileImageView.isHidden = true
            nickNameLabel.text = "익명"
            lockImageView.isHidden = publicFlag
            contentTextView.text = content
            dateLabel.text = date
        }
        
    }

    @IBAction func moreCommentButtonTapped(_ sender: UIButton) {
        
        delegate?.moreCellButtonDidTapped(to: indexPath!, isSecret: 0)
    }
    
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        
        delegate?.settingButtonDidTapped(to: indexPath!, isAuthor: isAuthor!)
    }
    
    @IBAction func sendAnswerButtonTapped(_ sender: UIButton) {
        
        delegate?.sendCommentButtonDidTapped(to: indexPath!, nickName: nickNameLabel.text!,  parentId: commentId!)
    }
}
