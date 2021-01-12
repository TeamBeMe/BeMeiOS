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
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
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
    private var isFollowed = false
    var othersProfile: [OthersProfile] = [] 
    //MARK:**- Life Cycle Part**
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    //MARK:**- IBAction Part**
    @IBAction func backButtonTapped(_ sender: Any) {
    }
    @IBAction func reportButtonTapped(_ sender: Any) {
    }
    @IBAction func followButtonTapped(_ sender: Any) {
        isFollowed = !isFollowed
        setFollowButton(view: followButton, isFollowed: isFollowed)
    }
    
    //MARK:**- default Setting Function Part**
    
    func setProfile(nickname: String, img: String, visit: String, answerCount: String, isFollowed: Bool){
        nameLabel.text = nickname
        profileImage.image = UIImage(contentsOfFile: img)
//        profileImage.image = UI
        attendanceCountInfoLabel.text = visit
        answerCountInfoLabel.text = answerCount
        setInfoLabel()
        setFollowButton(view: followButton, isFollowed: isFollowed)
    }
    func setFollowButton(view: UIButton, isFollowed: Bool) {
        if isFollowed {
            view.setBorderWithRadius(borderColor: .veryLightPinkTwo, borderWidth: 1, cornerRadius: 3)
            view.backgroundColor = UIColor.white
            view.setTitleColor(.black, for: .normal)
        } else {
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
