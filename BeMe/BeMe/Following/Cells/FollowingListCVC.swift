//
//  FollowingListCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowingListCVC: UICollectionViewCell {
    static let identifier : String = "FollowingListCVC"
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    override func awakeFromNib() {
        profileImageView.tintColor = .black
        userNameLabel.text = "Following"
        followButton.setTitle("팔로잉", for: .normal)
        followButton.tintColor = .black
        followButton.makeRounded(cornerRadius: 3)
        followButton.setBorder(borderColor: .lightGray, borderWidth: 1.0)
        
        
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
