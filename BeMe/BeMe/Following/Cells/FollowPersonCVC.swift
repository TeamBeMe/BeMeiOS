//
//  FollowPersonCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowPersonCVC: UICollectionViewCell {
    static let identifier : String = "FollowPersonCVC"

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        profileImageView.tintColor = .black
        
    }
    
    
    func setProfile(userName : String,profileImageURL: String){
        userNameLabel.text = userName
        if userName == "Follower"{
            profileImageView.tintColor = .systemBlue
        }
        else{
            profileImageView.tintColor = .black
        }
        profileImageView.imageFromUrl(profileImageURL, defaultImgPath: "")
        
    }
    
    
}
