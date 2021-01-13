//
//  AlarmMoreTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/12.
//

import UIKit

class AlarmMoreTVC: UITableViewCell {
    static let identifier: String = "AlarmMoreTVC"
    @IBOutlet weak var moreBiutton: UIButton!
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moreBiutton.makeRound(to: 4.0)
    }
    @IBAction func moreButtonTapped(_ sender: Any) {
        
        delegate?.exploreMoreAnswersButtonDidTapped()
    }
}
