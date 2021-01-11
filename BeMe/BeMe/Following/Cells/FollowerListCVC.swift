//
//  FollowerListCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowerListCVC: UICollectionViewCell {
    static let identifier : String = "FollowerListCVC"
    var followerPerson: FollowingFollows?
    var findPeopleSearchData: FindPeopleSearchData?
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        userNameLabel.text = followerPerson?.nickname
        profileImageView.imageFromUrl(followerPerson?.profileImg, defaultImgPath: "")
        moreButton.tintColor = .black
        profileImageView.makeRounded(cornerRadius: 18)
        profileImageView.contentMode = .scaleAspectFill
        
    }
    
    func setItems(){
        profileImageView.imageFromUrl(followerPerson?.profileImg, defaultImgPath: "")
        userNameLabel.text = followerPerson?.nickname
        
    }
    func setSearchedItem(){
        profileImageView.imageFromUrl(findPeopleSearchData?.profileImg, defaultImgPath: "")
        userNameLabel.text = findPeopleSearchData?.nickname
    }
    
}
