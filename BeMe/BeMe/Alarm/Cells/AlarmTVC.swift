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
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.makeRounded(cornerRadius: profileImageView.bounds.width / 2)
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
        
        // 닉네임 진하게 만들기
        let font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14.0)
        let attributedStr = NSMutableAttributedString(string: alarmLabel.text!)
        attributedStr.addAttribute(.font, value: font!, range: (alarmLabel.text! as NSString).range(of: nickName))
        alarmLabel.attributedText = attributedStr
        
//        print(alarmLabel.calculateMaxLines())
//        if alarmLabel.calculateMaxLines() > 2 {
//            stackView.alignment = .top
//        } else {
//            stackView.alignment = .center
//        }
    }
}

extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}
