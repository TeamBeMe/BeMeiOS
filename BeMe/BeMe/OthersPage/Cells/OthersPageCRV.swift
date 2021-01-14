//
//  OthersPageCRV.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/09.
//

import UIKit

class OthersPageCRV: UICollectionReusableView {
    //MARK:**- IBOutlet Part**
    // image
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    // profile
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var answerCountLabel: UILabel!
    @IBOutlet weak var attendanceCountLabel: UILabel!
    @IBOutlet weak var attendanceCountInfoLabel: UILabel!
    @IBOutlet weak var answerCountInfoLabel: UILabel!
    // height
    @IBOutlet weak var profileImageHeight: NSLayoutConstraint!
    @IBOutlet weak var profileViewHeight: NSLayoutConstraint!
    
    //MARK:**- Variable Part**
    static let identifier = "OthersPageCRV"
//    private var isFollowed = false
    var othersProfile: [OthersProfile] = []
    
    var isMyProfile: Bool?
    
    //MARK:**- Life Cycle Part**
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        print("CRV:::::: \(isMyProfile)")
        if let iMP = isMyProfile {
            print(iMP)
            followButton.isHidden = iMP
        } else {
            print(isMyProfile)
            followButton.isHidden = false
        }
        
    }
    
    
    //MARK:**- IBAction Part**
    @IBAction func followButtonTapped(_ sender: Any) {
//        isFollowed = !isFollowed
//        setFollowButton(view: followButton, isFollowed: isFollowed)
        
        
        if followButton.titleLabel?.text == "팔로잉"{
            FollowingFollowService.shared.follow(id: othersProfile[0].id){(networkResult) -> (Void) in
                switch networkResult{
                case .success(let data) :
                    print("success")
                    self.setFollowButton(view: self.followButton, isFollowed: false)
                    
                    
                    
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
            FollowingFollowService.shared.follow(id: othersProfile[0].id){(networkResult) -> (Void) in
                switch networkResult{
                case .success(let data) :
                    print("success")
//                    self.followButton.setTitle("팔로잉", for: .normal)
//                    self.followButton.backgroundColor = .white
//                    self.followButton.setTitleColor(.black, for: .normal)
                    
                    self.setFollowButton(view: self.followButton, isFollowed: true)
                    
                    
                    
                    
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
    
    //MARK:**- default Setting Function Part**
    
    func setProfile(nickname: String, img: String, visit: String, answerCount: String, isFollowed: Bool){
        nameLabel.text = nickname
        profileImage.imageFromUrl(img, defaultImgPath: "mypageDefault")
        attendanceCountInfoLabel.text = visit
        answerCountInfoLabel.text = answerCount
        setInfoLabel()
        setFollowButton(view: followButton, isFollowed: isFollowed)
        print("setP{riofile")
        print(isFollowed)
    }
    func setFollowButton(view: UIButton, isFollowed: Bool) {
        if isFollowed {
            view.setTitle("팔로잉", for: .normal)
            view.setBorderWithRadius(borderColor: .veryLightPinkTwo, borderWidth: 1, cornerRadius: 3)
            view.backgroundColor = UIColor.white
            view.setTitleColor(.black, for: .normal)
        } else {
            view.setTitle("팔로우", for: .normal)
            view.setBorderWithRadius(borderColor: .black, borderWidth: 1, cornerRadius: 3)
            view.backgroundColor = UIColor.black
            view.setTitleColor(.white, for: .normal)
        }
        
    }
    
    func setInfoLabel(){
        attendanceCountInfoLabel.textColor = .slateGrey
        answerCountInfoLabel.textColor = .slateGrey
    }
    
    //MARK:**- Function Part**
    
}

