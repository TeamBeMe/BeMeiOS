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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
