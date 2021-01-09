//
//  MoreTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/01.
//

import UIKit

class MoreTVC: UITableViewCell {
    static let identifier: String = "MoreTVC"
    
    @IBOutlet weak var moreButton: UIButton!
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreButton.makeRound(to: 6)
    }
    
    @IBAction func moreAnswerButtonTapped(_ sender: UIButton) {
        delegate?.exploreMoreAnswersButtonDidTapped()
    }
}
