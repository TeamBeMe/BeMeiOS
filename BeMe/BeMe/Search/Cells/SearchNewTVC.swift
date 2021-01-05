//
//  SearchNewTVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import UIKit

class SearchNewTVC: UITableViewCell {

    static let identifier = "SearchNewTVC"
    @IBOutlet weak var followButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        followButton.setTitle("팔로잉", for: .normal)
        followButton.tintColor = .black
        followButton.makeRounded(cornerRadius: 3)
        followButton.setBorder(borderColor: .lightGray, borderWidth: 1.0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func followButtonAction(_ sender: Any) {
        if followButton.titleLabel?.text == "팔로잉"{
            followButton.setTitle("팔로우", for: .normal)
            followButton.backgroundColor = .black
            followButton.setTitleColor(.white, for: .normal)
            
        }
        else {
            followButton.setTitle("팔로잉", for: .normal)
            followButton.backgroundColor = .white
            followButton.setTitleColor(.black, for: .normal)
            
        }
        
    }
    
    
}
