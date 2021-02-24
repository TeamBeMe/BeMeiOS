//
//  SearchNewTVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import UIKit
import Firebase
class SearchNewTVC: UITableViewCell {

    static let identifier = "SearchNewTVC"
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    var findPeopleSearchData: FindPeopleSearchData?
    var followSearchProfileDelegate: FollowSearchProfileDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        followButton.setTitle("팔로잉", for: .normal)
        followButton.tintColor = .black
        followButton.makeRounded(cornerRadius: 3)
        followButton.setBorder(borderColor: .lightGray, borderWidth: 1.0)
        profileImageView.makeRounded(cornerRadius: 18)
        profileImageView.contentMode = .scaleAspectFill
        
        profileImageView.isUserInteractionEnabled = true
        let profileTabGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpProfile))
        profileImageView.addGestureRecognizer(profileTabGesture)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func followButtonAction(_ sender: Any) {
        
        
        if followButton.titleLabel?.text == "팔로잉"{
            FirebaseAnalytics.Analytics.logEvent("FOLLOW_SEARCHID_TRUE", parameters: [
                AnalyticsParameterScreenName: "SEARCH"
            ])
            FollowingFollowService.shared.follow(id: findPeopleSearchData!.id){(networkResult) -> (Void) in
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
            FollowingFollowService.shared.follow(id: findPeopleSearchData!.id){(networkResult) -> (Void) in
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
    
    func setItems(profileImg: String, userName: String,isFollowed: Bool){
        profileImageView.imageFromUrl(profileImg, defaultImgPath: "")
        userNameLabel.text = userName
        if !isFollowed{
            followButton.setTitle("팔로우", for: .normal)
            followButton.backgroundColor = .black
            followButton.setTitleColor(.white, for: .normal)
        }
        
    }
    @objc func touchUpProfile(){
        followSearchProfileDelegate?.profileSelectedTap(userID: (findPeopleSearchData?.id)!)
        
    }
    
    
    
}
