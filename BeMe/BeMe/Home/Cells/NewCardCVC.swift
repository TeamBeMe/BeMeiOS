//
//  NewCardCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/28.
//

import UIKit
import Then
import SnapKit

class NewCardCVC: UICollectionViewCell {
    static let identifier : String = "NewCardCVC"
    
    //MARK:- IBOutlets
    var lockButton = UIButton().then {
        $0.setTitle("L", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    var questionInfoLabel = UILabel().then {
        $0.text = "[ 미래에 관한 2번째 질문 ] "
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    var dateLabel = UILabel().then {
        $0.text = "2020. 12. 24"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .white
        $0.textAlignment = .center
        
    }
    var questionLabel = UILabel().then {
        $0.text = "이번 주말을 후회 없이\n보낼 수 있는 방법은 무엇인가요?"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    var replyButton = UIButton().then {
        $0.setTitle("답변하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 6)
        $0.setTitleColor(.black, for: .normal)
    }
    
    var changeButton = UIButton().then {
        $0.setTitle("질문 변경하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
    }
    
    var isPublic = false
    var changePublicDelegate : ChangePublicDelegate?
    let deviceBound = UIScreen.main.bounds.height/812.0
}


//MARK:- LifeCycle Methods
extension NewCardCVC {
    
    override func awakeFromNib() {
        makeLockButton()
        makeQuestionInfoLabel()
        makeDateLabel()
        makeQuestionLabel()
        makeReplyButton()
        makeChangeButton()
        self.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1.0)
        self.contentView.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1.0)
        self.makeRounded(cornerRadius: 6)
        lockButton.addTarget(self, action: #selector(changePublic), for: .touchUpInside)
        self.setBorder(borderColor: UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1.0), borderWidth: 1.0)
    }
    
    
    
}


//MARK:- Setting AutoLayout
extension NewCardCVC {
    
    func makeLockButton(){
        self.addSubview(lockButton)
        lockButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(40)
            $0.width.equalTo(12.6)
            $0.height.equalTo(18)
        }
    }
    
    func makeQuestionInfoLabel(){
        self.addSubview(questionInfoLabel)
        questionInfoLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(77)
        }
    }
    
    func makeDateLabel(){
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(95)
        }
    }
    
    
    func makeQuestionLabel(){
        self.addSubview(questionLabel)
        questionLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(162)
        }
    }
    func makeReplyButton(){
        self.addSubview(replyButton)
        replyButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
            $0.bottom.equalToSuperview().offset(-62)
            $0.height.equalTo(50)
        }
    }
    
    func makeChangeButton(){
        self.addSubview(changeButton)
        changeButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.bottom.equalToSuperview().offset(-25)
            $0.centerX.equalToSuperview()
        }
        
    }

}



//MARK:- User Define Function

extension NewCardCVC {
    @objc func changePublic(){

        changePublicDelegate?.changePublic(now: isPublic)
        
    }
    
    
    func setLock(after : Bool){
        if after == true {
            lockButton.setTitle("U", for: .normal)
            lockButton.setImage(UIImage(systemName: "lock.slash"), for: .normal)
            lockButton.tintColor = .white
        }
        else{
            lockButton.setTitle("L", for: .normal)
            lockButton.setImage(UIImage(systemName: "lock"), for: .normal)
            lockButton.tintColor = .white
        }
        
    }
    
    
}
