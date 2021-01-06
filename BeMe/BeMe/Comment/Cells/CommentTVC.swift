//
//  CommentTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/05.
//

import UIKit

class CommentTVC: UITableViewCell {
    static let identifier: String = "CommentTVC"
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var moreCommentLabel: UILabel!
    @IBOutlet weak var moreImageView: UIImageView!
    @IBOutlet weak var moreCommentView: UIView!
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func moreCommentButtonTapped(_ sender: UIButton) {
        
        delegate?.moreCellButtonDidTapped(to: indexPath!)
    }
    
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        
        delegate?.settingButtonDidTapped(to: indexPath!)
    }
    
    @IBAction func sendAnswerButtonTapped(_ sender: UIButton) {
        
        delegate?.sendCommentButtonDidTapped(to: indexPath!)
    }
}
