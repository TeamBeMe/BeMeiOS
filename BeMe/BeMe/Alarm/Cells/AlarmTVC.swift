//
//  AlarmTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/12.
//

import UIKit

class AlarmTVC: UITableViewCell {
    static let identifier: String = "AlarmTVC"
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var alarmLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    func setInformations(type: String, profileImg: String, question: String, nickName: String) {
        if profileImg == "" {
            profileImageView.image = UIImage.init(named: "imgProfile")
        } else {
            let url = URL(string: profileImg)
            profileImageView.kf.setImage(with: url)
        }
        
        if type == "comment" {
            alarmLabel.text = "\(nickName)님이 “\(question)”에 대한 나의 글에 댓글을 달았습니다."
        } else if type == "cocomment" {
            alarmLabel.text = "\(nickName)님이 “\(question)”에 대한 나의 댓글에 답글을 달았습니다."
        } else {
            alarmLabel.text = "\(nickName)님이 나를 팔로우했습니다."
        }
        
    }
}
