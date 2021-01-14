//
//  SearchRecentTVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import UIKit

class SearchRecentTVC: UITableViewCell {

    static let identifier = "SearchRecentTVC"
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    var userInfo: SearchHistoryData?
    var searchxButtonDelegate: SearchxButtonDelegate?
    var followSearchProfileDelegate: FollowSearchProfileDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
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

    @IBAction func deleteButtonAction(_ sender: Any) {
        FindDeleteSearchService.shared.delete(id: (userInfo?.id)!) {(networkResult) -> (Void) in
            switch networkResult{
            case .success(let data) :
                self.searchxButtonDelegate?.xButtonTapped()
                print("success")
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
    
    func setItems(){
        profileImageView.imageFromUrl(userInfo?.profileImg, defaultImgPath: "")
        nickNameLabel.text = userInfo?.nickname
    }
    
    @objc func touchUpProfile(){
        followSearchProfileDelegate?.profileSelectedTap(userID: (userInfo?.id)!)
        
    }
}
