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
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreButton.makeRound(to: 6.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
