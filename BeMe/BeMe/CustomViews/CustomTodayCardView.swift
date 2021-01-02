//
//  CustomTodayCardView.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/31.
//

import UIKit

class CustomTodayCardView: UIView {

    var lockButton = UIButton().then {
        $0.setImage(UIImage(named: "btnLock"), for: .normal)
        $0.tintColor = .white
    }
    
    var questionInfoLabel = UILabel().then {
        $0.text = "[ 미래에 관한 2번째 질문 ] "
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .slateGrey
        $0.textAlignment = .center
    }
    var dateLabel = UILabel().then {
        $0.text = "2020. 12. 24"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .slateGrey
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
        $0.setTitleColor(.slateGrey, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeLockButton()
        makeQuestionInfoLabel()
        makeDateLabel()
        makeQuestionLabel()
        makeReplyButton()
        makeChangeButton()
        self.backgroundColor = .darkGrey
        self.makeRounded(cornerRadius: 6)
        self.setBorder(borderColor: .veryLightPink, borderWidth: 1.0)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



//MARK:- Setting AutoLayout
extension CustomTodayCardView {
    
    func makeLockButton(){
        self.addSubview(lockButton)
        lockButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(40)
            $0.width.equalTo(36)
            $0.height.equalTo(36)
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




