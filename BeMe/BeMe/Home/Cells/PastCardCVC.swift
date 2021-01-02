//
//  PastCardCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/28.
//

import UIKit

class PastCardCVC: UICollectionViewCell {
    static let identifier : String = "PastCardCVC"
    var answerData : AnswerDataForViewController?
    var index : Int?
    //MARK:- IBOutlets
    var lockButton = UIButton().then {
        $0.setImage(UIImage(named: "btnLock")?.withRenderingMode(.alwaysOriginal), for: .normal)
   
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
    var answerTextView = UITextView().then {
        $0.text = "저는 몇일 전 퇴사를 했어요. 수많은 고민 끝에 결국 저질렀습니다. 몇 년간 원해 왔던 일이라 꿈만 같아요. 제가 스스로의 힘으로 하고 싶은 걸 해볼 수있는 시간적 여유를 가지게 된게 정말 만족스러워요."
        $0.textColor = .white
//        $0.isEditable = false
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textAlignment = .center
        $0.backgroundColor = .darkGrey
        $0.isEditable = false
            
    }
    
    var fixButton = UIButton().then {
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.slateGrey,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "편집",
                                                        attributes: yourAttributes)
        $0.setAttributedTitle(attributeString, for: .normal)
    }
    
    
    var homeFixButtonDelegate : HomeFixButtonDelegate?
    //MARK:- User Define Variables
    
    var isPublic = false
    var changePublicDelegate : ChangePublicDelegate?

    
    
}


//MARK:- LifeCycle Methods
extension PastCardCVC {
    
    override func awakeFromNib() {
        makeLockButton()
        makeQuestionInfoLabel() 
        makeDateLabel()
        makeQuestionLabel()
        makeAnswerTextView()
        makeFixButton()
        self.makeRounded(cornerRadius: 6)
        self.backgroundColor = .darkGrey
        self.contentView.backgroundColor = .darkGrey
        lockButton.addTarget(self, action: #selector(changePublic), for: .touchUpInside)
//        self.setBorder(borderColor: .veryLightPink, borderWidth: 1.0)
        
    }
    
    
    
}


//MARK:- Setting AutoLayout
extension PastCardCVC {
    
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
    
    func makeAnswerTextView(){
        self.addSubview(answerTextView)
        answerTextView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.top.equalToSuperview().offset(223)
            $0.height.equalTo(160)
        }
    }
    
    func makeFixButton(){
        self.addSubview(fixButton)
        fixButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-25)
            
        }
        fixButton.addTarget(self, action: #selector(fixButtonAction), for: .touchUpInside)
        
    }
    
    
    
    
}

//MARK:- User Define functions
extension PastCardCVC {
    
    @objc func changePublic(){

        changePublicDelegate?.changePublic()
        
    }
    
    func setLock(after : Bool){
        if after == true {
            lockButton.setImage(
                UIImage(named: "btnUnlock")?.withRenderingMode(.alwaysOriginal), for: .normal)
 
        }
        else{
            lockButton.setImage(
                UIImage(named: "btnLock")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
    }
    
    @objc func fixButtonAction(){
        homeFixButtonDelegate?.fixButtonTapped()
    }
    
    func setItems(){
        if answerData?.lock == true{
            lockButton.setImage(
                UIImage(named: "btnLock")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        else{
            lockButton.setImage(
                UIImage(named: "btnUnlock")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        questionInfoLabel.text = "[ " + (answerData?.questionInfo)! + " ]"
        questionLabel.text = answerData?.question
        dateLabel.text = answerData?.answerDate
        answerTextView.text = answerData?.answer
        
    }
    
    
}
