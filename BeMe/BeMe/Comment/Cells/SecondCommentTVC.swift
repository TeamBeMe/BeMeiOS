//
//  SecondeCommentTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/05.
//

import UIKit

class SecondCommentTVC: UITableViewCell {
    static let identifier: String = "SecondCommentTVC"
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    
    var delegate: UITableViewButtonSelectedDelegate?
    
    var indexPath: IndexPath?

    var isAuthor: Bool?
    
    var commentId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        contentTextViewHeight.constant = contentTextView.contentSize.height
    }

    func setInformation(profileImage: String, nickName: String, content: String, date: String, isVisible: Bool, publicFlag: Bool, isAuthor: Bool, commentId: Int) {
        if isVisible {
            if profileImage == "" {
                profileImageView.image = UIImage.init(named: "imgProfile")
            } else {
                let url = URL(string: profileImage)
                profileImageView.kf.setImage(with: url)
            }
            nickNameLabel.text = nickName
            contentTextView.text = content
            dateLabel.text = date
            lockImageView.isHidden = publicFlag
            settingButton.isHidden = false
        } else {
            profileImageView.isHidden = true
            nickNameLabel.text = "익명"
            contentTextView.text = "비공개 댓글입니다."
            dateLabel.text = date
            lockImageView.isHidden = true
            settingButton.isHidden = true
        }
        
        self.isAuthor = isAuthor
        self.commentId = commentId
    }

    @IBAction func settingButtonTapped(_ sender: Any) {
        delegate?.settingButtonDidTapped(to: indexPath!, isAuthor: isAuthor!, commentId: commentId!, content: contentTextView.text!)
    }
}
