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
    var followingPerson: FollowingFollows?
    var findPeopleSearchData: FindPeopleSearchData?
    
    override func awakeFromNib() {
        profileImageView.imageFromUrl(followingPerson?.profileImg, defaultImgPath: "")
        profileImageView.makeRounded(cornerRadius: 18)
        userNameLabel.text = followingPerson?.nickname
        followButton.setTitle("팔로잉", for: .normal)
        followButton.tintColor = .black
        followButton.makeRounded(cornerRadius: 3)
        followButton.setBorder(borderColor: .lightGray, borderWidth: 1.0)
        profileImageView.contentMode = .scaleAspectFill
        
    }
    
    @IBAction func followButtonAction(_ sender: Any) {
        if followButton.titleLabel?.text == "팔로잉"{

            FollowingFollowService.shared.follow(id: followingPerson!.id!){(networkResult) -> (Void) in
                switch networkResult{
                case .success(let data) :
                    print("success")
                    self.followButton.setTitle("팔로우", for: .normal)
                    self.followButton.backgroundColor = .black
                    self.followButton.setTitleColor(.white, for: .normal)
                    
                    
                    
                    
                case .requestErr(let msg):
                    if let message = msg as? String {
                        print(message)
                    }
                case .pathErr :
                    print("pathErr")
                case .serverErr :
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
                    
                }
                

            }
            
        }
        else {
            FollowingFollowService.shared.follow(id: followingPerson!.id!){(networkResult) -> (Void) in
                switch networkResult{
                case .success(let data) :
                    print("success")
                    self.followButton.setTitle("팔로잉", for: .normal)
                    self.followButton.backgroundColor = .white
                    self.followButton.setTitleColor(.black, for: .normal)
                    
                    
                    
                    
                case .requestErr(let msg):
                    if let message = msg as? String {
                        print(message)
                    }
                case .pathErr :
                    print("pathErr")
                case .serverErr :
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
                    
                }
                

            }
            
        }
    }
    
    func setItems(){
        profileImageView.imageFromUrl(followingPerson?.profileImg, defaultImgPath: "")
        userNameLabel.text = followingPerson?.nickname
        
    }
    
    func setSearchedItem(){
        profileImageView.imageFromUrl(findPeopleSearchData?.profileImg, defaultImgPath: "")
        userNameLabel.text = findPeopleSearchData?.nickname
    }
    
    
    
}
