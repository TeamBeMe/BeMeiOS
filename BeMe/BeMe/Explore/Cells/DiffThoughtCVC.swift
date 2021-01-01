//
//  DiffThoughtCVC.swift
//  BeMe
//
//  Created by 이재용 on 2020/12/31.
//

import UIKit

class DiffThoughtCVC: UICollectionViewCell {
    static let identifier: String = "DiffThoughtCVC"
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UITextView!
    
    
    
    func setAnswer() {
        answer.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        let attributedString = NSMutableAttributedString(string: "저는 며칠 전 퇴사를 했어요. 수많은 고민 끝에 결국 저질렀습니다. 몇 년간 원해왔던 일이라 꿈만 같아요. 제가 스스로의 힘으로 하고 싶은 걸 해볼것 같아요. 수많은 고민 끝에 결국 저질렀습니다. 어쩌구 저쩌구 이러쿵 저러쿵,, 솰라솰라 하더라구요..")
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 2.0
//        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
//        answer.attributedText = attributedString
    }
}
