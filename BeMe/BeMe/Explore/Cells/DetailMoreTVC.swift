//
//  DetailMoretVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/03.
//

import UIKit

class DetailMoreTVC: UITableViewCell {
    static let identifier: String = "DetailMoreTVC"
    
    @IBOutlet weak var moreButton: UIButton!
    
    weak var delegate: UITableViewButtonSelectedDelegate?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreButton.makeRound(to: 6.0)
    }

    @IBAction func moreButtonTapped(_ sender: Any) {
        delegate?.exploreMoreAnswersButtonDidTapped()
    }
}
