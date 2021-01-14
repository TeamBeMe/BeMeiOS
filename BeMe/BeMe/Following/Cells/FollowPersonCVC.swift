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
    var followingFollows: FollowingFollows?
    
    var personToPeopleDelegate: PersonToPeopleDelegate?
    override func awakeFromNib() {
        profileImageView.tintColor = .black
       
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.isUserInteractionEnabled = true
        let profileTabGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpProfile))
        profileImageView.addGestureRecognizer(profileTabGesture)
        
        profileImageView.makeRounded(cornerRadius: 29)
//        profileImageView.dropShadow(color: .black, offSet: CGSize(width: 0, height:15), opacity: 1.0, radius: 50)
        
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
    
    @objc func touchUpProfile(){

        personToPeopleDelegate?.med(userID: (followingFollows?.id)!)
        
        
        
    }
    
}



