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
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreButton.makeRound(to: 6)
    }
}
