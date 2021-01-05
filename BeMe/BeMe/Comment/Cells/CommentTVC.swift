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
    @IBOutlet weak var contentTextViewHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentTextViewHeight.constant = contentTextView.contentSize.height
     
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
